package backend.dashboard.contorller;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import backend.dashboard.service.DeptService;
import backend.dashboard.service.TestCaseBiz;
import backend.entity.Dept;
import backend.entity.TestCase;
import backend.util.TreeModel;

@Controller
@RequestMapping("deptController.do")
public class DeptController {

	 @Resource(name = "deptServiceImpl")
	    private DeptService deptService;
	
	public static final String ROOT = "0";
	
//	@RequiresRoles("admin")
//	@RequestMapping("/deptTree")
	/*
	// 返回的是JSON格式
	public @ResponseBody List<TreeModel> deptTree() {
		
		System.out.println("enter controller");
		String id = ROOT;
		TreeModel tm = deptService.selectTree(id, true);
		System.out.println("in controller");
		return tm.getChildren();
	}*/
	
	@RequiresRoles("admin")
    @RequestMapping(value="deptTree",method=RequestMethod.POST)
	public @ResponseBody List<TreeModel> deptTree() {
			
			System.out.println("enter controller");
			String id = ROOT;
			TreeModel tm = deptService.selectTree(id, true);
			System.out.println("in controller");
			List<TreeModel> result = tm.getChildren();
			/*System.out.println(result);
			for(TreeModel treeModel : result)
			{
				System.out.println(treeModel.getId() + treeModel.getText());
			}*/
			return result;
		}
	
/*	public @ResponseBody List<Dept> deptTree() {
		System.out.println("test");
		List<Dept> list = deptService.findAll();
		System.out.println(list);	
		return list;
	}*/
}
