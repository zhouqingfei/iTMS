package backend.dashboard.service.impl;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.xml.sax.InputSource;

import com.inspur.iauto.aep.network.ACPSockClient;
import com.inspur.iauto.aep.network.TestTaskRes;

import com.itextpdf.text.DocumentException;
//import com.itextpdf.text.log.LoggerFactory;

import backend.dashboard.service.MachineAdminBiz;
import backend.dashboard.service.ReportLogBiz;
import backend.dashboard.service.TestCaseBiz;
import backend.dashboard.service.TestReportBiz;
import backend.dashboard.service.TestTaskBiz;
import backend.dashboard.service.TestTaskExecuteXMLBiz;
import backend.entity.ReportLog;
import backend.entity.TestCase;
import backend.entity.TestReport;
import backend.entity.TestTask;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.JDOMException;
import org.jdom2.input.SAXBuilder;
import org.jdom2.output.Format;
import org.jdom2.output.XMLOutputter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Service
public class TestTaskExecuteXMLBizImpl implements TestTaskExecuteXMLBiz {

	private static Logger logger = LoggerFactory.getLogger(TestTaskExecuteXMLBizImpl.class);
	@Resource(name = "testTaskBizImpl")
	private TestTaskBiz testTaskBiz;

	@Resource(name = "testCaseBizImpl")
	private TestCaseBiz testCaseBiz;

	@Resource(name = "report")
	private ReportLogBiz reportLogBiz;

	@Resource(name = "testReportBizImpl")
	private TestReportBiz testReportBiz;

	@Resource
	private PDF pdf;
	@Resource(name = "machineAdminBizImpl")
	private MachineAdminBiz machineAdminBiz;

	@Value("${user.dir}")
	String testTaskDir;

