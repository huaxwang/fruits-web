package com.king.fruits.service.api;

import java.util.List;

import com.king.fruits.core.common.base.page.Pagination;
import com.king.fruits.core.common.base.service.api.ParentService;
import com.king.fruits.entity.KingFruitsBean;
import com.king.fruits.model.KingFruits;
import com.king.fruits.model.KingFruitsCategory;
import com.king.fruits.model.KingPromotion;

/**
 * 
 * 版权：水果网 <br/>
 * 作者：huaxing.wang@sohu.com <br/>
 * 生成日期：2014-6-1 <br/>
 * 描述：〈水果表〉
 */
public interface FruitsService extends ParentService<KingFruits>{
	
	/**
	 * 
	 * 描述：〈查询水果分类〉 <br/>
	 * 作者：huaxing.wang@sohu.com <br/>
	 * 生成日期：2014-6-1 <br/>
	 * 
	 * @return
	 */
	public List<KingFruitsCategory> queryCategorys();
	
	/**
	 * 
	 * 描述：〈查询促销活动〉 <br/>
	 * 作者：huaxing.wang@sohu.com <br/>
	 * 生成日期：2014-6-1 <br/>
	 * 
	 * @return
	 */
	List<KingPromotion> selectShow();
	
	/**
	 * 
	 * 描述：〈查询所有栏目水果〉 <br/>
	 * 作者：huaxing.wang@sohu.com <br/>
	 * 生成日期：2014-6-2 <br/>
	 * 
	 * @return
	 */
    List<KingFruitsBean> queryColumnFruitsAll();
    
    /**
	 * 
	 * 描述：〈查询全部水果〉 <br/>
	 * 作者：huaxing.wang@sohu.com <br/>
	 * 生成日期：2014-6-2 <br/>
	 * 
	 * @return
	 */
    Pagination<KingFruitsBean> queryFruitsAll(String name,Integer columnId,Integer onlineOperStatue,Pagination<KingFruitsBean> pagination);
    
    /**
	 * 
	 * 描述：〈查询全部水果〉 <br/>
	 * 作者：why <br/>
	 * 生成日期：2014-6-8 <br/>
	 * 
	 * @return
	 */
    
    public KingFruits getKingFruitsByPid(Integer pid);
}
