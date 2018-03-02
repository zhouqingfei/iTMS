package backend.dashboard.leader.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


import backend.dashboard.service.UserTmpBiz;
import backend.entity.User;
import backend.system.service.UserBiz;

@Controller
@RequestMapping("userLeader.do")
public class UserLeaderController {

	
	 @Resource(name = "userTmpBizImpl")
	    private UserTmpBiz userTmpBiz;
	 
	 @Resource(name = "userBizImpl")
	    private UserBiz userBiz;
	
	    @RequestMapping(value="add",method=RequestMethod.POST)
	    public @ResponseBody String add(@RequestBody User user) {
		
	     //Map<String, String> result = new HashMap<String, String>();
	     //result.put("msg", "nimei");
	     //return result;
	        //return "/iAutoDemo/detail/testCaseAdmin";
	        //eturn "redirect:/testCase.do/index.view";
	    	 //userBiz.add(user);
		userTmpBiz.add(user);
	        //model.addAttribute("testTaskList", testTaskBiz.findAll());
	    	 System.out.println("11111111111");
	         return "success";
	    }
	 
	    @RequiresRoles("leader")
	    @RequestMapping("deleteNumber")
	    public String deleteNumber(String userId) {
	    	userBiz.deleteNumber(userId);
	        return "redirect:/userAdminLeader.do/userAdmin.view";
	    }

	    @RequestMapping(value="addNumber",method=RequestMethod.POST)
	    public @ResponseBody String addNumber(@RequestBody User user, HttpSession session) {
		
	    	 User addUser=userBiz.findById(user.getUserId());
	 	    if(addUser==null) {
	 	     	return user.getUserId()+"not Exist";
	 	    }else {
	 		System.out.println(session.getAttribute("loginId"));
	 		 user.setLeader((String) session.getAttribute("loginId"));
	 		 //System.out.println(user.getLeader());
	 		 userBiz.updateLeader(user);
	 	        //model.addAttribute("testTaskList", testTaskBiz.findAll());
	 	    	 System.out.println("2222");
	 	         return "success";
	 	         }
	    }
	 @RequiresRoles("leader")
	    @RequestMapping("pass")
	    public String pass(String userId,String email,String phone,String password,String qq,String weChat,String loginId,String roleIds) {
		if(password.equals(""))
		{
			 User user=new User();
			 user.setUserId(userId);
			 List<Long> list=new ArrayList<Long>();
			 Long l=(long) Integer.parseInt(roleIds);
			 list.add(l);
			 user.setRoleIds(list);
			 user.setEmail(email);
			 user.setLoginId(loginId);
			 user.setPassword(password);
			 user.setPhone(phone);
			 user.setQq(qq);
			 user.setWeChat(weChat);
			 userBiz.update(user);
			 userTmpBiz.delete(userId);
		}
		else
		{
		 System.out.println(userId);
		 System.out.println(roleIds);
		 User user=new User();
		 user.setUserId(userId);
		 List<Long> list=new ArrayList<Long>();
		 Long l=(long) Integer.parseInt(roleIds);
		 list.add(l);
		 user.setRoleIds(list);
		 user.setEmail(email);
		 user.setLoginId(loginId);
		 user.setPassword(password);
		 user.setPhone(phone);
		 user.setQq(qq);
		 user.setWeChat(weChat);
		 
		 userBiz.add(user);
		 userTmpBiz.delete(userId);
		}
	        return "redirect:/systemControl.do/index.view";
	    }
	 
	 @RequiresRoles("leader")
	    @RequestMapping("delete")
	    public String delete(String userId) {
		 userTmpBiz.delete(userId);
	        return "redirect:/systemControl.do/index.view";
	    }
}
