package backend.dashboard.service.impl;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.xml.sax.InputSource;

import com.inspur.iauto.aep.network.ACPSockClient;

import backend.dashboard.service.ItmsTestCaseBiz;
import backend.dashboard.service.TestCaseBiz;
import backend.dashboard.test.dao.ItmsTestCaseDao;
import backend.dashboard.test.dao.ItmsTestTaskDao;
import backend.dashboard.test.dao.MachineDao;
import backend.entity.ItmsTestCase;
import backend.entity.ItmsTestTask;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.JDOMException;
import org.jdom2.input.SAXBuilder;
import org.jdom2.output.Format;
import org.jdom2.output.XMLOutputter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory; 

@Service
public class ItmsTestCaseBizImpl implements ItmsTestCaseBiz{

	@Resource
	    private ItmsTestCaseDao itmsTestCaseDao;
	

	static Logger logger = LoggerFactory.getLogger(ItmsTestCaseBizImpl.class);
	
	@Resource
	ItmsTestTaskDao itmsTestTaskDao;
	
	@Value("#{systemProperties['user.dir'] + '/testTask'}")
	String testTaskDir;

	@Override
	public ItmsTestCase updateScriptInfo(ItmsTestCase itmsTestCase) {
		// TODO Auto-generated method stub
		itmsTestCaseDao.updateScriptInfo(itmsTestCase);
		return itmsTestCaseDao.findById(itmsTestCase.getId());
	}

	@Override
	public boolean executeTest(Integer id) {
		ItmsTestCase cas = itmsTestCaseDao.findById(id);
		if(cas == null) {
			logger.debug("task {} cannot execute, as taskcase {} does not exist.", id, id);
			return false;
		}
		if(cas.getIp()== null || cas.getScript() == null || cas.getParam() == null) {
			logger.debug("task {} cannot execute, as script info doesnot exist.");
			return false;
		}
		//check, insert or update testTask table.
		ItmsTestTask tmptask = itmsTestTaskDao.findById(id);
		if(tmptask != null) {
			String taskStatus = tmptask.getTaskStatus();
			if(taskStatus.equals("RUNNING")) {
				logger.debug("task {} is executing, cannot start it again.", id);
				return false;
			}
		}

		if(tmptask == null) {
			tmptask = new ItmsTestTask();
			tmptask.setId(id);
			tmptask.setTaskStatus("RUNNING");
			itmsTestTaskDao.insert(tmptask);
		}else {
			tmptask.setTaskStatus("RUNNING");
			tmptask.setStartTime(null);
			tmptask.setEndTime(null);
			tmptask.setTestResult(null);
			tmptask.setLogPath(null);
			itmsTestTaskDao.update(tmptask);
		}
		
		final ItmsTestTask task = tmptask;
		//start task async.
		new Thread(new Runnable() {
			@Override
			public void run() {
				String ip = cas.getIp();
				String scriptPath = cas.getScript();
				String scriptParam = cas.getParam();
				File taskFile = new File(testTaskDir, "testTask_" + id + ".xml");
				logger.info(String.format("~~~ execute task  %s in ip %s", taskFile.getPath(), ip));
				if(!buildXML(taskFile, id, scriptPath, scriptParam)) {
					task.setTaskStatus("FAILED");
					itmsTestTaskDao.update(task);
					return ;
				}
				int re = 0;
				int[] prg = new int[1];
				if(!ACPSockClient.execTask(ip, taskFile.getPath())) {
					task.setStartTime(new Date());
					itmsTestTaskDao.update(task);
					re = -1;
				}else {
					task.setStartTime(new Date());
					itmsTestTaskDao.update(task);
					while(true) {
						try {
							Thread.sleep(1000);
							re = ACPSockClient.queryTask1(ip, String.valueOf(id), prg);
							logger.debug("return from queryTask1: status: {}", re);
							if(re == -2) {
								logger.debug("connection to aep is broken, the query will not be stopped!!!");
							}
							else {
								if(re == -1 || prg[0] == 100) {
									break;
								}
							}
						} catch(InterruptedException e) {
							e.printStackTrace();
						}
					}
				}
				//generate finish time of test execution.
				SimpleDateFormat datefmt = new SimpleDateFormat("yyyyMMddHHmmss");
				Date curDate = new Date();
				String curDateStr = datefmt.format(curDate);
		
				List<TestCaseResult> testResList = new ArrayList<TestCaseResult>();
				String resultName = taskFile.getName().replace(".xml", "_res.xml");
				File resultFile = new File(testTaskDir, resultName);
				String casRes = null;
				if(getTestResult(resultFile, testResList)) {
					if(testResList.size() > 0) {
						casRes = testResList.get(0).result;
					}
				}
				
				if(prg[0] == 100) {
					task.setTaskStatus("FINISHED");
				}else {
					task.setTaskStatus("FAILED");
				}
				String logName = taskFile.getName().replaceAll(".xml", "_log.zip");
				File taskLogFile = new File(testTaskDir, logName);
				if (taskLogFile.exists()) {
					File desTaskLogFile = new File(testTaskDir, curDateStr + "_" + logName);
					if(!taskLogFile.renameTo(desTaskLogFile)) {
						logger.warn("fail to rename logfile, {} ==> {}.", taskLogFile, desTaskLogFile);
					}else {
						logger.debug("succeed to rename taskLogFile, {} ==> {}.", taskLogFile, desTaskLogFile);
						taskLogFile = desTaskLogFile;
					}
					task.setLogPath(taskLogFile.toString());
				}
				task.setTestResult(casRes);
				task.setEndTime(curDate);
				itmsTestTaskDao.update(task);
			}
			
		}).start();;

		return true;
	}

