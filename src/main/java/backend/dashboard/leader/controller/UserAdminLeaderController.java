package backend.dashboard.leader.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import backend.dashboard.service.TestCaseBiz;
import backend.dashboard.service.TestTaskBiz;
import backend.system.service.UserBiz;

@Controller
@RequestMapping("userAdminLeader.do")
public class UserAdminLeaderController {
	@Resource(name = "testTaskBizImpl")
	private TestTaskBiz testTaskBiz;
	 @Resource(name = "testCaseBizImpl")
	    private TestCaseBiz testCaseBiz;
	 @Resource(name = "userBizImpl")
	    private UserBiz userBiz;
	 @RequiresRoles("leader")
	 @RequestMapping("userAdmin.view")
	    public String index(Model model, HttpSession session) {
		 
		 model.addAttribute("user", userBiz.findById((String)session.getAttribute("loginId")));
		 
		 //System.out.println(userBiz.findById((String)session.getAttribute("loginId")).getRoleIdsStr());
		 model.addAttribute("userList", userBiz.findAllUser((String)session.getAttribute("loginId")));
	        return "/iAutoDemo/leader/userAdmin";
		// return "/admin/system/user/user_add";
	    }
	 
	 @RequiresRoles("leader")
	 @RequestMapping("addNumber.view")
	    public String addNumber(Model model) {
		 
	        return "/iAutoDemo/leader/addNumber";
		// return "/admin/system/user/user_add";
	    }
	 
	
	 @RequestMapping("openUser")
	    public String openUser(Model model,String userId) {
		 System.out.println(userId);
		 model.addAttribute("testTaskList", testTaskBiz.findAll(userId));
			return "/iAutoDemo/detail/frontPageNumber";
		// return "/admin/system/user/user_add";
	    }
	 @RequiresRoles("leader")
	    @RequestMapping("updatePassword")
	    public String updatePassword() {
		
	        return "/iAutoDemo/leader/updatePassword";
	    }
	 @RequiresRoles("leader")
	 @RequestMapping("updatePas")
	    public String updatePas(HttpSession session, String password) {
		 System.out.println(session.getAttribute("loginId"));   
		 System.out.println(password);
	       userBiz.changePassword((String)session.getAttribute("loginId"),password);
	        return "redirect:/userAdminLeader.do/updatePassword";
	    }
	 
}
