package utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.InputStream;
import java.io.PrintWriter;

import jxl.Sheet;
import jxl.Workbook;

public class CopyExcelToTxt {
	public static void main(String[] args) throws Exception {
		/* 1、需要 xls结尾。
		   2、需要将日期切换
		*/
		File file = new File("C:\\Users\\wang.ying.nan\\Desktop\\验证前后台数据逻辑\\cnc\\cnc-01-new3.xls");
		copy_excel(file);
		
		/**
		String s = " A	sadsad (56) " + "\n"
				+ "ddd";
		String replaceAll = s.replaceAll("[\\t\\n\\r )]", "").replaceAll("[(]", "-");
		System.out.println(s);
		System.out.println( s.replaceAll("[\\t\\n\\r )]", "").replaceAll("[(]", "-"));
		**/
			
	}
	
	@SuppressWarnings("resource")
	public static void copy_excel(File file) throws Exception {
		FileWriter fWriter = null;
		PrintWriter out = null;
		String fliename = file.getName().replace(".xls", "");
		fWriter = new FileWriter(file.getParent() + "/" + fliename + ".txt");//输出格式为.txt
		//fWriter = new FileWriter(file.getParent()+ "/agetwo.xls");//输出格式为.xls
		out = new PrintWriter(fWriter);
		InputStream is = new FileInputStream(file.getAbsoluteFile());
		Workbook wb = null;
		wb = Workbook.getWorkbook(is);
		int sheet_size = wb.getNumberOfSheets();
		Sheet sheet = wb.getSheet(0);
		for (int j = 1; j < sheet.getRows(); j++) {
			
			/**if( j ==10 ) {
				break;
			}  **/
			
			String line = sheet.getCell(0, j).getContents().trim().replaceAll("[\\t\\n\\r )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(1, j).getContents().trim().replaceAll("[\\t\\n\\r )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(2, j).getContents().trim().replaceAll("[\\t\\n\\r )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(3, j).getContents().trim().replaceAll("[\\t\\n\\r )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(4, j).getContents().trim().replaceAll("[\\t\\n\\r )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(5, j).getContents().trim().replaceAll("[\\t\\n\\r )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(6, j).getContents().trim().replaceAll("[\\t\\n\\r )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(7, j).getContents().trim().replaceAll("[\\t\\n\\r )]", "").replaceAll("[(]", "-").replaceAll("[/]", "-")
					+ "^#" + sheet.getCell(8, j).getContents().trim().replaceAll("[\\t\\n\\r )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(9, j).getContents().trim().replaceAll("[\\t\\n\\r )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(10, j).getContents().trim().replaceAll("[\\t\\n\\r )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(11, j).getContents().trim().replaceAll("[\\t\\n\\r )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(12, j).getContents().trim().replaceAll("[\\t\\n\\r )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(13, j).getContents().trim().replaceAll("[\\t\\n\\r )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(14, j).getContents().trim().replaceAll("[\\t\\n\\r )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(15, j).getContents().trim().replaceAll("[\\t\\n\\r )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(16, j).getContents().trim().replaceAll("[\\t\\n\\r )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(17, j).getContents().trim().replaceAll("[\\t\\n\\r )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(18, j).getContents().trim().replaceAll("[\\t\\n\\r )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(19, j).getContents().trim().replaceAll("[\\t\\n\\r )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(20, j).getContents().trim().replaceAll("[\\t\\n\\r )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(21, j).getContents().trim().replaceAll("[\\t\\n\\r )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(22, j).getContents().trim().replaceAll("[\\t\\n\\r )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(23, j).getContents().trim().replaceAll("[\\t\\n\\r )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(24, j).getContents().trim().replaceAll("[\\t\\n\\r )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(25, j).getContents().trim().replaceAll("[\\t\\n\\r )]", "").replaceAll("[(]", "-")
					;
					
			
			System.out.println(line);
			/*	//	System.out.println(sheet.getCell(7, j).getContents().trim().replaceAll("[\\t\\n\\r )]", "").replaceAll("[(]", "-").replaceAll("[/]", "-"));
			/*String cellinfo = sheet.getCell(1, j).getContents();//读取的是第二列数据，没有标题，标题起始位置在for循环中定义
			System.out.println(sheet.getCell(0, j).getContents().trim().replaceAll("[\\t\\n\\r ]", ""));
			System.out.println(sheet.getCell(1, j).getContents().trim().replaceAll("[\\t\\n\\r ]", ""));
			System.out.println(sheet.getCell(2, j).getContents().trim().replaceAll("[\\t\\n\\r ]", ""));
			System.out.println(sheet.getCell(3, j).getContents().trim().replaceAll("[\\t\\n\\r ]", ""));
			System.out.println(sheet.getCell(4, j).getContents().trim().replaceAll("[\\t\\n\\r ]", ""));
			System.out.println(sheet.getCell(5, j).getContents().trim().replaceAll("[\\t\\n\\r ]", ""));
			System.out.println(sheet.getCell(6, j).getContents().trim().replaceAll("[\\t\\n\\r ]", ""));
			System.out.println(sheet.getCell(7, j).getContents().trim().replaceAll("[\\t\\n\\r ]", ""));
			System.out.println(sheet.getCell(8, j).getContents().trim().replaceAll("[\\t\\n\\r ]", ""));
			System.out.println(sheet.getCell(9, j).getContents().trim().replaceAll("[\\t\\n\\r ]", ""));
			System.out.println(sheet.getCell(10, j).getContents().trim().replaceAll("[\\t\\n\\r ]", ""));
			System.out.println(sheet.getCell(11, j).getContents().trim().replaceAll("[\\t\\n\\r ]", ""));
			System.out.println(sheet.getCell(12, j).getContents().trim().replaceAll("[\\t\\n\\r ]", ""));
			System.out.println(sheet.getCell(13, j).getContents().trim().replaceAll("[\\t\\n\\r ]", ""));
			System.out.println(sheet.getCell(14, j).getContents().trim().replaceAll("[\\t\\n\\r ]", ""));
			System.out.println(sheet.getCell(15, j).getContents().trim().replaceAll("[\\t\\n\\r ]", ""));
			System.out.println(sheet.getCell(16, j).getContents().trim().replaceAll("[\\t\\n\\r ]", ""));
			System.out.println(sheet.getCell(17, j).getContents().trim().replaceAll("[\\t\\n\\r ]", ""));
			System.out.println(sheet.getCell(18, j).getContents().trim().replaceAll("[\\t\\n\\r ]", ""));
			System.out.println(sheet.getCell(19, j).getContents().trim().replaceAll("[\\t\\n\\r ]", ""));
			System.out.println(sheet.getCell(20, j).getContents().trim().replaceAll("[\\t\\n\\r ]", ""));
			System.out.println(sheet.getCell(21, j).getContents().trim().replaceAll("[\\t\\n\\r ]", ""));
			System.out.println(sheet.getCell(22, j).getContents().trim().replaceAll("[\\t\\n\\r ]", ""));
			System.out.println(sheet.getCell(23, j).getContents().trim().replaceAll("[\\t\\n\\r ]", ""));
			System.out.println(sheet.getCell(24, j).getContents().trim().replaceAll("[\\t\\n\\r ]", ""));
			System.out.println(sheet.getCell(25, j).getContents().trim().replaceAll("[\\t\\n\\r ]", ""));
			
			*/
			System.out.println("***********************");
			out.println(line);
		}
		out.close();//关闭流
		fWriter.close();
		out.flush();//刷新缓存
		//System.out.println("输出完成！");
	}
	
}
