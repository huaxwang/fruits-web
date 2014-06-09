package com.king.fruits.core.util;

import java.io.UnsupportedEncodingException;
import java.lang.reflect.Method;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashSet;
import java.util.List;
import java.util.Random;
import java.util.Set;
import java.util.StringTokenizer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 版权：融贯资讯 <br/>
 * 作者：yong.chen@rogrand.com <br/>
 * 生成日期：2013年11月6日 <br/>
 * 描述：字符串处理工具类
 */
public class StringUtil {
	/**
	 * 生成指定长度随机字符串 作者: yong.chen@rogrand.com <br/>
	 * 生成日期 ：2013年11月6日
	 * 
	 * @param genLong
	 *            生成随机字符串长度
	 * @return String 生成随机字符串
	 */
	public static String genRandomString(int genLong) {
		Random genRandom = new Random();
		char[] charactes = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
				.toCharArray();
		char[] strChar = new char[genLong];
		for (int i = 0; i < genLong; i++) {
			strChar[i] = charactes[genRandom.nextInt(charactes.length)];
		}
		return new String(strChar);
	}

	public static String genRandomNum(int genLong) {
		Random genRandom = new Random();
		char[] charactes = "0123456789"
				.toCharArray();
		char[] strChar = new char[genLong];
		for (int i = 0; i < genLong; i++) {
			strChar[i] = charactes[genRandom.nextInt(charactes.length)];
		}
		return new String(strChar);
	}
	
	/**
	 * 获得0-9的随机数
	 * 
	 * @param length
	 * @return String
	 */
	public static String getRandomNumber(int length) {
		Random random = new Random();
		StringBuffer buffer = new StringBuffer();
		
		for (int i = 0; i < length; i++) {
			buffer.append(random.nextInt(10));
		}
		return buffer.toString();
	}
	
	/**
	 * 消息生成消息摘要
	 *作者: yong.chen@rogrand.com <br/>
	 *生成日期 ：2013年11月6日
	 *String
	 * @param message
	 * @return
	 */
	public static String messageDegist(String message) {
		try {
			byte[] bytes = MessageDigest.getInstance("MD5").digest(
					message.getBytes());
			return new String(bytes);
		} catch (NoSuchAlgorithmException e) {
			throw new RuntimeException("消息摘要算法错误");
		}
	}
	
	public static boolean validateMd5Message(String newMD5,String oldMD5){
		return MessageDigest.isEqual(newMD5.getBytes(), oldMD5.getBytes());
	}
	
	/**
	 * 忽略字符串两边的空白后,再判断字符是否为空
	 * 
	 * @param str
	 *            某字符串
	 * @return 为null或为空串则返回true，否则返回false
	 */
	public static boolean isEmptyAfterTrim(String str) {
		return str == null || str.trim().length() == 0;
	}
	
	/**
	 * 获得0-9的随机数 长度默认为10
	 * 
	 * @return String
	 */
	public static String getRandomNumber() {
		return getRandomNumber(10);
	}
	 
	/**
	 * 判断字符是否为空
	 * 
	 * @param input
	 *            某字符串
	 * @return 包含则返回true，否则返回false
	 */
	public static boolean isEmpty(String input) {
		return input == null || input.trim().length() == 0;
	} 
	
	/**
	 * 字符串首字母大写
	 * 
	 * @param str
	 *            字符串
	 * @return String
	 */
	public static String upperFirstChar(String str) {
		if (str != null && str.length() > 0) {
			return str.substring(0, 1).toUpperCase() + str.substring(1);
		} else {
			return str;
		}
	}
	
	public static String lowerFirstChar(String str) {
		if (str != null && str.length() > 0) {
			return str.substring(0, 1).toLowerCase() + str.substring(1);
		} else {
			return str;
		}
	}
	
	public static boolean isIP(String ip) {
		Pattern pattern = Pattern.compile("\\b((?!\\d\\d\\d)\\d+|1\\d\\d|2[0-4]\\d|25[0-5])\\.((?!\\d\\d\\d)\\d+|1\\d\\d|2[0-4]\\d|25[0-5])\\.((?!\\d\\d\\d)\\d+|1\\d\\d|2[0-4]\\d|25[0-5])\\.((?!\\d\\d\\d)\\d+|1\\d\\d|2[0-4]\\d|25[0-5])\\b");
		Matcher matcher = pattern.matcher(ip);
		return matcher.matches();
	}
	
