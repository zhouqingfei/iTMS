package backend.dashboard.contorller;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import backend.dashboard.service.TestTaskBiz;
import backend.system.service.UserBiz;

@Controller
@RequestMapping("frontPage.do")
public class frontPageController {
	@Resource(name = "testTaskBizImpl")
	private TestTaskBiz testTaskBiz;
	@Resource(name = "userBizImpl")
    private UserBiz userBiz;
	@RequiresRoles(value={"admin","developer","leader","tester"},logical=Logical.OR)
	@RequestMapping("frontPage.view")
	//show frontpage
	public String index(Model model,HttpSession session) {
		// model.addAttribute("testCaseList", testCaseBiz.findAll());
		model.addAttribute("testTaskList", testTaskBiz.findAll((String) session.getAttribute("loginId")));
		// System.out.println(testTaskBiz.findAll().get(0).getTestTaskId());
		model.addAttribute("successCount", testTaskBiz.getPassCount((String) session.getAttribute("loginId")));
		model.addAttribute("failCount", testTaskBiz.getFailCount((String) session.getAttribute("loginId")));
		model.addAttribute("tbdCount", testTaskBiz.getTbdCount((String) session.getAttribute("loginId")));
		System.out.println("~~~~~~~~~~~~~~~~~~~~~~");
		model.addAttribute("finishedCount", testTaskBiz.getFinishedCount((String) session.getAttribute("loginId")));
		model.addAttribute("runningCount", testTaskBiz.getRunningCount((String) session.getAttribute("loginId")));
		model.addAttribute("readyCount", testTaskBiz.getReadyCount((String) session.getAttribute("loginId")));
		model.addAttribute("stopCount", testTaskBiz.getStopCount((String) session.getAttribute("loginId")));
		model.addAttribute("user", userBiz.findById((String) session.getAttribute("loginId")));
		
		return "/iAutoDemo/detail/frontPage";
	}
}
