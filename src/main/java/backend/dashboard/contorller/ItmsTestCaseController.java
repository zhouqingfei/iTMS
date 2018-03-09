package backend.dashboard.contorller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;

import backend.dashboard.service.ItmsTestCaseBiz;
import backend.dashboard.service.ProjectAndRoundBiz;
import backend.entity.ItmsTestCase;
import backend.entity.ItmsTestTask;
import backend.entity.ProjectAndRound;

class ItmsTestCaseScriptInfo {
	int id;
	String script;
	String param;
	String ip;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getScript() {
		return script;
	}

	public void setScript(String script) {
		this.script = script;
	}

	public String getParam() {
		return param;
	}

	public void setParam(String param) {
		this.param = param;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}
}

class ItmsTestTaskInfo {
	int id;
	String status;
	

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
}

@Controller
@RequestMapping("itmsTestCase.do")
public class ItmsTestCaseController {

	@Resource(name = "itmsTestCaseBizImpl")
	private ItmsTestCaseBiz itmsTestCaseBiz;

	@Resource(name = "projectAndRoundBizImpl")
	private ProjectAndRoundBiz projectAndRoundBiz;

	Logger logger = LoggerFactory.getLogger(ItmsTestCaseController.class);
	
	@RequestMapping(value = "update", method = RequestMethod.POST)
	@ResponseBody
	List<ItmsTestCaseScriptInfo> updateTestCase(@RequestBody List<ItmsTestCase> testCaseList) {
		StringBuilder sb = new StringBuilder();
		sb.append("~~~~~~~~~ update handler, testCaseList: size " + testCaseList.size() + ";");
		if(testCaseList.size() > 0) {
			sb.append("[0] ");
			ItmsTestCase cas = testCaseList.get(0);
			sb.append(cas.getId() + ",");
			sb.append(cas.getScript() + ",");
			sb.append(cas.getParam() + ",");
			sb.append(cas.getIp());
		}
		System.out.println(sb.toString());

		try {
			List<ItmsTestCaseScriptInfo> caslist = new ArrayList<>();
			for(ItmsTestCase testcase: testCaseList) {
				ItmsTestCase ret = itmsTestCaseBiz.updateScriptInfo(testcase);
				ItmsTestCaseScriptInfo info = new ItmsTestCaseScriptInfo();
				info.setId(ret.getId());
				info.setScript(ret.getScript());
				info.setParam(ret.getParam());
				info.setIp(ret.getIp());
				caslist.add(info);
			}
			return caslist;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	// TODO return ids of tasks starting successfully.
	@RequestMapping(value = "execute", method = RequestMethod.POST)
	@ResponseBody
	List<Integer> executeTestCases(@RequestBody List<Integer> ids) {

		List<Integer> ret = new ArrayList<Integer>();
		for (int id : ids) {
			if (itmsTestCaseBiz.executeTest(id)) {
				ret.add(id);
			}
		}
		return ret;
	}

	@RequestMapping(value = "getStatus", method = RequestMethod.POST)
	@ResponseBody
	List<ItmsTestTask> getStatusOfTasks(@RequestBody List<Integer> ids) {

		List<ItmsTestTask> tmp = itmsTestCaseBiz.getTaskByIds(ids);

		return tmp;
	}

	// 新的测试用例管理界面
	@RequiresRoles("admin")
	@RequestMapping("index.view")
	public String index(Model model) {
		model.addAttribute("itmsTestCaseList", itmsTestCaseBiz.findAllTestCase());
		model.addAttribute("itmsTestTaskList", itmsTestCaseBiz.findAllTestTask());
		return "/iAutoDemo/detail/itmsTestCaseAdmin";
	}

	// 新的测试用例管理界面
	@RequiresRoles("admin")
	@RequestMapping("importTestCase.view")
	public String importTestCase(Model model) {
		return "/iAutoDemo/detail/importTestCase";
	}

	// 树形结构演示
	@RequiresRoles("admin")
	@RequestMapping("treeDemo.view")
	public String treeDemo(Model model) {
		return "/iAutoDemo/detail/treeDemo";
	}

	// htmlTable测试
	@RequiresRoles("admin")
	@RequestMapping("testTable.view")
	public String treeTable(HttpServletRequest request,Model model) {
		System.out.println(request.getParameter("testId"));
		model.addAttribute("testId", request.getParameter("testId"));
		return "/iAutoDemo/detail/testTable";
	}

	// 测试管理系统
	@RequiresRoles("admin")
	@RequestMapping("testAdmin.view")
	public String testAdmin(Model model) {
		model.addAttribute("count", projectAndRoundBiz.findAll().size());
		return "/iAutoDemo/detail/testAdmin";
	}

	@RequiresRoles("admin")
	@RequestMapping(value = "importExcel", method = RequestMethod.POST)
	public @ResponseBody String importExcel(@RequestParam("file") MultipartFile[] files, HttpServletRequest request) {

		ItmsTestCase itmsTestCase;
		String flag = "1";
		System.out.println("找到我了！！！");
		try {
			for (MultipartFile file : files) {
				String originalFilename = file.getOriginalFilename();// 原文件名字
				InputStream is;

				try {
					is = file.getInputStream();

					if (!originalFilename.endsWith("xls") && !originalFilename.endsWith("xlsx")) {
						flag = "9";
						return flag;
					}

					String fileName = originalFilename;
					// 创建Workbook工作薄对象，表示整个excel
					Workbook workbook = null;

					itmsTestCase = new ItmsTestCase();

					try {
						if (fileName.endsWith("xls")) {
							// 2003
							workbook = new HSSFWorkbook(is);
						} else if (fileName.endsWith("xlsx")) {
							// 2007
							workbook = new XSSFWorkbook(is);
						}
					} catch (IOException e) {

					}

					Sheet sheet = workbook.getSheetAt(0);// 第一个工作表

					int firstRowIndex = sheet.getFirstRowNum();
					int lastRowIndex = sheet.getLastRowNum();

					for (int rIndex = 1; rIndex <= lastRowIndex; rIndex++) {
						Row row = sheet.getRow(rIndex);
						if (row != null) {
							int firstCellIndex = row.getFirstCellNum();
							int lastCellIndex = row.getLastCellNum();
							System.out.println(firstCellIndex);
							System.out.println(lastCellIndex);

							itmsTestCase.setName(row.getCell(0).toString());
							itmsTestCase.setNumber(row.getCell(1).toString());
							itmsTestCase.setVersion(row.getCell(2).toString());
							itmsTestCase.setWriter(row.getCell(3).toString());
							itmsTestCase.setCategory1(row.getCell(4).toString());
							itmsTestCase.setCategory2(row.getCell(5).toString());
							itmsTestCase.setCategory3(row.getCell(6).toString());
							itmsTestCase.setLevel(row.getCell(7).toString());
							itmsTestCase.setProduct(row.getCell(8).toString());
							itmsTestCase.setManualtime(row.getCell(9).toString());
							itmsTestCase.setAutotime(row.getCell(10).toString());
							itmsTestCase.setStatus(row.getCell(11).toString());
							itmsTestCase.setVersionchangelog(row.getCell(12).toString());
							itmsTestCase.setCondition(row.getCell(13).toString());
							itmsTestCase.setComment(row.getCell(14).toString());
							itmsTestCase.setAutoconnect(row.getCell(15).toString());
							itmsTestCase.setStep(row.getCell(16).toString());
							itmsTestCase.setExpect(row.getCell(17).toString());

							itmsTestCaseBiz.writeExelData(itmsTestCase);
						}
					}

				} catch (IOException e) {
					// TODO 自动生成的 catch 块
					flag = "9";
					e.printStackTrace();
				}
			}
		} catch (IllegalStateException e) {
			e.printStackTrace();
		}
		return flag;
	}

	Map<String, Object> getFieldMap(Object obj) {
		Map<String, Object> ret = new TreeMap<>();
		Class<?> clz = obj.getClass();
		Field[] fs = clz.getDeclaredFields();
		for (Field f : fs) {
			String name = f.getName();
			String getname = "get" + name.substring(0, 1).toUpperCase() + name.substring(1);
			Method getMeth = null;
			try {
				getMeth = clz.getDeclaredMethod(getname);
				Object val = getMeth.invoke(obj);
				ret.put(name, val);

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return ret;
	}

	@RequestMapping(value = "getTestCaseList", method = RequestMethod.POST)
	public @ResponseBody String getTestCaseList(HttpServletRequest request, Model model) {

		int currentPage = Integer.parseInt(request.getParameter("page"));
		int pageSize = Integer.parseInt(request.getParameter("rows"));
		//System.out.println(request.getParameter("testCaseList") + "11111111111111");
		String testId = request.getParameter("testId");
		List<Map<String, Object>> retList = new ArrayList<>();
		int totalNum = 0;
		ProjectAndRound par = projectAndRoundBiz.findById(Integer.valueOf(testId));
		String testCaseList = par.getTestCaseList();
		
		if(testCaseList.length() > 0) {
			String[] list = testCaseList.split(",");
			int[] caseIdList =  new int[list.length];
			List<ItmsTestCase> tempCaseList = new ArrayList<ItmsTestCase>();
			
			for(int i = 0; i < list.length;i++) {
				//caseIdList[i] = Integer.parseInt(list[i]);
				tempCaseList.add(itmsTestCaseBiz.findById(Integer.parseInt(list[i])));
			}
			
			
			List<ItmsTestCase> caseList = new ArrayList<ItmsTestCase>();
			System.out.println(String.format("~~~~~~ in getTestCaseList handler, currentPage: %d; pageSize: %d.",
					currentPage, pageSize));
			int from = (currentPage - 1) * pageSize;
			int count = pageSize;
	        
			int to = from;
			if(from + count > tempCaseList.size()) {
				to = tempCaseList.size();
			}
			else {
				to = from + count;
			}
			for(int i = from; i < to;i++) {
				caseList.add(tempCaseList.get(i));
			}
			 //= itmsTestCaseBiz.findByPagination(from, count);
			List<Integer> ids = new ArrayList<>();
			for (ItmsTestCase cas : caseList) {
				ids.add(cas.getId());
			}
			List<ItmsTestTask> taskList = itmsTestCaseBiz.getTaskByIds(ids);
			// merge two properties from taskcase and testTask, and result in list of map.
			int idx = 0;
			for (ItmsTestCase cas : caseList) {
				Map<String, Object> mer = getFieldMap(cas);
				String casId = mer.get("id").toString();
				if (idx < taskList.size()) {
					ItmsTestTask task = taskList.get(idx);
					String taskCasId = String.valueOf(task.getId());
					if (casId.equals(taskCasId)) {
						Map<String, Object> oth = getFieldMap(task);
						for (String key : oth.keySet()) {
							mer.putIfAbsent(key, oth.get(key));
						}

						idx++;
					}
				}
				retList.add(mer);
			}
			totalNum = tempCaseList.size();
		}

		Gson gs = new Gson();
		String json = "{\"total\":" + totalNum + " , \"rows\":" + gs.toJson(retList).toString() + "}";
		// System.out.println("getTestCaseList handler, ret: "+ json);
		return json;
	}

	@RequestMapping(value="download")
	public ResponseEntity<byte[]> download(@RequestParam String targetPath) throws Exception {
		System.out.println("~~~~~~ download file: " + targetPath);
		File file = new File(targetPath);
		HttpHeaders headers = new HttpHeaders();
		String downloadFielName = file.getName();
		headers.setContentDispositionFormData("attachment", downloadFielName);
		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
		return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file), headers, HttpStatus.OK);
	}
	
	@RequestMapping(value="tmptestcase.json")
	public @ResponseBody String getTempJsonFile() {
		System.err.println(String.format("current directory: %s.", new File("").getAbsolutePath()));
		File testFile = new File("tmptestcase.json");
		try {
			FileInputStream in = new FileInputStream(testFile);
			int size = in.available();
			byte[] data = new byte[size];
			in.read(data);
			return new String(data);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
}
