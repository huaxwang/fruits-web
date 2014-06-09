package com.king.fruits.model;

import java.util.Date;

public class KingFruits implements java.io.Serializable{
	
	private static final long serialVersionUID = -4986417748111735511L;
	
    private Integer id;

    private String name;

    private Double price;

    private String originalPrice;
    
    private Integer count;

    private String unit;

    private Integer category;

    private String picture;

    private String pictureDetail;

    private String remarks;

    private Integer createId;

    private Date createTime;

    private Integer delId;

    private Date delTime;

    private Integer onlineOperId;

    private Date onlineOperTime;

    private Integer onlineOperStatue;

    private String offlineReason;

    private Integer evaluation;

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

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public String getOriginalPrice() {
        return originalPrice;
    }

    public void setOriginalPrice(String originalPrice) {
        this.originalPrice = originalPrice == null ? null : originalPrice.trim();
    }

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public Integer getCategory() {
        return category;
    }

    public void setCategory(Integer category) {
        this.category = category;
    }

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture == null ? null : picture.trim();
    }

    public String getPictureDetail() {
        return pictureDetail;
    }

    public void setPictureDetail(String pictureDetail) {
        this.pictureDetail = pictureDetail == null ? null : pictureDetail.trim();
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks == null ? null : remarks.trim();
    }

    public Integer getCreateId() {
        return createId;
    }

    public void setCreateId(Integer createId) {
        this.createId = createId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getDelId() {
        return delId;
    }

    public void setDelId(Integer delId) {
        this.delId = delId;
    }

    public Date getDelTime() {
        return delTime;
    }

    public void setDelTime(Date delTime) {
        this.delTime = delTime;
    }

    public Integer getOnlineOperId() {
        return onlineOperId;
    }

    public void setOnlineOperId(Integer onlineOperId) {
        this.onlineOperId = onlineOperId;
    }

    public Date getOnlineOperTime() {
        return onlineOperTime;
    }

    public void setOnlineOperTime(Date onlineOperTime) {
        this.onlineOperTime = onlineOperTime;
    }

    public Integer getOnlineOperStatue() {
        return onlineOperStatue;
    }

    public void setOnlineOperStatue(Integer onlineOperStatue) {
        this.onlineOperStatue = onlineOperStatue;
    }

    public String getOfflineReason() {
        return offlineReason;
    }

    public void setOfflineReason(String offlineReason) {
        this.offlineReason = offlineReason == null ? null : offlineReason.trim();
    }

    public Integer getEvaluation() {
        return evaluation;
    }

    public void setEvaluation(Integer evaluation) {
        this.evaluation = evaluation;
    }

	public Integer getCount() {
		return count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}
    
}