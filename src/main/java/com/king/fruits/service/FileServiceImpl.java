package com.king.fruits.service;

import java.io.DataOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.king.fruits.service.api.FileService;

@Service
public class FileServiceImpl implements FileService{
	
	 protected static Logger logger = Logger.getLogger(FileServiceImpl.class);
	
	/**
     * 
     * 描述：〈文件上传〉 <br/>
     * 作者：huaxing.wang@rogrand.com <br/>
     * 生成日期：2014-5-21 <br/>
     * 
     * @param orginalFile
     * @param path
     * @throws FileNotFoundException
     */
	@Override
    public String uploadFile(MultipartFile orginalFile, String path) throws FileNotFoundException {
        if (orginalFile != null && !orginalFile.isEmpty()) {
            String filename = orginalFile.getOriginalFilename();
            File fullfile = new File(path);
            if (!fullfile.exists()) {
                fullfile.mkdir();
            }
            String filePath = path + "/" + filename;
            DataOutputStream out = new DataOutputStream(new FileOutputStream(filePath));// 存放文件的绝对路径
            InputStream is = null;
            try {
                is = orginalFile.getInputStream();
                byte[] b = new byte[is.available()];
                is.read(b);
                out.write(b);
            } catch (IOException e) {
                logger.error(e.getMessage(), e);
            } finally {
                if (is != null) {
                    try {
                        is.close();
                    } catch (IOException e) {
                        logger.error(e.getMessage(), e);
                    }
                }
                if (out != null) {
                    try {
                        out.close();
                    } catch (IOException e) {
                        logger.error(e.getMessage(), e);
                    }
                }
            }
            
            return filePath;
        }
        return null;
    }
}
