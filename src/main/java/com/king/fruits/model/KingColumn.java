package com.king.fruits.model;

public class KingColumn  implements java.io.Serializable{
	
	private static final long serialVersionUID = -4986417748111732512L;
	
    private Integer id;

    private String name;

    private String descri;

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

    public String getDescri() {
        return descri;
    }

    public void setDescri(String descri) {
        this.descri = descri == null ? null : descri.trim();
    }
}