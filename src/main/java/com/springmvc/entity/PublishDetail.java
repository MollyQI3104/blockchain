package com.springmvc.entity;

/**
 * Created by Molly on 18/4/25.
 */
public class PublishDetail {

    private User user;
    private Publish publish;

    public PublishDetail(User user, Publish publish) {
        super();

        this.user = user;
        this.publish = publish;

    }

    public PublishDetail() {
        super();
    }

    /**
     * @return the user
     */
    public User getUser() {
        return user;
    }

    /**
     * @param user the userid to set
     */
    public void setUser(User user) {
        this.user = user;
    }

    /**
     * @return the publish
     */
    public Publish getPublish() {
        return publish;
    }

    /**
     * @param publish the userid to set
     */
    public void setPublish(Publish publish) {
        this.publish = publish;
    }


}
