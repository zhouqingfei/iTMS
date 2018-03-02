package backend.dashboard.service.impl;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.springframework.stereotype.Service;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPRow;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

import backend.entity.TestCase;
import backend.entity.TestTask;

/**
 * Hello world!
 *
 */
@Service
public class PDF {

	public boolean writePDF(TestTask testTask, List<TestCase> testList, Map<Integer, String> testResult, File file){
		Document document = new Document();
		// 建立一个书写器
		PdfWriter writer = null;
		try {
			writer = PdfWriter.getInstance(document, new FileOutputStream(file));
		} catch (FileNotFoundException | DocumentException e) {
			e.printStackTrace();
			document.close();
			return false;
		}
		// 打开文件
		document.open();

	/*	try {
			document.add(new Paragraph("hello zsr!"));
		} catch (DocumentException e1) {
			e1.printStackTrace();
		}
		document.close();
		if(testTask != null) return false;
		*/

		try {
			BaseFont bfChinese = BaseFont.createFont("STSong-Light", "UniGB-UCS2-H", BaseFont.NOT_EMBEDDED);
			Font blackFont = new Font(bfChinese);
			blackFont.setColor(BaseColor.BLACK);
			blackFont.setSize(22);

			Font bodyFont = new Font(bfChinese);

			// 添加内容
			Paragraph head = new Paragraph("测试总结", blackFont);
			head.setAlignment(Element.ALIGN_CENTER);
			document.add(head);
			//Chunk chunk = Chunk.NEWLINE;
			//chunk.setBackground(BaseColor.BLUE);
			//document.add(chunk);
			// 4列的表.
			PdfPTable table = new PdfPTable(4);
			table.setWidthPercentage(100); // 宽度100%填充
			table.setSpacingBefore(20f); // 前间距
			table.setSpacingAfter(10f); // 后间距

			List<PdfPRow> listRow = table.getRows();
			// 设置列宽
			float[] columnWidths = { 2f, 2f, 2f, 2f };
			table.setWidths(columnWidths);

			// 行1
			PdfPCell cells1[] = new PdfPCell[4];
			PdfPRow row1 = new PdfPRow(cells1);
			cells1[0] = new PdfPCell(new Paragraph("项目:", bodyFont));// 单元格内容
			cells1[0].setBackgroundColor(BaseColor.GRAY);
			cells1[1] = new PdfPCell(new Paragraph(testTask.getTestTaskName()));
			cells1[2] = new PdfPCell(new Paragraph("测试日期:", bodyFont));
			cells1[2].setBackgroundColor(BaseColor.GRAY);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String startTime = sdf.format(testTask.getStartTime());
			cells1[3] = new PdfPCell(new Paragraph(startTime));

			// 行2
			PdfPCell cells2[] = new PdfPCell[4];
			PdfPRow row2 = new PdfPRow(cells2);
			cells2[0] = new PdfPCell(new Paragraph("待测机MAC地址:", bodyFont));
			cells2[0].setBackgroundColor(BaseColor.GRAY);

			cells2[1] = new PdfPCell(new Paragraph(testTask.getMachineInfo()));
			cells2[2] = new PdfPCell(new Paragraph("机器型号(pn):", bodyFont));
			cells2[2].setBackgroundColor(BaseColor.GRAY);
			cells2[3] = new PdfPCell(new Paragraph(testTask.getMachineType()));

			// 行3
			PdfPCell cells3[] = new PdfPCell[4];
			PdfPRow row3 = new PdfPRow(cells3);
			cells3[0] = new PdfPCell(new Paragraph("测试开始与结束时间:", bodyFont));
			cells3[0].setBackgroundColor(BaseColor.GRAY);

			SimpleDateFormat sdf1 = new SimpleDateFormat("HH:mm:ss");
			// java.util.Date date=new java.util.Date();
			String startTime1 = sdf1.format(testTask.getStartTime());
			String endTime1 = sdf1.format(testTask.getEndTime());
			cells3[1] = new PdfPCell(new Paragraph(startTime1 + "——" + endTime1));
			cells3[2] = new PdfPCell(new Paragraph("总耗时(d:h:m:s:ms):", bodyFont));
			cells3[2].setBackgroundColor(BaseColor.GRAY);
			Date d1 = testTask.getStartTime();
			Date d2 = testTask.getEndTime();
			long diff = d2.getTime() - d1.getTime();
			long days = diff / (1000 * 60 * 60 * 24);
			diff = diff - days * (1000 * 60 * 60 * 24);
			long hours = diff / (1000 * 60 * 60);
			diff = diff - hours * (1000 * 60 * 60);
			long mins = diff / (1000 * 60);
			diff = diff - mins * (1000 * 60);
			long secs = diff / 1000;
			diff = diff - secs * 1000;
			long ms = diff;
			cells3[3] = new PdfPCell(new Paragraph(days + ":" + hours + ":" + mins + ":" + secs + ":" + ms));

			// 行4
			PdfPCell cells4[] = new PdfPCell[4];
			PdfPRow row4 = new PdfPRow(cells4);
			cells4[0] = new PdfPCell(new Paragraph("测试工程师:", bodyFont));
			cells4[0].setBackgroundColor(BaseColor.GRAY);

			cells4[1] = new PdfPCell(new Paragraph(testTask.getLoginId()));
			cells4[2] = new PdfPCell(new Paragraph("综合测评:", bodyFont));
			cells4[2].setBackgroundColor(BaseColor.GRAY);
			cells4[3] = new PdfPCell(new Paragraph(testTask.getResult()));

			listRow.add(row1);
			listRow.add(row2);
			listRow.add(row3);
			listRow.add(row4);

			// 把表格添加到文件中
			document.add(table);
			// 测试项目详细信息
			Paragraph head2= new Paragraph("实际测试结果", bodyFont);
			head2.setAlignment(Element.ALIGN_CENTER);
			document.add(head2);

			// 5列的表.
			PdfPTable table1 = new PdfPTable(5);
			table1.setWidthPercentage(100); // 宽度100%填充
			table1.setSpacingBefore(10f); // 前间距
			table1.setSpacingAfter(10f); // 后间距

			List<PdfPRow> listRow1 = table1.getRows();
			// 设置列宽
			float[] columnWidths1 = { 2f, 1.5f, 1.5f, 1.5f, 1.5f };
			table1.setWidths(columnWidths1);

			PdfPCell cells11[] = new PdfPCell[5];

			cells11[0] = new PdfPCell(new Paragraph("测试类", bodyFont));// 单元格内容
			cells11[0].setBackgroundColor(BaseColor.GRAY);
			cells11[1] = new PdfPCell(new Paragraph("Pass(测试成功)", bodyFont));
			cells11[1].setBackgroundColor(BaseColor.GREEN);
			cells11[2] = new PdfPCell(new Paragraph("Fail(测试错误)", bodyFont));
			cells11[2].setBackgroundColor(BaseColor.RED);
			cells11[3] = new PdfPCell(new Paragraph("Blocked(无法测试)", bodyFont));
			cells11[3].setBackgroundColor(BaseColor.ORANGE);
			cells11[4] = new PdfPCell(new Paragraph("Comment(备注)", bodyFont));
			cells11[4].setBackgroundColor(BaseColor.DARK_GRAY);
			
			PdfPRow row11 = new PdfPRow(cells11);
			listRow1.add(row11);
			
			int passnum = 0;
			int failnum = 0;
			int stopnum = 0;
			Map<String, List<TestCase>> allcates = new TreeMap<>();
			for(TestCase tc: testList) {
				String testCate = tc.getTestCategory();
				if(!allcates.containsKey(testCate)) {
					allcates.put(testCate, new ArrayList<TestCase>());
				}
				allcates.get(testCate).add(tc);
			}
			for(List<TestCase> tcs: allcates.values()) {
				PdfPCell subtitle = new PdfPCell(new Paragraph(tcs.get(0).getTestCategory()));
				subtitle.setColspan(5);
				subtitle.setBackgroundColor(BaseColor.ORANGE.brighter());
				//subtitle.setHorizontalAlignment(Element.ALIGN_CENTER);
				table1.addCell(subtitle);
				for(TestCase tc: tcs) {
					PdfPCell[] testres = new PdfPCell[5];
					testres[0] = new PdfPCell(new Paragraph(tc.getTestCaseDescribe()));
					int tcid = tc.getId();
					int residx = 0;
					if(testResult.containsKey(tcid)) {
						String resstr = testResult.get(tcid).toLowerCase();
						if(resstr.startsWith("pass")) {
							residx = 1;
						}else if(resstr.startsWith("fail")) {
							residx = 2;
						}else if(resstr.startsWith("stop")) {
							residx = 3;
						}
					}
					if(residx == 1) {
						testres[1] = new PdfPCell(new Paragraph("1"));
						passnum ++;
					}else {
						testres[1] = new PdfPCell(new Paragraph("0"));
					}
					if(residx == 2) {
						testres[2] = new PdfPCell(new Paragraph("1"));
						failnum ++;
					}else {
						testres[2] = new PdfPCell(new Paragraph("0"));
					}
					if(residx != 1 && residx != 2) {
						testres[3] = new PdfPCell(new Paragraph("1"));
						stopnum ++;
					}else {
						testres[3] = new PdfPCell(new Paragraph("0"));
					}
					testres[4] = new PdfPCell(new Paragraph(""));
					listRow1.add(new PdfPRow(testres));
				}
			}
			
			PdfPCell sumtitle = new PdfPCell(new Paragraph("summary(总结)", bodyFont));
			sumtitle.setBackgroundColor(BaseColor.ORANGE.brighter());
			sumtitle.setColspan(5);
			table1.addCell(sumtitle);
			PdfPCell[] totalcells = new PdfPCell[5];
			totalcells[0] = new PdfPCell(new Paragraph("Total"));
			totalcells[1] = new PdfPCell(new Paragraph(String.valueOf(passnum)));
			totalcells[2] = new PdfPCell(new Paragraph(String.valueOf(failnum)));
			totalcells[3] = new PdfPCell(new Paragraph(String.valueOf(stopnum)));
			totalcells[4] = new PdfPCell(new Paragraph(""));
			listRow1.add(new PdfPRow(totalcells));
			document.add(table1);
			
		} catch (DocumentException | IOException e) {
			e.printStackTrace();
			document.close();
			writer.close();
			return false;
		}

		document.close();
		writer.close();
		return true;
	}
	