	public static boolean isIn(String[] strArray, String str) {
		if (strArray == null || strArray.length == 0) {
			return false;
		}
		for (String s : strArray) {
			if (s.equals(str)) {
				return true;
			}
		}
		return false;
	}
	
	 
	/**
	 * 字符串数组转换成Set集合
	 * 
	 * @param String
	 *            [] args
	 * @return Set<String>
	 */
	public static Set<String> strArrayToSet(String[] args) {
		if (args == null || args.length == 0) {
			return new HashSet<String>();
		}
		Set<String> set = new HashSet<String>();
		for (String str : args) {
			if (!StringUtil.isEmpty(str)) {
				set.add(str);
			}
		}
		return set;
	}
	
	 
	/**
	 * 去除字符串前的逗号，和结尾的逗号
	 * 
	 * @param contents
	 * @return
	 */
	public static String delFirstAndLastComma(String contents) {
		if (contents.startsWith(",") || contents.startsWith("，")) {
			contents = contents.substring(1);
		}
		if (contents.endsWith(",") || contents.endsWith("，")) {
			contents = contents.substring(0, contents.length() - 1);
		}
		if ((!contents.startsWith(",") && !contents.startsWith("，")) && (!contents.endsWith(",") && !contents.endsWith("，"))) {
			return contents;
		}
		return delFirstAndLastComma(contents);
	}
	
	/**
	 * 查找字符串个数
	 * 
	 * @param str
	 *            字符串
	 * @param sub
	 *            子串
	 * @return int
	 */
	public static int findCharCount(String str, String sub) {
		if (str == null || sub == null || str.length() == 0 || sub.length() == 0) {
			return 0;
		}
		int count = 0, pos = 0, idx = 0;
		while ((idx = str.indexOf(sub, pos)) != -1) {
			++count;
			pos = idx + sub.length();
		}
		return count;
	}
	
	public static int count(String s) {
		try {
			byte[] bytes = s.getBytes("Unicode");
			int n = 0; // 表示当前的字节数
			int i = 2; // 要截取的字节数，从第3个字节开始
			for (; i < bytes.length; i++) {
				if (i % 2 == 1) { // 奇数位置，如3、5、7等，为UCS2编码中两个字节的第二个字节
					if (bytes[i] != 0) {
						n++;
					}
				} else { // 当UCS2编码的第二个字节不等于0时，该UCS2字符为汉字，一个汉字算两个字节
					n++;
				}
			}
			return n;
			
		} catch (UnsupportedEncodingException e) {
			return 0;
		}
	}
	
	public static String substring(String s, int byteLength) {
		if (s == null)
			return null;
		if (s.equals(""))
			return "";
		try {
			byte[] bytes = s.getBytes("Unicode");
			int n = 0; // 表示当前的字节数
			int i = 2; // 要截取的字节数，从第3个字节开始
			for (i = 2; i < bytes.length && n < byteLength; i++) {
				if (i % 2 == 1) { // 奇数位置，如3、5、7等，为UCS2编码中两个字节的第二个字节
					if (bytes[i] != 0) {
						n++;
					}
				} else { // 当UCS2编码的第二个字节不等于0时，该UCS2字符为汉字，一个汉字算两个字节
					n++;
				}
			}
			if (i % 2 == 1) { // 如果i为奇数时，处理成偶数
				if (bytes[i] != 0)
					i = i - 1; // 该UCS2字符是汉字时，去掉这个截一半的汉字
				else
					i = i + 1; // 该UCS2字符是字母或数字，则保留该字符
			}
			return new String(bytes, 0, i, "Unicode");
		} catch (UnsupportedEncodingException e) {
			return null;
		}
	}
	
	public static String substringHtml(String s, int byteLength) {
		if (s == null)
			return null;
		if (s.equals(""))
			return "";
		s = s.replaceAll("<.*?>|</.*?>", "");
		try {
			byte[] bytes = s.getBytes("Unicode");
			int n = 0; // 表示当前的字节数
			int i = 2; // 要截取的字节数，从第3个字节开始
			for (i = 2; i < bytes.length && n < byteLength; i++) {
				if (i % 2 == 1) { // 奇数位置，如3、5、7等，为UCS2编码中两个字节的第二个字节
					if (bytes[i] != 0) {
						n++;
					}
				} else { // 当UCS2编码的第二个字节不等于0时，该UCS2字符为汉字，一个汉字算两个字节
					n++;
				}
			}
			if (i % 2 == 1) { // 如果i为奇数时，处理成偶数
				if (bytes[i] != 0)
					i = i - 1; // 该UCS2字符是汉字时，去掉这个截一半的汉字
				else
					i = i + 1; // 该UCS2字符是字母或数字，则保留该字符
			}
			return new String(bytes, 0, i, "Unicode");
		} catch (UnsupportedEncodingException e) {
			return null;
		}
	}
	
