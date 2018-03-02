package backend.entity;

import java.util.List;

public class TestTaskRes {

	private int result;
	private List<TestCaseRes> testCaseList;
	public int getResult() {
		return result;
	}
	public void setResult(int result) {
		this.result = result;
	}
	public List<TestCaseRes> getTestCaseList() {
		return testCaseList;
	}
	public void setTestCaseList(List<TestCaseRes> testCaseList) {
		this.testCaseList = testCaseList;
	}
	
}
