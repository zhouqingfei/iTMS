package backend.dashboard.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import backend.dashboard.service.MachineAdminBiz;
import backend.dashboard.test.dao.MachineAdminDao;
import backend.entity.MachineAdmin;

@Service
public class MachineAdminBizImpl implements MachineAdminBiz {

	 
	 @Resource
	    private MachineAdminDao machineAdminDao;

	@Override
	public List<MachineAdmin> findTem() {
		// TODO Auto-generated method stub
		return machineAdminDao.findTem();
	}

	@Override
	public List<MachineAdmin> findSut() {
		// TODO Auto-generated method stub
		return machineAdminDao.findSut();
	}

	@Override
	public void add(MachineAdmin machineAdmin) {
		// TODO Auto-generated method stub
		machineAdminDao.add(machineAdmin);
	}

	@Override
	public MachineAdmin findMachineByMAC(String mac) {
		// TODO Auto-generated method stub
		return machineAdminDao.findMachineByMAC(mac);
	}

	@Override
	public List<MachineAdmin> findTemByAddr(String addr) {
		// TODO Auto-generated method stub
		return machineAdminDao.findTemByAddr(addr);
	}

	@Override
	public List<MachineAdmin> findSutByAddr(String addr) {
		// TODO Auto-generated method stub
		return machineAdminDao.findSutByAddr(addr);
	}

	@Override
	public List<MachineAdmin> findMachineByUser(String user) {
		// TODO Auto-generated method stub
		return machineAdminDao.findMachineByUser(user);
	}

	@Override
	public void update(MachineAdmin machineAdmin) {
		// TODO Auto-generated method stub
		machineAdminDao.update(machineAdmin);
		
	}

	@Override
	public void delete(String hostMac) {
		// TODO Auto-generated method stub
		machineAdminDao.delete(hostMac);
	}


}
