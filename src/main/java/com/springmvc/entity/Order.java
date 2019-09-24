package com.springmvc.entity;

/**
 * Created by Molly on 18/4/25.
 */
public class Order{
    private String applyuserid;
    private String serviceuserid;
    private String publishid;
    private String begintime;
    private String endtime;
    private String estimateReturntime;
    private String status;
    private String reason;
    private String applyuserRating;
    private String applyuserComment;
    private String serviceuserRating;
    private String serviceuserComment;
    private String flag;
    private String txpoint;



    public Order(){super();}

    //申请借商品的构造函数
    public Order(String applyuserid, String serviceuserid, String publishid,String estimateReturntime,String status, String reason) {
        super();
        this.applyuserid = applyuserid;
        this.serviceuserid = serviceuserid;
        this.publishid = publishid;
        this.estimateReturntime = estimateReturntime;
        this.status = status;
        this.reason = reason;
    }
    public Order(String applyuserid, String serviceuserid, String publishid, String begintime, String endtime,String estimateReturntime,
                 String status, String reason, String applyuserRating, String applyuserComment, String serviceuserRating,
                 String serviceuserComment,String flag,String txpoint) {
        super();
        this.applyuserid = applyuserid;
        this.serviceuserid = serviceuserid;
        this.publishid = publishid;
        this.begintime = begintime;
        this.endtime = endtime;
        this.estimateReturntime = estimateReturntime;
        this.status = status;
        this.reason = reason;
        this.applyuserRating = applyuserRating;
        this.applyuserComment = applyuserComment;
        this.serviceuserRating = serviceuserRating;
        this.serviceuserComment = serviceuserComment;
        this.flag = flag;
        this.txpoint = txpoint;
    }
    /**
     * @return the flag
     */
    public String getFlag() {
        return flag;
    }
    /**
     * @param flag the applyuserid to set
     */
    public void setFlag(String flag) {
        this.flag = flag;
    }

    /**
     * @return the txpoint
     */
    public String getTxpoint() {
        return txpoint;
    }
    /**
     * @param txpoint the applyuserid to set
     */
    public void setTxpoint(String txpoint) {
        this.txpoint = txpoint;
    }

    /**
     * @return the applyuserid
     */
    public String getApplyuserid() {
        return applyuserid;
    }
    /**
     * @param applyuserid the applyuserid to set
     */
    public void setApplyuserid(String applyuserid) {
        this.applyuserid = applyuserid;
    }
    /**
     * @return the serviceuserid
     */
    public String getServiceuserid() {
        return serviceuserid;
    }
    /**
     * @param serviceuserid the serviceuserid to set
     */
    public void setServiceuserid(String serviceuserid) {
        this.serviceuserid = serviceuserid;
    }
    /**
     * @return the publishid
     */
    public String getPublishid() {
        return publishid;
    }
    /**
     * @param publishid the publishid to set
     */
    public void setPublishid(String publishid) {
        this.publishid = publishid;
    }
    /**
     * @return the begintime
     */
    public String getBegintime() {
        return begintime;
    }
    /**
     * @param begintime the begintime to set
     */
    public void setBegintime(String begintime) {
        this.begintime = begintime;
    }
    /**
     * @return the endtime
     */
    public String getEndtime() {
        return endtime;
    }
    /**
     * @param endtime the endtime to set
     */
    public void setEndtime(String endtime) {
        this.endtime = endtime;
    }
    /**
     * @return the status
     */
    public String getStatus() {
        return status;
    }
    /**
     * @param status the status to set
     */
    public void setStatus(String status) {
        this.status = status;
    }
    /**
     * @return the reason
     */
    public String getReason() {
        return reason;
    }
    /**
     * @param reason the reason to set
     */
    public void setReason(String reason) {
        this.reason = reason;
    }
    /**
     * @return the applyuserRating
     */
    public String getApplyuserRating() {
        return applyuserRating;
    }
    /**
     * @param applyuserRating the applyuserRating to set
     */
    public void setApplyuserRating(String applyuserRating) {
        this.applyuserRating = applyuserRating;
    }
    /**
     * @return the applyuserComment
     */
    public String getApplyuserComment() {
        return applyuserComment;
    }
    /**
     * @param applyuserComment the applyuserComment to set
     */
    public void setApplyuserComment(String applyuserComment) {
        this.applyuserComment = applyuserComment;
    }
    /**
     * @return the serviceuserRating
     */
    public String getServiceuserRating() {
        return serviceuserRating;
    }
    /**
     * @param serviceuserRating the serviceuserRating to set
     */
    public void setServiceuserRating(String serviceuserRating) {
        this.serviceuserRating = serviceuserRating;
    }
    /**
     * @return the serviceuserComment
     */
    public String getServiceuserComment() {
        return serviceuserComment;
    }
    /**
     * @param serviceuserComment the serviceuserComment to set
     */
    public void setServiceuserComment(String serviceuserComment) {
        this.serviceuserComment = serviceuserComment;
    }
    /**
     * @return the estimateReturntime
     */
    public String getEstimateReturntime() {
        return estimateReturntime;
    }
    /**
     * @param estimateReturntime the estimateReturntime to set
     */
    public void setEstimateReturntime(String estimateReturntime) {
        this.estimateReturntime = estimateReturntime;
    }
}
