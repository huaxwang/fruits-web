package com.king.fruits.core.common.base.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.util.UrlPathHelper;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.king.fruits.core.util.Body;
import com.king.fruits.core.util.FastjsonFilter;
import com.king.fruits.core.util.FastjsonFilterUtils;
import com.king.fruits.core.util.Head;
import com.king.fruits.core.util.JsonUtils;
import com.king.fruits.core.util.RequestJSON;
import com.king.fruits.core.util.ResponseJSON;
import com.king.fruits.core.util.ResponseUtils;
import com.king.fruits.core.util.RoUtil;
import com.king.fruits.core.util.SysCode;

public class BaseController {

    protected static Logger logger = Logger.getLogger(BaseController.class);

    protected SysCode returnCode;
    protected String returnResult;
    
protected UrlPathHelper urlPathHelper = new UrlPathHelper();
	
	// 依次为：
	// 输出空置字段；
	// list字段如果为null，输出为[]，而不是null；
	// 数值字段如果为null，输出为0，而不是null；
	// Boolean字段如果为null，输出为false，而不是null；
	// 字符类型字段如果为null，输出为""，而不是null；
	// 日期时间格式化，默认yyyy-MM-dd HH:mm:ss格式
	// 关闭循环引用检测
	// 兼容的浏览器
	public SerializerFeature[] featuresIncludeBrowser = { SerializerFeature.WriteMapNullValue, SerializerFeature.WriteNullListAsEmpty, SerializerFeature.WriteNullNumberAsZero, SerializerFeature.WriteNullBooleanAsFalse, SerializerFeature.WriteNullStringAsEmpty, SerializerFeature.WriteDateUseDateFormat, SerializerFeature.DisableCircularReferenceDetect, SerializerFeature.BrowserCompatible };
	
	// 依次为：
	// 输出空置字段；
	// list字段如果为null，输出为[]，而不是null；
	// 数值字段如果为null，输出为0，而不是null；
	// Boolean字段如果为null，输出为false，而不是null；
	// 字符类型字段如果为null，输出为""，而不是null；
	// 日期时间格式化，默认yyyy-MM-dd HH:mm:ss格式
	// 关闭循环引用检测
	public SerializerFeature[] features = { SerializerFeature.WriteMapNullValue, SerializerFeature.WriteNullListAsEmpty, SerializerFeature.WriteNullNumberAsZero, SerializerFeature.WriteNullBooleanAsFalse, SerializerFeature.WriteNullStringAsEmpty, SerializerFeature.WriteDateUseDateFormat, SerializerFeature.DisableCircularReferenceDetect };
	

    /**
     * 构建输出到终端JSON 串HEAD <br/>
     * 构建输出到终端JSON 串HEAD <br/>
     * 
     * @param [method]-[后台调用方法名] <br/>
     * @param [sNumber]-[序列号] <br/>
     * @param [version]-[版本号] <br/>
     * @return [Head] 输出到终端JSON 串 HEAD<br/>
     */
    protected Head getResponseHead(String method, String sNumber, String version) {
        return new Head(method, sNumber, version);
    }

    /**
     * 构建输出到终端JSON 串BODY <br/>
     * 构建输出到终端JSON 串BODY <br/>
     * 
     * @param [SysCode]-[返回消息消息码 和消息] <br/>
     * @param [result]-[返回JSON 结果] <br/>
     * @return [Body] 输出到终端JSON串 BODY<br/>
     */
    protected Body getResponseBody(SysCode code, Object result) {
        Body body = new Body();
        body.setMessage(code.getMessage());
        body.setCode(code.getCode());
        body.setResult(result);
        return body;
    }

    /**
     * 构建返回给前端的JSON对象 <br/>
     * 构建返回给前端的JSON对象 <br/>
     * 
     * @param [mac]-[加密信息] <br/>
     * @param [method]-[后台调用方法] <br/>
     * @param [sNumber]-[序列号] <br/>
     * @param [version]-[版本号] <br/>
     * @param [code]-[返回消息消息码和消息] <br/>
     * @param [result]-[返回结果] <br/>
     * @return [ResponseJSON] 返回给前段JSON对象<br/>
     */
    protected ResponseJSON getResponseJSON(String mac, String method, String sNumber, String version, SysCode code,
            Object result) {
        ResponseJSON responseJSON = new ResponseJSON();
        responseJSON.setMac(mac);
        responseJSON.setHead(getResponseHead(method, sNumber, version));
        responseJSON.setBody(getResponseBody(code, result));
        return responseJSON;
    }

    protected ParamInfo parseRequest(HttpServletRequest request, String method, String[] paramKey) {
        String jsonParam = request.getParameter("dataJson");
        Object jsonStr = "";
        String mac = UUID.randomUUID().toString();
        String sNumber = UUID.randomUUID().toString();
        String version = "V1.0";

        logger.info("parseRequest method:" + method + "; jsonParam:" + jsonParam);

        ParamInfo info = new ParamInfo();

        // 如果传入字符串为空,则提示参数不合法
        if (RoUtil.isEmpty(jsonParam)) {
            logger.info("parameter error !");
            info.setState(SysCode.PARAM_IS_ERROR);
            info.setResponse(getResponseJSON(mac, method, sNumber, version, SysCode.PARAM_IS_ERROR, jsonStr));
            return info;
        }

        RequestJSON requestJSON = JSON.parseObject(jsonParam, RequestJSON.class);
        info.setRequestJSON(JSON.parseObject(jsonParam, RequestJSON.class));

        if (paramKey != null && paramKey.length > 0) {
            for (int i = 0; i < paramKey.length; i++) {
                String jp = requestJSON.getBody().getString(paramKey[i]);
                if (!RoUtil.isEmpty(jp)) {
                    info.getParams().put(paramKey[i], jp);
                    logger.info("【text-- the key:" + paramKey[i] + " ,value :" + jp + "】");
                } else {
                    logger.info("【warn-- the key:" + paramKey[i] + " is empty or is null!】");
                }
            }
        }

        info.setResponse(getResponseJSON(mac, method, sNumber, version, SysCode.SUCCESS, jsonStr));
        info.setState(SysCode.SUCCESS);
        logger.info("parameter SUCCESS !");
        return info;
    }

