package backend.dashboard.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import backend.dashboard.test.dao.DeptDao;
import backend.entity.Dept;
import backend.dashboard.service.DeptService;
import backend.util.TreeModel;
import backend.util.TreeUtil;


@Service
public class DeptServiceImpl implements DeptService{
	
	@Resource
	private DeptDao deptDao;
	
	private List<Dept> selectChildren(String id, String type) {
		Map<String, Object> para = new HashMap<String, Object>();
		para.put("type", type);
		para.put("pid", id);
		return deptDao.list(para);
	}

	public TreeModel selectTree(String id, boolean containsDept) {
		
		//System.out.println("111");
		TreeModel tm = new TreeModel();
		String[] s = new String[] { "getId", "getName" };
		String type = containsDept ? "%" : "unit";
		List<Dept> li = this.selectChildren(id, type);
		
		this.tree(tm, li, s, containsDept);
		
		for(Dept dept:li)
		{
			System.out.println(dept.getId() + dept.getName() + dept.getPid() + dept.getType());
		}
		
		return tm;
	}
	
	private void tree(TreeModel tm, List<Dept> li, String[] s,boolean containsDept) {

		if (!CollectionUtils.isEmpty(li)) {

			for (int i = 0, l = li.size(); i < l; i++) {
				TreeModel ntm = new TreeModel();
				Dept dept = li.get(i);

				TreeUtil.copyModel(ntm, dept, s);
				tm.getChildren().add(ntm);

				String type = containsDept ? "%" : "unit";
				List<Dept> list = this.selectChildren(dept.getId(), type);
				for(Dept d:list)
				{
					System.out.println(d.getId() + d.getName() + d.getPid() + d.getType());
				}
				
				tree(ntm, list, s, containsDept);
			}
		}
	}

	@Override
	public List<Dept> findAll() {
		// TODO 自动生成的方法存根
		return deptDao.findAll();
	}
}
