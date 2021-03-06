package com.spring.finalins.model;

public class MemberVO {

	private String userid;
	private String pwd;
	private String name;
	private String nickname;
	private String email;
	private String tel1;
	private String tel2;
	private String tel3;
	private String leave_status;
	private String job;
	private String birthday;
	private String profilejpg;
	private String ins_personal_alarm;
	
	public MemberVO() {}

	public MemberVO(String userid, String pwd, String name, String nickname, String email, String tel1, String tel2,
			String tel3, String leave_status, String job, String birthday, String profilejpg,
			String ins_personal_alarm) {
		this.userid = userid;
		this.pwd = pwd;
		this.name = name;
		this.nickname = nickname;
		this.email = email;
		this.tel1 = tel1;
		this.tel2 = tel2;
		this.tel3 = tel3;
		this.leave_status = leave_status;
		this.job = job;
		this.birthday = birthday;
		this.profilejpg = profilejpg;
		this.ins_personal_alarm = ins_personal_alarm;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getTel1() {
		return tel1;
	}

	public void setTel1(String tel1) {
		this.tel1 = tel1;
	}

	public String getTel2() {
		return tel2;
	}

	public void setTel2(String tel2) {
		this.tel2 = tel2;
	}

	public String getTel3() {
		return tel3;
	}

	public void setTel3(String tel3) {
		this.tel3 = tel3;
	}

	public String getLeave_status() {
		return leave_status;
	}

	public void setLeave_status(String leave_status) {
		this.leave_status = leave_status;
	}

	public String getJob() {
		return job;
	}

	public void setJob(String job) {
		this.job = job;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public String getProfilejpg() {
		return profilejpg;
	}

	public void setProfilejpg(String profilejpg) {
		this.profilejpg = profilejpg;
	}

	public String getIns_personal_alarm() {
		return ins_personal_alarm;
	}

	public void setIns_personal_alarm(String ins_personal_alarm) {
		this.ins_personal_alarm = ins_personal_alarm;
	}
	
	
	
	
}
