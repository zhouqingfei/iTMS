package backend.dashboard.test.dao;

import java.util.List;

import backend.entity.ItmsTestTask;

public interface ItmsTestTaskDao {
	
	public ItmsTestTask findById(int id);
	public void insert(ItmsTestTask task);
	public void update(ItmsTestTask task);
	public List<ItmsTestTask> findAll();
	
}
