package com.king.fruits.model;

import java.util.Date;

/**
 * 
 * 版权：水果网 <br/>
 * 作者：huaxing.wang@sohu.com <br/>
 * 生成日期：2014-6-1 <br/>
 * 描述：〈促销model〉
 */
public class KingPromotion  implements java.io.Serializable {
	
	private static final long serialVersionUID = -4986417748111735512L;
	
    private Integer id;

    private String name;

    private String picture;

    private Date createTime;

    private Integer createId;

    private Integer showStatues;

    private Integer showUserId;

    private Date showTime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture == null ? null : picture.trim();
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getCreateId() {
        return createId;
    }

    public void setCreateId(Integer createId) {
        this.createId = createId;
    }

    public Integer getShowStatues() {
        return showStatues;
    }

    public void setShowStatues(Integer showStatues) {
        this.showStatues = showStatues;
    }

    public Integer getShowUserId() {
        return showUserId;
    }

    public void setShowUserId(Integer showUserId) {
        this.showUserId = showUserId;
    }

    public Date getShowTime() {
        return showTime;
    }

    public void setShowTime(Date showTime) {
        this.showTime = showTime;
    }
}