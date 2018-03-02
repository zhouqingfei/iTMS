package backend.dashboard.developer.controller;

import java.awt.Desktop;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.shiro.authz.annotation.RequiresRoles;

import org.jdom2.JDOMException;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import backend.dashboard.service.MachineAdminBiz;
import backend.dashboard.service.ReportLogBiz;
import backend.dashboard.service.TestCaseBiz;
import backend.dashboard.service.TestTaskBiz;
import backend.dashboard.service.TestTaskExecuteCSVBiz;
import backend.dashboard.service.TestTaskExecuteXMLBiz;
import backend.entity.TestTask;

@Controller
@RequestMapping("testTaskDeveloper.do")
public class TestTaskDeveloperController {
	@Resource(name = "testTaskBizImpl")
	private TestTaskBiz testTaskBiz;
	@Resource(name = "testTaskExecuteCSVBizImpl")
	private TestTaskExecuteCSVBiz testTaskExecuteCSVBiz;
	@Resource(name = "testTaskExecuteXMLBizImpl")
	private TestTaskExecuteXMLBiz testTaskExecuteXMLBiz;
	@Resource(name = "testCaseBizImpl")
	private TestCaseBiz testCaseBiz;
	@Resource(name = "report")
	private ReportLogBiz testCaseBiz1;
	@Resource(name = "machineAdminBizImpl")
	private MachineAdminBiz machineAdminBiz;

	@RequiresRoles("developer")
	@RequestMapping("index.view")
	public String index(Model model, HttpSession session) {
		model.addAttribute("testTaskList", testTaskBiz.findAll((String) session.getAttribute("loginId")));
		return "/iAutoDemo/developer/testTaskAdmin";
	}

	@RequiresRoles("developer")
	@RequestMapping("add.view")
	public String addView(Model model, HttpSession session) {
		String loginID = (String) session.getAttribute("loginId");
		model.addAttribute("testCaseList", testCaseBiz.findAll());
		model.addAttribute("sutList", machineAdminBiz.findMachineByUser(loginID));
		model.addAttribute("temList", machineAdminBiz.findTem());
		// return "/iAutoDemo/detail/addTestSuit1";
		return "/iAutoDemo/developer/addTestTask";
	}

	 @RequiresRoles("developer")
	 @RequestMapping(value="testTaskSearch",method=RequestMethod.GET)
	 public @ResponseBody List<TestTask> testTaskSearch(String content,HttpSession session) {
		 System.out.println(content);
		 List<TestTask> searchTaskList = testTaskBiz.search(content);
		 String loginId=(String) session.getAttribute("loginId");
		 for (int i = 0; i < searchTaskList.size(); i++) 
		 {
		 	if (!searchTaskList.get(i).getLoginId().equals(loginId))
		 	{
		 		searchTaskList.remove(searchTaskList.get(i));
		 		i=i-1;
		 	}
		 }
		 System.out.println(searchTaskList+"~~~~~~~~~~~");
		 return searchTaskList;
		 }
	 
	@RequiresRoles("developer")
	@RequestMapping(value = "add", method = RequestMethod.POST)
	public @ResponseBody String add(@RequestBody TestTask testtask, HttpSession session) {
		// testtask.setStartTime(new Date());// set time
		testtask.setLoginId((String) session.getAttribute("loginId"));
		System.out.println(testtask.getTemInfo());
		System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		testtask.setProcess("0");
		testtask.setTestTaskState("Ready");
		testTaskBiz.add(testtask);
		System.out.println(testtask.getTestCaseInfo());
		System.out.println(testtask.getSutInfo() + "!!!!!!!!!!!!!!!!!!!!!!11");

		// return "/iAutoDemo/detail/testCaseAdmin";
		return "success";
	}

	@RequiresRoles("developer")
	@RequestMapping(value = "update", method = RequestMethod.POST)
	public @ResponseBody String edit(@RequestBody TestTask testTask, HttpSession session) {
		testTask.setTestTaskState("Ready");
		testTaskBiz.update(testTask);

		return "finish";
	}

