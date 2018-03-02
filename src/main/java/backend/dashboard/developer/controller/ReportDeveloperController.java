package backend.dashboard.developer.controller;

import java.awt.Desktop;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import backend.dashboard.contorller.ReportController;
import backend.dashboard.service.ReportLogBiz;
import backend.dashboard.service.TestReportBiz;
import backend.entity.ReportLog;
import backend.entity.TestReport;

@Controller
@RequestMapping("reportDeveloper.do")
public class ReportDeveloperController {
	private static Logger logger = LoggerFactory.getLogger(ReportController.class);
	
	@Resource(name = "report")
    private ReportLogBiz reportLogBiz;
	
	@Resource(name = "testReportBizImpl")
    private TestReportBiz testReportBiz;
	
	 @Value("${user.dir}")
	 String testTaskDir;
	
	@RequiresRoles("developer")
	 @RequestMapping("log.view")
	    public String logView(Model model,HttpSession session) {
		 model.addAttribute("reportLogList", reportLogBiz.findAllTester((String) session.getAttribute("loginId")));
	        return "/iAutoDemo/developer/testLogAdmin";
		// return "/admin/system/user/user_add";
	    }
	@RequiresRoles("developer")
	 @RequestMapping("report.view")
	    public String reportView(Model model,HttpSession session) {
	     
		 model.addAttribute("testReportlist",testReportBiz.findAllTester((String) session.getAttribute("loginId")));
	        return "/iAutoDemo/developer/testReportAdmin";
		// return "/admin/system/user/user_add";
	    }
	
	@RequiresRoles("developer")
	 @RequestMapping(value="reportSearch",method=RequestMethod.GET)
	 public @ResponseBody List<TestReport> reportSearch(String content,HttpSession session) {
		 System.out.println(content);
		 List<TestReport> searchReportList = testReportBiz.search(content);
		 String loginId=(String) session.getAttribute("loginId");
		 for (int i = 0; i < searchReportList.size(); i++) 
		 {
		 	if (!searchReportList.get(i).getLoginId().equals(loginId))
		 	{
		 		searchReportList.remove(searchReportList.get(i));
		 		i=i-1;
		 	}
		 }
		 System.out.println(searchReportList+"~~~~~~~~~~~");
		 return searchReportList;
		 }
	@RequiresRoles("developer")
	 @RequestMapping(value="logSearch",method=RequestMethod.GET)
	 public @ResponseBody List<ReportLog> logSearch(String content,HttpSession session) {
		 System.out.println(content);
		 List<ReportLog> searchLogList = reportLogBiz.search(content);
		 String loginId=(String) session.getAttribute("loginId");
		 for (int i = 0; i < searchLogList.size(); i++) 
		 {
		 	if (!searchLogList.get(i).getLoginId().equals(loginId))
		 	{
		 		searchLogList.remove(searchLogList.get(i));
		 		i=i-1;
		 	}
		 }
		 System.out.println(searchLogList+"~~~~~~~~~~~");
		 return searchLogList;
		 }
	
	 @RequiresRoles("developer")
		@RequestMapping(value = "deleteLog", method = RequestMethod.GET)
		public @ResponseBody List<ReportLog> deleteLog(int id, HttpSession session) {
		 reportLogBiz.delete(id);
			List<ReportLog> logtList = reportLogBiz.findAllTester((String) session.getAttribute("loginId"));
			return logtList;
		}
	 @RequiresRoles("developer")
		@RequestMapping(value = "deleteReport", method = RequestMethod.GET)
		public @ResponseBody List<TestReport> deleteReport(int id, HttpSession session) {
		 testReportBiz.delete(id);
			List<TestReport> reportList = testReportBiz.findAllTester((String) session.getAttribute("loginId"));
			return reportList;
		}
	 @RequiresRoles("developer")
		@RequestMapping("openFileLog")
		public String openFileLog(String logNumber) {
			 try {
				Desktop.getDesktop().open(new File(new File(testTaskDir, "testTask"), "testTask_"+logNumber+"_log.zip"));
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}  
			 return "redirect:/reportDeveloper.do/log.view";
		}
	 @RequiresRoles("developer")
	 @RequestMapping(value="/downloadLog")
	    public ResponseEntity<byte[]> download(HttpServletRequest request,Model model,String logName)throws Exception {
	    	//get filePath by filename, and fetch file content.
	       File file = new File(new File(testTaskDir, "testTask"), logName);
	       if(!file.exists()) {
	    	   logger.warn("request file not exist! {}", file);
	    	  FileInputStream filein = new FileInputStream(file);
	    	  if(filein != null) {
	    		  filein.close();
	    	  }
	       }
	       HttpHeaders headers = new HttpHeaders();
	       String downloadFielName = new String(file.getName().getBytes("UTF-8"),"iso-8859-1");
	       headers.setContentDispositionFormData("attachment", downloadFielName);
	       headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
	       return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),    
	               headers, HttpStatus.CREATED);
	    }
	    @RequiresRoles("developer")
		@RequestMapping("openFileReport")
		public String openFileReport(String reportNumber) {
			 try {
				Desktop.getDesktop().open(new File(new File(testTaskDir, "testTask"), "testTask_"+reportNumber+"_report.pdf"));
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}  
			 return "redirect:/reportDeveloper.do/report.view";
		}
	    
	    @RequiresRoles("developer")
		@RequestMapping("openFileReportFrontPage")
		public String openFileReportFrontPage(String reportNumber) {
			 try {
				Desktop.getDesktop().open(new File(new File(testTaskDir, "testTask"), "testTask_"+reportNumber+"_report.pdf"));
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}  
			 return "redirect:/frontPageDeveloper.do/frontPage.view";
		}
	    @RequiresRoles("developer")
	    @RequestMapping(value="/downloadReport")
	    public ResponseEntity<byte[]> downloadReport(HttpServletRequest request,Model model,String reportName)throws Exception {
	       //String path = request.getServletContext().getRealPath("/images/");
	       File file = new File(new File(testTaskDir, "testTask"), reportName);
	       byte[] bodypart = FileUtils.readFileToByteArray(file);
	       logger.info("in controller downloadReport, report file {}, size {}", file.getPath(), bodypart.length);
	       
	       HttpHeaders headers = new HttpHeaders();  
	       String downloadFielName = new String(file.getName().getBytes("UTF-8"),"iso-8859-1");
	       headers.setContentDispositionFormData("attachment", downloadFielName); 
	       headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
	       return new ResponseEntity<byte[]>(bodypart, headers, HttpStatus.CREATED);  
	    }
		 @RequestMapping(value="/downloadRecentReport")
		    public ResponseEntity<byte[]> downloadRecentReport(HttpServletRequest request,Model model,String reportNumber)throws Exception {
		       //String path = request.getServletContext().getRealPath("/images/");
		    	String reportName=testReportBiz.findRecentReport(reportNumber).getReportName();
		       File file = new File(new File(testTaskDir, "testTask"), reportName);
		       byte[] bodypart = FileUtils.readFileToByteArray(file);
		       logger.info("in controller downloadReport, report file {}, size {}", file.getPath(), bodypart.length);
		       
		       HttpHeaders headers = new HttpHeaders();  
		       String downloadFielName = new String(file.getName().getBytes("UTF-8"),"iso-8859-1");
		       headers.setContentDispositionFormData("attachment", downloadFielName); 
		       headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
		       return new ResponseEntity<byte[]>(bodypart, headers, HttpStatus.CREATED);  
		    }
}
