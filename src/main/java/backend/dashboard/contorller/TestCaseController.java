package backend.dashboard.contorller;


import java.io.BufferedInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.itextpdf.text.pdf.hyphenation.TernaryTree.Iterator;

import backend.dashboard.service.ItmsTestCaseBiz;
import backend.dashboard.service.TestCaseBiz;
import backend.entity.TestCase;

@Controller
@RequestMapping("testCase.do")
public class TestCaseController {

	
	 @Resource(name = "testCaseBizImpl")
	    private TestCaseBiz testCaseBiz;
	 
	 @Resource(name = "itmsTestCaseBizImpl")
	    private ItmsTestCaseBiz itmsTestCaseBiz;
	
	 @RequiresRoles("admin")
	    @RequestMapping("index.view")
	    public String index(Model model) {
		 model.addAttribute("testCaseList", testCaseBiz.findAll());
	        return "/iAutoDemo/detail/testCaseAdmin";
	    }
	 
	/* //新的测试用例管理界面
	 @RequiresRoles("admin")
	    @RequestMapping("newIndex.view")
	    public String newIndex(Model model) {
		 model.addAttribute("testCaseList", testCaseBiz.findAll());
	        return "/iAutoDemo/detail/newTestCaseAdmin";
	    }
	 
	//新的测试用例管理界面
		 @RequiresRoles("admin")
		    @RequestMapping("importTestCase.view")
		    public String importTestCase(Model model) {
		        return "/iAutoDemo/detail/importTestCase";
		    }*/
	 
	 //单个处理导入
	/* @RequiresRoles("admin")
	    @RequestMapping(value="importExcel",method=RequestMethod.POST)
		 public @ResponseBody String importExcel(@RequestParam("file") MultipartFile file, HttpServletRequest request){
		        //System.out.println("jinrule");
		 		// 判断文件是否为空
		        String flag = "1";//上传标志
		        if (!file.isEmpty()) {
		            try {
		                String originalFilename = file.getOriginalFilename();//原文件名字
		                InputStream is = file.getInputStream();//获取输入流
		                		                
		                if(!originalFilename.endsWith("xls") && !originalFilename.endsWith("xlsx"))
		                {
		                	flag = "9";
		                	return flag;
		                }
		                
		                String result = importTestCaseExcelBiz.writeExelData(is);
		                //flag = summaryExpServiceImpl.writeExelData(is);
		                // 转存文件 
		                //file.transferTo(new File(filePath));
		                System.out.println(result);
		                
		                System.out.println("test");
		                System.out.println(originalFilename);
		            } catch (Exception e) {
		                flag="03";//上传出错
		                e.printStackTrace();
		            }
		        }
		        return flag;
		    }*/

	 
/*	//多个处理导入
	 @RequiresRoles("admin")
	    @RequestMapping(value="importExcel",method=RequestMethod.POST)
		 public @ResponseBody String importExcel(@RequestParam("file") MultipartFile[] files, HttpServletRequest request){
		 
		 String flag = "1";
		 System.out.println("找到我了！！！");
	        try {
	            for (MultipartFile file : files) {
	                //String fileName = file.getOriginalFilename();
	                String saveName = UUID.randomUUID().toString() + fileName.substring(fileName.lastIndexOf("."));
	                File file1 = new File("E:/test/", saveName);
	                file.transferTo(file1);
	                
	                String originalFilename = file.getOriginalFilename();//原文件名字
	                InputStream is;
	                
					try {
						is = file.getInputStream();
						
						if(!originalFilename.endsWith("xls") && !originalFilename.endsWith("xlsx"))
		                {
		                	flag = "9";
		                	return flag;
		                }
		                
		                String result = importTestCaseExcelBiz.writeExelData(is,originalFilename);
					} catch (IOException e) {
						// TODO 自动生成的 catch 块
						e.printStackTrace();
					}     
	            }
	        } catch (IllegalStateException e) {
	            e.printStackTrace();
	        }        
	        return "1";
		}
	 */
	 
	 @RequiresRoles("admin")
	    @RequestMapping("add.view")
	    public String addView() {
	       
	        return "/iAutoDemo/detail/addTestCase";
		// return "/admin/system/user/user_add";
	    }
	 
	 @RequiresRoles("admin")
	    @RequestMapping(value="add",method=RequestMethod.POST)
	    public @ResponseBody String add(@RequestBody TestCase testcase,HttpSession session) {
		 //Date now = new Date(); 
		 System.out.println(testcase.getId());
		 //SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//闁告瑯鍨禍鎺楀棘闁稓鈹掗柛锕傤暒閹便劑寮ㄧ憴鍕級闁哄牏鍠愰悧绋款嚕閿燂拷
		 testcase.setModifyTime(new Date());//set time
		 testcase.setUserLoginId((String)session.getAttribute("loginId"));
	     testCaseBiz.add(testcase);
	     System.out.println(testcase.getLogPath());
	     //Map<String, String> result = new HashMap<String, String>();
	     //result.put("msg", "nimei");
	     //return result;
	        //return "/iAutoDemo/detail/testCaseAdmin";
	        //eturn "redirect:/testCase.do/index.view";
	     return "finish";
	    }
	 
	 @RequiresRoles("admin")
	    @RequestMapping(value="update",method=RequestMethod.POST)
	    public @ResponseBody String edit(@RequestBody TestCase testcase,HttpSession session) {
		 //Date now = new Date(); 
		 //System.out.println(testcase.getId());
		 //SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//闁告瑯鍨禍鎺楀棘闁稓鈹掗柛锕傤暒閹便劑寮ㄧ憴鍕級闁哄牏鍠愰悧绋款嚕閿燂拷
		 testcase.setModifyTime(new Date());
	     testCaseBiz.update(testcase);
	     //System.out.println(testcase.getLogPath());
	     //Map<String, String> result = new HashMap<String, String>();
	     //result.put("msg", "nimei");
	     //return result;
	        //return "/iAutoDemo/detail/testCaseAdmin";
	        //eturn "redirect:/testCase.do/index.view";
	     return "finish";
	    }
	 
	 @RequiresRoles("admin")
	 @RequestMapping(value="testCaseSearch",method=RequestMethod.GET)
	 public @ResponseBody List<TestCase> testCaseSearch(String content) {
		 System.out.println(content);
		 List<TestCase> searchCaseList = testCaseBiz.search(content);
		 System.out.println(searchCaseList+"~~~~~~~~~~~");
		 return searchCaseList;
		 }
	 
	 @RequiresRoles("admin")
	 @RequestMapping(value="delete",method=RequestMethod.GET)
	 public @ResponseBody List<TestCase> delete(int id) {
		 testCaseBiz.delete(id);
		 List<TestCase> caseList = testCaseBiz.findAll();
		 return caseList;
		 }
	 
	 @RequiresRoles("admin")
	    @RequestMapping("edit")
	    public String edit(int id,Model model) {
		 model.addAttribute("testCase", testCaseBiz.findTestCaseById(id));
		 //System.out.println(testCaseBiz.findTestCaseById(id).getLogPath());
		 return "/iAutoDemo/detail/editTestCase";
	    }
}