	private boolean buildXML(File taskFile, Integer id, String scriptPath, String scriptParam) {
		try {
			int lastidx = scriptPath.lastIndexOf('/');
			String scriptName = scriptPath.substring(lastidx + 1);
			String scriptDir = scriptPath.substring(0, lastidx);
			Element root = new Element("testTasks").setAttribute("count", "1");
			Element task = new Element("testTask");
			task.addContent(new Element("id").setText(id + ""));
			Element cas = new Element("testCase");
			cas.addContent(new Element("caseId").setText(id + ""));
			cas.addContent(new Element("scriptConfigSrcPath").setText(scriptDir));
			cas.addContent(new Element("scriptConfigName").setText(scriptName));
			cas.addContent(new Element("scriptConfigDesPath").setText(""));
			cas.addContent(new Element("scriptConfigParm").setText(scriptParam));
			task.addContent(cas);
			root.addContent(task);
			Document doc = new Document(root);
			Format format = Format.getPrettyFormat();
			XMLOutputter xmlout = new XMLOutputter(format);
			try {
				xmlout.output(doc, new FileOutputStream(taskFile.getPath()));
			} catch (IOException e) {
				e.printStackTrace();
				return false;
			}
		}catch(Exception e) {
			logger.warn("{}", e);
			return false;
		}
		return true;
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

	@Override
	public List<ItmsTestTask> getTaskByIds(List<Integer> ids) {
		List<ItmsTestTask> ret = new ArrayList<ItmsTestTask>();
		for(int id: ids) {
			ItmsTestTask t = itmsTestTaskDao.findById(id);
			if(t != null) ret.add(t);
		}
		return ret;
	}
	
	
	
	
	@Override
	public void writeExelData(ItmsTestCase itmsTestCase) {
	    itmsTestCaseDao.add(itmsTestCase);
	}
	
	@Override
	public List<ItmsTestCase> findAllTestCase() {
	    return itmsTestCaseDao.findAll();
	}

	@Override
	public List<ItmsTestCase> findByPagination(int from, int count) {
		// TODO �Զ����ɵķ������
		return itmsTestCaseDao.findByPagination(from,count);
	}

	@Override
	public List<ItmsTestTask> findAllTestTask() {
		// TODO �Զ����ɵķ������
		return itmsTestTaskDao.findAll();
	}

	@Override
	public ItmsTestCase findById(Integer id) {
		// TODO 自动生成的方法存根
		return itmsTestCaseDao.findById(id);
	}
	
	
}
