package com.king.fruits.core.common.util;

import java.io.Serializable;

import com.king.fruits.core.util.SysCode;


/**
 * 版权：融贯资讯 <br/>
 * 作者：yong.li@rogrand.com <br/>
 * 生成日期：2014-1-8 <br/>
 * 描述：处理结果,适用于ajax请求
 */

public class Result implements Serializable{

	/**
	 * serialVersionUID : <功能描述)>
	*/
	private static final long serialVersionUID = 1L;
	
	private String code;
	
	private String msg;
	
	private Object data;
	
	public Result(){
		
	}
	
	public Result(SysCode code){
		this.code=code.toString().toLowerCase();
		this.msg=code.getMessage();
	}
	
	public Result(SysCode code,Object data){
		this.code=code.toString().toLowerCase();
		this.msg=code.getMessage();
		this.data=data;
	}
	
	public Result(SysCode code,String msg,Object data){
		this.code=code.toString().toLowerCase();
		this.msg=msg;
		this.data=data;
	}
	
	public Result(String code){
		this.code=code;
	}
	
	public Result(String code,String msg){
		this.code=code;
		this.msg=msg;
	}
	
	public Result(String code,Object data){
		this.code=code;
		this.data=data;
	}
	
	public Result(String code,String msg,Object data){
		this.code=code;
		this.msg=msg;
		this.data=data;
	}
	
	public Object getData() {
		return data;
	}

	
	public void setData(Object data) {
		this.data = data;
	}

	public String getCode() {
		return code;
	}

	
	public void setCode(String code) {
		this.code = code;
	}

	
	public String getMsg() {
		return msg;
	}

	
	public void setMsg(String msg) {
		this.msg = msg;
	}
}
