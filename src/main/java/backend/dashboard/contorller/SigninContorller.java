package backend.dashboard.contorller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import backend.dashboard.service.TestTaskBiz;

@Controller
@RequestMapping("signin.do")
public class SigninContorller {

	@Resource(name = "testTaskBizImpl")
	private TestTaskBiz testTaskBiz;
	@RequestMapping("index.view")
	//show frontpage
	public String index() {
		// model.addAttribute("testCaseList", testCaseBiz.findAll());	
		// System.out.println(testTaskBiz.findAll().get(0).getTestTaskId());
		return "/iAutoDemo/detail/userSigninAdmin";
}

}