package backend.dashboard.test.dao;

import java.util.List;
import java.util.Map;

import backend.entity.Dept;
import backend.entity.TestCase;

public interface DeptDao {
    public List<Dept> list(Map<String, Object> para);
    public List<Dept> findAll();
}