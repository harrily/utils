package thread;

import java.io.File;
import java.io.FilenameFilter;

public class Recursion {

	public static void main(String[] args) {
		readDirectory(new File("D:\\opt"));
	}
	
	public static void readDirectory(File file) {
		if(file.isDirectory()) {
			File[] listFiles = file.listFiles();
			for(File file1 : listFiles) {
				System.out.println(file1.getName());
				readDirectory(file1);
			}
		}
	}
	  
}
