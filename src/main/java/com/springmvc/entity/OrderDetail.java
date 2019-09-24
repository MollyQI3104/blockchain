package com.springmvc.entity;

/**
 * Created by Molly on 18/4/25.
 */
public class OrderDetail {

    private User applyuser;
    private User serviceuser;
    private Order order;
    private Publish publish;

    public OrderDetail(User applyuser, User serviceuser, Publish publish ,Order order) {
        super();

        this.applyuser = applyuser;
        this.serviceuser = serviceuser;
        this.publish = publish;
        this.order = order;

    }

    public OrderDetail() {
        super();
    }

    /**
     * @return the user
     */
    public User getApplyUser() {
        return applyuser;
    }

    /**
     * @param applyuser
     */
    public void setApplyUser(User applyuser) {
        this.applyuser = applyuser;
    }

    /**
     * @return the user
     */
    public User getServiceUser() {
        return serviceuser;
    }

    /**
     * @param serviceuser
     */
    public void setServiceUser(User serviceuser) {
        this.serviceuser = serviceuser;
    }


    /**
     * @return the order
     */
    public Order getOrder() {
        return order;
    }

    /**
     * @param order
     */
    public void setOrder(Order order) {
        this.order = order;
    }

    /**
     * @return the publish
     */
    public Publish getPublish() {
        return publish;
    }

    /**
     * @param publish
     */
    public void setPublish(Publish publish) {
        this.publish = publish;
    }


}
