package backend.dashboard.tester.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import backend.dashboard.service.MachineEditBiz;
import backend.dashboard.service.MachineAdminBiz;
import backend.dashboard.service.MachineBiz;
import backend.dashboard.service.NetworkBiz;
import backend.dashboard.service.NetworkExecuteBiz;
import backend.entity.Machine;
import backend.entity.MachineAdmin;
import backend.entity.Network;

@Controller
@RequestMapping("machineTester.do")
public class MachineLTesterController {

	@Resource(name = "networkBizImpl")
	private NetworkBiz netwokBiz;
	@Resource(name = "networkExecuteBizImpl")
	private NetworkExecuteBiz networkExecuteBiz;
	@Resource(name = "machineBizImpl")
	private MachineBiz machineBiz;
	@Resource(name = "machineEditBizImpl")
	private MachineEditBiz machineEditBiz;

	@RequiresRoles("tester")
	@RequestMapping("addMachine.view")
	public String index(Model model, HttpSession session) {
		// List<Machine> machineList=machineBiz.findAll();
		model.addAttribute("machineList", machineBiz.findAll((String) session.getAttribute("loginId")));
		return "/iAutoDemo/tester/addMachine";
	}
	/*
	 * @RequiresRoles("admin")
	 * 
	 * @RequestMapping("scan") public @ResponseBody List<Machine> scan() {
	 * List<Machine> machineList=machineBiz.findAll();
	 * //model.addAttribute("machineList", machineBiz.findAll()); return
	 * machineList; }
	 */

	// 新增机器页面
	@RequiresRoles("tester")
	@RequestMapping("scan")
	public @ResponseBody Map<String, Object> scan(String id, HttpSession session) throws Exception {
		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~");

		Network network = netwokBiz.findByid(Integer.valueOf(id));
		String addr = network.getAddr();
		String ip = network.getIp();
		String user = network.getUser();
		String psd = network.getPsd();
		System.out.println(ip + "~~~" + user + "~~~" + psd);
		String loginID = (String) session.getAttribute("loginId");
		System.out.println(session.getAttribute("loginId"));
		String msg=networkExecuteBiz.execute(Integer.valueOf(id), loginID);
		List<Machine> machineList = machineBiz.findAll((String) session.getAttribute("loginId"));
		// model.addAttribute("machineList", machineBiz.findAll());
		// return "/iAutoDemo/detail/addMachine";
		Map<String, Object> map = new HashMap<>();
		map.put("result", msg);
		map.put("machineList", machineList);
		return map;
	}

	// 新建机器信息
	@RequiresRoles("tester")
	@RequestMapping("createMachineInfo")
	public String createMachineInfo(String id, Model model) {
		model.addAttribute("id", id);
		return "/iAutoDemo/tester/createMachineInfo";
	}

	// 新建机器信息保存
	@RequiresRoles("tester")
	@RequestMapping(value = "save", method = RequestMethod.POST)
	public @ResponseBody String save(@RequestBody MachineAdmin machineinfo, HttpSession session) {

		String lohinID = (String) session.getAttribute("loginId");
		String msg = machineEditBiz.add(machineinfo, lohinID);
		return msg;
	}

	// 机器管理页面显示
	@Resource(name = "machineAdminBizImpl")
	private MachineAdminBiz machineAdminBiz;

	@RequiresRoles("tester")
	@RequestMapping("machineAdmin.view")
	public String index1(Model model, HttpSession session) {
		model.addAttribute("temList", machineAdminBiz.findTem());
		model.addAttribute("sutList", machineAdminBiz.findSut());
		return "/iAutoDemo/tester/machineAdmin";
	}

