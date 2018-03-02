package backend.entity;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class TestCase {
  private int id;
  private String testCaseName;
  private String temSut;
  private String testCaseId;
  private String testCategory;
  private String testCaseDescribe;
  private String scriptConfigName;
  private String scriptConfigSrcPath;
  private String scriptConfigDesPath;
  private String scriptConfigParm;
  private String userLoginId;
  private int testSuitId;
  @DateTimeFormat(pattern="yyyy-MM-dd") 
  private Date modifyTime;
  private String logPath;
  private String scriptConfigDescribe;
  
  private String scriptRecordType;
  private String scriptExplain;
public String getScriptRecordType() {
	return scriptRecordType;
}
public void setScriptRecordType(String scriptRecordType) {
	this.scriptRecordType = scriptRecordType;
}
public String getScriptExplain() {
	return scriptExplain;
}
public void setScriptExplain(String scriptExplain) {
	this.scriptExplain = scriptExplain;
}
public String getLogPath() {
	return logPath;
}
public void setLogPath(String logPath) {
	this.logPath = logPath;
}
public String getScriptConfigDescribe() {
	return scriptConfigDescribe;
}
public void setScriptConfigDescribe(String scriptConfigDescribe) {
	this.scriptConfigDescribe = scriptConfigDescribe;
}
public Date getModifyTime() {
	return modifyTime;
}
public void setModifyTime(Date modifyTime) {
	this.modifyTime = modifyTime;
}
public int getId() {
	return id;
}
public void setId(int id) {
	this.id = id;
}
public String getTestCaseName() {
	return testCaseName;
}
public void setTestCaseName(String testCaseName) {
	this.testCaseName = testCaseName;
}
public String getTemSut() {
	return temSut;
}
public void setTemSut(String temSut) {
	this.temSut = temSut;
}
public String getTestCaseId() {
	return testCaseId;
}
public void setTestCaseId(String testCaseId) {
	this.testCaseId = testCaseId;
}
public String getTestCategory() {
	return testCategory;
}
public void setTestCategory(String testCategory) {
	this.testCategory = testCategory;
}
public String getTestCaseDescribe() {
	return testCaseDescribe;
}
public void setTestCaseDescribe(String testCaseDescribe) {
	this.testCaseDescribe = testCaseDescribe;
}
public String getScriptConfigName() {
	return scriptConfigName;
}
public void setScriptConfigName(String scriptConfigName) {
	this.scriptConfigName = scriptConfigName;
}
public String getScriptConfigSrcPath() {
	return scriptConfigSrcPath;
}
public void setScriptConfigSrcPath(String scriptConfigSrcPath) {
	this.scriptConfigSrcPath = scriptConfigSrcPath;
}
public String getScriptConfigDesPath() {
	return scriptConfigDesPath;
}
public void setScriptConfigDesPath(String scriptConfigDesPath) {
	this.scriptConfigDesPath = scriptConfigDesPath;
}
public String getScriptConfigParm() {
	return scriptConfigParm;
}
public void setScriptConfigParm(String scriptConfigParm) {
	this.scriptConfigParm = scriptConfigParm;
}
public String getUserLoginId() {
	return userLoginId;
}
public void setUserLoginId(String userLoginId) {
	this.userLoginId = userLoginId;
}
public int getTestSuitId() {
	return testSuitId;
}
public void setTestSuitId(int testSuitId) {
	this.testSuitId = testSuitId;
}

  
}
