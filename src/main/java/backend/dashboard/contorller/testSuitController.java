package backend.dashboard.contorller;

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
import backend.entity.TestSuit;;

@Controller
@RequestMapping("testSuit.do")
public class testSuitController {

	@Resource(name = "testSuitBizImpl")
    private TestSuitBiz testSuitBiz;

	
	@Resource(name = "testCaseBizImpl")
    private TestCaseBiz testCaseBiz;
	 @RequiresRoles("admin")
	    @RequestMapping("index.view")
	    public String index(Model model) {
		 model.addAttribute("testSuitList", testSuitBiz.findAll());
	        return "/iAutoDemo/detail/testSuitAdmin";
	    }
	 
	 @RequiresRoles("admin")
	    @RequestMapping("add.view")
	    public String addView(Model model) {
		 model.addAttribute("testCaseList", testCaseBiz.findAll());
	        return "/iAutoDemo/detail/addTestSuit";
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
	 
	 @RequiresRoles("admin")
		@RequestMapping(value = "add", method = RequestMethod.POST)
		public @ResponseBody String add(@RequestBody TestSuit testsuit, HttpSession session) {
		 System.out.println(testsuit.getTestSuitDescribe());
		 System.out.println(testsuit.getTestSuitCategory());
		 	 testsuit.setModifyTime(new Date());//set time
			 testsuit.setUserLoginId((String)session.getAttribute("loginId"));
		     testSuitBiz.add(testsuit);
			 return "success";
	 }
	 
	 @RequiresRoles("admin")
	 @RequestMapping(value="testSuitSearch",method=RequestMethod.GET)
	 public @ResponseBody List<TestSuit> testSuitSearch(String content) {
		 System.out.println(content);
		 List<TestSuit> searchSuitList = testSuitBiz.search(content);
		 System.out.println(searchSuitList+"~~~~~~~~~~~");
		 return searchSuitList;
		 }
	 
	 @RequiresRoles("admin")
	    @RequestMapping("edit")
	    public String edit(int id,Model model) {
		 model.addAttribute("testSuit", testSuitBiz.findTestSuitById(id)); 
		 model.addAttribute("testCaseList", testCaseBiz.findAll());
		 //System.out.println(testCaseBiz.findTestCaseById(id).getLogPath());
		 return "/iAutoDemo/detail/editTestSuit";
	    }
	 
	/* @RequiresRoles("admin")
	    @RequestMapping("delete")
	    public String delete(int id) {
	        testSuitBiz.delete(id);
	        return "redirect:/testSuit.do/index.view";
	    }*/
	 @RequiresRoles("admin")
	    @RequestMapping(value="delete",method=RequestMethod.GET)
	    public @ResponseBody List<TestSuit> delete(int id) {
	    	
	    	testSuitBiz.delete(id);
		 	List<TestSuit> suitList = testSuitBiz.findAll();
		 	return suitList; 
	    }
	 @RequiresRoles("admin")
	    @RequestMapping(value="update",method=RequestMethod.POST)
	    public @ResponseBody String edit(@RequestBody TestSuit testsuit,HttpSession session) {
		 //Date now = new Date(); 
		 //System.out.println(testcase.getId());
		 //SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//閸欘垯浜掗弬閫涚┒閸﹂鎱ㄩ弨瑙勬）閺堢喐鐗稿锟�
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
