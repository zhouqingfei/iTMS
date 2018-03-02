package backend.dashboard.test.dao;

import java.util.List;

import backend.entity.Machine;
import backend.entity.TestTask;

public interface MachineDao {
	public List<Machine> findAll(String loginId);
	public void add(Machine machine);
	public void delete(String user);
	public Machine findMachineByMAC(String mac,String loginId);
	public void update(Machine machine);
    //public void add(String deptName);
  /*  public TestCase findTestCaseById(int id);
	public void add(TestCase testcase);
	public void delete(int id);*/
}
