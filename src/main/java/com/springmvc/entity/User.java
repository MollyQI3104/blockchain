package com.springmvc.entity;

/**
 * 用户实体类.
 */
public class User{
	private String name;
	private String wechat;
	private String openid;
	private String point;
	private String evaluation;
	private String times;
	private String myfavorid;
	private String mypublish;
	private String needConfirm;
	private String needSerShare;
	private String needSerPay;
	private String publishfinish;
	private String myapply;
	private String needAppshare;
	private String needAppPay;
	private String applyfinish;
	private String headImage;
	private String frozenPoint;//已经冻结的积分
	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}
	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}
	/**
	 * @return the wechat
	 */
	public String getWechat() {
		return wechat;
	}
	/**
	 * @param wechat the wechat to set
	 */
	public void setWechat(String wechat) {
		this.wechat = wechat;
	}
	/**
	 * @return the openid
	 */
	public String getOpenid() {
		return openid;
	}
	/**
	 * @param openid the openid to set
	 */
	public void setOpenid(String openid) {
		this.openid = openid;
	}
	/**
	 * @return the point
	 */
	public String getPoint() {
		return point;
	}
	/**
	 * @param point the point to set
	 */
	public void setPoint(String point) {
		this.point = point;
	}
	/**
	 * @return the evaluation
	 */
	public String getEvaluation() {
		return evaluation;
	}
	/**
	 * @param evaluation the evaluation to set
	 */
	public void setEvaluation(String evaluation) {
		this.evaluation = evaluation;
	}
	/**
	 * @return the times
	 */
	public String getTimes() {
		return times;
	}
	/**
	 * @param times the times to set
	 */
	public void setTimes(String times) {
		this.times = times;
	}
	/**
	 * @return the myfavorid
	 */
	public String getMyfavorid() {
		return myfavorid;
	}
	/**
	 * @param myfavorid the myfavorid to set
	 */
	public void setMyfavorid(String myfavorid) {
		this.myfavorid = myfavorid;
	}
	/**
	 * @return the mypublish
	 */
	public String getMypublish() {
		return mypublish;
	}
	/**
	 * @param mypublish the mypublish to set
	 */
	public void setMypublish(String mypublish) {
		this.mypublish = mypublish;
	}
	/**
	 * @return the needConfirm
	 */
	public String getNeedConfirm() {
		return needConfirm;
	}
	/**
	 * @param needConfirm the needConfirm to set
	 */
	public void setNeedConfirm(String needConfirm) {
		this.needConfirm = needConfirm;
	}
	/**
	 * @return the needShare
	 */

	/**
	 * @return the needSerPay
	 */
	public String getNeedSerPay() {
		return needSerPay;
	}
	/**
	 * @param needSerPay the needSerPay to set
	 */
	public void setNeedSerPay(String needSerPay) {
		this.needSerPay = needSerPay;
	}
	/**
	 * @return the publishfinish
	 */
	public String getPublishfinish() {
		return publishfinish;
	}
	/**
	 * @param publishfinish the publishfinish to set
	 */
	public void setPublishfinish(String publishfinish) {
		this.publishfinish = publishfinish;
	}
	/**
	 * @return the myapply
	 */
	public String getMyapply() {
		return myapply;
	}
	/**
	 * @param myapply the myapply to set
	 */
	public void setMyapply(String myapply) {
		this.myapply = myapply;
	}
	/**
	 * @return the needshare
	 */

	/**
	 * @return the needAppPay
	 */
	public String getNeedAppPay() {
		return needAppPay;
	}
	/**
	 * @param needAppPay the needAppPay to set
	 */
	public void setNeedAppPay(String needAppPay) {
		this.needAppPay = needAppPay;
	}
	/**
	 * @return the applyfinish
	 */
	public String getApplyfinish() {
		return applyfinish;
	}
	/**
	 * @param applyfinish the applyfinish to set
	 */
	public void setApplyfinish(String applyfinish) {
		this.applyfinish = applyfinish;
	}
	/**
	 * @return the needSerShare
	 */
	public String getNeedSerShare() {
		return needSerShare;
	}
	/**
	 * @param needSerShare the needSerShare to set
	 */
	public void setNeedSerShare(String needSerShare) {
		this.needSerShare = needSerShare;
	}
	/**
	 * @return the needAppshare
	 */
	public String getNeedAppshare() {
		return needAppshare;
	}
	/**
	 * @param needAppshare the needAppshare to set
	 */
	public void setNeedAppshare(String needAppshare) {
		this.needAppshare = needAppshare;
	}
	public User(String name, String wechat, String openid, String point, String evaluation, String times,
				String myfavorid) {
		super();
		this.name = name;
		this.wechat = wechat;
		this.openid = openid;
		this.point = point;
		this.evaluation = evaluation;
		this.times = times;
		this.myfavorid = myfavorid;
	}
	public User(String name, String wechat, String openid, String point, String evaluation, String times,
				String myfavorid, String mypublish, String needConfirm, String needSerShare, String needSerPay,
				String publishfinish, String myapply, String needAppshare, String needAppPay, String applyfinish,
				String headImage,String frozenPoint) {
		super();
		this.name = name;
		this.wechat = wechat;
		this.openid = openid;
		this.point = point;
		this.evaluation = evaluation;
		this.times = times;
		this.myfavorid = myfavorid;
		this.mypublish = mypublish;
		this.needConfirm = needConfirm;
		this.needSerShare = needSerShare;
		this.needSerPay = needSerPay;
		this.publishfinish = publishfinish;
		this.myapply = myapply;
		this.needAppshare = needAppshare;
		this.needAppPay = needAppPay;
		this.applyfinish = applyfinish;
		this.headImage=headImage;
		this.frozenPoint=frozenPoint;
	}

	public User(){};
	/**
	 * @return the headImage
	 */
	public String getHeadImage() {
		return headImage;
	}
	/**
	 * @param headImage the headImage to set
	 */
	public void setHeadImage(String headImage) {
		this.headImage = headImage;
	}
	/**
	 * @return the frozenPoint
	 */
	public String getFrozenPoint() {
		return frozenPoint;
	}
	/**
	 * @param frozenPoint the frozenPoint to set
	 */
	public void setFrozenPoint(String frozenPoint) {
		this.frozenPoint = frozenPoint;
	}
}
