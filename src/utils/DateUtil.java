package utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

public class DateUtil {
	private static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	public static SimpleDateFormat sdfMMdd = new SimpleDateFormat("MMdd");

	private static SimpleDateFormat getNowSDF = new SimpleDateFormat("yyyyMMdd");
	private static SimpleDateFormat DAY_HOUR_MINUTE = new SimpleDateFormat("yyyyMMdd-HH-mm");

	private static SimpleDateFormat sdfyyyy_MM_dd = new SimpleDateFormat("yyyy-MM-dd");
	private static SimpleDateFormat sdfHH = new SimpleDateFormat("HH");
	private static SimpleDateFormat SDF_DAY_HOUR = new SimpleDateFormat("yyyyMMdd-HH");
	/**
	 * ����������,������ǰ�ƶ�
	 * @param amount
	 * @return
	 */
	public static String getDateStr(int amount) {
		return getDateStr(amount,"yyyyMMdd");
	}
	public static String getDateStr(int amount, String pattern) {
		Date date = new Date();
		Calendar calendar = new GregorianCalendar();
		calendar.setTime(date);
		calendar.add(Calendar.DATE, amount);
		date = calendar.getTime();
		SimpleDateFormat sdf = new SimpleDateFormat(pattern);
		return sdf.format(date);
	}

	public static String long2String(long timestamp) {
		return sdf.format(timestamp);
	}
	
	public static String getYesterday(){
		return getNowSDF.format(minusCalendar(new Date(), 1));
	}
	public static String getYesterdayString(){
		return sdfyyyy_MM_dd.format(minusCalendar(new Date(), 1));
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

	public static Date parseFormat(String date) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			return dateFormat.parse(date);
		} catch (ParseException e) {
			e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
			return null;
		}
	}
	public static Date parseFormat(String date,String format) {
		SimpleDateFormat df = new SimpleDateFormat(format);
		try {
			return df.parse(date);
		} catch (ParseException e) {
			e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
			return null;
		}
	}

	public static String format(Long timestamp,String format) {
		SimpleDateFormat df = new SimpleDateFormat(format);
		try {
			Date date = new Date(timestamp);
			return df.format(date);
		} catch (Exception e) {
			e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
			return null;
		}
	}
	public static String format(Date date,String pattern) {
		SimpleDateFormat df = new SimpleDateFormat(pattern);
		return df.format(date);
	}

	public static Long parse4Long(String date) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			return dateFormat.parse(date).getTime();
		} catch (ParseException e) {
			e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
		}
		return 0L;
	}

	public static List<String> getLastMinuteList() {
		return getLastMinuteList(30);
	}

	/**
	 * ��װ���30���ӵ��ַ����б�
	 * @param num
	 * @return
     */
	public static List<String> getLastMinuteList(int num) {
		List<String> minuteList = new LinkedList<>();

		for (int i = 1; i <= num; i++) {
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(new Date());
			calendar.add(Calendar.MINUTE, -1 * i);
			minuteList.add(DAY_HOUR_MINUTE.format(calendar.getTime()));
		}
		return minuteList;
	}

	public static List<String> getListFromString(String startDate, String endDate) {
		return getListFromString(startDate, endDate, "yyyyMMdd");

	}

	public static List<String> getListFromString(String startDate, String endDate, String pattern) {
		SimpleDateFormat sdf = new SimpleDateFormat(pattern);
		List<String> dateList = new ArrayList<String>();
		Date start = DateUtil.parseFormat(startDate, pattern);
		Date end = DateUtil.parseFormat(endDate, pattern);
		Calendar start_cal = Calendar.getInstance();
		Calendar end_cal = Calendar.getInstance();
		start_cal.setTime(start);
		end_cal.setTime(end);
		while (start_cal.getTimeInMillis() <= end_cal.getTimeInMillis()) {
			dateList.add(sdf.format(start_cal.getTime()));
			start_cal.add(Calendar.DATE, 1);
		}
		return dateList;
	}






	public static long getFromString(String startDate) throws ParseException {
		return getNowSDF.parse(startDate).getTime();
	}
	  /**
     * �ڵ�ǰ�������������
     *
     * @param date
     * @param day
     * @return ������������������
     */
    public static Date addCalendar(Date date, int day) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.add(Calendar.DATE, day);
        return calendar.getTime();
    }

    public static Date minusCalendar(Date date, int day) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.add(Calendar.DATE, -1 * day);
        return calendar.getTime();
    }
	
	public static  String today(){
		return getNowSDF.format(new Date());
	}
	public static String getMMddStr(long millis) {
		return sdfMMdd.format(millis);
	}


	public static boolean validateTs(long ts){
		long current = (Calendar.getInstance().getTimeInMillis()/1000l);
		long interval = current - ts;
		if(Math.abs(interval) < 900){//15������
			return true;
		}
		return false;
	}
	public static void main(String[] args) {
		System.out.println(System.currentTimeMillis()/1000);
		System.out.println(validateTs(1497505959l));
		System.out.println(validateTs(1497505459l));
		System.out.println(validateTs(1497503559l));
		System.out.println("today = " + today());
	}

	/**
	 * ����������,������ǰ�ƶ�
	 * @param amount
	 * @return
	 */
	public static String getDateAsStr(int amount) {
		 Calendar calendar = Calendar.getInstance();
	     calendar.setTime(new Date());
	     calendar.add(Calendar.DATE, amount);
		return sdfyyyy_MM_dd.format(calendar.getTime());
	}
	
	public static String getCurrentHourAsString() {
		return sdfHH.format(new Date());
	}

	public static String addHour(int hour) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(new Date());
		calendar.add(Calendar.HOUR, hour);
		Date time = calendar.getTime();
		return SDF_DAY_HOUR.format(time);

	}
	public static Map<String, Object> addCalendar(int hour) {
		Map<String, Object> map = new LinkedHashMap<String, Object>();
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(new Date());
		calendar.add(Calendar.HOUR, hour);
		Date time = calendar.getTime();
		map.put("date", time);
		map.put("dateStr", getNowSDF.format(time));
		map.put("hour", sdfHH.format(time));
		return map;
	}
	 
	public static String getLastHourAsString() {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(new Date());
		calendar.add(Calendar.HOUR, -1);
		Date time = calendar.getTime();
		return sdfHH.format(time);
	}

	public static String getLastNHourAsString(int num) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(new Date());
		calendar.add(Calendar.HOUR,-1 * num );
		Date time = calendar.getTime();
		return sdfHH.format(time);
	}

	public static String getLastNHourDayAsString(int num) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(new Date());
		calendar.add(Calendar.HOUR,-1 * num );
		Date time = calendar.getTime();
		return sdfyyyy_MM_dd.format(time);
	}
	public static Long getLastNHourDayAsLong(int num) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(new Date());
		calendar.add(Calendar.HOUR,-1 * num );
		Date time = calendar.getTime();
		return time.getTime();
	}
	
	public static String getDateAsStr(Date date) {
		 Calendar calendar = Calendar.getInstance();
	     calendar.setTime(date);
		return sdfyyyy_MM_dd.format(calendar.getTime());
	}
}