	/**
	 * 过滤特殊字符
	 * 
	 * @param value
	 * @return
	 */
	public static String escapeDir(String value) {
		String[] codes = { "/", "\\", ":", "*", "?", "\"", "<", ">", "|" };
		for (int i = 0; i < codes.length; i++) {
			value = value.replace(codes[i], "");
		}
		return value;
	}
	
	/**
	 * 关键字分隔符
	 * 
	 * @param value
	 * @return
	 */
	public static String gjzDir(String value) {
		String[] codes = { ",", "，", ";", "；", " ", "?", "|", "&" };
		for (int i = 0; i < codes.length; i++) {
			value = value.replace(codes[i], ",");
		}
		return value;
	}
	
	/**
	 * 去除字符串前，后，中的空格
	 * 
	 * @param value
	 * @return
	 */
	public static String bankDir(String value) {
		String[] codes = { " " };
		for (int i = 0; i < codes.length; i++) {
			value = value.replace(codes[i], "");
		}
		return value;
	}
	
	/**
	 * 字符串分割并转成数组
	 * 
	 * @param input
	 *            输入字符串
	 * @param delim
	 *            分隔符
	 * @return 分隔后数组
	 */
	public static String[] splitString(String input, String delim) {
		if (isEmpty(input)) {
			return new String[0];
		}
		ArrayList<String> a1 = new ArrayList<String>();
		for (StringTokenizer stringTokenizer = new StringTokenizer(input, delim); stringTokenizer.hasMoreTokens(); a1.add(stringTokenizer.nextToken())) {
		}
		String result[] = new String[a1.size()];
		for (int i = 0; i < result.length; i++) {
			result[i] = a1.get(i);
		}
		return result;
	}
	
	 
	
	/**
	 * 字符串分割并转成List<String>集合
	 * 
	 * @param input
	 *            输入字符串
	 * @param delim
	 *            分隔符
	 * @return List<String>
	 */
	public static List<String> splitList(String input, String delim) {
		if (isEmpty(input)) {
			return null;
		}
		ArrayList<String> a1 = new ArrayList<String>();
		for (StringTokenizer stringTokenizer = new StringTokenizer(input, delim); stringTokenizer.hasMoreTokens(); a1.add(stringTokenizer.nextToken())) {
		}
		return a1;
	}
	
	/**
	 * 数组转成字符串
	 * 
	 * @param String
	 *            [] strs
	 * @return String
	 */
	public static String joinArray(String[] strs) {
		if (strs == null)
			return null;
		if (strs.length == 0)
			return "";
		String ss = "";
		for (String s : strs) {
			ss += "," + s;
		}
		return ss.substring(1);
	} 
	
	public static List<String> stringToList(String args) {
		String[] strs = args.split(",");
		List<String> list = new ArrayList<String>();
		for (String str : strs) {
			list.add(str);
		}
		return list;
	}
	
	public static String stringListToString(List<String> args) {
		String name = "";
		for (String str : args) {
			name += "," + str;
		}
		if (!StringUtil.isEmpty(name)) {
			name = name.substring(1);
		}
		return name;
	}
	
	/**
	 * 字符串是否存在字符串数组中
	 * 
	 * @param stringArray
	 * @param str
	 * @return
	 */
	public static boolean isInStringArray(String[] stringArray, String str) {
		if (stringArray == null || stringArray.length == 0) {
			return false;
		}
		for (String s : stringArray) {
			if (s.equalsIgnoreCase(str)) {
				return true;
			}
		}
		return false;
	}
	
	/**
	 * 全角逗号，转成半角逗号
	 * 
	 * @param param
	 * @return
	 */
	public String adjustComma(String param) {
		if (param == null)
			return "";
		String tmpStr = param.replaceAll("，", ",");
		String[] ss = tmpStr.split(",");
		String str = "";
		for (String s : ss) {
			if (!StringUtil.isEmpty(s.trim())) {
				str += "," + s.trim();
			}
		}
		return str.length() > 0 ? str.substring(1) : "";
	}
	
	public static String replaceAllChar(String str, String colType) {
		if (StringUtil.isEmpty(str)) {
			return "";
		}
		if ("clob".equalsIgnoreCase(colType)) {
			return str.replaceAll("<p>", "").replaceAll("</p>", "").replaceAll("<P>", "").replaceAll("</P>", "").replaceAll("&", "＆").replaceAll("<", "＜");
		} else if ("varchar".equalsIgnoreCase(colType)) {
			return str.replaceAll("&", "＆").replaceAll("<", "＜");
		} else if (StringUtil.isEmpty(colType)) {
			return str.replaceAll("&", "＆").replaceAll("<", "＜");
		}
		return str;
	}
	
