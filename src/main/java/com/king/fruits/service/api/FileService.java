package com.king.fruits.service.api;

import java.io.FileNotFoundException;

import org.springframework.web.multipart.MultipartFile;

/**
 * 
 * 版权：水果网 <br/>
 * 作者：huaxing.wang@sohu.com <br/>
 * 生成日期：2014-6-2 <br/>
 * 描述：〈文件业务〉
 */
public interface FileService {
	
	/**
	 * 
	 * 描述：〈文件上传〉 <br/>
	 * 作者：huaxing.wang@sohu.com <br/>
	 * 生成日期：2014-6-2 <br/>
	 * 
	 * @param orginalFile
	 * @param path
	 * @return
	 * @throws FileNotFoundException
	 */
	public String uploadFile(MultipartFile orginalFile, String path) throws FileNotFoundException;
}
