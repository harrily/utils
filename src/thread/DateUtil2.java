package thread;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

public class DateUtil2 {
	private static SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd HH:mm:ss");
	public static SimpleDateFormat sdfMMdd = new SimpleDateFormat("MMdd");

	private static SimpleDateFormat getNowSDF = new SimpleDateFormat("yyyyMMdd");
	private static SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
	private static SimpleDateFormat dayHourSdf = new SimpleDateFormat("yyyyMMdd-HH");
	private static SimpleDateFormat dayHourMinSdf = new SimpleDateFormat("yyyyMMdd-HH-mm");

	private static SimpleDateFormat sdfyyyy_MM_dd = new SimpleDateFormat("yyyy-MM-dd");
	private static SimpleDateFormat sdfHH = new SimpleDateFormat("HH");

	/**
	 * 正数往后推,负数往前移动
	 * @param amount
	 * @return
	 */
	public static String getDateStr(int amount) {
		Date date = new Date();
		Calendar calendar = new GregorianCalendar();
		calendar.setTime(date);
		calendar.add(Calendar.DATE, amount);
		date = calendar.getTime();
		String dateString = getNowSDF.format(date);
		return dateString;
	}
	public static String long2String(long timestamp) {
		return sdf.format(new Date(timestamp));
	}
	public static String long2String(long timestamp,String pattern) {
		SimpleDateFormat sdf = new SimpleDateFormat(pattern);
		return sdf.format(new Date(timestamp));
	}

	public static String getCurrentDateAsString() {
		return getNowSDF.format(new Date());
	}

	public static String rowkey2everyDay(String rowKey) {
		return rowKey.substring(rowKey.lastIndexOf("_") + 1);
	}

	public static Date parseDate(String date) {
		try {
			return getNowSDF.parse(date);
		} catch (ParseException e) {
			e.printStackTrace();
			return null;
		}
	}

	public static String parseDate(Date date){
		return sdf1.format(date);
	}

	public static List<String> getListFromString(String startDate, String endDate) {
		List<String> dateList = new ArrayList<String>();
		Date start = DateUtil2.parseDate(startDate);
		Date end = DateUtil2.parseDate(endDate);
		Calendar start_cal = Calendar.getInstance();
		Calendar end_cal = Calendar.getInstance();
		start_cal.setTime(start);
		end_cal.setTime(end);
		while (start_cal.getTimeInMillis() <= end_cal.getTimeInMillis()) {
			dateList.add(getNowSDF.format(start_cal.getTime()));
			start_cal.add(Calendar.DATE, 1);
		}
		return dateList;
	}

	public static int getSBetweenTime() {
		long between = 0;
		try {
			String begin = sdf.format(new Date());
			String today = begin.substring(0, 8);

			Date dateBegin = sdf.parse(begin);
			Date dateEnd = sdf.parse(today.concat(" 24:00:00"));
			between = (dateEnd.getTime() - dateBegin.getTime());// 得到两者的毫秒数
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		long s = (between / 1000);
		return new Long(s).intValue();
	}

	public static long getFromString(String startDate) throws ParseException {
		return getNowSDF.parse(startDate).getTime();
	}

	public static  String today(){
		return getNowSDF.format(new Date());
	}
	public static String getMMddStr(long millis) {
		return sdfMMdd.format(millis);
	}

	public static String getDayHour(long millis){
		return dayHourSdf.format(new Date(millis));
	}

	public static String getDayHourMinute(long millis){
		return dayHourMinSdf.format(new Date(millis));
	}

	public static boolean validateTs(long ts){
		long current = (Calendar.getInstance().getTimeInMillis()/1000l);
		long interval = current - ts;
		if(Math.abs(interval) < 900){//15分钟内
			return true;
		}
		return false;
	}

	public static Date minusCalendar(Date date, int day) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.DATE, -1 * day);
		return calendar.getTime();
	}

	public static String getYesterday(){
		return getNowSDF.format(minusCalendar(new Date(), 1));
	}
	public static void main(String[] args) {
//		System.out.println(System.currentTimeMillis()/1000);
//		System.out.println(validateTs(1497505959l));
//		System.out.println(validateTs(1497505459l));
//		System.out.println(validateTs(1497503559l));
//		System.out.println("today = " + today());
		Map<String, Object> addCalendar = addCalendar(-1);
		Object object = addCalendar.get("date");
		Object object2 = addCalendar.get("dateStr");
		Object object3 = addCalendar.get("hour");
		System.out.println(object2);
		long a = 1557968827L * 1000;
		System.out.println("===:"+dayHourSdf.format(new Date(a)));
	}

	public static Map<String, Object> addCalendar(int hour) {
		Map<String, Object> map = new LinkedHashMap<String, Object>();
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(new Date());
		calendar.add(Calendar.HOUR, hour);
		Date time = calendar.getTime();
		map.put("date", time);
		map.put("dateStr", sdfyyyy_MM_dd.format(time));
		map.put("hour", sdfHH.format(time));
		return map;
	}
}
