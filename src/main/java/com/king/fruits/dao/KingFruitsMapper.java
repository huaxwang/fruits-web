package com.king.fruits.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.king.fruits.core.db.DBInterface;
import com.king.fruits.entity.KingFruitsBean;
import com.king.fruits.model.KingFruits;

public interface KingFruitsMapper extends DBInterface<KingFruits>{
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
	 * 描述：〈查询全部水果总数〉 <br/>
	 * 作者：huaxing.wang@sohu.com <br/>
	 * 生成日期：2014-6-2 <br/>
	 * 
	 * @return
	 */
    Integer queryFruitsAllTotal(@Param("name")String name,@Param("columnId")Integer columnId,@Param("onlineOperStatue")Integer onlineOperStatue);

    
    /**
	 * 
	 * 描述：〈查询全部水果〉 <br/>
	 * 作者：huaxing.wang@sohu.com <br/>
	 * 生成日期：2014-6-2 <br/>
	 * 
	 * @return
	 */
    List<KingFruitsBean> queryFruitsAll(@Param("name")String name,@Param("columnId")Integer columnId,@Param("onlineOperStatue")Integer onlineOperStatue,
    		@Param("limitFrom") int limitFrom, @Param("pageSize") int pageSize);
}