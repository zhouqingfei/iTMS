package backend.dashboard.service;

import java.io.InputStream;
import java.util.List;

import backend.entity.ItmsTestCase;
import backend.entity.ItmsTestTask;

public interface ItmsTestCaseBiz {
	public void writeExelData(ItmsTestCase itmsTestCase);
	public List<ItmsTestCase> findAllTestCase();
	public List<ItmsTestCase> findByPagination(int from ,int count);
	
	public ItmsTestCase updateScriptInfo(ItmsTestCase itmsTestCase);
	
	public boolean executeTest(Integer id);
	
	public List<ItmsTestTask> getTaskByIds(List<Integer> ids);
	
	public List<ItmsTestTask> findAllTestTask();

	public ItmsTestCase findById(Integer id);
}
