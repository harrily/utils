package my_test;
import java.util.Date;

import org.apache.commons.lang.time.DateUtils;

public class date {
  public static void main(String[] args) {
	
	  Date day30agoDate = DateUtils.addDays(new Date(), -1 * 180);
      Date yesterdayDate = DateUtils.addDays(new Date(), -1);
      String day30agoStr = DateUtil.format(day30agoDate, "yyyy-MM-dd");
      String yesterdayStr = DateUtil.format(yesterdayDate, "yyyy-MM-dd");
	  System.out.println("day30agoStr:"+day30agoStr);
	  System.out.println("yesterdayStr:"+yesterdayStr);
	  System.out.println(Integer.valueOf(String.valueOf(new Date().getTime()/1000)));
	  byte[] b = new byte[100];
	  System.out.println(b[0]);

	
  }
}
