package backend.dashboard.contorller;

import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("performance.do")
public class PerformanceController {

	@RequiresRoles("admin")
	 @RequestMapping("index.view")
	    public String index() {
	     
	        return "/iAutoDemo/detail/performance";
		// return "/admin/system/user/user_add";
	    }
}
