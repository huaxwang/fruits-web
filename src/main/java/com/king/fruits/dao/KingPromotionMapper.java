package com.king.fruits.dao;

import java.util.List;

import com.king.fruits.core.db.DBInterface;
import com.king.fruits.model.KingPromotion;

/**
 * 
 * 版权：水果网 <br/>
 * 作者：huaxing.wang@sohu.com <br/>
 * 生成日期：2014-6-1 <br/>
 * 描述：〈促销活动mapper〉
 */
public interface KingPromotionMapper  extends DBInterface<KingPromotion>{
	/**
	 * 
	 * 描述：〈查询促销活动〉 <br/>
	 * 作者：huaxing.wang@sohu.com <br/>
	 * 生成日期：2014-6-1 <br/>
	 * 
	 * @return
	 */
	List<KingPromotion> selectShow();
}