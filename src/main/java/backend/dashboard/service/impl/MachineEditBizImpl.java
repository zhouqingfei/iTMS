package backend.dashboard.service.impl;

import org.springframework.stereotype.Service;

import com.inspur.iauto.aep.AEPStatusRequest;
import com.inspur.iauto.aep.AEPStatusResult;
import com.inspur.iauto.aep.network.ACPSockClient;
import com.inspur.iauto.aep.tools.RemoteMachineControl;

import backend.dashboard.service.MachineEditBiz;
import backend.dashboard.service.MachineAdminBiz;
import backend.dashboard.service.MachineBiz;
import backend.entity.MachineAdmin;

import java.util.Date;

import javax.annotation.Resource;

@Service
public class MachineEditBizImpl implements MachineEditBiz {

	@Resource(name = "machineBizImpl")
	private MachineBiz machineBiz;

	@Resource(name = "machineAdminBizImpl")
	private MachineAdminBiz machineAdminBiz;

	@Override
	public String add(MachineAdmin machineAdmin,String loginId){
		// TODO Auto-generated method stub
		 String msg="";
		 Date date=new Date();
		 String model=machineAdmin.getModel();
		 String type=machineAdmin.getType();
		 String host_mac=machineAdmin.getHost_mac();
		 String bmc_mac=machineAdmin.getBmc_mac();
		 String user=machineAdmin.getUser();
		 String bmc_user=machineAdmin.getBmc_user();
		 String bmc_psd=machineAdmin.getBmc_psd();
		 String comment=machineAdmin.getComment();
		 System.out.println(machineAdmin.getModel());
		 System.out.println(machineAdmin.getType());
		 System.out.println(machineAdmin.getHost_mac());
		 System.out.println(machineAdmin.getBmc_mac());
		 System.out.println(machineAdmin.getUser());
		 System.out.println(machineAdmin.getComment());
		 System.out.println(loginId);
		 
		 if(machineBiz.findMachineByMAC(host_mac.toUpperCase(),loginId)==null && machineBiz.findMachineByMAC(host_mac.toLowerCase(),loginId)==null) { 
			 msg=host_mac+" Not Exist";
		 }else if(machineBiz.findMachineByMAC(bmc_mac.toLowerCase(),loginId)==null && machineBiz.findMachineByMAC(bmc_mac.toUpperCase(),loginId)==null ) {
			 msg=bmc_mac+" Not Exist";
		 }else if(machineAdminBiz.findMachineByMAC(host_mac.toLowerCase())!=null || machineAdminBiz.findMachineByMAC(host_mac.toUpperCase())!=null){
			 msg="The Machine Already Exist";
		 }else {
			 machineAdmin.setStatus("Ready");
			 machineAdmin.setLine_status("OffLine");
			 machineAdmin.setOs("N/A");
			 machineAdmin.setUser_id(loginId);
			 if(machineBiz.findMachineByMAC(host_mac.toUpperCase(),loginId)!=null) {
				 machineAdmin.setHost_ip(machineBiz.findMachineByMAC(host_mac.toUpperCase(),loginId).getIp());
			 }else {
				 machineAdmin.setHost_ip(machineBiz.findMachineByMAC(host_mac.toLowerCase(),loginId).getIp());
			 }
			 
			 if(machineBiz.findMachineByMAC(bmc_mac.toUpperCase(),loginId)!=null) {
				 machineAdmin.setBmc_ip(machineBiz.findMachineByMAC(bmc_mac.toUpperCase(),loginId).getIp());
				 machineAdmin.setAddr(machineBiz.findMachineByMAC(bmc_mac.toUpperCase(),loginId).getAddr());
			 }else {
				 machineAdmin.setBmc_ip(machineBiz.findMachineByMAC(bmc_mac.toLowerCase(),loginId).getIp());
				 machineAdmin.setAddr(machineBiz.findMachineByMAC(bmc_mac.toLowerCase(),loginId).getAddr());
			 }
			// machineAdmin.setHost_ip(host_ip);
			 machineAdmin.setTime(date);
			 machineAdminBiz.add(machineAdmin);
			 msg="Insert Success";
		 }
		 
		return msg;
	}

