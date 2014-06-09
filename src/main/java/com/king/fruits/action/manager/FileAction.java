package com.king.fruits.action.manager;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.king.fruits.core.common.base.action.BaseController;
import com.king.fruits.core.common.util.Result;
import com.king.fruits.core.common.util.image.ImageScale;
import com.king.fruits.core.common.util.image.ImageScaleImpl;
import com.king.fruits.core.util.Constants;
import com.king.fruits.core.util.SysCode;
import com.king.fruits.service.api.FileService;

@Controller
@RequestMapping("file")
public class FileAction  extends BaseController{

	@Autowired
	FileService fileService;
	
	/**
     * 
     * 描述：〈图片存储到服务器〉 <br/>
     * 作者：huaxing.wang@rogrand.com <br/>
     * 生成日期：2014-5-22 <br/>
     * 
     * @param request
     * @param response
     * @throws FileNotFoundException
     */
    @RequestMapping(value = "preUpload")
    public void preUpload(HttpServletRequest request, HttpServletResponse response) throws FileNotFoundException {
        try {
            String pageid = request.getParameter("pageid");
            MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
            String path = request.getSession().getServletContext().getRealPath(Constants.FILE_PATH_TEMP + pageid);
            String filePath = "";
            for (Map.Entry<String, MultipartFile> entry : multipartRequest.getFileMap().entrySet()) {
            	filePath = fileService.uploadFile(entry.getValue(), path);
            }
            if(filePath==null||filePath.isEmpty()){
            	writeJson(request, response, new Result(SysCode.SYS_ERR, "图片上传出错"));
            }
            ImageScale scale=new ImageScaleImpl();
            int[] size= scale.dimensionImage(new File(filePath));
            if(size==null){
            	writeJson(request, response, new Result(SysCode.SYS_ERR, "获取图片宽高出错"));
            	return;
            }
            if(size[0]>Constants.FILE_MAX_HEIGHT){
            	writeJson(request, response, new Result(SysCode.SYS_ERR, "上传图片高度不能超过"+Constants.FILE_MAX_HEIGHT+"px"));
            	FileUtils.deleteDirectory(new File(path));
            	return;
            }
            if(size[1]>Constants.FILE_MAX_WIDTH){
            	writeJson(request, response, new Result(SysCode.SYS_ERR, "上传图片宽度不能超过"+Constants.FILE_MAX_WIDTH+"px"));
            	FileUtils.deleteDirectory(new File(path));
            	return;
            }
            
            writeJson(request, response, new Result(SysCode.SUCCESS, null));
        } catch (Exception e) {
            logger.error("新增优惠券上传图片错误：" +e.getMessage(), e);
            writeJson(request, response, new Result(SysCode.SYS_ERR, e));
        }
    }
}
