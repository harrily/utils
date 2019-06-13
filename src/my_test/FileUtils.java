package my_test;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

public class FileUtils {
	
	static List<Character> oui41Char = Arrays.asList(new Character[]{'0','4','8','C'});
	/** 
    写入文件
     */  
    public static void readFileByLines(String fileName) {  
        File file = new File(fileName);  
        BufferedReader reader = null;
        HashMap<String, Integer> map1 = new HashMap<String, Integer>();
        try {  
            reader = new BufferedReader(new FileReader(file));  
            String tempString = null;  
            float count=0;
            System.out.println("---------------start---------------------------");
            while ((tempString = reader.readLine()) != null) {  
                // ��ʾ�к�  
                //System.out.println("line " + line + ": " + tempString);  
            	//System.out.println(tempString);
            	String mifi = tempString.split("-")[0];
            	//System.out.println("mifi:"+mifi);
            	//String mifi2 = tempString.split("\t")[1];
            	//int value = (int) ( (Integer.valueOf(tempString.split("\t")[1])) *0.026);
            	//int real_value = (int)( (Integer.valueOf(tempString.split("\t")[6])));
            	//System.out.println(value+"\t"+real_value);
            	//DecimalFormat df = new DecimalFormat("0.00");//��ʽ��С��  
            	//count = count + value;
            	//float div = (float)((float)value/30);
            	//String format = df.format(div);
            	//map.put(hezi, vlaue);
				/*
				 * if(map.containsKey(substring)) { int value = (Integer)map.get(substring) +1;
				 * map.put(substring, value); }else { map.put(substring, 1); }
				 */
            	if( !oui41Char.contains(mifi.charAt(1))) {
            		System.out.println(tempString);//"\t"+real_value);
            	}
            	//System.out.println(mifi+"\t"+value);//"\t"+real_value);
				/*
				 * int a = 9; int b = 2; System.out.println((float)a/b);
				 * System.out.println(a/(float)b);
				 */
            } 
			/*
			 * float div = (float)((float)count/30); System.out.println(div);
			 */
            reader.close();  
			
			/*
			 * Set<Entry<String, Integer>> entrySet = map.entrySet(); for(Map.Entry<String,
			 * Integer> entry : entrySet) { Integer value = entry.getValue();
			 * System.out.println(entry.getKey() + "\t" + (value)); }
			 */
			 
        } catch (IOException e) {  
            e.printStackTrace();  
        } finally {  
            if (reader != null) {  
                try {  
                    reader.close();  
                } catch (IOException e1) {  
                }  
            }  
        }  
    }  
    


	public static void main(String[] args) {
    	readFileByLines("E:\\note\\20190326_mifi_bhu吞吐量\\oui_mac.txt");
	}
}
