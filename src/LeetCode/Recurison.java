package LeetCode;

import java.io.File;

public class Recurison {
	    public static void main(String [] args) {
	        traverseFolder("C:\\Users\\wang.ying.nan\\Desktop\\验证前后台数据逻辑\\基准价新规则--VVVVVVVV");
	    }
	    public  static void traverseFolder(String path) {

	        File file = new File(path);
	        if (file.exists()) {
	            File[] files = file.listFiles();
	            if (null == files || files.length == 0) {
	                System.out.println("文件夹是空的!");
	                return;
	            } else {
	                for (File file2 : files) {
	                    if (file2.isDirectory()) {
	                        traverseFolder(file2.getAbsolutePath());
	                    } else {
	                        System.out.println("文件:" + file2.getAbsolutePath());
	                    }
	                }
	            }
	        } else {
	            System.out.println("文件不存在!");
	        }
	    }
	    
	   
}