	@Override
	public String update(MachineAdmin machineAdmin,String loginId) {
		// TODO Auto-generated method stub
		 String model=machineAdmin.getModel();
		 String type=machineAdmin.getType();
		 String host_mac=machineAdmin.getHost_mac();
		 String bmc_mac=machineAdmin.getBmc_mac();
		 String user=machineAdmin.getUser();
		 String comment=machineAdmin.getComment();
		 String bmc_user=machineAdmin.getBmc_user();
		 String bmc_psd=machineAdmin.getBmc_psd();
		 String msg="";
		 MachineAdmin newMachineAdmin=machineAdminBiz.findMachineByMAC(host_mac);
		 newMachineAdmin.setModel(model);
		 newMachineAdmin.setType(type);
		 newMachineAdmin.setUser(user);
		 newMachineAdmin.setBmc_mac(bmc_mac);
		 newMachineAdmin.setBmc_user(bmc_user);
		 newMachineAdmin.setBmc_psd(bmc_psd);
		 newMachineAdmin.setComment(comment);
		 Date date=new Date();
		 if(machineBiz.findMachineByMAC(bmc_mac.toLowerCase(),loginId)==null && machineBiz.findMachineByMAC(bmc_mac.toUpperCase(),loginId)==null ) {
			 msg=bmc_mac+" Not Exist";
		 }else {
			 
			 if(machineBiz.findMachineByMAC(bmc_mac.toUpperCase(),loginId)!=null) {
				 newMachineAdmin.setBmc_ip(machineBiz.findMachineByMAC(bmc_mac.toUpperCase(),loginId).getIp());
			 }else {
				 newMachineAdmin.setBmc_ip(machineBiz.findMachineByMAC(bmc_mac.toLowerCase(),loginId).getIp());
			 }
			// machineAdmin.setHost_ip(host_ip);
			 newMachineAdmin.setTime(date);
			 machineAdminBiz.update(newMachineAdmin);
			 msg="Update Success";
		 }
		 
		return msg;
	}

	@Override
	public String powerOn(String mac) {
		//MachineAdmin machineAdmin=machineAdminBiz.findMachineByMAC(mac);
		// TODO Auto-generated method stub
		String  ip=machineAdminBiz.findMachineByMAC(mac).getBmc_ip();
		String  user=machineAdminBiz.findMachineByMAC(mac).getBmc_user();
		String  pwd=machineAdminBiz.findMachineByMAC(mac).getBmc_psd();
		System.out.println(ip+user+pwd+"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
		boolean result=RemoteMachineControl.powerOn(ip, user, pwd);
		if(result==true) {
			//machineAdmin.setLine_status("OnLine");
			//machineAdminBiz.update(machineAdmin);
			return "Power On Success";
		}else {
			return "Power On Fail";
		}
	}

	@Override
	public String powerOff(String mac) {
		//MachineAdmin machineAdmin=machineAdminBiz.findMachineByMAC(mac);
		// TODO Auto-generated method stub
		String  ip=machineAdminBiz.findMachineByMAC(mac).getBmc_ip();
		String  user=machineAdminBiz.findMachineByMAC(mac).getBmc_user();
		String  pwd=machineAdminBiz.findMachineByMAC(mac).getBmc_psd();
		boolean result=RemoteMachineControl.powerOff(ip, user, pwd);
		if(result==true) {
			//machineAdmin.setLine_status("OffLine");
			//machineAdminBiz.update(machineAdmin);
			return "Power Off Success";
		}else {
			return "Power Off Fail";
		}
	}

	@Override
	public String statusUpdate(String mac) {
		// TODO Auto-generated method stub
		 Date date=new Date();
		MachineAdmin machineAdmin = machineAdminBiz.findMachineByMAC(mac);
		String hostMac=machineAdminBiz.findMachineByMAC(mac).getHost_mac();
		String hostIp=machineAdminBiz.findMachineByMAC(mac).getHost_ip();
		String bmcMac=machineAdminBiz.findMachineByMAC(mac).getBmc_mac();
		String bmcIp=machineAdminBiz.findMachineByMAC(mac).getBmc_ip();
		String bmcUser=machineAdminBiz.findMachineByMAC(mac).getBmc_user();
		String bmcPwd=machineAdminBiz.findMachineByMAC(mac).getBmc_psd();
		AEPStatusRequest rep=new AEPStatusRequest();
		rep.bmcIp=bmcIp;
		rep.bmcMac=bmcMac;
		rep.bmcPwd=bmcPwd;
		rep.bmcUser=bmcUser;
		rep.hostIp=hostIp;
		rep.hostMac=hostMac;
		AEPStatusResult ret=new AEPStatusResult();
		ret = ACPSockClient.queryStatus(hostIp,rep);
		if(ret.connected==false) {
			machineAdmin.setStatus("N/A");
			machineAdmin.setLine_status("OffLine");
			machineAdmin.setOs("N/A");
			machineAdmin.setBmc_ver("N/A");
			machineAdmin.setBios_ver("N/A");
			machineAdmin.setTime(date);
			machineAdminBiz.update(machineAdmin);
			return "Update Fail!Please Check ...";
		}else {
			System.out.println(ret.aepState.toString());
			machineAdmin.setStatus(ret.aepState.toString());
			machineAdmin.setLine_status("OnLine");
			machineAdmin.setOs(ret.osInfo);
			machineAdmin.setBmc_ver(ret.bmcInfo);
			System.out.println(ret.bmcInfo+"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
			machineAdmin.setBios_ver(ret.biosInfo);
			machineAdmin.setTime(date);
			machineAdminBiz.update(machineAdmin);
			return "Update Success";
		}
		
	}

	@Override
	public String installAEP(String mac) {
		// TODO Auto-generated method stub
		String ip=machineAdminBiz.findMachineByMAC(mac).getHost_ip();
		boolean result=RemoteMachineControl.installAep(ip);
		if(result==true) {
			//machineAdmin.setLine_status("OffLine");
			//machineAdminBiz.update(machineAdmin);
			return "AEP Install Success";
		}else {
			return "AEP Install Fail";
		}
	}

}
