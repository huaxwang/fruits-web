package com.king.fruits.action.manager;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.king.fruits.core.common.base.action.BaseController;
import com.king.fruits.core.common.base.page.Pagination;
import com.king.fruits.core.common.util.RequestUtils;
import com.king.fruits.core.util.SysCode;
import com.king.fruits.entity.KingFruitsBean;
import com.king.fruits.model.KingFruits;
import com.king.fruits.service.api.FruitsService;

@Controller
@RequestMapping("manager")
public class ManagerAction extends BaseController{
	
	@Autowired
	FruitsService fruitsService;
	
	@RequestMapping(value = "/index")
	public String index(){
		return "/manager/index";
	}
	
	/**
	 * 
	 * 描述：〈查询全部水果列表〉 <br/>
	 * 作者：huaxing.wang@sohu.com <br/>
	 * 生成日期：2014-6-1 <br/>
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/getFruitsList")
	@ResponseBody
	public void getFruitsList(String name,Integer columnId,Integer onlineOperStatue,HttpServletRequest request, HttpServletResponse response){
		try {
			Pagination<KingFruitsBean> pagination = RequestUtils.getPagination(request);
			pagination = fruitsService.queryFruitsAll(name, columnId, onlineOperStatue,pagination);
			renderResponseJson(request, response, SysCode.SUCCESS, pagination);
		} catch (Exception e) {
			logger.error("查询全部水果列表错误:"+e.getMessage(),e);
			renderResponseJson(request, response, SysCode.SYS_ERR, null);
		}
	}
	
	
	/**
	 * 
	 * 描述：〈修改水果状态〉 <br/>
	 * 作者：huaxing.wang@sohu.com <br/>
	 * 生成日期：2014-6-1 <br/>
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/onlineUpdate")
	@ResponseBody
	public void onlineUpdate(Integer id,Integer onlineState,HttpServletRequest request, HttpServletResponse response){
		try {
			KingFruits KingFruits = new KingFruits();
			KingFruits.setId(id);
			KingFruits.setOnlineOperStatue(onlineState);
			fruitsService.updateByPrimaryKeySelective(KingFruits);
			renderResponseJson(request, response, SysCode.SUCCESS, null);
		} catch (Exception e) {
			logger.error("查询全部水果列表错误:"+e.getMessage(),e);
			renderResponseJson(request, response, SysCode.SYS_ERR, null);
		}
	}
	
	
	/**
	 * 
	 * 描述：〈增加水果〉 <br/>
	 * 作者：huaxing.wang@sohu.com <br/>
	 * 生成日期：2014-6-1 <br/>
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/add")
	@ResponseBody
	public void add(Integer category,Double price,Integer count,String unit,String name,String idcard1,HttpServletRequest request, HttpServletResponse response){
		try {
			String fileName = FilenameUtils.getName(idcard1);
			KingFruits kingFruits = new KingFruits();
			kingFruits.setCategory(category);
			kingFruits.setPrice(price);
			kingFruits.setCategory(count);
			kingFruits.setUnit(unit);
			kingFruits.setName(name);
			kingFruits.setPicture(fileName);
			fruitsService.insert(kingFruits);
			
			Map<String,Object> result = new HashMap<String, Object>();
	        result.put("picPath", fileName);
	        renderResponseJson(request, response, SysCode.SUCCESS, result);
		} catch (Exception e) {
			logger.error("查询全部水果列表错误:"+e.getMessage(),e);
			renderResponseJson(request, response, SysCode.SYS_ERR, null);
		}
	}
	
	
}
