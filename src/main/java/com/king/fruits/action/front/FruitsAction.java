package com.king.fruits.action.front;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.king.fruits.core.common.base.action.BaseController;
import com.king.fruits.core.util.SysCode;
import com.king.fruits.entity.KingFruitsBean;
import com.king.fruits.model.KingFruitsCategory;
import com.king.fruits.model.KingPromotion;
import com.king.fruits.service.api.FruitsService;

@Controller
@RequestMapping("fruits")
public class FruitsAction extends BaseController{
	
	@Autowired
	FruitsService fruitsService;
	
	@RequestMapping(value = "/index")
	public String index(){
		return "/index/index";
	}
	
	/**
	 * 
	 * 描述：〈获取水果分类列表〉 <br/>
	 * 作者：huaxing.wang@sohu.com <br/>
	 * 生成日期：2014-6-1 <br/>
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/categoryList")
	@ResponseBody
	public void categoryList(HttpServletRequest request, HttpServletResponse response){
		try {
			List<KingFruitsCategory> list = fruitsService.queryCategorys();
			renderResponseJson(request, response, SysCode.SUCCESS, list);
		} catch (Exception e) {
			logger.error("获取水果分类列表错误:"+e.getMessage(),e);
			renderResponseJson(request, response, SysCode.SYS_ERR, null);
		}
	}
	
	/**
	 * 
	 * 描述：〈查询促销活动〉 <br/>
	 * 作者：huaxing.wang@sohu.com <br/>
	 * 生成日期：2014-6-1 <br/>
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/selectShow")
	@ResponseBody
	public void selectShow(HttpServletRequest request, HttpServletResponse response){
		try {
			List<KingPromotion> list = fruitsService.selectShow();
			renderResponseJson(request, response, SysCode.SUCCESS, list);
		} catch (Exception e) {
			logger.error("查询促销活动错误:"+e.getMessage(),e);
			renderResponseJson(request, response, SysCode.SYS_ERR, null);
		}
	}
	
	/**
	 * 
	 * 描述：〈查询栏目水果〉 <br/>
	 * 作者：huaxing.wang@sohu.com <br/>
	 * 生成日期：2014-6-1 <br/>
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/queryColumnFruitsAll")
	@ResponseBody
	public void queryColumnFruitsAll(HttpServletRequest request, HttpServletResponse response){
		try {
			List<KingFruitsBean> list = fruitsService.queryColumnFruitsAll();
			renderResponseJson(request, response, SysCode.SUCCESS, list);
		} catch (Exception e) {
			logger.error("查询栏目水果错误:"+e.getMessage(),e);
			renderResponseJson(request, response, SysCode.SYS_ERR, null);
		}
	}
	
}
