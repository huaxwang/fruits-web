package com.king.fruits.dao;

import java.util.List;

import com.king.fruits.core.db.DBInterface;
import com.king.fruits.model.KingFruitsCategory;


/**
 * 
 * 版权：水果网 <br/>
 * 作者：huaxing.wang@sohu.com <br/>
 * 生成日期：2014-6-1 <br/>
 * 描述：〈水果分类〉
 */
public interface KingFruitsCategoryMapper extends DBInterface<KingFruitsCategory>{
	
	/**
	 * 
	 * 描述：〈查询水果分类〉 <br/>
	 * 作者：huaxing.wang@sohu.com <br/>
	 * 生成日期：2014-6-1 <br/>
	 * 
	 * @return
	 */
	List<KingFruitsCategory> queryCategorys();
}