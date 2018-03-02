package backend.dashboard.service;

import java.util.List;

import backend.entity.Dept;
import backend.entity.TestCase;
import backend.util.TreeModel;

public interface DeptService {
   public TreeModel selectTree(String id, boolean containsDept);
   public List<Dept> findAll();   
}
