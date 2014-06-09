package com.king.fruits.core.common.util;

import java.text.ParseException;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.king.fruits.core.common.base.page.Pagination;

/**
 * 版权：融贯资讯 <br/>
 * 作者：xuan.zhou@rogrand.com <br/>
 * 生成日期：2014-5-20 <br/>
 * 描述：〈HttpServletRequest 工具类〉
 */
public class RequestUtils {

    public static final Logger log = LoggerFactory.getLogger(RequestUtils.class);
    
    /**
     * 描述：〈获取查询参数值〉 <br/>
     * 作者：xuan.zhou@rogrand.com <br/>
     * 生成日期：2014-5-21 <br/>
     * 
     * @param request 用户请求
     * @param paramName 参数名称
     * @return 参数值
     */
    public static String getQueryParam(HttpServletRequest request, String paramName) {
        return getQueryParam(request, paramName, null);
    }
    
    /**
     * 描述：〈获取查询参数值〉 <br/>
     * 作者：xuan.zhou@rogrand.com <br/>
     * 生成日期：2014-5-21 <br/>
     * 
     * @param request 用户请求
     * @param paramName 参数名称
     * @param defaultValue 默认值
     * @return 参数值
     */
    public static String getQueryParam(HttpServletRequest request, String paramName, String defaultValue) {
        String paramValue = request.getParameter(paramName);
        if(StringUtils.isNotEmpty(paramValue)){
            return StringUtils.defaultIfEmpty(paramValue.trim(), defaultValue);
        }
        
        return null;
    }

    public static Date getDateParam(HttpServletRequest request, String paramName) {
        return getDateParam(request, paramName, new String[] { "yyyy-MM-dd" });
    }

    public static Date getDateParam(HttpServletRequest request, String paramName, String[] parsePatterns) {
        if (StringUtils.isEmpty(paramName)) {
            log.warn("参数名为空");
            return null;
        }

        String paramValue = request.getParameter(paramName);
        if (StringUtils.isNotEmpty(paramValue)) {
            try {
                return DateUtils.parseDate(paramValue, parsePatterns);
            } catch (ParseException e) {
                log.error("解析日期格式出错：" + e.getMessage(), e);
            }
        }

        return null;
    }
    
    public static Date getDateToParam(HttpServletRequest request, String paramName) {
        return getDateToParam(request, paramName, new String[]{"yyyy-MM-dd HH:mm:ss"});
    }
    
    public static Date getDateToParam(HttpServletRequest request, String paramName, String[] parsePatterns) {
        if (StringUtils.isEmpty(paramName)) {
            log.warn("参数名为空");
            return null;
        }

        String paramValue = request.getParameter(paramName);
        if (StringUtils.isNotEmpty(paramValue)) {
            try {
                return DateUtils.parseDate(paramValue + " 23:59:59", parsePatterns);
            } catch (ParseException e) {
                log.error("解析日期格式出错：" + e.getMessage(), e);
            }
        }

        return null;
    }

    public static <T> Pagination<T> getPagination(HttpServletRequest request) {
        return new Pagination<T>(getPageNo(request), getPageSize(request));
    }

    private static int getPageNo(HttpServletRequest request) {
        int pageNo = 1;

        String pn = request.getParameter("pageNo");
        if (StringUtils.isNotEmpty(pn) && StringUtils.isNumeric(pn)) {
            pageNo = Integer.parseInt(pn);
        }

        return pageNo;
    }

    private static int getPageSize(HttpServletRequest request) {
        int pageSize = Pagination.DEF_COUNT;

        String ps = request.getParameter("pageSize");
        if (StringUtils.isNotEmpty(ps) && StringUtils.isNumeric(ps)) {
            pageSize = Integer.parseInt(ps);
        }

        return pageSize;
    }
}
