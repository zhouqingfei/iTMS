package backend.dashboard.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import backend.dashboard.service.MachineBiz;
import backend.dashboard.test.dao.MachineDao;
import backend.entity.Machine;

@Service
public class MachineBizImpl implements MachineBiz {

	 @Resource
	    private MachineDao machineDao;
	public List<Machine> findAll(String loginId) {
		// TODO Auto-generated method stub
		return machineDao.findAll(loginId);
	}
	@Override
	public void add(Machine machine) {
		// TODO Auto-generated method stub
		machineDao.add(machine);
	}
	@Override
	public void delete(String user) {
		// TODO Auto-generated method stub
		machineDao.delete(user);
	}
	@Override
	public Machine findMachineByMAC(String mac,String loginId) {
		// TODO Auto-generated method stub
		return machineDao.findMachineByMAC(mac,loginId);
	}
	@Override
	public void update(Machine machine) {
		// TODO Auto-generated method stub
		machineDao.update(machine);
	}
}
