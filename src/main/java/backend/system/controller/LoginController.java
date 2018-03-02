package backend.system.controller;



import backend.dashboard.service.TestCaseBiz;
import backend.dashboard.service.TestTaskBiz;
import backend.entity.User;
import backend.system.dao.UserDao;
import backend.system.service.UserBiz;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import javax.security.auth.Subject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


@Controller
public class LoginController {

   
//    @Resource(name = "testCaseBizImpl")
//    private TestCaseBiz testCaseBiz;
	 @Resource(name = "userBizImpl")
	    UserBiz userBiz;
    @Resource(name = "testTaskBizImpl")
    private TestTaskBiz testTaskBiz;
    
    @RequestMapping("singin")
    public String singin(HttpServletRequest req, Model model, HttpSession session) {
    	return "/iAutoDemo/detail/frontPage";
    		
    }
    
    
    
    @RequestMapping("login")
    public String login(HttpServletRequest req, Model model, HttpSession session,RedirectAttributes attr) {

    	String username = req.getParameter("username");
    	session.setAttribute("loginId", username);
    	//System.out.println(username);
    	try
    	{
    		//String exceptionClassName = (String) req.getAttribute("shiroLoginFailure");
    		String exceptionClassName = req.getAttribute("shiroLoginFailure").toString();
    	
	        String error = "";
	        if (UnknownAccountException.class.toString().equals(exceptionClassName)) {
	            error = "username/password is wrong";
	        } else if (IncorrectCredentialsException.class.toString().equals(exceptionClassName)) {
	            error = "username/password is wrong";
	        } else if (exceptionClassName != null) {
	            error = "username/password is wrong";
	        }
	        
	        //session.setAttribute("loginError", error);
	        attr.addAttribute("Error", error); 
	        
	        if(error != "")
	        {
	            return "redirect:login.jsp";
	        }
	        else	        	
	        {
	        	org.apache.shiro.subject.Subject subject = SecurityUtils.getSubject();
	            boolean isAuthenticated = subject.isAuthenticated();

	            if (isAuthenticated) {
	                String principal = (String) subject.getPrincipal();
	                User user=userBiz.findById(principal);
	                //System.out.println(user.getRoleIds().get(0)+"");
	                String roleId=user.getRoleIds().get(0)+"";
	                session.setAttribute("username", principal);
	                model.addAttribute("testTaskList", testTaskBiz.findAll((String) session.getAttribute("loginId")));
	    			model.addAttribute("successCount", testTaskBiz.getPassCount((String) session.getAttribute("loginId")));
	         		model.addAttribute("failCount", testTaskBiz.getFailCount((String) session.getAttribute("loginId")));
	         		model.addAttribute("tbdCount", testTaskBiz.getTbdCount((String) session.getAttribute("loginId")));
	         		
	         		model.addAttribute("finishedCount", testTaskBiz.getFinishedCount((String) session.getAttribute("loginId")));
	         		model.addAttribute("runningCount", testTaskBiz.getRunningCount((String) session.getAttribute("loginId")));
	         		model.addAttribute("readyCount", testTaskBiz.getReadyCount((String) session.getAttribute("loginId")));
	         		model.addAttribute("stopCount", testTaskBiz.getStopCount((String) session.getAttribute("loginId")));
	         		model.addAttribute("user", userBiz.findById((String) session.getAttribute("loginId")));
	                switch (roleId) {
	                    case "1":
	                    	//model.addAttribute("testCaseList", testCaseBiz.findAll());
	                    	//System.out.println(testCaseBiz.findAll().get(0).getId());
	                    	
	                    	
	                    	//System.out.println(testTaskBiz.findAll().get(0).getTestTaskId());
	                        return "/iAutoDemo/detail/frontPage";
	                    	//return "admin/main";
	                    case "2":
	                    	//model.addAttribute("testTaskList", testTaskBiz.findAll((String) session.getAttribute("loginId")));
	                    	 return "/iAutoDemo/tester/frontPage";
	                    	 
	                    case "3":
	                    	//model.addAttribute("testTaskList", testTaskBiz.findAll((String) session.getAttribute("loginId")));
	                    	 return "/iAutoDemo/developer/frontPage";
	                    	 
	                    case "4":
	                    	//model.addAttribute("testTaskList", testTaskBiz.findAll((String) session.getAttribute("loginId")));
	                    	 return "/iAutoDemo/leader/frontPage";
	                }
	            } 
	            return "redirect:login.jsp";
	        }
	        
	    }
    	catch(Exception e)
    	{
    		//System.out.println("1111"+e);
    		org.apache.shiro.subject.Subject subject = SecurityUtils.getSubject();
            boolean isAuthenticated = subject.isAuthenticated();

            if (isAuthenticated) {
                String principal = (String) subject.getPrincipal();
                User user=userBiz.findById(principal);
                //System.out.println(user.getRoleIds().get(0)+"");
                String roleId=user.getRoleIds().get(0)+"";
                session.setAttribute("username", principal);
                model.addAttribute("testTaskList", testTaskBiz.findAll((String) session.getAttribute("loginId")));
    			model.addAttribute("successCount", testTaskBiz.getPassCount((String) session.getAttribute("loginId")));
         		model.addAttribute("failCount", testTaskBiz.getFailCount((String) session.getAttribute("loginId")));
         		model.addAttribute("tbdCount", testTaskBiz.getTbdCount((String) session.getAttribute("loginId")));
         		
         		model.addAttribute("finishedCount", testTaskBiz.getFinishedCount((String) session.getAttribute("loginId")));
         		model.addAttribute("runningCount", testTaskBiz.getRunningCount((String) session.getAttribute("loginId")));
         		model.addAttribute("readyCount", testTaskBiz.getReadyCount((String) session.getAttribute("loginId")));
         		model.addAttribute("stopCount", testTaskBiz.getStopCount((String) session.getAttribute("loginId")));
         		model.addAttribute("user", userBiz.findById((String) session.getAttribute("loginId")));
                switch (roleId) {
                    case "1":
                    	//model.addAttribute("testCaseList", testCaseBiz.findAll());
                    	//System.out.println(testCaseBiz.findAll().get(0).getId());
                    	
                    	
                    	//System.out.println(testTaskBiz.findAll().get(0).getTestTaskId());
                        return "/iAutoDemo/detail/frontPage";
                    	//return "admin/main";
                    case "2":
                    	//model.addAttribute("testTaskList", testTaskBiz.findAll((String) session.getAttribute("loginId")));
                    	 return "/iAutoDemo/tester/frontPage";
                    	 
                    case "3":
                    	//model.addAttribute("testTaskList", testTaskBiz.findAll((String) session.getAttribute("loginId")));
                    	 return "/iAutoDemo/developer/frontPage";
                    	 
                    case "4":
                    	//model.addAttribute("testTaskList", testTaskBiz.findAll((String) session.getAttribute("loginId")));
                    	 return "/iAutoDemo/leader/frontPage";
                }
            } 
            return "redirect:login.jsp";
    	}  
    }
}
