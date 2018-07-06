package com.spring.finalins.model;

public class TeamVO {

	private String team_idx;
	private String admin_userid;
	private String team_name;
	private String team_delete_status;
	private String team_visibility_status;
	private String team_image;
	
	public TeamVO() {}
	
	public TeamVO(String team_idx, String admin_userid, String team_name, String team_delete_status,
			String team_visibility_status, String team_image) {
		
		this.team_idx = team_idx;
		this.admin_userid = admin_userid;
		this.team_name = team_name;
		this.team_delete_status = team_delete_status;
		this.team_visibility_status = team_visibility_status;
		this.team_image = team_image;
	}

	public String getTeam_idx() {
		return team_idx;
	}

	public void setTeam_idx(String team_idx) {
		this.team_idx = team_idx;
	}

	public String getAdmin_userid() {
		return admin_userid;
	}

	public void setAdmin_userid(String admin_userid) {
		this.admin_userid = admin_userid;
	}

	public String getTeam_name() {
		return team_name;
	}

	public void setTeam_name(String team_name) {
		this.team_name = team_name;
	}

	public String getTeam_delete_status() {
		return team_delete_status;
	}

	public void setTeam_delete_status(String team_delete_status) {
		this.team_delete_status = team_delete_status;
	}

	public String getTeam_visibility_status() {
		return team_visibility_status;
	}

	public void setTeam_visibility_status(String team_visibility_status) {
		this.team_visibility_status = team_visibility_status;
	}

	public String getTeam_image() {
		return team_image;
	}

	public void setTeam_image(String team_image) {
		this.team_image = team_image;
	}
	
}