	public static void main(String[] args) {
		PDF pdf = new PDF();
		TestTask testTask = new TestTask();
		testTask.setLoginId("Allen");
		testTask.setTestTaskName("测试任务1");
		testTask.setMachineInfo("机器1");
		Calendar curcal = Calendar.getInstance();
		testTask.setEndTime(curcal.getTime());
		curcal.add(Calendar.HOUR, -2);
		testTask.setStartTime(curcal.getTime());
		testTask.setMachineType("机器类型1");
		testTask.setLoginId("测试者");
		testTask.setResult("FAIL");
		
		ArrayList<TestCase> testlist = new ArrayList<TestCase>();
		TestCase cas = new TestCase();
		cas.setId(1);
		cas.setTestCategory("category 1");
		cas.setTestCaseDescribe("describe 1");
		testlist.add(cas);
		cas = new TestCase();
		cas.setId(2);
		cas.setTestCategory("category 1");
		cas.setTestCaseDescribe("describe 2");
		testlist.add(cas);
		cas = new TestCase();
		cas.setId(3);
		cas.setTestCategory("category 2");
		cas.setTestCaseDescribe("describe 1");
		testlist.add(cas);
		
		Map<Integer, String> testres = new HashMap<>();
		testres.put(1, "PASS");
		testres.put(2, "FAIL");
		testres.put(3, "STOP");
		pdf.writePDF(testTask, testlist, testres, new File("test1.pdf"));
		
	}
}