package utils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import net.sf.json.JSONObject;
public class JsonFormat {
	public static void main(String[] args) {
		 Map<String, Object> params = new HashMap<String, Object> ();
		 Map<String, String> map1 = new HashMap<String, String> ();
		 Map<String, String> map2 = new HashMap<String, String> ();
		 Map<String, String> map3 = new HashMap<String, String> ();
		 List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		 map1.put("mac_addr", "E4956E4B7170");
		 map1.put("user_num", "111");
		 map2.put("mac_addr", "E4956E4DAD83");
		 map2.put("user_num", "222");
		 map3.put("mac_addr", "C8EEA60D847D");
		 map3.put("user_num", "333");
		 list.add(map1);
		 list.add(map2);
		 list.add(map3);
		 params.put("data", list);
		 params.put("stat_day", "2018-05-20");
		 String string = JSONObject.fromObject(params).toString();
		 System.out.println(string);
	}
}
