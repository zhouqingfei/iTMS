package backend.dashboard.service;

import backend.entity.MachineAdmin;

public interface MachineEditBiz {

	public String add(MachineAdmin machineAdmin ,String loginId);
	public String update(MachineAdmin machineAdmin,String loginId);
	public String powerOn(String mac);
	public String powerOff(String mac);
	public String statusUpdate(String mac);
	public String installAEP(String mac);
}
