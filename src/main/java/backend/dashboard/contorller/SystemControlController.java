package backend.dashboard.contorller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import backend.dashboard.service.UserTmpBiz;

@Controller
@RequestMapping("systemControl.do")
public class SystemControlController {

	 @Resource(name = "userTmpBizImpl")
	    private UserTmpBiz userTmpBiz;
	 @RequestMapping("index.view")
	    public String index(Model model) {
		 model.addAttribute("userList", userTmpBiz.findAll());
	        return "/iAutoDemo/detail/systemControl";
		// return "/admin/system/user/user_add";
	    }
}
