package backend.system.controller;

import backend.dashboard.service.TestTaskBiz;
import backend.entity.TestCase;
import backend.entity.User;
import backend.system.service.RoleBiz;
import backend.system.service.UserBiz;

import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.lang.reflect.InvocationTargetException;



@Controller
@RequiresRoles("admin")
@RequestMapping("user1.do")
public class UserController1 {

	@Resource(name = "testTaskBizImpl")
	private TestTaskBiz testTaskBiz;
    @Resource(name = "userBizImpl")
    private UserBiz userBiz;

    @Resource(name = "roleBizImpl")
    private RoleBiz roleBiz;

    @RequiresRoles("admin")
    @RequestMapping("user.view")
    public String userView(Model m) throws InvocationTargetException, IllegalAccessException {
        m.addAttribute("userList", userBiz.findAll());
        return "/admin/system/user/user";
    }

    @RequiresRoles("admin")
    @RequestMapping("user_add.view")
    public String userAddView(Model m) {
        m.addAttribute("roleList", roleBiz.findAll());
        return "/admin/system/user/user_add";
    }

    @RequiresRoles("admin")
    @RequestMapping("findById")
    public String findById(String id, Model m) {
        //todo 这里要做非空判断
        m.addAttribute("user", userBiz.findById(id));
        return "/admin/system/user/user_update";
    }

    @RequiresRoles("admin")
    @RequestMapping("update")
    public String update(User user) {
        userBiz.update(user);
        return "redirect:/user.do/user.view";
    }

    @RequiresRoles("admin")
    @RequestMapping(value="add",method=RequestMethod.POST)
    public @ResponseBody String add(@RequestBody User user,HttpSession session) {

        //userBiz.add(user);
        //model.addAttribute("testTaskList", testTaskBiz.findAll());
		// System.out.println(testTaskBiz.findAll().get(0).getTestTaskId());
        return "555";
    }

    @RequiresRoles("admin")
    @RequestMapping("delete")
    public String delete(String id) {
        userBiz.delete(id);
        return "redirect:/user.do/user.view";
    }

}