	@Override
	public void execute(int id, String loginId) {
		List<TestCase> testlist = new ArrayList<TestCase>();
		TestTask testTask = testTaskBiz.findTestTaskById(id);
		String[] testids = testTask.getTestCaseInfo().split(",");
		String targetMAC = testTask.getTemInfo();
		String ip = "";
		if (targetMAC.length() > 0) {
			ip = machineAdminBiz.findMachineByMAC(testTask.getTemInfo()).getHost_ip();
		} else {
			ip = machineAdminBiz.findMachineByMAC(testTask.getSutInfo()).getHost_ip();
		}
		// we need to take care here
		for(int i=0;i<testids.length;i++) {
			String[] arryInfo=testids[i].split(";");
			TestCase testCase = testCaseBiz.findTestCaseById(Integer.parseInt(arryInfo[0]));
			testCase.setScriptConfigParm(arryInfo[1]);
			testlist.add(testCase);
		}

		File taskDirFile = new File(testTaskDir, "testTask");
		if (!taskDirFile.exists()) {
			taskDirFile.mkdir();
		}
		
		String prjName = testTask.getSpecialCaseName();
		String machType = testTask.getMachineType();
		String testCate = testTask.getTestCategory();
		String testDisc = testTask.getTestTaskDescribe();
		testDisc = testDisc.replaceAll(" ", "");
		//construct task name by design specific 
		File taskFile = new File(taskDirFile, String.format("%d_%s_%s_%s_%s.xml", id, prjName, machType, testCate, testDisc));
		logger.info(String.format("execute task  %s in ip %s by loginId %s", taskFile.getPath(), ip, loginId));

		try {
			BuildXMLDoc(taskFile, testTask, testlist);
		} catch (IOException e) {
			e.printStackTrace();
			logger.warn("failed to buildXmlDoc to file {}.", taskFile, e);
		}

		int re = 0;
		int[] prg = new int[1];
		if (ACPSockClient.execTask(ip, taskFile.getPath())) {
			testTask.setTestTaskState("Running");
			testTask.setStartTime(new Date());
			testTask.setEndTime(null);
			testTask.setProcess("0");
			testTask.setResult("");
			testTaskBiz.update(testTask);
			while (true) {
				try {
					Thread.sleep(1000);
					re = ACPSockClient.queryTask1(ip, String.valueOf(testTask.getId()), prg);
					logger.debug(String.format("return from queryTask: state: %d, progress: %d.", re, prg[0]));
					if (re == -2) {
						logger.warn("connection to aep is broken, the query will not be stopped!!!");
					}else {
						//更新进度
						String curprg = String.valueOf(prg[0]);
						if(! curprg.equals(testTask.getProcess())) {
							testTask.setProcess(curprg);
							testTaskBiz.update(testTask);							
						}
						if(re == -1 || prg[0] == 100) {
							break;
						}
					}
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
		} else {
			re = -1;
		}

		//generate finish time of test execution.
		SimpleDateFormat datefmt = new SimpleDateFormat("yyyyMMddHHmmss");
		Date curDate = new Date();
		String curDateStr = datefmt.format(curDate);
		
		//update testtask.
		boolean isTestPass = false;
		List<TestCaseResult> testResList = new ArrayList<TestCaseResult>();
		if (prg[0] == 100) {
			String resultName = taskFile.getName().replace(".xml", "_res.xml");			
			File resultFile = new File(taskDirFile, resultName);
			if (getTestResult(resultFile, testResList)) {
				if (testResList.size() > 0) {
					isTestPass = true;
					for (TestCaseResult res : testResList) {
						if (!res.result.equals("PASS")) {
							isTestPass = false;
							break;
						}
					}
				}
			}
		}
		
		if (prg[0] == 100) {
			testTask.setTestTaskState("Finished");
			if (isTestPass) {
				testTask.setResult("PASS");
			} else {
				testTask.setResult("FAIL");
			}
			testTask.setEndTime(curDate);
			testTaskBiz.update(testTask);
		} else if (re == -1) {
			testTask.setTestTaskState("Stop");
			testTask.setResult("FAIL");
			testTask.setEndTime(curDate);
			testTaskBiz.update(testTask);
		}
		
		//update testReport.
		String resultName = taskFile.getName().replace(".xml", "_res.xml");
		File taskReportFile = new File(taskDirFile, resultName);
		if (taskReportFile.exists()) {
			Path taskReportPath = Paths.get(taskReportFile.getPath());
			Path desTaskReportPath = taskReportPath.resolveSibling( curDateStr + "_" + resultName);
			try {
				taskReportPath = Files.move(taskReportPath, desTaskReportPath);
				logger.debug("succeed to move {} to {}.", taskReportPath, desTaskReportPath);
			} catch (IOException e1) {
				//e1.printStackTrace();
				logger.warn("failed to move {} to {}. {}", taskReportPath, desTaskReportPath, e1);
			}
			/*
			File desTaskReportFile = new File(taskDirFile, curDateStr + "_" + resultName);
			if(! taskReportFile.renameTo(desTaskReportFile)) {
				logger.warn("fail to rename reportfile, from {} to {}.", taskReportFile, desTaskReportFile);
			}else {
				logger.debug("succeed to rename taskReportFile, {} ==> {}", taskReportFile, desTaskReportFile);
				taskReportFile = desTaskReportFile;
			}
			*/
			String reportName = taskReportPath.getFileName().toString().replaceAll("_res.xml", "_report.pdf");
			Map<Integer, String> testcaseres = new HashMap<>();
			for(TestCaseResult res: testResList) {
				testcaseres.put(Integer.valueOf(res.id), res.result);
			}
			
			try {
				pdf.writePDF(testTask, testlist, testcaseres, new File(taskDirFile, reportName));
			} catch(Exception e) {
				e.printStackTrace();
			}
		
			TestReport tr = new TestReport();
			tr.setLoginId(loginId);
			tr.setReportName(reportName);
			tr.setReportNumber(id + "");
			tr.setModifyTime(new Date());
			testReportBiz.add(tr);
		} else {
			logger.warn("after execute task, reportfile not exist! {}", taskReportFile);
		}

		//update testlog.
		String taskLogName = taskFile.getName().replaceAll(".xml", "_log.zip");
		File taskLogFile = new File(taskDirFile, taskLogName);
		if (taskLogFile.exists()) {
			File desTaskLogFile = new File(taskDirFile, curDateStr + "_" + taskLogName);
			if(!taskLogFile.renameTo(desTaskLogFile)) {
				logger.warn("fail to rename logfile, {} ==> {}.", taskLogFile, desTaskLogFile);
			}else {
				logger.debug("succeed to rename taskLogFile, {} ==> {}.", taskLogFile, desTaskLogFile);
				taskLogFile = desTaskLogFile;
			}
			ReportLog rl = new ReportLog();
			rl.setLogNumber(id + "");
			rl.setLogName(taskLogFile.getName());
			rl.setModifyTime(new Date());
			rl.setLoginId(loginId);
			reportLogBiz.add(rl);
		} else {
			logger.warn("after executing task, logfile not exist! {}", taskLogFile);
		}

	}

	static class TestCaseResult {
		TestCaseResult() {
		}

		TestCaseResult(String id, String res) {
			this.id = id;
			this.result = res;
		}

		String id;
		String result;
	};

	public static boolean getTestResult(File resfile, List<TestCaseResult> resli) {

		FileReader fr;
		try {
			fr = new FileReader(resfile);
		} catch (FileNotFoundException e1) {
			e1.printStackTrace();
			return false;
		}
		SAXBuilder dombuilder = new SAXBuilder();
		try {
			Document doc = dombuilder.build(new InputSource(fr));
			Element root = doc.getRootElement();
			List<Element> allcases = root.getChildren().get(0).getChildren("testCase");
			for (Element c : allcases) {
				String casId = c.getChild("caseId").getText();
				String res = c.getChild("result").getText();
				System.out.println("resfile: " + resfile + " testcaseresult caseId: " + casId + "; result: " + res);
				resli.add(new TestCaseResult(casId, res));
			}

			return true;
		} catch (JDOMException | IOException e) {
			e.printStackTrace();
		} finally {
			try {
				fr.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return false;
	}

	public void BuildXMLDoc(File taskFile, TestTask testTask, List<TestCase> list)
			throws FileNotFoundException, IOException {

		Element root = new Element("testTasks").setAttribute("count", "1");
		Element elements = new Element("testTask");

		elements.addContent(new Element("id").setText(testTask.getId() + ""));
		elements.addContent(new Element("testTaskName").setText(testTask.getTestTaskName()));
		elements.addContent(new Element("suitName").setText(testTask.getSuitName()));
		elements.addContent(new Element("startTime")
				.setText((new SimpleDateFormat("yyyy/MM/dd HH:mm:ss EE")).format(testTask.getStartTime())));
		elements.addContent(new Element("specialCaseName").setText(testTask.getSpecialCaseName()));
		elements.addContent(new Element("machineType").setText(testTask.getMachineType()));
		elements.addContent(new Element("testCategory").setText(testTask.getTestCategory()));
		elements.addContent(new Element("testTaskDescribe").setText(testTask.getTestTaskDescribe()));
		elements.addContent(new Element("poolType").setText(testTask.getPoolType()));
		elements.addContent(new Element("poolSuitOrCase").setText(testTask.getPoolSuitOrCase()));
		elements.addContent(new Element("machineInfo").setText(testTask.getMachineInfo()));
		for (int i = 0; i < list.size(); i++) {
			Element test = new Element("testCase");
			test.addContent(new Element("caseId").setText(list.get(i).getId() + ""));
			test.addContent(new Element("testCaseName").setText(list.get(i).getTestCaseName()));
			test.addContent(new Element("temSut").setText(list.get(i).getTemSut()));
			test.addContent(new Element("testCaseId").setText(list.get(i).getTestCaseId()));
			test.addContent(new Element("testCategory").setText(list.get(i).getTestCategory()));
			test.addContent(new Element("testCaseDescribe").setText(list.get(i).getTestCaseDescribe()));
			test.addContent(new Element("scriptConfigName").setText(list.get(i).getScriptConfigName()));
			test.addContent(new Element("scriptConfigSrcPath").setText(list.get(i).getScriptConfigSrcPath()));
			test.addContent(new Element("scriptConfigDesPath").setText(list.get(i).getScriptConfigDesPath()));
			test.addContent(new Element("scriptConfigParm").setText(list.get(i).getScriptConfigParm()));

			elements.addContent(test);
		}

		root.addContent(elements);
		Document Doc = new Document(root);
		Format format = Format.getPrettyFormat();
		XMLOutputter XMLOut = new XMLOutputter(format);
		XMLOut.output(Doc, new FileOutputStream(taskFile.getPath()));

	}
/*
	public void reportLogView(int id, String loginId) {
		ReportLog rl = new ReportLog();
		rl.setLogNumber(id + "");
		rl.setLogName("testTask_" + id + "_log");
		rl.setModifyTime(new Date());
		rl.setLoginId(loginId);
		reportLogBiz.add(rl);

	}

	private void testReportView(int id, String loginId) {
		// TODO Auto-generated method stub
		TestReport tr = new TestReport();
		tr.setLoginId(loginId);
		tr.setReportName("testTask_" + id + "_res");
		tr.setReportNumber(id + "");
		tr.setModifyTime(new Date());
		testReportBiz.add(tr);
	}
*/
}
