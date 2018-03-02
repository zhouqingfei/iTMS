package backend.dashboard.leader.controller;

import java.util.Date;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import backend.dashboard.service.TestCaseBiz;
import backend.entity.TestCase;

@Controller
@RequestMapping("testCaseLeader.do")
public class TestCaseLeaderController {

	
	 @Resource(name = "testCaseBizImpl")
	    private TestCaseBiz testCaseBiz;
	
	 @RequiresRoles("leader")
	    @RequestMapping("index.view")
	    public String index(Model model) {
		 model.addAttribute("testCaseList", testCaseBiz.findAll());
	        return "/iAutoDemo/leader/testCaseAdmin";
	    }
	 
	 
	 @RequiresRoles("leader")
	    @RequestMapping("add.view")
	    public String addView() {
	       
	        return "/iAutoDemo/leader/addTestCase";
		// return "/admin/system/user/user_add";
	    }
	 @RequiresRoles("leader")
	 @RequestMapping(value="testCaseSearch",method=RequestMethod.GET)
	 public @ResponseBody List<TestCase> testCaseSearch(String content) {
		 System.out.println(content);
		 List<TestCase> searchCaseList = testCaseBiz.search(content);
		 System.out.println(searchCaseList+"~~~~~~~~~~~");
		 return searchCaseList;
		 }
	 @RequiresRoles("leader")
	    @RequestMapping(value="add",method=RequestMethod.POST)
	    public @ResponseBody String add(@RequestBody TestCase testcase,HttpSession session) {
		 //Date now = new Date(); 
		 System.out.println(testcase.getId());
		 //SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//鍙互鏂逛究鍦颁慨鏀规棩鏈熸牸寮�
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
	 
	 @RequiresRoles("leader")
	    @RequestMapping(value="update",method=RequestMethod.POST)
	    public @ResponseBody String edit(@RequestBody TestCase testcase,HttpSession session) {
		 //Date now = new Date(); 
		 //System.out.println(testcase.getId());
		 //SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//鍙互鏂逛究鍦颁慨鏀规棩鏈熸牸寮�
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
	 
	 @RequiresRoles("leader")
	    @RequestMapping("delete")
	    public String delete(int id) {
	        testCaseBiz.delete(id);
	        return "redirect:/testCaseLeader.do/index.view";
	    }
	 @RequiresRoles("leader")
	    @RequestMapping("edit")
	    public String edit(int id,Model model) {
		 model.addAttribute("testCase", testCaseBiz.findTestCaseById(id));
		 //System.out.println(testCaseBiz.findTestCaseById(id).getLogPath());
		 return "/iAutoDemo/leader/editTestCase";
	    }
}
