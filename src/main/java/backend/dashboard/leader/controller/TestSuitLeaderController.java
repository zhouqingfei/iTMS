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
import backend.dashboard.service.TestSuitBiz;
import backend.entity.TestSuit;

@Controller
@RequestMapping("testSuitLeader.do")
public class TestSuitLeaderController {

	@Resource(name = "testSuitBizImpl")
    private TestSuitBiz testSuitBiz;

	
	@Resource(name = "testCaseBizImpl")
    private TestCaseBiz testCaseBiz;
	 @RequiresRoles("leader")
	    @RequestMapping("index.view")
	    public String index(Model model) {
		 model.addAttribute("testSuitList", testSuitBiz.findAll());
	        return "/iAutoDemo/leader/testSuitAdmin";
	    }
	 
	 @RequiresRoles("leader")
	 @RequestMapping(value="testSuitSearch",method=RequestMethod.GET)
	 public @ResponseBody List<TestSuit> testSuitSearch(String content) {
		 System.out.println(content);
		 List<TestSuit> searchSuitList = testSuitBiz.search(content);
		 System.out.println(searchSuitList+"~~~~~~~~~~~");
		 return searchSuitList;
		 }
	 
	 @RequiresRoles("leader")
	    @RequestMapping("add.view")
	    public String addView(Model model) {
		 model.addAttribute("testCaseList", testCaseBiz.findAll());
	        return "/iAutoDemo/leader/addTestSuit";
		// return "/admin/system/user/user_add";
	    }
	 
	 //@RequiresRoles("admin")
	  //  @RequestMapping("add")
	  //  public String add(TestSuit testsuit,HttpSession session) {

		// testsuit.setModifyTime(new Date());//set time
		// testsuit.setUserLoginId((String)session.getAttribute("loginId"));
	   //     testSuitBiz.add(testsuit);
	   //     //return "/iAutoDemo/detail/testCaseAdmin";
	   //     return "redirect:/testSuit.do/index.view";
	   // }
	 
	 @RequiresRoles("leader")
		@RequestMapping(value = "add", method = RequestMethod.POST)
		public @ResponseBody String add(@RequestBody TestSuit testsuit, HttpSession session) {
		 System.out.println(testsuit.getTestSuitDescribe());
		 System.out.println(testsuit.getTestSuitCategory());
		 	 testsuit.setModifyTime(new Date());//set time
			 testsuit.setUserLoginId((String)session.getAttribute("loginId"));
		     testSuitBiz.add(testsuit);
			 return "success";
	 }
	 
	 @RequiresRoles("leader")
	    @RequestMapping("edit")
	    public String edit(int id,Model model) {
		 model.addAttribute("testSuit", testSuitBiz.findTestSuitById(id)); 
		 model.addAttribute("testCaseList", testCaseBiz.findAll());
		 //System.out.println(testCaseBiz.findTestCaseById(id).getLogPath());
		 return "/iAutoDemo/leader/editTestSuit";
	    }
	 
	 @RequiresRoles("leader")
	 @RequestMapping(value="delete",method=RequestMethod.GET)
	    public @ResponseBody List<TestSuit> delete(int id) {
	    	
	    	testSuitBiz.delete(id);
		 	List<TestSuit> suitList = testSuitBiz.findAll();
		 	return suitList; 
	    }
	 @RequiresRoles("leader")
	    @RequestMapping(value="update",method=RequestMethod.POST)
	    public @ResponseBody String edit(@RequestBody TestSuit testsuit,HttpSession session) {
		 //Date now = new Date(); 
		 //System.out.println(testcase.getId());
		 //SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//鍙互鏂逛究鍦颁慨鏀规棩鏈熸牸寮�
		 testsuit.setModifyTime(new Date());
	     testSuitBiz.update(testsuit);
	     //System.out.println(testcase.getLogPath());
	     //Map<String, String> result = new HashMap<String, String>();
	     //result.put("msg", "nimei");
	     //return result;
	        //return "/iAutoDemo/detail/testCaseAdmin";
	        //eturn "redirect:/testCase.do/index.view";
	     return "finish";
	    }
}