	// 机器信息编辑权限
	@RequiresRoles("tester")
	@RequestMapping("editMachineInfo")
	public @ResponseBody String editMachineInfo(String hostMac, HttpSession session) {

		System.out.println(hostMac);

		String user = machineAdminBiz.findMachineByMAC(hostMac).getUser();
		String user_id = machineAdminBiz.findMachineByMAC(hostMac).getUser_id();
		String loginID = (String) session.getAttribute("loginId");

		System.out.println(hostMac);

		if (loginID.equals(user_id) || loginID.equals(user)) {
			// model.addAttribute("machineInfo", machineAdminBiz.findMachineByMAC(hostmac));
			return "success";
		} else {
			return "Permission Denied";
		}

	}

	// 跳转机器信息编辑页面
	@RequiresRoles("tester")
	@RequestMapping("updateMachineInfo")
	public String updateMachineInfo(Model model, String hostMac, int id) {
		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~");
		model.addAttribute("machineInfo", machineAdminBiz.findMachineByMAC(hostMac));
		model.addAttribute("id", id);
		// model.addAttribute("machineList", machineBiz.findAll());
		// return "/iAutoDemo/detail/addMachine";
		return "/iAutoDemo/tester/editMachineInfo";

	}

	// 机器信息编辑页面保存
	@RequiresRoles("tester")
	@RequestMapping(value = "machineUpdate", method = RequestMethod.POST)
	public @ResponseBody String machineUpdate(@RequestBody MachineAdmin machineinfo,HttpSession session) {
		String loginID = (String) session.getAttribute("loginId");
		System.out.println(machineinfo.getModel());
		System.out.println(machineinfo.getType());
		System.out.println(machineinfo.getHost_mac());
		System.out.println(machineinfo.getBmc_mac());
		System.out.println(machineinfo.getUser());
		System.out.println(machineinfo.getComment());
		String msg = machineEditBiz.update(machineinfo,loginID);
		return msg;
	}

	@RequiresRoles("tester")
	@RequestMapping("preSetUp")
	public String preSetUp(Model model, String hostMac, int id) {
		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~");
		model.addAttribute("machineInfo", machineAdminBiz.findMachineByMAC(hostMac));
		model.addAttribute("id", id);
		// model.addAttribute("machineList", machineBiz.findAll());
		// return "/iAutoDemo/detail/addMachine";
		return "/iAutoDemo/tester/preSetUp";

	}

