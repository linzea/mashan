package com.panda.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * 日期时间工具类
 * author geekcattle
 * date 2016/11/23 0023 下午 14:53
 */
public class DateUtil {

	private static String ymdhms = "yyyy-MM-dd HH:mm:ss";
	private static String ymd = "yyyy-MM-dd";
	public static SimpleDateFormat ymdSDF = new SimpleDateFormat(ymd);
	private static String year = "yyyy";
	private static String month = "MM";
	private static String day = "dd";
	public static SimpleDateFormat yyyyMMddHHmmss = new SimpleDateFormat(ymdhms);
	public static SimpleDateFormat yearSDF = new SimpleDateFormat(year);
	public static SimpleDateFormat monthSDF = new SimpleDateFormat(month);
	public static SimpleDateFormat daySDF = new SimpleDateFormat(day);
	public static SimpleDateFormat yyyyMMddHHmm = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	public static SimpleDateFormat yyyyMMdd = new SimpleDateFormat("yyyy-MM-dd");
	public static SimpleDateFormat yyyyMMddHH_NOT_ = new SimpleDateFormat("yyyyMMdd");
	public static long DATEMM = 86400L;

	/**
	 * 获得当前时间(字符串类型)
	 * 格式：2014-12-02 10:38:53
	 * @return String
	 */
	public static String getCurrentTime() {
		return yyyyMMddHHmmss.format(new Date());
	}
	/**
	 * 获得当前时间(日期类型)
	 * 格式：2014-12-02 10:38:53
	 * @return String
	 */
	public static Date getSysTime() {
		return DateUtil.stringToDate(getCurrentTime(), ymdhms);
	}

	/**
	 * 获取年月日(日期类型)
	 * 格式：2014-12-02
	 * @return String
	 */
	public static Date getSysDate() {
		return DateUtil.stringToDate(getCurrentTime(), ymd);
	}

	/**
	 * 获取年月日(字符串类型)
	 * 格式：2014-12-02
	 * @return String
	 */
	public static String getCurrentDate() {
		return ymdSDF.format(new Date());
	}

	/**
	 * 可以获取昨天的日期
	 * 格式：2014-12-01
	 *
	 * @return String
	 */
	public static String getYesterdayYYYYMMDD() {
		Date date = new Date(System.currentTimeMillis() - DATEMM * 1000L);
		String str = yyyyMMdd.format(date);
		try {
			date = yyyyMMddHHmmss.parse(str + " 00:00:00");
			return yyyyMMdd.format(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return "";
	}

	/**
	 * 可以获取后退N天的日期
	 * 格式：传入2 得到2014-11-30
	 * @param backDay
	 * @return String
	 */
	public String getStrDate(String backDay) {
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.DATE, Integer.parseInt("-" + backDay));
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String back = sdf.format(calendar.getTime());
		return back;
	}

	/**
	 * 获取当前的年、月、日
	 * @return String
	 */
	public static String getCurrentYear() {
		return yearSDF.format(new Date());
	}

	public static String getCurrentMonth() {
		return monthSDF.format(new Date());
	}

	public static String getCurrentDay() {
		return daySDF.format(new Date());
	}

	/**
	 * 获取今天0点开始的秒数
	 * @return long
	 */
	public static long getTimeNumberToday() {
		Date date = new Date();
		String str = yyyyMMdd.format(date);
		try {
			date = yyyyMMdd.parse(str);
			return date.getTime() / 1000L;
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return 0L;
	}

	/**
	 * 获取今天的日期
	 * 格式：20141202
	 * @return String
	 */
	public static String getTodateString() {
		String str = yyyyMMddHH_NOT_.format(new Date());
		return str;
	}

	/**
	 * 获取昨天的日期
	 * 格式：20141201
	 * @return String
	 */
	public static String getYesterdayString() {
		Date date = new Date(System.currentTimeMillis() - DATEMM * 1000L);
		String str = yyyyMMddHH_NOT_.format(date);
		return str;
	}

	/**
	 * 获得昨天零点
	 * @return Date
	 */
	public static Date getYesterDayZeroHour() {
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, -1);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.HOUR, 0);
		return cal.getTime();
	}

