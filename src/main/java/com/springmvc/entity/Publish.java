package com.springmvc.entity;

/**
 * Created by Molly on 18/4/25.
 */
public class Publish{
    private String userid;
    private String type;
    private String description;
    private String price;
    private String address;
    private String endDate;
    private String deposit;
    private String theme;
    private String img1;
    private String img2;
    private String img3;
    private String publishStatus;
    public Publish(String userid, String type, String description, String price, String address, String endDate,
                   String deposit, String theme, String img1, String img2, String img3,String publishStatus) {
        super();
        this.userid = userid;
        this.type = type;
        this.description = description;
        this.price = price;
        this.address = address;
        this.endDate = endDate;
        this.deposit = deposit;
        this.theme = theme;
        this.img1 = img1;
        this.img2 = img2;
        this.img3 = img3;
        this.publishStatus = publishStatus;
    }

    public Publish(){super();}
    /**
     * @return the userid
     */
    public String getUserid() {
        return userid;
    }
    /**
     * @param userid the userid to set
     */
    public void setUserid(String userid) {
        this.userid = userid;
    }
    /**
     * @return the type
     */
    public String getType() {
        return type;
    }
    /**
     * @param type the type to set
     */
    public void setType(String type) {
        this.type = type;
    }
    /**
     * @return the description
     */
    public String getDescription() {
        return description;
    }
    /**
     * @param description the description to set
     */
    public void setDescription(String description) {
        this.description = description;
    }
    /**
     * @return the price
     */
    public String getPrice() {
        return price;
    }
    /**
     * @param price the price to set
     */
    public void setPrice(String price) {
        this.price = price;
    }
    /**
     * @return the address
     */
    public String getAddress() {
        return address;
    }
    /**
     * @param address the address to set
     */
    public void setAddress(String address) {
        this.address = address;
    }
    /**
     * @return the endDate
     */
    public String getEndDate() {
        return endDate;
    }
    /**
     * @param endDate the endDate to set
     */
    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }
    /**
     * @return the deposit
     */
    public String getDeposit() {
        return deposit;
    }
    /**
     * @param deposit the deposit to set
     */
    public void setDeposit(String deposit) {
        this.deposit = deposit;
    }
    /**
     * @return the theme
     */
    public String getTheme() {
        return theme;
    }
    /**
     * @param theme the theme to set
     */
    public void setTheme(String theme) {
        this.theme = theme;
    }
    /**
     * @return the img1
     */
    public String getImg1() {
        return img1;
    }
    /**
     * @param img1 the img1 to set
     */
    public void setImg1(String img1) {
        this.img1 = img1;
    }
    /**
     * @return the img2
     */
    public String getImg2() {
        return img2;
    }
    /**
     * @param img2 the img2 to set
     */
    public void setImg2(String img2) {
        this.img2 = img2;
    }
    /**
     * @return the img3
     */
    public String getImg3() {
        return img3;
    }
    /**
     * @param img3 the img3 to set
     */
    public void setImg3(String img3) {
        this.img3 = img3;
    }
    /**
     * @return the publishStatus
     */
    public String getPublishStatus() {
        return publishStatus;
    }
    /**
     * @param publishStatus the publishStatus to set
     */
    public void setPublishStatus(String publishStatus) {
        this.publishStatus = publishStatus;
    }
}
