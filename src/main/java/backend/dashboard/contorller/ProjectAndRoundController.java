package backend.dashboard.contorller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import backend.dashboard.service.ProjectAndRoundBiz;
import backend.entity.ProjectAndRound;
import backend.entity.ProjectAndRoundDTO;
import backend.util.TreeModel;


@Controller
@RequestMapping("projectAndRound.do")

public class ProjectAndRoundController {
	@Resource(name = "projectAndRoundBizImpl")
    private ProjectAndRoundBiz projectAndRoundBiz;

	@RequiresRoles("admin")
	@RequestMapping(value="loadTree",method=RequestMethod.POST)
	public @ResponseBody List<ProjectAndRoundDTO> loadTree(HttpServletRequest request,Model model) {
			
		String id = request.getParameter("id");
		List<ProjectAndRoundDTO> dtoList = new ArrayList<ProjectAndRoundDTO>();
		
		if("".equals(id) || id == null){
			ProjectAndRound root = projectAndRoundBiz.getRoot();
			ProjectAndRoundDTO parDTO = new ProjectAndRoundDTO();
			parDTO.setId(root.getId());
			parDTO.setParent_id(root.getParent_id());
			parDTO.setText(root.getName());
			parDTO.setChecked(root.getChecked());
			parDTO.setIconCls(root.getIcon());
			parDTO.setState("closed");

			Map<String, Object>  map = new HashMap<String, Object>();
			map.put("url", root.getUrl());
			map.put("testCaseList", root.getTestCaseList());
			map.put("type", root.getType());
			parDTO.setAttributes(map);
			
			dtoList.add(parDTO);
		}
		else {
			List<ProjectAndRound> list = projectAndRoundBiz.getChildrenByPid(id);
			for (ProjectAndRound par:list) {
				ProjectAndRoundDTO parDTO = new ProjectAndRoundDTO();
				parDTO.setId(par.getId());
				parDTO.setParent_id(par.getParent_id());
				parDTO.setText(par.getName());
				parDTO.setChecked(par.getChecked());
				parDTO.setIconCls(par.getIcon());
				
				System.out.println(par.getParent_id());
				if(projectAndRoundBiz.getChildrenByPid(par.getId()).size() > 0){
					
					parDTO.setState("closed");
					//System.out.println("closed");
				} else {
					parDTO.setState("open");
					//System.out.println("open");
				}
				
				Map<String, Object>  map = new HashMap<String, Object>();
				map.put("url", par.getUrl());
				map.put("testCaseList", par.getTestCaseList());
				map.put("type", par.getType());
				parDTO.setAttributes(map);
				dtoList.add(parDTO);
			}
		}
		//String count = projectAndRoundBiz.findAll().size() + "";
		//System.out.println(count);
		//model.addAttribute("count", count);
		return dtoList;
	}
	
	@RequiresRoles("admin")
	@RequestMapping(value="save",method=RequestMethod.POST)
	public @ResponseBody String save(HttpServletRequest request,Model model) {

		try {
			//String id = request.getParameter("id");
			String parentId = request.getParameter("parentId");
			String name = request.getParameter("name");
			String url  = request.getParameter("url");
			String type  = request.getParameter("type");
			
			System.out.println(type);
			
			ProjectAndRound projectAndRound = projectAndRoundBiz.getRoot();
			
			//projectAndRound.setId(id);
			projectAndRound.setName(name);
			projectAndRound.setUrl(url);
			projectAndRound.setParent_id(parentId);
			projectAndRound.setType(type);
			projectAndRound.setTestCaseList("");;
			projectAndRound.setChecked(0);
			projectAndRound.setIcon("");
			
			projectAndRoundBiz.save(projectAndRound);
			
			
		} catch (Exception e) {
			e.printStackTrace();
			return "insert fail";
		}
		
		//model.addAttribute("count", projectAndRoundBiz.findAll().size());
		//String count = projectAndRoundBiz.findAll().size() + "";
		//System.out.println(count);
		//return "insert success:" + count;
		return "insert success";
	}
	
	@RequiresRoles("admin")
	@RequestMapping(value="update",method=RequestMethod.POST)
	public @ResponseBody String update(HttpServletRequest request,Model model) {

		try {
			String id = request.getParameter("id");
			String name = request.getParameter("name");
			
			ProjectAndRound projectAndRound = new ProjectAndRound();
			
			projectAndRound.setId(id);
			projectAndRound.setName(name);
			
			projectAndRoundBiz.update(projectAndRound);

		} catch (Exception e) {
			e.printStackTrace();
			return "update fail";
		}
		return "update success";
	}
	
	@RequiresRoles("admin")
	@RequestMapping(value="delete",method=RequestMethod.POST)
	public @ResponseBody String delete(HttpServletRequest request,Model model) {

		try {
			int id = Integer.parseInt(request.getParameter("id"));

			ProjectAndRound projectAndRound = new ProjectAndRound();
			
			projectAndRoundBiz.delete(id);

		} catch (Exception e) {
			e.printStackTrace();
			return "delete fail";
		}
		return "delete success";
	}
	
}
