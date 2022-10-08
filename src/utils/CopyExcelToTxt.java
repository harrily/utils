package utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.InputStream;
import java.io.PrintWriter;
import java.math.RoundingMode;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import jxl.Cell;
import jxl.CellType;
import jxl.NumberCell;
import jxl.Sheet;
import jxl.Workbook;

public class CopyExcelToTxt {
	public static void main(String[] args) throws Exception {
		/* 1、需要 xls结尾。
		   2、需要将日期切换
		*/
		////File file2 = new File("C:\\Users\\wang.ying.nan\\Desktop\\验证前后台数据逻辑\\冲压\\冲压-03-xls.xls");
		///copy_excel2(file2);
		
		////File file1 = new File("C:\\Users\\wang.ying.nan\\Desktop\\验证前后台数据逻辑\\cnc\\CNC03\\cnc-03-new1.xls");
		////copy_excel1(file1);
		
		////File file1 = new File("C:\\Users\\wang.ying.nan\\Desktop\\验证前后台数据逻辑\\zuzhaung\\zuzhuang-03-new1.xls");
		///copy_excel1(file1);
		
		////File file3 = new File("C:\\Users\\wang.ying.nan\\Desktop\\验证前后台数据逻辑\\模切数据\\模切数据-3.xls");
		////copy_excel_moqie(file3);
		
		File file3 = new File("C:\\Users\\wang.ying.nan\\Desktop\\验证前后台数据逻辑\\模切数据\\模切-部分数据\\moqie-01-part1.xls");
		copy_excel_moqie2(file3);
		
		////File file2 = new File("C:\\Users\\wang.ying.nan\\Desktop\\验证前后台数据逻辑\\磁材\\cicai-03.xls");
		////copy_excel_cicai(file2);
		
		/**
		String s = " A	sadsad (56) " + "\n"
				+ "ddd";
		String replaceAll = s.replaceAll("[\\t\\n\\r )]", "").replaceAll("[(]", "-");
		System.out.println(s);
		System.out.println( s.replaceAll("[\\t\\n\\r )]", "").replaceAll("[(]", "-"));
		**/
		
		//String format = String.format("%.6f",Double.valueOf("0.76991145"));
		//System.out.println(format);
		
		/**
	    String format = "yyyy-MM-dd";
        Date nowTime = new SimpleDateFormat(format).parse("2021-10-09");
        Date startTime = new SimpleDateFormat(format).parse("2019-12-16");
        System.out.println(nowTime);
        Date endTime = new SimpleDateFormat(format).parse("2020-01-15");
        System.out.println(isEffectiveDate(nowTime, startTime, endTime));
		**/
		
}

	
	/**
	 * 1、日期，excel处理 长日期、 且代码中  "/" 替换为 "-" ,且 代码中excel中部分数值要去掉 ','
	 * 2、单价保留10位处理
	 * 3、去掉  特殊字符，以及 (213)数据去掉括号。
	 * 4、文件改为xls
	 * 5、不要读取第一行，则置j=1，反之置为0
	 * 6、数据是否会读取空行，读取的话，需要break
	 * @param file
	 * @throws Exception
	 */
	@SuppressWarnings("resource")
	public static void copy_excel1(File file) throws Exception {
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
			
			// 测试前十条数据
		if( j == 256 ) {break;}
			
			/**
			 单价保留10位处理
			 */
			String price = "";
			if(sheet.getCell(16, j).getContents().trim().replaceAll("[\\t\\n\\r,)]", "").replaceAll("[(]", "-") == null || 
					sheet.getCell(16, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-") == "") {
				  price = sheet.getCell(16, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-");
			}else {
				  Cell cell = sheet.getCell(16, j);
				  NumberCell numberCell = (NumberCell) cell;
				  double value =numberCell.getValue();
	              NumberFormat nf=NumberFormat.getInstance();
	              nf.setMaximumFractionDigits(10);//保留4位小数 
	              nf.setRoundingMode (RoundingMode.HALF_UP);
	              /* * 如果想输出的格式用逗号隔开，可以设置成true */
	              nf.setGroupingUsed(false);
	              price =  nf.format(value);
				
				//price = String.format("%.6f", (Double.valueOf(sheet.getCell(16, j).getContents().trim().replaceAll("[\\t\\n\\r )]", "").replaceAll("[(]", "-"))));
			}
			
	             
	             
			//System.out.println(sheet.getCell(16, j).getNumericCellValue().trim().replaceAll("[\\t\\n\\r )]", "").replaceAll("[(]", "-"));
	     // System.out.println("====>  "+ String.format("%.6f", (Double.valueOf(sheet.getCell(16, j).getContents().trim().replaceAll("[\\t\\n\\r )]", "").replaceAll("[(]", "-")))));
		// CNC 专用  （逻辑钟包含 去掉  （）  转化为  空和- ）
			String line = sheet.getCell(0, j).getContents().trim().replaceAll("[\\t\\n\\r,)]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(1, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(2, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(3, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(4, j).getContents().trim().replaceAll("[\\t\\n\\r,  )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(5, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(6, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					// 日期修正
					+ "^#" + sheet.getCell(7, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-").replaceAll("[/]", "-")
					+ "^#" + sheet.getCell(8, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(9, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(10, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" 	+ sheet.getCell(11, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(12, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(13, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(14, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(15, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + price
					+ "^#" + sheet.getCell(17, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(18, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(19, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(20, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(21, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(22, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(23, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(24, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(25, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					;
			
			System.out.println("j:"+j+"   "+line);
				System.out.println("***********************");
				out.println(line);
		}
		out.close();//关闭流
		fWriter.close();
	    out.flush();//刷新缓存
	  //System.out.println("输出完成！");
	}
	
	
	
	
	/**
	 * chongya专用
	 * 	 1、日期，excel处理 长日期、 且代码中  "/" 替换为 "-" ,且 代码中excel中部分数值要去掉 ','
	 * 2、单价保留10位处理
	 * 3、去掉  特殊字符，以及 (213)数据去掉括号。
	 * 4、文件改为xls
	 * 5、不要读取第一行，则置j=1，反之置为0
	 * 6、数据是否会读取空行，读取的话，需要break
	 * @param file
	 * @throws Exception
	 */
	@SuppressWarnings("resource")
	public static void copy_excel2(File file) throws Exception {
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
			
			// 测试前十条数据
			if( j ==12197 ) {break;}
			  
			// 处理日期
			String date_new = sheet.getCell(4, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-");
			String split0 = "";
			String split1 = "";
			String split2 = "";
			if(date_new.contains("/")) {
				 split0 = date_new.split("/")[0];
				 split1 = date_new.split("/")[1];
				 split2 = date_new.split("/")[2];
			}
			if(date_new.contains("-")) {
				 split0 = date_new.split("-")[0];
				 split1 = date_new.split("-")[1];
				 split2 = date_new.split("-")[2];

			}
			
			if(split1.length() == 1) {
				split1 = "0"+split1;
			}
			if(split2.length() == 1) {
				split2 = "0"+split2;
			}
			date_new =  split0+"-"+split1+"-"+split2;
			//System.out.println(date_new);
			
			
				//处理price
			String price = "";
			if(sheet.getCell(19, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-") == null || 
					sheet.getCell(19, j).getContents().trim().replaceAll("[\\t\\n\\r ,)]", "").replaceAll("[(]", "-") == "") {
				  price =sheet.getCell(19, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-");
			}else {
				  Cell cell = sheet.getCell(19, j);
				  NumberCell numberCell = (NumberCell) cell;
				  double value =numberCell.getValue();
	              NumberFormat nf=NumberFormat.getInstance();
	              nf.setMaximumFractionDigits(10);//保留4位小数 
	              nf.setRoundingMode (RoundingMode.HALF_UP);
	              /* * 如果想输出的格式用逗号隔开，可以设置成true */
	              nf.setGroupingUsed(false);
	              price =  nf.format(value);
				
				//price = String.format("%.6f", (Double.valueOf(sheet.getCell(16, j).getContents().trim().replaceAll("[\\t\\n\\r )]", "").replaceAll("[(]", "-"))));
			}
			
			
			// 冲压专用
			String line = sheet.getCell(0, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(1, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(2, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(3, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + date_new
					+ "^#" + sheet.getCell(5, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(6, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(7, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(8, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(9, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(10, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" 	+ sheet.getCell(11, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(12, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(13, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(14, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(15, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(16, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(17, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(18, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + price
					+ "^#" + sheet.getCell(20, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(21, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(22, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(23, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(24, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(25, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(26, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(27, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(28, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(29, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(30, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(31, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(32, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(33, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(34, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(35, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					;
			System.out.println(line);
			System.out.println("***********************");
			out.println(line);
		}
		out.close();//关闭流
		fWriter.close();
		out.flush();//刷新缓存
		//System.out.println("输出完成！");
	}
	
	
	/**
	 * 模切专用
	 * 
	 * 1、日期，excel处理 长日期、 且代码中  "/" 替换为 "-" ,且 excel中部分数值要去掉 ',' 且，excel中 设置日期为 ‘2010/10/11’
	 * 2、单价保留10位处理
	 * 3、去掉  特殊字符，以及 (213)数据去掉括号。
	 * 4、文件改为xls
	 * 
	 * 5、根据入库审核时间过滤数据写入
	 * @param file
	 * @throws Exception
	 */
	@SuppressWarnings("resource")
	public static void copy_excel_moqie(File file) throws Exception {
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
		for (int j =1; j < sheet.getRows(); j++) {
			
			// 模切 01 时，数据太多为null的，break掉
		//	if( j ==47682 ) {break;}
			  
			// 处理日期
		
			String date_new = sheet.getCell(3, j).getContents().trim().replaceAll("[\\t\\n\\r )]", "").replaceAll("[(]", "-");
			System.out.println(date_new);
			if(date_new.contains("-")) {
				date_new = date_new.substring(0, 10);
			}else {
				String split0 = date_new.split("/")[0];
				String split1 = date_new.split("/")[1];
				String split2 = date_new.split("/")[2];
				if(split1.length() == 1) {
					split1 = "0"+split1;
				}
				if(split2.length() == 1) {
					split2 = "0"+split2;
				}
				date_new =  split0+"-"+split1+"-"+split2;
			}
			
			System.out.println("j="+j+"  data_new="+date_new);
				
			//处理price
			
			String price = "";
			if(sheet.getCell(27, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-") == null || 
					sheet.getCell(27, j).getContents().trim().replaceAll("[\\t\\n\\r ,)]", "").replaceAll("[(]", "-") == "") {
				  price =sheet.getCell(27, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-");
			}else {
				  Cell cell = sheet.getCell(27, j);
				  NumberCell numberCell = (NumberCell) cell;
				  double value =numberCell.getValue();
	              NumberFormat nf=NumberFormat.getInstance();
	              nf.setMaximumFractionDigits(10);//保留4位小数 
	              nf.setRoundingMode (RoundingMode.HALF_UP);
	              /* * 如果想输出的格式用逗号隔开，可以设置成true */
	              nf.setGroupingUsed(false);
	              price =  nf.format(value);
				
				//price = String.format("%.6f", (Double.valueOf(sheet.getCell(16, j).getContents().trim().replaceAll("[\\t\\n\\r )]", "").replaceAll("[(]", "-"))));
			}
			
			
			// 模切专用
			String line = sheet.getCell(0, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(1, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(2, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + date_new
					+ "^#" + sheet.getCell(4, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(5, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(7, j).getContents().trim().replaceAll("[\\t\\n\\r,)]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(9, j).getContents().trim().replaceAll("[\\t\\n\\r,)]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(10, j).getContents().trim().replaceAll("[\\t\\n\\r,)]", "").replaceAll("[(]", "-")
					+ "^#" 	+ sheet.getCell(11, j).getContents().trim().replaceAll("[\\t\\n\\r,)]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(12, j).getContents().trim().replaceAll("[\\t\\n\\r,)]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(19, j).getContents().trim().replaceAll("[\\t\\n\\r ,)]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(20, j).getContents().trim().replaceAll("[\\t\\n\\r ,)]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(22, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(23, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(24, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(25, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(26, j).getContents().trim().replaceAll("[\\t\\n\\r ,)]", "").replaceAll("[(]", "-")
						+ "^#" + price
					+ "^#" + sheet.getCell(28, j).getContents().trim().replaceAll("[\\t\\n\\r ,)]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(29, j).getContents().trim().replaceAll("[\\t\\n\\r ,)]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(30, j).getContents().trim().replaceAll("[\\t\\n\\r ,)]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(31, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(32, j).getContents().trim().replaceAll("[\\t\\n\\r ,)]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(34, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(35, j).getContents().trim().replaceAll("[\\t\\n\\r ,)]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(38, j).getContents().trim().replaceAll("[\\t\\n\\r ,)]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(39, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(40, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(41, j).getContents().trim().replaceAll("[\\t\\n\\r ,)]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(46, j).getContents().trim().replaceAll("[\\t\\n\\r ,)]", "").replaceAll("[(]", "-")
					;
			System.out.println(line);
			System.out.println("***********************");
			out.println(line);
		}
   	out.close();//关闭流
		fWriter.close();
		out.flush();//刷新缓存
		//System.out.println("输出完成！");
	}
	
	
	/**
	 * 
	 * 1、日期，excel处理 长日期、 且代码中  "/" 替换为 "-" ,且 excel中部分数值要去掉 ',' 且，excel中 设置日期为 ‘2010/10/11’
	 * 2、单价保留10位处理
	 * 3、去掉  特殊字符，以及 (213)数据去掉括号。
	 * 4、文件改为xls
	 * 
	 * 5、根据入库审核时间过滤数据写入
	 * @param file
	 * @throws Exception
	 */
	@SuppressWarnings("resource")
	public static void copy_excel_moqie2(File file) throws Exception {
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
		for (int j =1; j < sheet.getRows(); j++) {
			
			// 模切 01 时，数据太多为null的，break掉
		//	if( j ==47682 ) {break;}
			  
			// 处理日期
		
			String date_new = sheet.getCell(3, j).getContents().trim().replaceAll("[\\t\\n\\r )]", "").replaceAll("[(]", "-");
			System.out.println(date_new);
			if(date_new.contains("-")) {
				date_new = date_new.substring(0, 10);
			}else {
				String split0 = date_new.split("/")[0];
				String split1 = date_new.split("/")[1];
				String split2 = date_new.split("/")[2];
				if(split1.length() == 1) {
					split1 = "0"+split1;
				}
				if(split2.length() == 1) {
					split2 = "0"+split2;
				}
				date_new =  split0+"-"+split1+"-"+split2;
			}
			
			System.out.println("j="+j+"  data_new="+date_new);
				
			//处理price
			
			String price = "";
			if(sheet.getCell(18, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-") == null || 
					sheet.getCell(18, j).getContents().trim().replaceAll("[\\t\\n\\r ,)]", "").replaceAll("[(]", "-") == "") {
				  price =sheet.getCell(18, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-");
			}else {
				  Cell cell = sheet.getCell(18, j);
				  NumberCell numberCell = (NumberCell) cell;
				  double value =numberCell.getValue();
	              NumberFormat nf=NumberFormat.getInstance();
	              nf.setMaximumFractionDigits(10);//保留4位小数 
	              nf.setRoundingMode (RoundingMode.HALF_UP);
	              /* * 如果想输出的格式用逗号隔开，可以设置成true */
	              nf.setGroupingUsed(false);
	              price =  nf.format(value);
				
				//price = String.format("%.6f", (Double.valueOf(sheet.getCell(16, j).getContents().trim().replaceAll("[\\t\\n\\r )]", "").replaceAll("[(]", "-"))));
			}
			
			
			// 模切专用
			String line = sheet.getCell(0, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(1, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(2, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + date_new
					+ "^#" + sheet.getCell(4, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(5, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(6, j).getContents().trim().replaceAll("[\\t\\n\\r,)]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(7, j).getContents().trim().replaceAll("[\\t\\n\\r,)]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(8, j).getContents().trim().replaceAll("[\\t\\n\\r,)]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(9, j).getContents().trim().replaceAll("[\\t\\n\\r,)]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(10, j).getContents().trim().replaceAll("[\\t\\n\\r,)]", "").replaceAll("[(]", "-")
					+ "^#" 	+ sheet.getCell(11, j).getContents().trim().replaceAll("[\\t\\n\\r,)]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(12, j).getContents().trim().replaceAll("[\\t\\n\\r,)]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(13, j).getContents().trim().replaceAll("[\\t\\n\\r ,)]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(14, j).getContents().trim().replaceAll("[\\t\\n\\r ,)]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(15, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(16, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(17, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + price
					+ "^#" + sheet.getCell(19, j).getContents().trim().replaceAll("[\\t\\n\\r ,)]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(20, j).getContents().trim().replaceAll("[\\t\\n\\r ,)]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(21, j).getContents().trim().replaceAll("[\\t\\n\\r ,)]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(22, j).getContents().trim().replaceAll("[\\t\\n\\r ,)]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(23, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(24, j).getContents().trim().replaceAll("[\\t\\n\\r ,)]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(25, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(26, j).getContents().trim().replaceAll("[\\t\\n\\r ,)]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(27, j).getContents().trim().replaceAll("[\\t\\n\\r ,)]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(28, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(29, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(30, j).getContents().trim().replaceAll("[\\t\\n\\r ,)]", "").replaceAll("[(]", "-")
					;
			System.out.println(line);
			System.out.println("***********************");
			
			/**
			 * 入库审核时间  在 某个范围内才写入。
			 */
			 String format = "yyyy-MM-dd";
			 Date nowTime = new SimpleDateFormat(format).parse(date_new);
		     Date startTime = new SimpleDateFormat(format).parse("2019-12-16");
		     Date endTime = new SimpleDateFormat(format).parse("2020-01-15");
			 if( isEffectiveDate(nowTime, startTime, endTime)) {
				    System.out.println("++++++++++:"+isEffectiveDate(nowTime, startTime, endTime));
			     	out.println(line);
			 }
			
			
		}
      	out.close();//关闭流
		fWriter.close();
		out.flush();//刷新缓存
		//System.out.println("输出完成！");
	}

	    /**
	     * 判断当前时间是否在[startTime, endTime]区间，注意时间格式要一致
	     * 
	     * @param nowTime 当前时间
	     * @param startTime 开始时间
	     * @param endTime 结束时间
	     * @return
	     * @author jqlin
	     */
	    public static boolean isEffectiveDate(Date nowTime, Date startTime, Date endTime) {
	        if (nowTime.getTime() == startTime.getTime()
	                || nowTime.getTime() == endTime.getTime()) {
	            return true;
	        }

	        Calendar date = Calendar.getInstance();
	        date.setTime(nowTime);

	        Calendar begin = Calendar.getInstance();
	        begin.setTime(startTime);

	        Calendar end = Calendar.getInstance();
	        end.setTime(endTime);

	        if (date.after(begin) && date.before(end)) {
	            return true;
	        } else {
	            return false;
	        }
	    }
	
	
	/**
	 * 磁材专用
	 * 
	 * 
	 * 1、日期，excel处理 长日期、 且代码中  "/" 替换为 "-" ,且 代码中excel中部分数值要去掉 ','
	 * 2、单价保留10位处理
	 * 3、去掉  特殊字符，以及 (213)数据去掉括号。
	 * 4、文件改为xls
	 * 5、不要读取第一行，则置j=1，反之置为0
	 * 6、数据是否会读取空行，读取的话，需要break
	 * @param file
	 * @throws Exception
	 */
	@SuppressWarnings("resource")
	public static void copy_excel_cicai(File file) throws Exception {
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
			
			// 测试前十条数据
	//	if( j == 256 ) {break;}
			
			/**
			 单价保留10位处理
			 */
			String price = "";
			if(sheet.getCell(14, j).getContents().trim().replaceAll("[\\t\\n\\r,)]", "").replaceAll("[(]", "-") == null || 
					sheet.getCell(14, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-") == "") {
				  price = sheet.getCell(14, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-");
			}else {
				  Cell cell = sheet.getCell(14, j);
				  NumberCell numberCell = (NumberCell) cell;
				  double value =numberCell.getValue();
	              NumberFormat nf=NumberFormat.getInstance();
	              nf.setMaximumFractionDigits(10);//保留4位小数 
	              nf.setRoundingMode (RoundingMode.HALF_UP);
	              /* * 如果想输出的格式用逗号隔开，可以设置成true */
	              nf.setGroupingUsed(false);
	              price =  nf.format(value);
				
				//price = String.format("%.6f", (Double.valueOf(sheet.getCell(16, j).getContents().trim().replaceAll("[\\t\\n\\r )]", "").replaceAll("[(]", "-"))));
			}
			
			
			  
				// 处理日期
			
				String date_new = sheet.getCell(7, j).getContents().trim().replaceAll("[\\t\\n\\r )]", "").replaceAll("[(]", "-");
				System.out.println(date_new);
				if(sheet.getCell(7, j).getContents().trim().replaceAll("[\\t\\n\\r,)]", "").replaceAll("[(]", "-") == null || 
						sheet.getCell(7, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-") == "") {
					  price = sheet.getCell(7, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-");
				}else {
					if(date_new.contains("-")) {
						date_new = date_new.substring(0, 10);
					}else {
						String split0 = date_new.split("/")[0];
						String split1 = date_new.split("/")[1];
						String split2 = date_new.split("/")[2];
						if(split1.length() == 1) {
							split1 = "0"+split1;
						}
						if(split2.length() == 1) {
							split2 = "0"+split2;
						}
						date_new =  split0+"-"+split1+"-"+split2;
					}
					
					System.out.println("j="+j+"  data_new="+date_new);
				
				} 
				
				
				// 处理 tax  为百分号
				String tax_rate = "";
				if(sheet.getCell(35, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-").contains("%")) {
					tax_rate = sheet.getCell(35, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-").split("%")[0];
				}else {
					tax_rate = sheet.getCell(35, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-");
				}
				String cd_pro = "";
				if(sheet.getCell(28, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-").contains("%")) {
					cd_pro = sheet.getCell(28, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-").split("%")[0];
				}else {
					cd_pro = sheet.getCell(28, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-");
				}
				
				
				
	             
			//System.out.println(sheet.getCell(16, j).getNumericCellValue().trim().replaceAll("[\\t\\n\\r )]", "").replaceAll("[(]", "-"));
	     // System.out.println("====>  "+ String.format("%.6f", (Double.valueOf(sheet.getCell(16, j).getContents().trim().replaceAll("[\\t\\n\\r )]", "").replaceAll("[(]", "-")))));
		// CNC 专用  （逻辑钟包含 去掉  （）  转化为  空和- ）
			String line = sheet.getCell(0, j).getContents().trim().replaceAll("[\\t\\n\\r,)]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(1, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(2, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(3, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(4, j).getContents().trim().replaceAll("[\\t\\n\\r,  )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(5, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(6, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					// 日期修正
					+ "^#" + date_new
					+ "^#" + sheet.getCell(8, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(9, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(10, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" 	+ sheet.getCell(11, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(12, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(13, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + price
					+ "^#" + sheet.getCell(15, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(16, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(17, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(18, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(19, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(20, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(21, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(22, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(23, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(24, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(25, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(26, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(27, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + cd_pro
					+ "^#" + sheet.getCell(29, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(30, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(31, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(32, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(33, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(34, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + tax_rate
					+ "^#" + sheet.getCell(36, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(37, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					+ "^#" + sheet.getCell(38, j).getContents().trim().replaceAll("[\\t\\n\\r, )]", "").replaceAll("[(]", "-")
					;
			
			System.out.println("j:"+j+"   "+line);
				System.out.println("***********************");
				out.println(line);
		}
		out.close();//关闭流
		fWriter.close();
	    out.flush();//刷新缓存
	  //System.out.println("输出完成！");
	}
}
