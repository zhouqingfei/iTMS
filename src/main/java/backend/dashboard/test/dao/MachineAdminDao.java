package backend.dashboard.test.dao;

import java.util.List;

import backend.dashboard.service.impl.MachineAdminBizImpl;
import backend.entity.Machine;
import backend.entity.MachineAdmin;


public interface MachineAdminDao {
	public List<MachineAdmin> findTem();
	public List<MachineAdmin> findSut();
	public void add(MachineAdmin machineAdmin);
	public void delete(String hostMac);
	public void update(MachineAdmin machineAdmin);
	public MachineAdmin findMachineByMAC(String mac);
	public List<MachineAdmin> findMachineByUser(String user);
	public List<MachineAdmin> findTemByAddr(String addr);
	public List<MachineAdmin> findSutByAddr(String addr);
    //public void add(String deptName);
    /*public ReportLog findTestCaseById(int id);
	public void add(ReportLog reportLog);
	public void delete(int id);*/
}
