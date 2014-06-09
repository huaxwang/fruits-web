package com.king.fruits.core.util;

import org.apache.commons.httpclient.DefaultHttpMethodRetryHandler;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.apache.commons.lang.StringUtils;

public class Moblie {
 
	public static String sendMessage(String tel) {
		HttpClient client = new HttpClient();
		PostMethod post = null;
		String responseString = "";
		try { 
			post = new PostMethod("http://life.tenpay.com/cgi-bin/mobile/MobileQueryAttribution.cgi");
			post.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
			 
			NameValuePair mobile = new NameValuePair("chgmobile", tel);
			post.setRequestBody(new NameValuePair[] {  mobile });
			post.setDoAuthentication(true);
			// 使用系统提供的默认的恢复策略
			post.getParams().setParameter(HttpMethodParams.RETRY_HANDLER, new DefaultHttpMethodRetryHandler());
			int statusCode = client.executeMethod(post);
			if (statusCode != HttpStatus.SC_OK) {
				System.err.println("Method failed: " + post.getStatusLine());
			}
			// 读取内容
			byte[] responseBody = post.getResponseBody();
			// 处理内容
			responseString = new String(responseBody,"GBK");
			System.out.println("back str:" + responseString);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			post.releaseConnection();
		}
		return responseString;
	}
	 
	public static String getMobileNoTrack(String mobileCode) { 
		String message = "请人工查询此号码";
			String temp = sendMessage(mobileCode);
			if(temp!=null && !"".equals(temp)){
			String province =  StringUtils.substringBetween(temp, "<province>", "</province>");
			String city =  StringUtils.substringBetween(temp, "<city>", "</city>");
			String supplier =  StringUtils.substringBetween(temp, "<supplier>", "</supplier>");
			String retmsg =  StringUtils.substringBetween(temp, "<retmsg>", "</retmsg>");
			if(retmsg.equals("OK")){
				message = supplier+""+province+""+city;
			} 
		}
		return message;
	} 
	
	public static String getMobileCity(String mobileCode) { 
		String message = "";
			String temp = sendMessage(mobileCode);
			if(temp!=null && !"".equals(temp)){ 
			String city =  StringUtils.substringBetween(temp, "<city>", "</city>"); 
			String retmsg =  StringUtils.substringBetween(temp, "<retmsg>", "</retmsg>");
			if(retmsg.equals("OK")){
				message = city;
			} 
		}
		return message;
	} 
	
//	public static String sendMessage(String tel) {
//		HttpClient client = new HttpClient();
//		PostMethod post = null;
//		String responseString = "";
//		try { 
//			post = new PostMethod("http://api.showji.com/Locating/www.showji.c.om.aspx?output=json");
//			post.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
//			 
//			NameValuePair mobile = new NameValuePair("m", tel);
//			post.setRequestBody(new NameValuePair[] {  mobile });
//			post.setDoAuthentication(true);
//			// 使用系统提供的默认的恢复策略
//			post.getParams().setParameter(HttpMethodParams.RETRY_HANDLER, new DefaultHttpMethodRetryHandler());
//			int statusCode = client.executeMethod(post);
//			if (statusCode != HttpStatus.SC_OK) {
//				System.err.println("Method failed: " + post.getStatusLine());
//			}
//			// 读取内容
//			byte[] responseBody = post.getResponseBody();
//			// 处理内容
//			responseString = new String(responseBody,"utf-8");
//			System.out.println("back str:" + responseString);
//		} catch (Exception e) {
//			e.printStackTrace();
//		} finally {
//			post.releaseConnection();
//		}
//		return responseString;
//	}
//	
//	
//	public static String getMobileNoTrack(String mobileCode) { 
//		String message = "";
//			String temp = sendMessage(mobileCode);
//			if(temp!=null && !"".equals(temp)){
//			JSONObject json = JSON.parseObject(temp);
//			String province =  (String)json.get("Province");
//			String city =  (String)json.get("City");
//			String supplier =  (String)json.get("Corp");
//			Boolean retmsg =  Boolean.valueOf((String)json.get("QueryResult"));
//			if(retmsg){
//				message = province+" "+city +" " + supplier;
//			} 
//		}
//		return message;
//	} 
//	
//	public static String getMobileCity(String mobileCode) { 
//		String message = "";
//			String temp = sendMessage(mobileCode);
//			if(temp!=null && !"".equals(temp)){ 
//			JSONObject json = JSON.parseObject(temp);
//			String city =  (String)json.get("City");
//			Boolean retmsg =   Boolean.valueOf((String)json.get("QueryResult"));
//			if(retmsg){
//				message = city;
//			} 
//		}
//		return message;
//	} 
}
