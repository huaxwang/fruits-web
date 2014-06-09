package com.king.fruits.core.util;

import org.apache.commons.lang.StringUtils;

/**
 * 版权：融贯资讯 <br/>
 * 作者：xuan.zhou@rogrand.com <br/>
 * 生成日期：2014-2-24 <br/>
 * 描述：〈APP 客户端工具类〉
 */
public class AppClientUtils {

    /**
     * 描述：〈转换为适合客户端屏幕尺寸的 banner 图片地址〉 <br/>
     * 作者：xuan.zhou@rogrand.com <br/>
     * 生成日期：2014-2-24 <br/>
     * 
     * @param bannerPicUrl banner 图片地址
     * @param screenSize 客户端屏幕尺寸
     * @return 适合客户端屏幕尺寸的 banner 图片地址
     */
    public static String convertBannerPicUrl(String bannerPicUrl, String screenSize) {
        if (StringUtils.isNotEmpty(bannerPicUrl)) {
            int index = bannerPicUrl.lastIndexOf(".");
            String name = StringUtils.substring(bannerPicUrl, 0, index);
            String extension = StringUtils.substring(bannerPicUrl, index);
            return name + "_" + screenSize + extension;
        }
        return null;
    }
}
