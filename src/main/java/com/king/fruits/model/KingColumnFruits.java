package com.king.fruits.model;

public class KingColumnFruits implements java.io.Serializable{
	
	private static final long serialVersionUID = -4986417748111732513L;
	
    private Integer id;

    private Integer fruitsId;

    private Integer columnId;

    private Integer status;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getFruitsId() {
        return fruitsId;
    }

    public void setFruitsId(Integer fruitsId) {
        this.fruitsId = fruitsId;
    }

    public Integer getColumnId() {
        return columnId;
    }

    public void setColumnId(Integer columnId) {
        this.columnId = columnId;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
}