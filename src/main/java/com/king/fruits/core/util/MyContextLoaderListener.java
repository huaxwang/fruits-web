package com.king.fruits.core.util;

import java.net.InetAddress;
import java.net.UnknownHostException;

import javax.servlet.ServletContext;

import org.apache.commons.lang.ArrayUtils;
import org.apache.log4j.Logger;
import org.springframework.util.StringUtils;
import org.springframework.web.context.ConfigurableWebApplicationContext;
import org.springframework.web.context.ContextLoaderListener;

/**
 * 版权：融贯资讯 <br/>
 * 作者：kai.gao@rogrand.com <br/>
 * 生成日期：2013-12-24 <br/>
 * 描述：根据主机名自动需要加载的配置文件
 */
public class MyContextLoaderListener extends ContextLoaderListener {
	
	private static final Logger logger = Logger.getLogger(MyContextLoaderListener.class);
	
	// 正式服务器
	private static final String officialHostname = PropertiesLoader.getProperty("official.hostname");
	
	// 公网测试服务器
    private static final String test2Hostname = PropertiesLoader.getProperty("test2.hostname");
    private static final String test2ConfigFile = PropertiesLoader.getProperty("test2.config.file");
    
	// 测试服务器
	private static final String testHostname = PropertiesLoader.getProperty("test.hostname");
	private static final String testConfigFile = PropertiesLoader.getProperty("test.config.file");
	
	// 本地开发测试机
	private static final String localHostname = PropertiesLoader.getProperty("local.hostname");
	private static final String localConfigFile = PropertiesLoader.getProperty("local.config.file");
	
	protected void customizeContext(ServletContext sc, ConfigurableWebApplicationContext wac) {
		// 获取主机名
		String hostname = getHostName();
		logger.info("hostname = " + hostname);
		
		// 默认配置文件
		String configLocation = sc.getInitParameter(CONFIG_LOCATION_PARAM);
		
		if (ArrayUtils.indexOf(officialHostname.split(","), hostname) != -1) {// 正式服务器
			;
		} else if (ArrayUtils.indexOf(testHostname.split(","), hostname) != -1) {// 开发测试服务器
			configLocation = testConfigFile;
		} else if (ArrayUtils.indexOf(test2Hostname.split(","), hostname) != -1) {// 公网测试服务器
            configLocation = test2ConfigFile;
        } else if (ArrayUtils.indexOf(localHostname.split(","), hostname) != -1) {// 本地开发测试机
			configLocation = localConfigFile;
		} else {// 其它名称均连接本地开发测试机
			configLocation = localConfigFile;
		}
		String[] xml = StringUtils.tokenizeToStringArray(configLocation, ConfigurableWebApplicationContext.CONFIG_LOCATION_DELIMITERS);
		wac.setConfigLocations(xml);
	}
	
	private String getHostName() {
		String hostname = "";
		try {
			// Linux下获取主机名
			hostname = System.getenv("HOSTNAME");
			
			if (null == hostname || hostname.trim().length() == 0) {
				// Windows下获取主机名
				InetAddress netAddress = InetAddress.getLocalHost();
				
				if (null != netAddress) {
					hostname = netAddress.getHostName();
				}
			}
		} catch (UnknownHostException e) {
			logger.error("unknown host!", e);
		}
		return hostname;
	}
}