	/*
	 * @RequiresRoles("developer")
	 * 
	 * @RequestMapping("delete") public String delete(int id) {
	 * testTaskBiz.delete(id); return "redirect:/testTask.do/index.view"; }
	 */
	@RequiresRoles("developer")
	@RequestMapping(value = "delete", method = RequestMethod.GET)
	public @ResponseBody List<TestTask> delete(int id, HttpSession session) {
		testTaskBiz.delete(id);
		List<TestTask> taskList = testTaskBiz.findAll((String) session.getAttribute("loginId"));
		return taskList;
	}

	@RequiresRoles("developer")
	@RequestMapping("edit")
	public String edit(int id, Model model, HttpSession session) {
		String loginID = (String) session.getAttribute("loginId");
		model.addAttribute("testTask", testTaskBiz.findTestTaskById(id));
		model.addAttribute("testCaseList", testCaseBiz.findAll());
		model.addAttribute("sutList", machineAdminBiz.findMachineByUser(loginID));
		model.addAttribute("temList", machineAdminBiz.findTem());
		// System.out.println(testCaseBiz.findTestCaseById(id).getLogPath());
		return "/iAutoDemo/developer/editTestTask";
	}

	@RequiresRoles("developer")
	@RequestMapping("openFile")
	public String openFile(String reportNumber) {
		try {
			Desktop.getDesktop().open(new File("D:/testTask_" + reportNumber + "_report.pdf"));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "redirect:/testTaskDeveloper.do/index.view";
	}

	@RequiresRoles("developer")
	@RequestMapping("execute")
	public String execute(int id, HttpSession session) {

		// System.out.println((String) session.getAttribute("loginId"));
		// ReportLog rl=new ReportLog();
		// rl.setLogId(111);
		// rl.setLogName("111");
		// testCaseBiz1.add(rl);
		TestTask testTask = testTaskBiz.findTestTaskById(id);
		testTask.setStartTime(new Date());
		testTaskBiz.update(testTask);
		// testTaskExecuteXMLBiz.execute(id);
		try {
			testTaskExecuteXMLBiz.execute(id, (String) session.getAttribute("loginId"));
		} catch (IOException | JDOMException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "redirect:/testTaskDeveloper.do/index.view";
	}

	@RequiresRoles("developer")
	@RequestMapping(value = "/download")
	public ResponseEntity<byte[]> download(HttpServletRequest request, Model model) throws Exception {
		// 婵炴垶鎸搁鍫澝归崶顒�妫橀柛銉檮椤愪粙鎮规笟顖氱仩缂佽鎷�
		// String path = request.getServletContext().getRealPath("/images/");
		File file = new File("D://testTask.xml");
		HttpHeaders headers = new HttpHeaders();
		// 婵炴垶鎸搁鍫澝归崶顒�鍙婇柛鎾椾椒绮甸梺姹囧妼鐎氼參寮搁崘鈺冾浄閻犺櫣鍎ら崐鎶芥煥濞戞鐒风悮娆撴煕閹邦剙甯犻柤鍨灴瀵剟宕惰閸婂磭绱掓径鎰垫殥閻犳劧绻濋幆宥嗙瑹閿熻棄螞閼哥绱ｉ柨鐕傛嫹
		String downloadFielName = new String("nimei".getBytes("UTF-8"), "iso-8859-1");
		// 闂備緡鍋呭銊╂偂閳ヨ秮纭呯疀濮樺吋缍岄梺闈╃祷閸斿绂嶉幎濯achment闂佹寧绋戦悧鍛箔閸涱喗濮滈柤鎭掑劜閻撴瑧锟芥鍠栨蹇曟濮樿泛绠ラ柟鎯х－绾惧鏌涢妷銉モ挃濠⒀嶆嫹
		headers.setContentDispositionFormData("attachment", downloadFielName);
		// application/octet-stream 闂佹寧鍐婚幏锟�
		// 婵炲瓨绮岄惌浣烘崲濮楋拷瀹曟岸鎳滈悽鐐瑰亰闂佽桨鑳舵晶妤�鐣垫笟锟介弫宥夊醇閻旈晲绮柣銏╁灡閻℃洟锝為崱娑欏剭闁告洦鍓氶悗顔济归悩铏瀯缂佹鎳忓顏堝棘閵堝洨顦梺闈涙４閹凤拷
		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
		return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file), headers, HttpStatus.CREATED);
	}

}
