package backend.dashboard.service.impl;


import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import backend.dashboard.service.NetworkBiz;
import backend.dashboard.test.dao.NetworkDao;
import backend.entity.Network;

@Service
public class NetworkBizImpl implements NetworkBiz {

	 @Resource
	    private NetworkDao networkDao;
	@Override
	public Network findByid(int id) {
		// TODO Auto-generated method stub
		return networkDao.findByid(id);
	}

/*	@Override
	public TestReport findTestCaseById(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void add(TestReport testReport) {
		// TODO Auto-generated method stub
		testReportDao.add(testReport);
	}

	@Override
	public void delete(int reportId) {
		// TODO Auto-generated method stub
		testReportDao.delete(reportId);
	}

	*/

}