	@RequiresRoles("tester")
	@RequestMapping(value = "deleteMachine", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> deleteMachine(String hostMac, HttpSession session) {
		String msg = "";
		String loginId = (String) session.getAttribute("loginId");
		String user = machineAdminBiz.findMachineByMAC(hostMac).getUser();
		String user_id = machineAdminBiz.findMachineByMAC(hostMac).getUser_id();
		System.out.println(hostMac);
		if (loginId.equals(user_id) || loginId.equals(user)) {
			// model.addAttribute("machineInfo", machineAdminBiz.findMachineByMAC(hostmac));
			machineAdminBiz.delete(hostMac);
			msg = "delete success";
		} else {
			msg = "Permission Denied";
		}
		List<MachineAdmin> TemList = machineAdminBiz.findTem();
		List<MachineAdmin> SutList = machineAdminBiz.findSut();
		Map<String, Object> map = new HashMap<>();
		map.put("result", msg);
		map.put("deTemList", TemList);
		map.put("deSutList", SutList);
		return map;
	}

	@RequiresRoles("tester")
	@RequestMapping(value = "powerOn", method = RequestMethod.GET)
	public @ResponseBody String powerOn(String hostMac, HttpSession session) {
		String loginId = (String) session.getAttribute("loginId");
		String user = machineAdminBiz.findMachineByMAC(hostMac).getUser();
		String user_id = machineAdminBiz.findMachineByMAC(hostMac).getUser_id();
		System.out.println(hostMac);
		if (loginId.equals(user_id) || loginId.equals(user)) {
			// model.addAttribute("machineInfo", machineAdminBiz.findMachineByMAC(hostmac));
			String msg = machineEditBiz.powerOn(hostMac);
			return msg;
		} else {
			return "Permission Denied";
		}
	}

	@RequiresRoles("tester")
	@RequestMapping(value = "powerOff")
	public @ResponseBody String powerOff(String hostMac, HttpSession session) {
		String loginId = (String) session.getAttribute("loginId");
		String user = machineAdminBiz.findMachineByMAC(hostMac).getUser();
		String user_id = machineAdminBiz.findMachineByMAC(hostMac).getUser_id();
		System.out.println(hostMac);
		if (loginId.equals(user_id) || loginId.equals(user)) {
			// model.addAttribute("machineInfo", machineAdminBiz.findMachineByMAC(hostmac));
			String msg = machineEditBiz.powerOff(hostMac);
			return msg;
		} else {
			return "Permission Denied";
		}
	}

	@RequiresRoles("tester")
	@RequestMapping(value = "installAEP")
	public @ResponseBody String installAEP(String hostMac, HttpSession session) {
		String loginId = (String) session.getAttribute("loginId");
		String user = machineAdminBiz.findMachineByMAC(hostMac).getUser();
		String user_id = machineAdminBiz.findMachineByMAC(hostMac).getUser_id();
		System.out.println(hostMac);
		if (loginId.equals(user_id) || loginId.equals(user)) {
			// model.addAttribute("machineInfo", machineAdminBiz.findMachineByMAC(hostmac));
			String msg = machineEditBiz.installAEP(hostMac);
			return msg;
		} else {
			return "Permission Denied";
		}
	}

	@RequiresRoles("tester")
	@RequestMapping(value = "statusUpdate")
	public @ResponseBody Map<String, Object> statusUpdate(String hostMac, HttpSession session) {
		String msg = machineEditBiz.statusUpdate(hostMac);
		List<MachineAdmin> TemList = machineAdminBiz.findTem();
		List<MachineAdmin> SutList = machineAdminBiz.findSut();
		Map<String, Object> map = new HashMap<>();
		map.put("result", msg);
		map.put("updateTemList", TemList);
		map.put("updateSutList", SutList);

		return map;
		// return msg;
	}

	// 全机线上更新
	@RequiresRoles("tester")
	@RequestMapping(value = "update", method = RequestMethod.GET)
	public @ResponseBody Map<Object, Object> update(int id) {
		/*
		 * System.out.println(id); System.out.println(netwokBiz.findByid(id).getAddr());
		 * System.out.println(machineAdminBiz.findTemByAddr(netwokBiz.findByid(id).
		 * getAddr()).size());
		 */
		// String loginId=(String) session.getAttribute("loginId");
		List<MachineAdmin> TemList = machineAdminBiz.findTem();
		List<MachineAdmin> SutList = machineAdminBiz.findSut();
		for (MachineAdmin attribute : TemList) {
			machineEditBiz.statusUpdate(attribute.getHost_mac());
		}
		for (MachineAdmin attribute : SutList) {
			machineEditBiz.statusUpdate(attribute.getHost_mac());
		}
		List<MachineAdmin> newTemList = machineAdminBiz.findTemByAddr(netwokBiz.findByid(id).getAddr());
		List<MachineAdmin> newSutList = machineAdminBiz.findSutByAddr(netwokBiz.findByid(id).getAddr());
		/*
		 * for(MachineAdmin attribute : newSutList) { if(attribute.getUser_id()!=loginId
		 * && attribute.getUser()!=loginId) { newSutList.remove(attribute); } }
		 */
		/*
		 * model.addAttribute("newtemList",
		 * machineAdminBiz.findTemByAddr(netwokBiz.findByid(id).getAddr()));
		 * model.addAttribute("newsutList",
		 * machineAdminBiz.findSutByAddr(netwokBiz.findByid(id).getAddr()));
		 */
		Map<Object, Object> map = new HashMap<>();
		map.put("newSutList", newSutList);
		map.put("newTemList", newTemList);

		return map;
	}
}
