package backend.dashboard.tester.controller;



import javax.annotation.Resource;


import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import backend.entity.User;
import backend.system.service.UserBiz;

@Controller
@RequestMapping("userTester.do")
public class UserTesterController {

	
	 @Resource(name = "userBizImpl")
	    private UserBiz userBiz;
	
	 @RequiresRoles("tester")
	    @RequestMapping(value="add",method=RequestMethod.POST)
	    public @ResponseBody String add(@RequestBody User user) {
		
	     //Map<String, String> result = new HashMap<String, String>();
	     //result.put("msg", "nimei");s
	     //return result;
	        //return "/iAutoDemo/detail/testCaseAdmin";
	        //eturn "redirect:/testCase.do/index.view";
	    	 userBiz.add(user);
	        //model.addAttribute("testTaskList", testTaskBiz.findAll());
	    	 System.out.println("11111111111");
	         return "success";
	    }
	 
	
}
