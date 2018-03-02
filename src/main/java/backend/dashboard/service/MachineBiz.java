package backend.dashboard.service;

import java.util.List;

import backend.entity.Machine;

public interface MachineBiz {
	public List<Machine> findAll(String loginId);   
	public void add(Machine machine);
	public void delete(String user);
	public Machine findMachineByMAC(String mac,String loginId);
	public void update(Machine machine);
    /*public TestCase findTestCaseById(int id);
	
	public void delete(int id);*/
}
