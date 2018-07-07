package com.spring.finalins.model;

public class ListVO {

	private String list_idx;
	private String fk_project_idx;
	private String list_name;
	private String list_delete_status;
	
	public ListVO() {}
	
	public ListVO(String list_idx, String fk_project_idx, String list_name, String list_delete_status) {
		
		this.list_idx = list_idx;
		this.fk_project_idx = fk_project_idx;
		this.list_name = list_name;
		this.list_delete_status = list_delete_status;
	}

	public String getList_idx() {
		return list_idx;
	}

	public void setList_idx(String list_idx) {
		this.list_idx = list_idx;
	}

	public String getFk_project_idx() {
		return fk_project_idx;
	}

	public void setFk_project_idx(String fk_project_idx) {
		this.fk_project_idx = fk_project_idx;
	}

	public String getList_name() {
		return list_name;
	}

	public void setList_name(String list_name) {
		this.list_name = list_name;
	}

	public String getList_delete_status() {
		return list_delete_status;
	}

	public void setList_delete_status(String list_delete_status) {
		this.list_delete_status = list_delete_status;
	}
	
}
