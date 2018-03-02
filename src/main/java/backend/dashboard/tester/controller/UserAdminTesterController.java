package backend.dashboard.tester.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import backend.system.service.UserBiz;

@Controller
@RequestMapping("userAdminTester.do")
public class UserAdminTesterController {
	 @Resource(name = "userBizImpl")
	    private UserBiz userBiz;
	 @RequiresRoles("tester")
	 @RequestMapping("userAdmin.view")
	    public String index(Model model, HttpSession session) {
		 model.addAttribute("user", userBiz.findById((String)session.getAttribute("loginId")));
	        return "/iAutoDemo/tester/userAdmin";
		// return "/admin/system/user/user_add";
	    }
	 @RequiresRoles("tester")
	    @RequestMapping("updatePassword")
	    public String updatePassword() {
		
	        return "/iAutoDemo/tester/updatePassword";
	    }
	 @RequiresRoles("tester")
	 @RequestMapping("updatePas")
	    public String updatePas(HttpSession session, String password) {
		 System.out.println(session.getAttribute("loginId"));   
		 System.out.println(password);
	       userBiz.changePassword((String)session.getAttribute("loginId"),password);
	        return "redirect:/userAdminTester.do/updatePassword";
	    }
}
