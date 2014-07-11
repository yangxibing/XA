package com.model;

import java.util.Date;

public class BiddingExpert {
	private String expertId;
	private String expertName;
	private String birthday;
	private String workUnit;
	private String title;
	private String personalProfile;
	private String photograph;
		private String photographFileName;
		private String photographContentType;
	private String telephone;
	private String fax;
	private String email;
	private String website;
	private Integer minAge;
	private Integer maxAge;
	private Date beginDate;
	private Date endDate;
	private Boolean changePhotoTag;
	public static final String updatePath="images/BiddingExpert/";
	
	public String getExpertId() {
		return expertId;
	}
	public void setExpertId(String expertId) {
		this.expertId = expertId;
	}
	public String getExpertName() {
		return expertName;
	}
	public void setExpertName(String expertName) {
		this.expertName = expertName;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getWorkUnit() {
		return workUnit;
	}
	public void setWorkUnit(String workUnit) {
		this.workUnit = workUnit;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getPersonalProfile() {
		return personalProfile;
	}
	public void setPersonalProfile(String personalProfile) {
		this.personalProfile = personalProfile;
	}
	public String getPhotograph() {
		return photograph;
	}
	public void setPhotograph(String photograph) {
		this.photograph = photograph;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public String getFax() {
		return fax;
	}
	public void setFax(String fax) {
		this.fax = fax;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getWebsite() {
		return website;
	}
	public void setWebsite(String website) {
		this.website = website;
	}
	public Integer getMinAge() {
		return minAge;
	}
	public void setMinAge(Integer minAge) {
		this.minAge = minAge;
	}
	public Integer getMaxAge() {
		return maxAge;
	}
	public void setMaxAge(Integer maxAge) {
		this.maxAge = maxAge;
	}
	public Date getBeginDate() {
		return beginDate;
	}
	public void setBeginDate(Date beginDate) {
		this.beginDate = beginDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public Boolean getChangePhotoTag() {
		return changePhotoTag;
	}
	public void setChangePhotoTag(Boolean changePhotoTag) {
		this.changePhotoTag = changePhotoTag;
	}
	public static String getUpdatepath() {
		return updatePath;
	}
	public String getPhotographFileName() {
		return photographFileName;
	}
	public void setPhotographFileName(String photographFileName) {
		this.photographFileName = photographFileName;
	}
	public String getPhotographContentType() {
		return photographContentType;
	}
	public void setPhotographContentType(String photographContentType) {
		this.photographContentType = photographContentType;
	}
}