	public static String replaceAllChar(Object o, String colType) {
		if (o == null) {
			return "";
		}
		String str = o.toString();
		return replaceAllChar(str, colType);
	}

	public static boolean isNumber(String sNum) {
		if(StringUtil.isEmpty(sNum)){
			return false;
		}
		return sNum.matches("^[1-9]\\d*$");
	}
	
	/**
	 * 利用反射实现对象之间属性复制
	 * @param from
	 * @param to
	 */
	public static void copyProperties(Object from, Object to) throws Exception {
		copyPropertiesExclude(from, to, null);
	}
	
	/**
	 * 复制对象属性
	 * @param from
	 * @param to
	 * @param excludsArray 排除属性列表
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public static void copyPropertiesExclude(Object from, Object to, String[] excludsArray) throws Exception {
		List<String> excludesList = null;
		if(excludsArray != null && excludsArray.length > 0) {
			excludesList = Arrays.asList(excludsArray);	//构造列表对象
		}
		Method[] fromMethods = from.getClass().getDeclaredMethods();
		Method[] toMethods = to.getClass().getDeclaredMethods();
		Method fromMethod = null, toMethod = null;
		String fromMethodName = null, toMethodName = null;
		for (int i = 0; i < fromMethods.length; i++) {
			fromMethod = fromMethods[i];
			fromMethodName = fromMethod.getName();
			if (!fromMethodName.contains("get"))
				continue;
			//排除列表检测
			if(excludesList != null && excludesList.contains(fromMethodName.substring(3).toLowerCase())) {
				continue;
			}
			toMethodName = "set" + fromMethodName.substring(3);
			toMethod = findMethodByName(toMethods, toMethodName);
			if (toMethod == null)
				continue;
			Object value = fromMethod.invoke(from, new Object[0]);
			if(value == null)
				continue;
			//集合类判空处理
			if(value instanceof Collection) {
				Collection newValue = (Collection)value;
				if(newValue.size() <= 0)
					continue;
			}
			toMethod.invoke(to, new Object[] {value});
		}
	}
	
	
	 /**
	  * 对象属性值复制，仅复制指定名称的属性值
	  * @param from
	  * @param to
	  * @param includsArray
	  * @throws Exception
	  */
	 @SuppressWarnings("unchecked")
	 public static void copyPropertiesInclude(Object from, Object to, String[] includsArray) throws Exception {
	  List<String> includesList = null;
	  if(includsArray != null && includsArray.length > 0) {
	   includesList = Arrays.asList(includsArray);	//构造列表对象
	  } else {
	   return;
	  }
	  Method[] fromMethods = from.getClass().getDeclaredMethods();
	  Method[] toMethods = to.getClass().getDeclaredMethods();
	  Method fromMethod = null, toMethod = null;
	  String fromMethodName = null, toMethodName = null;
	  for (int i = 0; i < fromMethods.length; i++) {
	   fromMethod = fromMethods[i];
	   fromMethodName = fromMethod.getName();
	   if (!fromMethodName.contains("get"))
	    continue;
	   //排除列表检测
	   String str = fromMethodName.substring(3);
	   if(!includesList.contains(str.substring(0,1).toLowerCase() + str.substring(1))) {
	    continue;
	   }
	   toMethodName = "set" + fromMethodName.substring(3);
	   toMethod = findMethodByName(toMethods, toMethodName);
	   if (toMethod == null)
	    continue;
	   Object value = fromMethod.invoke(from, new Object[0]);
	   if(value == null)
	    continue;
	   //集合类判空处理
	   if(value instanceof Collection) {
	    Collection newValue = (Collection)value;
	    if(newValue.size() <= 0)
	     continue;
	   }
	   toMethod.invoke(to, new Object[] {value});
	  }
	 }
	 
	/**
	 * 从方法数组中获取指定名称的方法
	 * 
	 * @param methods
	 * @param name
	 * @return
	 */
	public static Method findMethodByName(Method[] methods, String name) {
		for (int j = 0; j < methods.length; j++) {
			if (methods[j].getName().equals(name))
				return methods[j];
		}
		return null;
	}
	
	public static void main(String[] args) {
		String now = DateUtil.getDate("yyyyMMdd").substring(2);
		int bastNum = Integer.valueOf(StringUtil.genRandomNum(4));
		int nexRandNum = bastNum+new Random().nextInt(5);
		String randNum = now+nexRandNum;
		System.out.println("now=="+now);
		System.out.println("bastNum=="+bastNum);
		System.out.println("nexRandNum=="+nexRandNum);
		System.out.println("result=="+randNum);
	}
}
