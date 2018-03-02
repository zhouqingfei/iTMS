package backend.dashboard.service.impl;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import backend.dashboard.service.TestTaskBiz;
import backend.dashboard.service.TestTaskExecuteCSVBiz;
import backend.entity.TestTask;

import org.apache.commons.beanutils.BeanUtils; 

@Service
public class TestTaskExecuteCSVBizImpl implements TestTaskExecuteCSVBiz {

	@Resource(name = "testTaskBizImpl")
	private TestTaskBiz testTaskBiz;

	@Override
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void execute(int id) {
		TestTask testTask = testTaskBiz.findTestTaskById(id);
		System.out.println(testTask.getStartTime());

		List exportData = new ArrayList<Map>();
		Map row = new LinkedHashMap<String, String>();
		row.put("1", testTask.getId());
		row.put("2", testTask.getTestTaskName());
		row.put("3", new SimpleDateFormat("yyyy/MM/dd HH:mm:ss EE").format(testTask.getStartTime()));
		exportData.add(row);
		LinkedHashMap map = new LinkedHashMap();
		map.put("1", "test_task_id");
		map.put("2", "test_task_name");
		map.put("3", "start_time");
		String path = "/home/acp/";
		String fileName = "testTask";
		File file = TestTaskExecuteCSVBizImpl.createCSVFile(exportData, map, path, fileName);
		String fileName2 = file.getName();
		System.out.println("鏂囦欢鍚嶇О锛�" + fileName2);

	}

	private static File createCSVFile(List exportData, LinkedHashMap map, String outPutPath,String fileName) {
		File csvFile = null;  
        BufferedWriter csvFileOutputStream = null;  
        try {  
            File file = new File(outPutPath);  
            if (!file.exists()) {  
                file.mkdir();  
            }  
            //瀹氫箟鏂囦欢鍚嶆牸寮忓苟鍒涘缓  
            //csvFile = File.createTempFile(fileName, ".csv", new File(outPutPath)); 
            csvFile = new File(outPutPath+fileName+".csv");
            System.out.println("csvFile锛�" + csvFile);  
            // UTF-8浣挎纭鍙栧垎闅旂","    
            csvFileOutputStream = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(  
                csvFile), "GBK"), 1024);  
            System.out.println("csvFileOutputStream锛�" + csvFileOutputStream);  
            // 鍐欏叆鏂囦欢澶撮儴    
            for (Iterator propertyIterator = map.entrySet().iterator(); propertyIterator.hasNext();) {  
                java.util.Map.Entry propertyEntry = (java.util.Map.Entry) propertyIterator.next();  
                csvFileOutputStream.write((String) propertyEntry.getValue() != null ? new String(  
                    ((String) propertyEntry.getValue()).getBytes("GBK"), "GBK") : "");  
                if (propertyIterator.hasNext()) {  
                    csvFileOutputStream.write(",");  
                }  
                System.out.println(new String(((String) propertyEntry.getValue()).getBytes("GBK"),  
                    "GBK"));  
            }  
            csvFileOutputStream.write("\r\n");  
            // 鍐欏叆鏂囦欢鍐呭    
            for (Iterator iterator = exportData.iterator(); iterator.hasNext();) {  
                Object row = (Object) iterator.next();  
                for (Iterator propertyIterator = map.entrySet().iterator(); propertyIterator  
                    .hasNext();) {  
                    java.util.Map.Entry propertyEntry = (java.util.Map.Entry) propertyIterator  
                        .next();  
                    csvFileOutputStream.write((String) BeanUtils.getProperty(row,  
                        ((String) propertyEntry.getKey()) != null? (String) propertyEntry.getKey()  
                            : ""));  
                    if (propertyIterator.hasNext()) {  
                        csvFileOutputStream.write(",");  
                    }  
                }  
                if (iterator.hasNext()) {  
                    csvFileOutputStream.write("\r\n");  
                }  
            }  
            csvFileOutputStream.flush();  
        } catch (Exception e) {  
            e.printStackTrace();  
        } finally {  
            try {  
                csvFileOutputStream.close();  
            } catch (IOException e) {  
                e.printStackTrace();  
            }  
        }  
        return csvFile;  
    }  
	}