    /**
     * 描述：〈响应输出内容，包含跨域处理〉 <br/>
     * 作者：xuan.zhou@rogrand.com <br/>
     * 生成日期：2014-03-13 <br/>
     */
    protected void renderResponseJson(HttpServletRequest request, HttpServletResponse response, SysCode sysCode,
            Object content) {
        String callback = request.getParameter("callback");
        if (StringUtils.isNotEmpty(callback)) {
            Map<String, Object> result = new HashMap<String, Object>();
            result.put("code", sysCode.getCode());
            result.put("message", sysCode.getMessage());
            result.put("result", content);

            ResponseUtils.renderText(response, callback + "(" + JSON.toJSON(result) + ");");
        } else {
        	 Map<String, Object> result = new HashMap<String, Object>();
             result.put("code", sysCode.getCode());
             result.put("message", sysCode.getMessage());
             result.put("result", content);
            ResponseUtils.renderJson(response, JsonUtils.toJsonString(result, false));
        }
    }

    /**
     * 描述：〈响应输出内容，包含跨域处理〉 <br/>
     * 作者：xuan.zhou@rogrand.com <br/>
     * 生成日期：2014-03-13 <br/>
     */
    protected void renderResponseJson(HttpServletRequest request, HttpServletResponse response, Object content) {
        String callback = request.getParameter("callback");
        if (StringUtils.isNotEmpty(callback)) {
            ResponseUtils.renderText(response, callback + "(" + JSON.toJSON(content) + ");");
        } else {
            ResponseUtils.renderJson(response, JsonUtils.toJsonString(content, false));
        }
    }

    protected void renderResponseJson(HttpServletResponse response, ResponseJSON responseJson) {
        ResponseUtils.renderJson(response, JsonUtils.toJsonString(responseJson, false));
    }

    protected void renderResponseJson(HttpServletResponse response, ResponseJSON responseJson,
            String[] excludesProperties) {
        ResponseUtils.renderJson(response, JsonUtils.toJsonString(responseJson, null, excludesProperties, false));
    }

    protected void renderResponseJson(HttpServletResponse response, ResponseJSON responseJson,
            String[] includesProperties, String[] excludesProperties) {
        ResponseUtils.renderJson(response,
                JsonUtils.toJsonString(responseJson, includesProperties, excludesProperties, false));
    }

    protected String getIpAddr(HttpServletRequest request) {
        String ip = request.getHeader("x-forwarded-for");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        return ip;
    }
    
    /**
	 * 将对象转换成JSON字符串，并响应回前台 <br/>
	 * 将对象转换成JSON字符串，在response 中输出<br/>
	 * 
	 * @param [request]-[HTTP请求对象] <br/>
	 * @param [response]-[HTTP响应对象] <br/>
	 * @param [object]-[需要转换为JSON输出的对象] <br/>
	 * @return[void]
	 */
	public void writeJson(HttpServletRequest request, HttpServletResponse response, Object object) {
		writeJsonByFilter(request, response, object, null, null);
	}
	
	/**
	 * 将对象转换成JSON字符串，并响应回前台 <br/>
	 * 将对象转换成JSON字符串，在response 中输出<br/>
	 * 
	 * @param [request]-[HTTP请求对象] <br/>
	 * @param [response]-[HTTP响应对象] <br/>
	 * @param [object]-[需要转换为JSON输出的对象] <br/>
	 * @param [includesProperties]-[需要转换的属性] <br/>
	 * @param [excludesProperties]-[不需要转换的属性] <br/>
	 * @return[void]
	 */
	public void writeJsonByFilter(HttpServletRequest request, HttpServletResponse response, Object object, String[] includesProperties, String[] excludesProperties) {
		response.setContentType("application/json;charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
			
			FastjsonFilter filter = FastjsonFilterUtils.getInstance().getFilter(includesProperties, excludesProperties);// excludes优先于includes
			// logger.info("对象转JSON：要排除的属性[" + excludesProperties + "]要包含的属性[" + includesProperties + "]");
			String json;
			String User_Agent = request.getHeader("User-Agent") == null ? "" : request.getHeader("User-Agent");
			if (User_Agent.indexOf("MSIE") > -1 && (User_Agent.indexOf("MSIE 6") > -1)) {
				// 使用SerializerFeature.BrowserCompatible特性会把所有的中文都会序列化为\\uXXXX这种格式，字节数会多一些，但是能兼容IE6
				json = JSON.toJSONString(object, filter, featuresIncludeBrowser);
			} else {
				// 使用SerializerFeature.WriteDateUseDateFormat特性来序列化日期格式的类型为yyyy-MM-dd hh24:mi:ss
				// 使用SerializerFeature.DisableCircularReferenceDetect特性关闭引用检测和生成
				json = JSON.toJSONString(object, filter, features);
			}
			out.write(json);
			out.flush();
		} catch (IOException e) {
			logger.error("系统转换JSON输出异常:", e);
			e.printStackTrace();
		} finally {
			if (out != null) {
				out.close();
				out = null;
			}
		}
	}
}
