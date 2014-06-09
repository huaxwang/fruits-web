package com.king.fruits.core.util;

import java.util.HashMap;
import java.util.Map;

public class Constants {
	public static final int SMS_NUM = 6;
	public static final int MERCHANT_INIT_STATE = 1;
	
	public static final String DATE_DIR_FORMAT = "yyyy/MM/dd";// 日期目录格式
	
	public static Map<String,String> telMap = new HashMap<String,String>();
	
//	0 内容不正常，不显示
//	1 内容正常，过期不显示
//	2 显示
//	3 创建
	//用户发布服务 与商户响应 是否显示 
	//过期不显示
	public static final int NOT_SHOW_EXPIRED = 1;
	//内容不正常不显示
	public static final int NOT_SHOW_ABNORMAL = 0;
	//内容正常显示 
	public static final int IS_SHOW_NORMAL= 2;
	//创建服务
	public static final int IS_SHOW_CREATE= 3;
	//心跳
	public static final int HEARTBEAT = 10 ;
	
	//每页显示数据
	public static final int PAGE_COUNT = 5;
	
	/**
	 * 商户荣誉榜显示数据量
	 */
	public static final int MERCHANT_SHOW_NUM = 5;
	
	//图片上传临时目录
    public static final String FILE_PATH_TEMP = "/upload/pic/temp/";
    //上传图片现在最大宽
    public static final int FILE_MAX_WIDTH = 480;
  //上传图片现在最大高
    public static final int FILE_MAX_HEIGHT = 640;
}
