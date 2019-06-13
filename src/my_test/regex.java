package my_test;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class regex {

	
	public static void main(String[] args) {
		//global:mac:0c1daf61bf78:1551931701\001global:mac:022222222222:1551931701\001....
		//"id":"-0415XYSJ05559423","id_type":"comp_id","channel":"global"}
		//Pattern p = Pattern.compile("(?<=^[^\\:]{1,10000}\\:[^\\:]{1,10000}\\:).+(?=\\:\\d{1,10000}$)", 2);
		Pattern p = Pattern.compile("(?<=^[^\\:]{1,10000}\\:[^\\:]{1,10000}\\:).+(?=\\:\\d{10,10000}$)", 2);
        Matcher matcher = p.matcher("global:comp_id:-0415XYSJ05559423:1551931701");
        matcher.find();
        String id_value;
        id_value = matcher.group().toString();
        System.out.println("id_values:"+id_value);
        System.out.println("count:"+matcher.groupCount());
        
        
        
        
        // 按指定模式在字符串查找
        String line = "wo ao ni :3000:! OK?";
        String pattern = "(?<=^\\D*\\:).+(?=\\:.*$)";
   
        // 创建 Pattern 对象
        Pattern r = Pattern.compile(pattern);
       
        // 现在创建 matcher 对象
        Matcher m = r.matcher(line);
        System.out.println("count2:"+m.groupCount());
        if (m.find( )) {
           System.out.println("Found value: " + m.group(0) );
          // System.out.println("Found value: " + m.group(1) );
          // System.out.println("Found value: " + m.group(2) );
          // System.out.println("Found value: " + m.group(3) ); 
        } else {
           System.out.println("NO MATCH");
        }
	}
}
