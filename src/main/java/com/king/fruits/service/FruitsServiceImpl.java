package com.king.fruits.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.king.fruits.core.common.base.page.Pagination;
import com.king.fruits.core.common.base.service.ParentServiceImpl;
import com.king.fruits.core.db.DBInterface;
import com.king.fruits.dao.KingFruitsCategoryMapper;
import com.king.fruits.dao.KingFruitsMapper;
import com.king.fruits.dao.KingPromotionMapper;
import com.king.fruits.entity.KingFruitsBean;
import com.king.fruits.model.KingFruits;
import com.king.fruits.model.KingFruitsCategory;
import com.king.fruits.model.KingPromotion;
import com.king.fruits.service.api.FruitsService;

@Service
public class FruitsServiceImpl extends ParentServiceImpl<KingFruits> implements FruitsService{
	
	@Autowired
	private KingFruitsCategoryMapper kingFruitsCategoryMapper;
	
	@Autowired
	private KingFruitsMapper kingFruitsMapper;
	
	@Autowired
	private KingPromotionMapper kingPromotionMapper;
	
	
	@Override
	protected DBInterface<KingFruits> getDao() {
		return kingFruitsMapper;
	}

	@Override
	public List<KingFruitsCategory> queryCategorys() {
		return kingFruitsCategoryMapper.queryCategorys();
	}

	@Override
	public List<KingPromotion> selectShow() {
		return kingPromotionMapper.selectShow();
	}

	@Override
	public List<KingFruitsBean> queryColumnFruitsAll() {
		return kingFruitsMapper.queryColumnFruitsAll();
	}

	@Override
	public Pagination<KingFruitsBean> queryFruitsAll(String name, Integer columnId,
			Integer onlineOperStatue, Pagination<KingFruitsBean> pagination) {
		//查询总数
		int totalCount = kingFruitsMapper.queryFruitsAllTotal(name, columnId, onlineOperStatue);
		
		pagination.setTotalCount(totalCount);
        pagination.adjustPageNo();
        
        List<KingFruitsBean> list = null;
        if (totalCount > 0) {
        	list = kingFruitsMapper.queryFruitsAll(name, columnId, onlineOperStatue,pagination.getFirstResult(), pagination.getPageSize());
        }
        pagination.setList(list);
		return pagination;
	}
	
}