	/**
	 * 把long型日期转String ；---OK
	 * @param date   long型日期；
	 * @param format 日期格式；
	 * @return
	 */
	public static String longToString(long date, String format) {
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		// 前面的lSysTime是秒数，先乘1000得到毫秒数，再转为java.util.Date类型
		java.util.Date dt2 = new Date(date * 1000L);
		String sDateTime = sdf.format(dt2); // 得到精确到秒的表示：08/31/2006 21:08:00
		return sDateTime;
	}

	/**
	 * 获得今天零点
	 * @return Date
	 */
	public static Date getTodayZeroHour() {
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.HOUR, 0);
		return cal.getTime();
	}

	/**
	 * 获得昨天23时59分59秒
	 * @return
	 */
	public static Date getYesterDay24Hour() {
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, -1);
		cal.set(Calendar.SECOND, 59);
		cal.set(Calendar.MINUTE, 59);
		cal.set(Calendar.HOUR, 23);
		return cal.getTime();
	}

	/**
	 * String To Date ---OK
	 * @param date   待转换的字符串型日期；
	 * @param format 转化的日期格式
	 * @return 返回该字符串的日期型数据；
	 */
	public static Date stringToDate(String date, String format) {
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		try {
			return sdf.parse(date);
		} catch (ParseException e) {
			return null;
		}
	}

	/**
	 * 获得指定日期所在的自然周的第一天，即周日
	 * @param date 日期
	 * @return 自然周的第一天
	 */
	public static Date getStartDayOfWeek(Date date) {
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		c.set(Calendar.DAY_OF_WEEK, 1);
		date = c.getTime();
		return date;
	}

	/**
	 * 获得指定日期所在的自然周的最后一天，即周六
	 * @param date
	 * @return
	 */
	public static Date getLastDayOfWeek(Date date) {
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		c.set(Calendar.DAY_OF_WEEK, 7);
		date = c.getTime();
		return date;
	}

	/**
	 * 获得指定日期所在当月第一天
	 * @param date
	 * @return
	 */
	public static Date getStartDayOfMonth(Date date) {
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		c.set(Calendar.DAY_OF_MONTH, 1);
		date = c.getTime();
		return date;
	}

	/**
	 * 获得指定日期所在当月最后一天
	 * @param date
	 * @return
	 */
	public static Date getLastDayOfMonth(Date date) {
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		c.set(Calendar.DATE, 1);
		c.add(Calendar.MONTH, 1);
		c.add(Calendar.DATE, -1);
		date = c.getTime();
		return date;
	}

	/**
	 * 获得指定日期的下一个月的第一天
	 * @param date
	 * @return
	 */
	public static Date getStartDayOfNextMonth(Date date) {
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		c.add(Calendar.MONTH, 1);
		c.set(Calendar.DAY_OF_MONTH, 1);
		date = c.getTime();
		return date;
	}

	/**
	 * 获得指定日期的下一个月的最后一天
	 * @param date
	 * @return
	 */
	public static Date getLastDayOfNextMonth(Date date) {
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		c.set(Calendar.DATE, 1);
		c.add(Calendar.MONTH, 2);
		c.add(Calendar.DATE, -1);
		date = c.getTime();
		return date;
	}

	/**
	 * 求某一个时间向前多少秒的时间(currentTimeToBefer)---OK
	 * @param givedTime        给定的时间
	 * @param interval         间隔时间的毫秒数；计算方式 ：n(天)*24(小时)*60(分钟)*60(秒)(类型)
	 * @param format_Date_Sign 输出日期的格式；如yyyy-MM-dd、yyyyMMdd等；
	 */
	public static String givedTimeToBefer(String givedTime, long interval, String format_Date_Sign) {
		String tomorrow = null;
		try {
			SimpleDateFormat sdf = new SimpleDateFormat(format_Date_Sign);
			Date gDate = sdf.parse(givedTime);
			long current = gDate.getTime(); // 将Calendar表示的时间转换成毫秒
			long beforeOrAfter = current - interval * 1000L; // 将Calendar表示的时间转换成毫秒
			Date date = new Date(beforeOrAfter); // 用timeTwo作参数构造date2
			tomorrow = new SimpleDateFormat(format_Date_Sign).format(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return tomorrow;
	}

	/**
	 * 把String 日期转换成long型日期；---OK
	 *
	 * @param date   String 型日期；
	 * @param format 日期格式；
	 * @return
	 */
	public static long stringToLong(String date, String format) {
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		Date dt2 = null;
		long lTime = 0;
		try {
			dt2 = sdf.parse(date);
			// 继续转换得到秒数的long型
			lTime = dt2.getTime() / 1000;
		} catch (ParseException e) {
			e.printStackTrace();
		}

		return lTime;
	}

	/**
	 * 得到二个日期间的间隔日期；
	 *
	 * @param endTime   结束时间
	 * @param beginTime 开始时间
	 * @param isEndTime 是否包含结束日期；
	 * @return
	 */
	public static Map<String, String> getTwoDay(String endTime,
												String beginTime, boolean isEndTime) {
		Map<String, String> result = new HashMap<String, String>();
		if ((endTime == null || endTime.equals("") || (beginTime == null || beginTime
				.equals(""))))
			return null;
		try {
			java.util.Date date = ymdSDF.parse(endTime);
			endTime = ymdSDF.format(date);
			java.util.Date mydate = ymdSDF.parse(beginTime);
			long day = (date.getTime() - mydate.getTime())
					/ (24 * 60 * 60 * 1000);
			result = getDate(endTime, Integer.parseInt(day + ""), isEndTime);
		} catch (Exception e) {
		}
		return result;
	}

	/**
	 * 得到二个日期间的间隔日期；
	 *
	 * @param endTime   结束时间
	 * @param beginTime 开始时间
	 * @param isEndTime 是否包含结束日期；
	 * @return
	 */
	public static Integer getTwoDayInterval(String endTime, String beginTime,
											boolean isEndTime) {
		if ((endTime == null || endTime.equals("") || (beginTime == null || beginTime
				.equals(""))))
			return 0;
		long day = 0l;
		try {
			java.util.Date date = ymdSDF.parse(endTime);
			endTime = ymdSDF.format(date);
			java.util.Date mydate = ymdSDF.parse(beginTime);
			day = (date.getTime() - mydate.getTime()) / (24 * 60 * 60 * 1000);
		} catch (Exception e) {
			return 0;
		}
		return Integer.parseInt(day + "");
	}

	/**
	 * 根据结束时间以及间隔差值，求符合要求的日期集合；
	 *
	 * @param endTime
	 * @param interval
	 * @param isEndTime
	 * @return
	 */
	public static Map<String, String> getDate(String endTime, Integer interval,
											  boolean isEndTime) {
		Map<String, String> result = new HashMap<String, String>();
		if (interval == 0 || isEndTime) {
			if (isEndTime)
				result.put(endTime, endTime);
		}
		if (interval > 0) {
			int begin = 0;
			for (int i = begin; i < interval; i++) {
				endTime = givedTimeToBefer(endTime, DATEMM, ymd);
				result.put(endTime, endTime);
			}
		}
		return result;
	}

	/**
	 * 在日期上增加天数 小时数 分钟数
	 * @param date 日期
	 * @param type 类型 1分，2时，3天
	 * @param num  类型 增加多少
	 * @return
	 */
	public static String nowTimeAddMinuteOrHourOrDay(Date date, int type , int num) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		switch (type){
			case 1:
				cal.add(Calendar.MINUTE, num);
				break;
			case 2:
				cal.add(Calendar.HOUR, num);
				break;
			case 3:
				cal.add(Calendar.DATE, num);
				break;
			default:
				break;
		}
		return yyyyMMddHHmmss.format(cal.getTime());
	}

	/**
	 * 根据传入时间，返回距离该时间的分钟数，小时数，天数，大于3天的显示日期
	 *
	 * @param dateStr
	 * @return
	 */
	public static String convertFormatDate(String dateStr) {
		String formatDate = null;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			Date date = sdf.parse(dateStr);
			Long difference = (new Date()).getTime() - date.getTime();
			if (difference / 1000 / 60 == 0 || difference / 1000 / 60 == 1) {
				formatDate = "刚刚";
			} else if (difference / 1000 / 60 / 60 < 1) {
				formatDate = "约" + (difference / 1000 / 60) + "分钟前";
			} else if (difference / 1000 / 60 / 60 / 24 < 1) {
				formatDate = "约" + (difference / 1000 / 60 / 60) + "小时前";
			} else if (difference / 1000 / 60 / 60 / 24 == 1) {
				formatDate = "昨天";
			} else if (difference / 1000 / 60 / 60 / 24 > 1 && difference / 1000 / 60 / 60 / 24 < 4) {
				formatDate = "约" + (difference / 1000 / 60 / 60 / 24) + "天前";
			}  else if (difference / 1000 / 60 / 60 / 24 > 1 && difference / 1000 / 60 / 60 / 24 < 999999) {
				formatDate = "约" + (difference / 1000 / 60 / 60 / 24) + "天前";
			}else {
				Calendar cal = Calendar.getInstance();
				cal.setTime(date);
				int month = cal.get(Calendar.MONTH);
				if (month < 11)
					month = month + 1;
				else
					month = 12;
				formatDate = cal.get(Calendar.YEAR) + "年" + month + "月" + cal.get(Calendar.DATE) + "日";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return formatDate;
	}

	/**
	 * 比较两个时间 开始时间 和结束时间小于当前时间
	 * @return
	 */
	public static boolean checkNowTime(String statusTime,String endTime){
		boolean flag = false;
		DateFormat df = new SimpleDateFormat("HH:mm:ss");
		try {
			Date nowTime = df.parse(df.format(new Date()));
			Date dtStatusTime = df.parse(statusTime.substring(11, 19));
			Date dtEndTime = df.parse(endTime.substring(11, 19));
			if(nowTime.getTime() >= dtStatusTime.getTime() && nowTime.getTime() <= dtEndTime.getTime())
			{
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}

	/**
	 * 计算两个时间差(精确到秒)
	 * @param max_time
	 * @param min_time
	 * @return
	 */
	public static  long calculationSecond(Date max_time,Date min_time){
		SimpleDateFormat dfs = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
		long between = 0;
		try {
			Date begin = min_time;
			Date end = max_time;
			between = (end.getTime() - begin.getTime());// 得到两者的毫秒数
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		long day = between / (24 * 60 * 60 * 1000);
		long hour = (between / (60 * 60 * 1000) - day * 24);
		long min = ((between / (60 * 1000)) - day * 24 * 60 - hour * 60);
		long s = (between / 1000 - day * 24 * 60 * 60 - hour * 60 * 60 - min * 60);
		return s;
	}

	/**
	 * 转换时间类型，返回。分，时，天 类型
	 * @param beginTime
	 * @param endTime
	 * @return
	 */
	public static String calculationSecond(String beginTime,String endTime) {
		String time = "";
		SimpleDateFormat dfs = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
		long between = 0;
		try {
			Date end   = DateUtil.stringToDate(endTime,"yyyy-MM-dd HH:mm:ss"),
				 begin = DateUtil.stringToDate(beginTime,"yyyy-MM-dd HH:mm:ss");
			between = (end.getTime() - begin.getTime());// 得到两者的毫秒数
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		int day = (int)between / (24 * 60 * 60 * 1000);
		int hour = (int)(between / (60 * 60 * 1000) - day * 24);
		int min = (int) ((between / (60 * 1000)) - day * 24 * 60 - hour * 60);
		long s = (between / 1000 - day * 24 * 60 * 60 - hour * 60 * 60 - min * 60);
		if (day > 0){
			time = day+"天";
		}else if (hour > 0){
			time = hour+"时"+min+"分";
		}else if (min > 0){
			time = min+"分钟";
		}
		return time;
	}
}