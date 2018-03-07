package backend.dashboard.contorller;

import java.util.ArrayList;
import java.util.HashMap;
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

import backend.dashboard.service.ItmsTestCaseTreeBiz;
import backend.entity.ItmsTestCaseTree;
import backend.entity.ItmsTestCaseTreeDTO;

@Controller
@RequestMapping("itmsTestCaseTree.do")
public class ItmsTestCaseTreeController {
	@Resource(name = "itmsTestCaseTreeBizImpl")
    private ItmsTestCaseTreeBiz itmsTestCaseTreeBiz;
	
	@RequiresRoles("admin")
	@RequestMapping(value="loadTree",method=RequestMethod.POST)
	public @ResponseBody List<ItmsTestCaseTreeDTO> loadTree(HttpServletRequest request,Model model) {
			
		String id = request.getParameter("id");
		List<ItmsTestCaseTreeDTO> dtoList = new ArrayList<ItmsTestCaseTreeDTO>();
		
		if("".equals(id) || id == null){
			ItmsTestCaseTree root = itmsTestCaseTreeBiz.getRoot();
			ItmsTestCaseTreeDTO testCaseTreeDTO = new ItmsTestCaseTreeDTO();
			testCaseTreeDTO.setId(root.getId());
			testCaseTreeDTO.setParent_id(root.getParent_id());
			testCaseTreeDTO.setText(root.getName());
			testCaseTreeDTO.setChecked(root.getChecked());
			testCaseTreeDTO.setIconCls(root.getIcon());
			testCaseTreeDTO.setState("closed");

			Map<String, Object>  map = new HashMap<String, Object>();
			map.put("url", root.getUrl());
			map.put("testCaseList", root.getTestCaseList());
			map.put("type", root.getType());
			testCaseTreeDTO.setAttributes(map);
			
			dtoList.add(testCaseTreeDTO);
		}
		else {
			List<ItmsTestCaseTree> list = itmsTestCaseTreeBiz.getChildrenByPid(id);
			for (ItmsTestCaseTree tree:list) {
				ItmsTestCaseTreeDTO testCaseTreeDTO = new ItmsTestCaseTreeDTO();
				testCaseTreeDTO.setId(tree.getId());
				testCaseTreeDTO.setParent_id(tree.getParent_id());
				testCaseTreeDTO.setText(tree.getName());
				testCaseTreeDTO.setChecked(tree.getChecked());
				testCaseTreeDTO.setIconCls(tree.getIcon());
				
				System.out.println(tree.getParent_id());
				if(itmsTestCaseTreeBiz.getChildrenByPid(tree.getId()).size() > 0){
					
					testCaseTreeDTO.setState("closed");
					//System.out.println("closed");
				} else {
					testCaseTreeDTO.setState("open");
					//System.out.println("open");
				}
				
				Map<String, Object>  map = new HashMap<String, Object>();
				map.put("url", tree.getUrl());
				map.put("testCaseList", tree.getTestCaseList());
				map.put("type", tree.getType());
				testCaseTreeDTO.setAttributes(map);
				dtoList.add(testCaseTreeDTO);
			}
		}
		return dtoList;
	}
}
