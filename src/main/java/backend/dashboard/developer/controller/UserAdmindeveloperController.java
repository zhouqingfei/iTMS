package backend.dashboard.developer.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import backend.system.service.UserBiz;

@Controller
@RequestMapping("userAdminDeveloper.do")
public class UserAdmindeveloperController {
	 @Resource(name = "userBizImpl")
	    private UserBiz userBiz;
	 @RequiresRoles("developer")
	 @RequestMapping("userAdmin.view")
	    public String index(Model model, HttpSession session) {
		 model.addAttribute("user", userBiz.findById((String)session.getAttribute("loginId")));
	        return "/iAutoDemo/developer/userAdmin";
		// return "/admin/system/user/user_add";
	    }
	 @RequiresRoles("developer")
	    @RequestMapping("updatePassword")
	    public String updatePassword() {
		
	        return "/iAutoDemo/developer/updatePassword";
	    }
	 @RequiresRoles("developer")
	 @RequestMapping("updatePas")
	    public String updatePas(HttpSession session, String password) {
		 System.out.println(session.getAttribute("loginId"));   
		 System.out.println(password);
	       userBiz.changePassword((String)session.getAttribute("loginId"),password);
	        return "redirect:/userAdminDeveloper.do/updatePassword";
	    }
}
