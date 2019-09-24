package com.springmvc.controller;


import com.alibaba.fastjson.JSONObject;
import com.springmvc.entity.*;

import com.springmvc.utils.*;
import com.springmvc.util.MD5Util;
import com.springmvc.weixin.util.VerificationMessageSend;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
public class UserController {

    private User getCurrentUser(HttpServletRequest request) {

        HttpSession session = request.getSession();
        String openid =  (String) session.getAttribute("openid");

        User userEntity = new User();
        //openid
        Connection conn = null;
        try {
            conn = DbControl.getConnection();
            Statement st = conn.createStatement();
            //根据openid搜索
            String userid = openid;
            ResultSet rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'showMyHomepage\',\'" + userid + "\')");

                while (rs.next()) {
                    System.out.println(rs.getString("message"));
                    String strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                    JSONObject object=JSONObject.parseObject(strPublish.trim());
                    System.out.println(object.getString("StatusCode"));
                    userEntity =JSONObject.parseObject(object.getString("SuccessMsg").trim(),User.class);
                    System.out.println(userEntity.getName());

                }

            DbControl.closeConnection(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (userEntity != null)
            return userEntity;
        else return null;


    }


    // 添加收藏请求接口
    @RequestMapping(value = "/setfavor", method = RequestMethod.POST)
    @ResponseBody
    public String userFavor(ModelMap map, HttpServletRequest request,@RequestParam String publishID) {

        String status = "fail";

        Connection conn = null;
        try {
            conn = DbControl.getConnection();
            Statement st = conn.createStatement();

            HttpSession session = request.getSession();
            String openid =  (String) session.getAttribute("openid");

            String publishid=publishID;
            ResultSet rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'myfavor\',\'" + openid + "\',\'" + publishid + "\')");
            while (rs.next()) {
                System.out.println(rs.getString("message"));
                JSONObject object=JSONObject.parseObject(rs.getString("message").trim());
                if(object.getString("SuccessMsg").trim().equals("success"))
                    status = "ok";

            }
            DbControl.closeConnection(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    // 查看是否已收藏请求接口
    @RequestMapping(value = "/isfavor", method = RequestMethod.POST)
    @ResponseBody
    public String isFavor(ModelMap map, HttpServletRequest request,@RequestParam String publishID) {

        String status = "no";
        ArrayList<Publish> list=new ArrayList<Publish>();

        Connection conn = null;
        try {
            conn = DbControl.getConnection();
            Statement st = conn.createStatement();
            HttpSession session = request.getSession();
            String openid =  (String) session.getAttribute("openid");

            ResultSet rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'showMyfavor\',\'" + openid + "\')");
            while (rs.next()) {

                String strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                System.out.println(strPublish);

                JSONObject object=JSONObject.parseObject(strPublish.trim());
                System.out.println(object);
                System.out.println(object.getString("StatusCode"));
                JSONObject object2=JSONObject.parseObject(object.getString("SuccessMsg"));
                System.out.println(object2.getString("Number"));

                System.out.println(object2.getString("Records").trim());
                list=(ArrayList<Publish>) JSONObject.parseArray(object2.getString("Records").trim(),Publish.class);

                System.out.println(list.size());

                for (int i = 0; i < list.size(); i++) {

                    if(publishID.equals(list.get(i).getPublishStatus()))
                    {
                        status = "yes";
                        break;
                    }
                }

            }
            DbControl.closeConnection(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }


    // 取消收藏请求接口
    @RequestMapping(value = "/deletefavor", method = RequestMethod.POST)
    @ResponseBody
    public String deleteFavor(ModelMap map, HttpServletRequest request,@RequestParam String publishID) {

        String status = "fail";

        Connection conn = null;
        try {
            conn = DbControl.getConnection();
            Statement st = conn.createStatement();
            HttpSession session = request.getSession();
            String openid =  (String) session.getAttribute("openid");

            String publishid=publishID;
            ResultSet rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'removeMyfavor\',\'" + openid + "\',\'" + publishid + "\')");
            while (rs.next()) {
                System.out.println(rs.getString("message"));
                JSONObject object=JSONObject.parseObject(rs.getString("message").trim());
                if(object.getString("SuccessMsg").trim().equals("success"))
                    status = "ok";
            }
            DbControl.closeConnection(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String userPage(ModelMap map,HttpServletRequest request) {
        User userEntity = getCurrentUser(request);
        map.addAttribute("user", userEntity);
        return "userinfo";
    }

    //查看个人信息
    @RequestMapping(value = "/userdetail",method = RequestMethod.GET)
    public String userdetail(ModelMap map,HttpServletRequest request){
        User user = getCurrentUser(request);

        map.addAttribute("user",user);
        return "userdetail";
    }

    //发布者
    //查询用户发布服务的接口：待确认
    @RequestMapping(value = "/queryPublishWaitingConfirm",method = RequestMethod.GET)
    public String queryPublishWaitingConfirm(ModelMap map,HttpServletRequest request){

        ArrayList<Order> list=new ArrayList<Order>();
        ArrayList<OrderDetail> Detaillist= new ArrayList<OrderDetail>();
        User applyuser = new User();
        User serviceuser = new User();
        Publish publish = new Publish();

        String strPublish;

        Connection conn = null;
        try {
            conn = DbControl.getConnection();
            Statement st = conn.createStatement();

            HttpSession session = request.getSession();
            String openid =  (String) session.getAttribute("openid");

            String showType="needConfirm";
            ResultSet rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'show\',\'" + openid + "\',\'" + showType + "\')");
            while (rs.next()) {
                System.out.println(rs.getString("message"));

                strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                System.out.println(strPublish);

                JSONObject object=JSONObject.parseObject(strPublish.trim());
                System.out.println(object);
                System.out.println(object.getString("StatusCode"));
                JSONObject object2=JSONObject.parseObject(object.getString("SuccessMsg"));
                System.out.println(object2.getString("Number"));

                System.out.println(object2.getString("Records").trim());
                list=(ArrayList<Order>) JSONObject.parseArray(object2.getString("Records").trim(),Order.class);

                System.out.println(list.size());


                for (int i = 0; i < list.size(); i++) {

                    //搜申请者
                    rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'showMyHomepage\',\'" + list.get(i).getApplyuserid() + "\')");

                    while (rs.next()) {
                        System.out.println(rs.getString("message"));
                        strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                        JSONObject user_object=JSONObject.parseObject(strPublish.trim());
                        applyuser =JSONObject.parseObject(user_object.getString("SuccessMsg").trim(),User.class);

                    }


                    //搜发布者
                    rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'showMyHomepage\',\'" + list.get(i).getServiceuserid() + "\')");

                    while (rs.next()) {
                        System.out.println(rs.getString("message"));
                        strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                        JSONObject user_object=JSONObject.parseObject(strPublish.trim());
                        serviceuser =JSONObject.parseObject(user_object.getString("SuccessMsg").trim(),User.class);

                    }

                    //搜商品
                    rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'queryByPublishID\',\'" +list.get(i).getPublishid()+ "\')");
                    while (rs.next()) {
                        System.out.println(rs.getString("message"));
                        strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                        JSONObject publish_object=JSONObject.parseObject(strPublish.trim());
                        System.out.println(publish_object.getString("StatusCode"));
                        publish =JSONObject.parseObject(publish_object.getString("SuccessMsg").trim(),Publish.class);

                    }


                    OrderDetail orderDetail = new OrderDetail(applyuser,serviceuser,publish,list.get(i));
                    Detaillist.add(orderDetail);
                }

            }
            DbControl.closeConnection(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }


        map.addAttribute("recordDetailList", Detaillist);
        return "service_posted_queren";
    }

    //查询用户发布服务的接口：待分享
    @RequestMapping(value = "/queryPublishWaitingService",method = RequestMethod.GET)
    public String queryPublishWaitingService(ModelMap map,HttpServletRequest request){

        ArrayList<Order> list=new ArrayList<Order>();
        ArrayList<OrderDetail> Detaillist= new ArrayList<OrderDetail>();
        User applyuser = new User();
        User serviceuser = new User();
        Publish publish = new Publish();

        String strPublish;

        Connection conn = null;
        try {
            conn = DbControl.getConnection();
            Statement st = conn.createStatement();
            //String userid= getCurrentUser().getOpenid();
            HttpSession session = request.getSession();
            String openid =  (String) session.getAttribute("openid");

            String showType="needSerShare";
            ResultSet rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'show\',\'" + openid + "\',\'" + showType + "\')");
            while (rs.next()) {

                strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                System.out.println(strPublish);

                JSONObject object=JSONObject.parseObject(strPublish.trim());
                System.out.println(object);
                System.out.println(object.getString("StatusCode"));
                JSONObject object2=JSONObject.parseObject(object.getString("SuccessMsg"));
                System.out.println(object2.getString("Number"));

                System.out.println(object2.getString("Records").trim());
                list=(ArrayList<Order>) JSONObject.parseArray(object2.getString("Records").trim(),Order.class);

                System.out.println(list.size());


                for (int i = 0; i < list.size(); i++) {

                    //搜申请者
                    rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'showMyHomepage\',\'" + list.get(i).getApplyuserid() + "\')");

                    while (rs.next()) {
                        System.out.println(rs.getString("message"));
                        strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                        JSONObject user_object=JSONObject.parseObject(strPublish.trim());
                        applyuser =JSONObject.parseObject(user_object.getString("SuccessMsg").trim(),User.class);

                    }


                    //搜发布者
                    rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'showMyHomepage\',\'" + list.get(i).getServiceuserid() + "\')");

                    while (rs.next()) {
                        System.out.println(rs.getString("message"));
                        strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                        JSONObject user_object=JSONObject.parseObject(strPublish.trim());
                        serviceuser =JSONObject.parseObject(user_object.getString("SuccessMsg").trim(),User.class);

                    }

                    //搜商品
                    rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'queryByPublishID\',\'" +list.get(i).getPublishid()+ "\')");
                    while (rs.next()) {
                        System.out.println(rs.getString("message"));
                        strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                        JSONObject publish_object=JSONObject.parseObject(strPublish.trim());
                        System.out.println(publish_object.getString("StatusCode"));
                        publish =JSONObject.parseObject(publish_object.getString("SuccessMsg").trim(),Publish.class);

                    }


                    OrderDetail orderDetail = new OrderDetail(applyuser,serviceuser,publish,list.get(i));
                    Detaillist.add(orderDetail);
                }

            }
            DbControl.closeConnection(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }


        map.addAttribute("recordDetailList", Detaillist);
        return "service_posted_fuwu";
    }
    //查询用户发布服务的接口：待结算
    @RequestMapping(value = "/queryPublishWaitingCollect",method = RequestMethod.GET)
    public String queryPublishWaitingCollect(ModelMap map,HttpServletRequest request){

        ArrayList<Order> list=new ArrayList<Order>();
        ArrayList<OrderDetail> Detaillist= new ArrayList<OrderDetail>();
        User applyuser = new User();
        User serviceuser = new User();
        Publish publish = new Publish();

        String strPublish;

        Connection conn = null;
        try {
            conn = DbControl.getConnection();
            Statement st = conn.createStatement();
            //String userid= getCurrentUser().getOpenid();
            //String userid = "IDIDID";

            HttpSession session = request.getSession();
            String openid =  (String) session.getAttribute("openid");

            String showType="needSerPay";
            ResultSet rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'show\',\'" + openid + "\',\'" + showType + "\')");
            while (rs.next()) {
                System.out.println(rs.getString("message"));

                strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                System.out.println(strPublish);

                JSONObject object=JSONObject.parseObject(strPublish.trim());
                System.out.println(object);
                System.out.println(object.getString("StatusCode"));
                JSONObject object2=JSONObject.parseObject(object.getString("SuccessMsg"));
                System.out.println(object2.getString("Number"));

                System.out.println(object2.getString("Records").trim());
                list=(ArrayList<Order>) JSONObject.parseArray(object2.getString("Records").trim(),Order.class);

                System.out.println(list.size());


                for (int i = 0; i < list.size(); i++) {

                    //搜申请者
                    rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'showMyHomepage\',\'" + list.get(i).getApplyuserid() + "\')");

                    while (rs.next()) {
                        System.out.println(rs.getString("message"));
                        strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                        JSONObject user_object=JSONObject.parseObject(strPublish.trim());
                        applyuser =JSONObject.parseObject(user_object.getString("SuccessMsg").trim(),User.class);

                    }


                    //搜发布者
                    rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'showMyHomepage\',\'" + list.get(i).getServiceuserid() + "\')");

                    while (rs.next()) {
                        System.out.println(rs.getString("message"));
                        strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                        JSONObject user_object=JSONObject.parseObject(strPublish.trim());
                        serviceuser =JSONObject.parseObject(user_object.getString("SuccessMsg").trim(),User.class);

                    }

                    //搜商品
                    rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'queryByPublishID\',\'" +list.get(i).getPublishid()+ "\')");
                    while (rs.next()) {
                        System.out.println(rs.getString("message"));
                        strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                        JSONObject publish_object=JSONObject.parseObject(strPublish.trim());
                        System.out.println(publish_object.getString("StatusCode"));
                        publish =JSONObject.parseObject(publish_object.getString("SuccessMsg").trim(),Publish.class);

                    }


                    OrderDetail orderDetail = new OrderDetail(applyuser,serviceuser,publish,list.get(i));
                    Detaillist.add(orderDetail);
                }

            }
            DbControl.closeConnection(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }

        map.addAttribute("recordDetailList", Detaillist);
        return "service_posted_zhifu";
    }

    //查询用户发布服务的接口：已完成
    @RequestMapping(value = "/queryPublishAlreadyComplete",method = RequestMethod.GET)
    public String queryPublishAlreadyComplete(ModelMap map,HttpServletRequest request){
        ArrayList<Order> list=new ArrayList<Order>();
        ArrayList<OrderDetail> Detaillist= new ArrayList<OrderDetail>();
        User applyuser = new User();
        User serviceuser = new User();
        Publish publish = new Publish();

        String strPublish;

        Connection conn = null;
        try {
            conn = DbControl.getConnection();
            Statement st = conn.createStatement();
            //String userid= getCurrentUser().getOpenid();
            //String userid = "IDIDID";
            HttpSession session = request.getSession();
            String openid =  (String) session.getAttribute("openid");

            String showType="publishfinish";
            ResultSet rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'show\',\'" + openid + "\',\'" + showType + "\')");
            while (rs.next()) {
                System.out.println(rs.getString("message"));

                strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                System.out.println(strPublish);

                JSONObject object=JSONObject.parseObject(strPublish.trim());
                System.out.println(object);
                System.out.println(object.getString("StatusCode"));
                JSONObject object2=JSONObject.parseObject(object.getString("SuccessMsg"));
                System.out.println(object2.getString("Number"));

                System.out.println(object2.getString("Records").trim());
                list=(ArrayList<Order>) JSONObject.parseArray(object2.getString("Records").trim(),Order.class);

                System.out.println(list.size());


                for (int i = 0; i < list.size(); i++) {

                    //搜申请者
                    rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'showMyHomepage\',\'" + list.get(i).getApplyuserid() + "\')");

                    while (rs.next()) {
                        System.out.println(rs.getString("message"));
                        strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                        JSONObject user_object=JSONObject.parseObject(strPublish.trim());
                        applyuser =JSONObject.parseObject(user_object.getString("SuccessMsg").trim(),User.class);

                    }


                    //搜发布者
                    rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'showMyHomepage\',\'" + list.get(i).getServiceuserid() + "\')");

                    while (rs.next()) {
                        System.out.println(rs.getString("message"));
                        strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                        JSONObject user_object=JSONObject.parseObject(strPublish.trim());
                        serviceuser =JSONObject.parseObject(user_object.getString("SuccessMsg").trim(),User.class);

                    }

                    //搜商品
                    rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'queryByPublishID\',\'" +list.get(i).getPublishid()+ "\')");
                    while (rs.next()) {
                        System.out.println(rs.getString("message"));
                        strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                        JSONObject publish_object=JSONObject.parseObject(strPublish.trim());
                        System.out.println(publish_object.getString("StatusCode"));
                        publish =JSONObject.parseObject(publish_object.getString("SuccessMsg").trim(),Publish.class);

                    }


                    OrderDetail orderDetail = new OrderDetail(applyuser,serviceuser,publish,list.get(i));
                    Detaillist.add(orderDetail);
                }

            }
            DbControl.closeConnection(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }

        map.addAttribute("recordDetailList", Detaillist);

        return "service_posted_wancheng";
    }



    //申请者
    //查询用户申请订单的接口：已申请
    @RequestMapping(value = "/queryOrderAlreadyApply",method = RequestMethod.GET)
    public String queryAlreadyApplyOrder(ModelMap map,HttpServletRequest request){

        ArrayList<Order> list=new ArrayList<Order>();
        ArrayList<OrderDetail> Detaillist= new ArrayList<OrderDetail>();
        User applyuser = new User();
        User serviceuser = new User();
        Publish publish = new Publish();

        String strPublish;

        Connection conn = null;
        try {
            conn = DbControl.getConnection();
            Statement st = conn.createStatement();
            // String userid= getCurrentUser().getOpenid();
            HttpSession session = request.getSession();
            String openid =  (String) session.getAttribute("openid");

            String showType="myapply";
            ResultSet rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'show\',\'" + openid + "\',\'" + showType + "\')");
            while (rs.next()) {
                System.out.println(rs.getString("message"));

                strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");

                JSONObject object=JSONObject.parseObject(strPublish.trim());

                JSONObject object2=JSONObject.parseObject(object.getString("SuccessMsg"));


                System.out.println(object2.getString("Records").trim());
                list=(ArrayList<Order>) JSONObject.parseArray(object2.getString("Records").trim(),Order.class);

                System.out.println(list.size());


                for (int i = 0; i < list.size(); i++) {

                    //搜申请者
                    rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'showMyHomepage\',\'" + list.get(i).getApplyuserid() + "\')");

                    while (rs.next()) {
                        System.out.println(rs.getString("message"));
                        strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                        JSONObject user_object=JSONObject.parseObject(strPublish.trim());
                        applyuser =JSONObject.parseObject(user_object.getString("SuccessMsg").trim(),User.class);

                    }


                    //搜发布者
                    rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'showMyHomepage\',\'" + list.get(i).getServiceuserid() + "\')");

                    while (rs.next()) {
                        System.out.println(rs.getString("message"));
                        strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                        JSONObject user_object=JSONObject.parseObject(strPublish.trim());
                        serviceuser =JSONObject.parseObject(user_object.getString("SuccessMsg").trim(),User.class);

                    }

                    //搜商品
                    rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'queryByPublishID\',\'" +list.get(i).getPublishid()+ "\')");
                    while (rs.next()) {
                        System.out.println(rs.getString("message"));
                        strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                        JSONObject publish_object=JSONObject.parseObject(strPublish.trim());
                        System.out.println(publish_object.getString("StatusCode"));
                        publish =JSONObject.parseObject(publish_object.getString("SuccessMsg").trim(),Publish.class);

                    }


                    OrderDetail orderDetail = new OrderDetail(applyuser,serviceuser,publish,list.get(i));
                    Detaillist.add(orderDetail);
                }

            }
            DbControl.closeConnection(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }

        map.addAttribute("recordDetailList", Detaillist);
        return "service_requested_yuyue";
    }

    //查询用户申请订单的接口：待分享
    @RequestMapping(value = "/queryOrderWaitingService",method = RequestMethod.GET)
    public String queryWaitingServiceOrder(ModelMap map,HttpServletRequest request){

        ArrayList<Order> list=new ArrayList<Order>();
        ArrayList<OrderDetail> Detaillist= new ArrayList<OrderDetail>();
        User applyuser = new User();
        User serviceuser = new User();
        Publish publish = new Publish();

        String strPublish;

        Connection conn = null;
        try {
            conn = DbControl.getConnection();
            Statement st = conn.createStatement();
            // String userid= getCurrentUser().getOpenid();
            HttpSession session = request.getSession();
            String openid =  (String) session.getAttribute("openid");

            String showType="needAppshare";
            ResultSet rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'show\',\'" + openid + "\',\'" + showType + "\')");
            while (rs.next()) {
                System.out.println(rs.getString("message"));

                strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");

                JSONObject object=JSONObject.parseObject(strPublish.trim());

                JSONObject object2=JSONObject.parseObject(object.getString("SuccessMsg"));


                System.out.println(object2.getString("Records").trim());
                list=(ArrayList<Order>) JSONObject.parseArray(object2.getString("Records").trim(),Order.class);

                System.out.println(list.size());


                for (int i = 0; i < list.size(); i++) {

                    //搜申请者
                    rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'showMyHomepage\',\'" + list.get(i).getApplyuserid() + "\')");

                    while (rs.next()) {
                        System.out.println(rs.getString("message"));
                        strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                        JSONObject user_object=JSONObject.parseObject(strPublish.trim());
                        applyuser =JSONObject.parseObject(user_object.getString("SuccessMsg").trim(),User.class);

                    }


                    //搜发布者
                    rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'showMyHomepage\',\'" + list.get(i).getServiceuserid() + "\')");

                    while (rs.next()) {
                        System.out.println(rs.getString("message"));
                        strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                        JSONObject user_object=JSONObject.parseObject(strPublish.trim());
                        serviceuser =JSONObject.parseObject(user_object.getString("SuccessMsg").trim(),User.class);

                    }

                    //搜商品
                    rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'queryByPublishID\',\'" +list.get(i).getPublishid()+ "\')");
                    while (rs.next()) {
                        System.out.println(rs.getString("message"));
                        strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                        JSONObject publish_object=JSONObject.parseObject(strPublish.trim());
                        System.out.println(publish_object.getString("StatusCode"));
                        publish =JSONObject.parseObject(publish_object.getString("SuccessMsg").trim(),Publish.class);

                    }


                    OrderDetail orderDetail = new OrderDetail(applyuser,serviceuser,publish,list.get(i));
                    Detaillist.add(orderDetail);
                }

            }
            DbControl.closeConnection(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }

        map.addAttribute("recordDetailList", Detaillist);
        return "service_requested_shangmen";
    }

    //查询用户申请订单的接口：待结算
    @RequestMapping(value = "/queryOrderWaitingPay",method = RequestMethod.GET)
    public String queryWaitingPayOrder(ModelMap map,HttpServletRequest request){
        ArrayList<Order> list=new ArrayList<Order>();
        ArrayList<OrderDetail> Detaillist= new ArrayList<OrderDetail>();
        User applyuser = new User();
        User serviceuser = new User();
        Publish publish = new Publish();

        String strPublish;

        Connection conn = null;
        try {
            conn = DbControl.getConnection();
            Statement st = conn.createStatement();
            //String userid= getCurrentUser().getOpenid();
            //String userid = "IDIDID";

            HttpSession session = request.getSession();
            String openid =  (String) session.getAttribute("openid");

            String showType="needAppPay";
            ResultSet rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'show\',\'" + openid + "\',\'" + showType + "\')");
            while (rs.next()) {
                System.out.println(rs.getString("message"));

                strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                System.out.println(strPublish);

                JSONObject object=JSONObject.parseObject(strPublish.trim());
                System.out.println(object);
                System.out.println(object.getString("StatusCode"));
                JSONObject object2=JSONObject.parseObject(object.getString("SuccessMsg"));
                System.out.println(object2.getString("Number"));

                System.out.println(object2.getString("Records").trim());
                list=(ArrayList<Order>) JSONObject.parseArray(object2.getString("Records").trim(),Order.class);

                System.out.println(list.size());


                for (int i = 0; i < list.size(); i++) {

                    //搜申请者
                    rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'showMyHomepage\',\'" + list.get(i).getApplyuserid() + "\')");

                    while (rs.next()) {
                        System.out.println(rs.getString("message"));
                        strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                        JSONObject user_object=JSONObject.parseObject(strPublish.trim());
                        applyuser =JSONObject.parseObject(user_object.getString("SuccessMsg").trim(),User.class);

                    }


                    //搜发布者
                    rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'showMyHomepage\',\'" + list.get(i).getServiceuserid() + "\')");

                    while (rs.next()) {
                        System.out.println(rs.getString("message"));
                        strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                        JSONObject user_object=JSONObject.parseObject(strPublish.trim());
                        serviceuser =JSONObject.parseObject(user_object.getString("SuccessMsg").trim(),User.class);

                    }

                    //搜商品
                    rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'queryByPublishID\',\'" +list.get(i).getPublishid()+ "\')");
                    while (rs.next()) {
                        System.out.println(rs.getString("message"));
                        strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                        JSONObject publish_object=JSONObject.parseObject(strPublish.trim());
                        System.out.println(publish_object.getString("StatusCode"));
                        publish =JSONObject.parseObject(publish_object.getString("SuccessMsg").trim(),Publish.class);

                    }


                    OrderDetail orderDetail = new OrderDetail(applyuser,serviceuser,publish,list.get(i));
                    Detaillist.add(orderDetail);
                }

            }
            DbControl.closeConnection(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }

        map.addAttribute("recordDetailList", Detaillist);
        return "service_requested_fukuan";
    }

    //查询用户申请订单的接口：已完成
    @RequestMapping(value = "/queryOrderAlreadyComplete",method = RequestMethod.GET)
    public String queryAlreadyCompleteOrder(ModelMap map,HttpServletRequest request){
        ArrayList<Order> list=new ArrayList<Order>();
        ArrayList<OrderDetail> Detaillist= new ArrayList<OrderDetail>();
        User applyuser = new User();
        User serviceuser = new User();
        Publish publish = new Publish();

        String strPublish;

        Connection conn = null;
        try {
            conn = DbControl.getConnection();
            Statement st = conn.createStatement();

            HttpSession session = request.getSession();
            String openid =  (String) session.getAttribute("openid");

            String showType="applyfinish";
            ResultSet rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'show\',\'" + openid + "\',\'" + showType + "\')");
            while (rs.next()) {
                System.out.println(rs.getString("message"));

                strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                System.out.println(strPublish);

                JSONObject object=JSONObject.parseObject(strPublish.trim());
                System.out.println(object);
                System.out.println(object.getString("StatusCode"));
                JSONObject object2=JSONObject.parseObject(object.getString("SuccessMsg"));
                System.out.println(object2.getString("Number"));

                System.out.println(object2.getString("Records").trim());
                list=(ArrayList<Order>) JSONObject.parseArray(object2.getString("Records").trim(),Order.class);

                System.out.println(list.size());


                for (int i = 0; i < list.size(); i++) {

                    //搜申请者
                    rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'showMyHomepage\',\'" + list.get(i).getApplyuserid() + "\')");

                    while (rs.next()) {
                        System.out.println(rs.getString("message"));
                        strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                        JSONObject user_object=JSONObject.parseObject(strPublish.trim());
                        applyuser =JSONObject.parseObject(user_object.getString("SuccessMsg").trim(),User.class);

                    }


                    //搜发布者
                    rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'showMyHomepage\',\'" + list.get(i).getServiceuserid() + "\')");

                    while (rs.next()) {
                        System.out.println(rs.getString("message"));
                        strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                        JSONObject user_object=JSONObject.parseObject(strPublish.trim());
                        serviceuser =JSONObject.parseObject(user_object.getString("SuccessMsg").trim(),User.class);

                    }

                    //搜商品
                    rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'queryByPublishID\',\'" +list.get(i).getPublishid()+ "\')");
                    while (rs.next()) {
                        System.out.println(rs.getString("message"));
                        strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                        JSONObject publish_object=JSONObject.parseObject(strPublish.trim());
                        System.out.println(publish_object.getString("StatusCode"));
                        publish =JSONObject.parseObject(publish_object.getString("SuccessMsg").trim(),Publish.class);

                    }


                    OrderDetail orderDetail = new OrderDetail(applyuser,serviceuser,publish,list.get(i));
                    Detaillist.add(orderDetail);
                }

            }
            DbControl.closeConnection(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }

        map.addAttribute("recordDetailList", Detaillist);
        return "service_requested_wancheng";
    }

    //服务者开始扫码
    @RequestMapping(value = "/serviceUserStartScan",method = RequestMethod.GET)
    public String serviceUserStartScan(ModelMap map, @RequestParam String recordID) throws InterruptedException {

        Order order = new Order();
        Connection conn = null;
        try {
            conn = DbControl.getConnection();
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'queryByOrderID\',\'" + recordID + "\')");
            while (rs.next()) {
                String strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                JSONObject user_object=JSONObject.parseObject(strPublish.trim());
                order =JSONObject.parseObject(user_object.getString("SuccessMsg").trim(),Order.class);
            }
            DbControl.closeConnection(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }

        map.addAttribute("isFirst", order.getBegintime()==null);
        map.addAttribute("recordID",recordID);

        //return "returnRobot";微信接口扫码
        return "tx";//web测试
    }

    //服务者扫码结束
    @RequestMapping(value = "/serviceUserCompleteScan",method = RequestMethod.POST)
    @ResponseBody
    public String serviceUserCompleteFirstScan(ModelMap map, @RequestParam String qrcode, @RequestParam String recordID){

        String status = "null";
        Order order = new Order();
        Connection conn = null;
        try {
            conn = DbControl.getConnection();
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'queryByOrderID\',\'" + recordID + "\')");
            while (rs.next()) {
                System.out.println(rs.getString("message"));
                String strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                JSONObject user_object=JSONObject.parseObject(strPublish.trim());
                order =JSONObject.parseObject(user_object.getString("SuccessMsg").trim(),Order.class);
            }
            DbControl.closeConnection(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }

//qrcode可以设计为其他组合
      //  if(!(order.getApplyuserid()+order.getStatus()).equals(qrcode)){
        if(!order.getStatus().equals(qrcode)){
            status = "notOneself";
            return status;
        }else{

            if(order.getBegintime()==null || order.getBegintime().equals("null")) {
                try {
                    conn = DbControl.getConnection();
                    Statement st = conn.createStatement();
                    Date now = new Date();
                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                   // SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/ddHH:mm:ss");// 可以方便地修改日期格式
                    String begintime = dateFormat.format(now);
                    ResultSet rs = st.executeQuery(
                            "INVOKE INTO 2665637542 VALUES(\'borrow\',\'" + recordID + "\',\'" + begintime + "\')");
                    while (rs.next()) {
                        System.out.println(rs.getString("message"));
                        JSONObject object = JSONObject.parseObject(rs.getString("message").trim());
                        if (object.getString("SuccessMsg").trim().equals("success"))
                            status = "success";
                        else status = "fail";

                    }
                    DbControl.closeConnection(conn);
                    return status;
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            if(order.getBegintime()!=null) {
                try {

                    conn = DbControl.getConnection();
                    Statement st = conn.createStatement();
                    Date now = new Date();
                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                    // SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/ddHH:mm:ss");// 可以方便地修改日期格式
                    String endtime = dateFormat.format(now);
                    String str = endtime;
                    System.out.println(str);
                    ResultSet rs = st
                            .executeQuery("INVOKE INTO 2665637542 VALUES(\'giveback\',\'" + recordID + "\',\'" + str + "\')");
                    while (rs.next()) {
                        JSONObject object = JSONObject.parseObject(rs.getString("message").trim());
                        if (object.getString("SuccessMsg").trim().equals("giveback"))
                            status = "success";
                        else status = "fail";
                    }
                    DbControl.closeConnection(conn);
                    return status;
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        //map.addAttribute("status",status);
        return status;
    }

    //申请者开始付款
    @RequestMapping(value = "/applyUserStartPay",method = RequestMethod.GET)
    public String applyUserStartPay(ModelMap map, @RequestParam String recordID){


        Order order = new Order();
        User applyuser = new User();
        User serviceuser = new User();
        Publish publish = new Publish();
        String strPublish;

        Connection conn = null;
        try {
            conn = DbControl.getConnection();
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'queryByOrderID\',\'" + recordID + "\')");
            while (rs.next()) {
                strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                JSONObject user_object=JSONObject.parseObject(strPublish.trim());
                order =JSONObject.parseObject(user_object.getString("SuccessMsg").trim(),Order.class);
            }
            //搜申请者
            rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'showMyHomepage\',\'" + order.getApplyuserid() + "\')");

            while (rs.next()) {
                strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                JSONObject user_object=JSONObject.parseObject(strPublish.trim());
                applyuser =JSONObject.parseObject(user_object.getString("SuccessMsg").trim(),User.class);

            }

            //搜发布者
            rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'showMyHomepage\',\'" + order.getServiceuserid() + "\')");

            while (rs.next()) {
                strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                JSONObject user_object=JSONObject.parseObject(strPublish.trim());
                serviceuser =JSONObject.parseObject(user_object.getString("SuccessMsg").trim(),User.class);

            }

            //搜商品
            rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'queryByPublishID\',\'" +order.getPublishid()+ "\')");
            while (rs.next()) {
                strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                JSONObject publish_object=JSONObject.parseObject(strPublish.trim());
                System.out.println(publish_object.getString("StatusCode"));
                publish =JSONObject.parseObject(publish_object.getString("SuccessMsg").trim(),Publish.class);

            }

            DbControl.closeConnection(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }

        OrderDetail orderDetail = new OrderDetail(applyuser,serviceuser,publish,order);
        map.addAttribute("viewPublishOrderDetailEntity", orderDetail);
        return "service_posted_paydetails";
    }

    //用户支付积分
    @RequestMapping(value = "/applyUserPayCredit",method = RequestMethod.POST)
    @ResponseBody
    public String applyUserPayTimeCoin(ModelMap map, @RequestParam String recordID) {
        String status="";
        Connection conn = null;
        try {
            conn = DbControl.getConnection();
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'payMoney\',\'" + recordID + "\')");
            while (rs.next()) {
                JSONObject object=JSONObject.parseObject(rs.getString("message").trim());
                if(object.getString("SuccessMsg").trim().equals("borrowsuccess"))
                    status = "borrowsuccess";
                else if(object.getString("SuccessMsg").trim().equals("delaysuccess"))
                    status = "delaysuccess";
                else status = "fail";

            }
            DbControl.closeConnection(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }

    return status;
    }


    //发布者结束未归还订单入口
    @RequestMapping(value = "/serviceUserFinishGiveBack1",method = RequestMethod.GET)
    public String finish_step1(ModelMap map, @RequestParam String recordID) throws InterruptedException {


        map.addAttribute("recordID",recordID);


        return "finish_not_giveback_order";
    }

    //结束未归还订单
    @RequestMapping(value = "/serviceUserFinishGiveBack2",method = RequestMethod.POST)
    @ResponseBody
    public String finish_step2(ModelMap map,@RequestParam String recordID){
        String status ="fail";
        Connection conn = null;
        try {
            conn = DbControl.getConnection();
            Statement st = conn.createStatement();
            Date now = new Date();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");// 可以方便地修改日期格式
            String nowtime = dateFormat.format(now);
            ResultSet rs = st.executeQuery(
                    "INVOKE INTO 2665637542 VALUES(\'overdueNotGiveback\',\'" + recordID + "\',\'" + nowtime + "\')");
            while (rs.next()) {
                JSONObject object=JSONObject.parseObject(rs.getString("message").trim());
                if(object.getString("SuccessMsg").trim().equals("success"))
                    status = "success";
            }
            DbControl.closeConnection(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }


        //map.addAttribute("status",status);
        return status;
    }


    //发布者结束余额不足订单
    @RequestMapping(value = "/serviceUserFinishOrder",method = RequestMethod.GET)
    public String serviceUserFinishOrder(ModelMap map, @RequestParam String recordID){

        String status ="fail";
        Connection conn = null;
        try {
            conn = DbControl.getConnection();
            Statement st = conn.createStatement();
            Date now = new Date();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");// 可以方便地修改日期格式
            String nowtime = dateFormat.format(now);
            ResultSet rs = st.executeQuery(
                    "INVOKE INTO 2665637542 VALUES(\'pointNotEnough\',\'" + recordID + "\',\'" + nowtime + "\')");
            while (rs.next()) {
                JSONObject object=JSONObject.parseObject(rs.getString("message").trim());
                if(object.getString("SuccessMsg").trim().equals("success"))
                    status="ok";

            }
            DbControl.closeConnection(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }

        map.addAttribute("msg", status);
        return "finish_result";
    }

    /*

    //积分余额查看
    @RequestMapping(value = "/credit",method = RequestMethod.GET)
    public String volunteer_coin(ModelMap map){
        UserEntity userEntity = getCurrentUser();
        map.addAttribute("user", userEntity);
        return "credit";
    }

    //查询用户发布服务接口：已完成的物品分享
    @RequestMapping(value="/queryVolPublishAlComplete",method = RequestMethod.GET)
    public String queryVolPublicAlComplete(ModelMap map){
        List<ViewPublishOrderDetailEntity> recordDetailList = viewRecordDetailDao.findViewRecordDetailEntitiesByServiceUserIdAndStatus(getCurrentUser().getId(),OrderStatus.alreadyComplete);
        List<ViewPublishOrderDetailEntity> recordDetailList2 = viewRecordDetailDao.findViewRecordDetailEntitiesByApplyUserIdAndStatus(getCurrentUser().getId(), OrderStatus.alreadyComplete);
        recordDetailList.addAll(recordDetailList2);

        map.addAttribute("recordDetailList", recordDetailList);
        map.addAttribute("userid",getCurrentUser().getId());
        return "credit_list";

    }



    //显示积分交易详情
    @RequestMapping(value="/credit_detail",method = RequestMethod.GET)
    public String detailPage(ModelMap map, @RequestParam long id) {

            ViewPublishOrderDetailEntity record = viewRecordDetailDao.findOne(id);
            map.addAttribute("userid", getCurrentUser().getId());

            map.addAttribute("credit_detail", record);

        return "credit_detail";
    }





    //更改订单状态
    @RequestMapping(value = "/updateOrderToComplete",method = RequestMethod.POST)
    @ResponseBody
    public void updateOrderToComplete(ModelMap map, @RequestParam long recordID) {
        accountService.updateOrderToComplete(recordID);
    }

*/


    /**
     * 查询用户发布的服务
     * @param map
     * @return
     */


   //查询用户发布服务的接口：已发布
    @RequestMapping(value = "/queryPublishAlreadyPublish",method = RequestMethod.GET)
    public String queryPublishAlreadyPublish(ModelMap map,HttpServletRequest request){

        ArrayList<Publish> list=new ArrayList<Publish>();
        ArrayList<PublishDetail> Detaillist= new ArrayList<PublishDetail>();
        User userEntity = new User();

        Connection conn = null;
        try {
            conn = DbControl.getConnection();
            Statement st = conn.createStatement();
            //String userid = getCurrentUser().getOpenid();

            HttpSession session = request.getSession();
            String openid =  (String) session.getAttribute("openid");

            String showType="mypublish";
            ResultSet rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'show\',\'" + openid + "\',\'" + showType + "\')");
            while (rs.next()) {
                String strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                System.out.println(strPublish);

                JSONObject object=JSONObject.parseObject(strPublish.trim());
                System.out.println(object);
                System.out.println(object.getString("StatusCode"));
                JSONObject object2=JSONObject.parseObject(object.getString("SuccessMsg"));
                System.out.println(object2.getString("Number"));

                System.out.println(object2.getString("Records").trim());
                list=(ArrayList<Publish>) JSONObject.parseArray(object2.getString("Records").trim(),Publish.class);

                System.out.println(list.size());


                for (int i = 0; i < list.size(); i++) {
                    rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'showMyHomepage\',\'" + list.get(i).getUserid() + "\')");

                    while (rs.next()) {
                        System.out.println(rs.getString("message"));
                        strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");

                        JSONObject user_object=JSONObject.parseObject(strPublish.trim());
                        userEntity =JSONObject.parseObject(user_object.getString("SuccessMsg").trim(),User.class);

                    }
                    PublishDetail publishDetail = new PublishDetail(userEntity,list.get(i));
                    Detaillist.add(publishDetail);
                }


            }
            DbControl.closeConnection(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }

        map.addAttribute("publishList", Detaillist);
        return "service_posted_fabu";
    }

    //服务详细列表
    @RequestMapping(value = "/fabuDetail", method = RequestMethod.GET)
    public String coindetailPage(ModelMap map, @RequestParam String id) {

        Publish publish = new Publish();
        User user = new User();
        String strPublish;

        Connection conn = null;
        try {
            conn = DbControl.getConnection();
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'queryByPublishID\',\'" +id+ "\')");
            while (rs.next()) {
                System.out.println(rs.getString("message"));
                strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");

                JSONObject object=JSONObject.parseObject(strPublish.trim());
                System.out.println(object.getString("StatusCode"));
                publish =JSONObject.parseObject(object.getString("SuccessMsg").trim(),Publish.class);

            }


            rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'showMyHomepage\',\'" + publish.getUserid() + "\')");

            while (rs.next()) {
                System.out.println(rs.getString("message"));
                strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                JSONObject user_object=JSONObject.parseObject(strPublish.trim());
                user =JSONObject.parseObject(user_object.getString("SuccessMsg").trim(),User.class);

            }

            PublishDetail viewPublishEntity = new PublishDetail(user,publish);
            map.addAttribute("detail", viewPublishEntity);

            DbControl.closeConnection(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "service_posted_detail";
    }

    //删除已发布的服务
    @RequestMapping(value = "/deletePublish", method = RequestMethod.GET)
    public String deletePublishService(ModelMap map,HttpServletRequest request, @RequestParam String id) {
        String deleteMsg = "";
        Connection conn =null;
        try{
            conn  = DbControl.getConnection();
            Statement st=conn.createStatement();

            HttpSession session = request.getSession();
            String openid =  (String) session.getAttribute("openid");


            ResultSet rs=st.executeQuery("INVOKE INTO 2665637542 VALUES(\'deleteUnPublish\',\'"+openid+"\',\'"+ id +"\')");
            while(rs.next()){
                System.out.println(rs.getString("message"));
                JSONObject object=JSONObject.parseObject(rs.getString("message").trim());
                if(object.getString("SuccessMsg").trim().equals("deletesuccess"))
                    deleteMsg = "删除成功";
                else  deleteMsg = "请拒绝所有申请后再尝试删除";
            }
            DbControl.closeConnection(conn);
        }catch(Exception e){
            e.printStackTrace();
        }

        map.addAttribute("deleteMsg", deleteMsg);
        return "service_delete_result";
    }

    //跳转到二维码页面
    @RequestMapping(value = "/show_qrcode",method = RequestMethod.GET)
    public String startModifyPersonalInfo(ModelMap map,@RequestParam String id,HttpServletRequest request){
        User user = getCurrentUser(request);

        map.addAttribute("user",user);
        map.addAttribute("id",id);
        return "show_qrcode";
    }

    //评价
    //发布者跳转到评价订单页面
    @RequestMapping(value = "/serviceUserStartEvaluate",method = RequestMethod.GET)
    public String serviceUserStartEvaluate(ModelMap map, @RequestParam String recordID){

        Order order = new Order();
        User applyuser = new User();
        User serviceuser = new User();
        Publish publish = new Publish();
        String strPublish;

        Connection conn = null;
        try {
            conn = DbControl.getConnection();
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'queryByOrderID\',\'" + recordID + "\')");
            while (rs.next()) {
                strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                JSONObject user_object=JSONObject.parseObject(strPublish.trim());
                order =JSONObject.parseObject(user_object.getString("SuccessMsg").trim(),Order.class);
            }
            //搜申请者
            rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'showMyHomepage\',\'" + order.getApplyuserid() + "\')");

            while (rs.next()) {
                strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                JSONObject user_object=JSONObject.parseObject(strPublish.trim());
                applyuser =JSONObject.parseObject(user_object.getString("SuccessMsg").trim(),User.class);

            }

            //搜发布者
            rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'showMyHomepage\',\'" + order.getServiceuserid() + "\')");

            while (rs.next()) {
                strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                JSONObject user_object=JSONObject.parseObject(strPublish.trim());
                serviceuser =JSONObject.parseObject(user_object.getString("SuccessMsg").trim(),User.class);

            }

            //搜商品
            rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'queryByPublishID\',\'" +order.getPublishid()+ "\')");
            while (rs.next()) {
                strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                JSONObject publish_object=JSONObject.parseObject(strPublish.trim());
                System.out.println(publish_object.getString("StatusCode"));
                publish =JSONObject.parseObject(publish_object.getString("SuccessMsg").trim(),Publish.class);

            }

            DbControl.closeConnection(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }

        OrderDetail orderDetail = new OrderDetail(applyuser,serviceuser,publish,order);
        map.addAttribute("viewPublishOrderDetailEntity", orderDetail);

        return "service_user_rate";//发布者给申请者评价
    }


    //查看发布者给申请者的评价
    @RequestMapping(value = "/checkServiceUserEvaluate",method = RequestMethod.GET)
    public String checkServiceUserStartEvaluate(ModelMap map, @RequestParam String recordID){

        Order order = new Order();
        User applyuser = new User();
        User serviceuser = new User();
        Publish publish = new Publish();
        String strPublish;

        Connection conn = null;
        try {
            conn = DbControl.getConnection();
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'queryByOrderID\',\'" + recordID + "\')");
            while (rs.next()) {
                strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                JSONObject user_object=JSONObject.parseObject(strPublish.trim());
                order =JSONObject.parseObject(user_object.getString("SuccessMsg").trim(),Order.class);
            }
            //搜申请者
            rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'showMyHomepage\',\'" + order.getApplyuserid() + "\')");

            while (rs.next()) {
                strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                JSONObject user_object=JSONObject.parseObject(strPublish.trim());
                applyuser =JSONObject.parseObject(user_object.getString("SuccessMsg").trim(),User.class);

            }

            //搜发布者
            rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'showMyHomepage\',\'" + order.getServiceuserid() + "\')");

            while (rs.next()) {
                strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                JSONObject user_object=JSONObject.parseObject(strPublish.trim());
                serviceuser =JSONObject.parseObject(user_object.getString("SuccessMsg").trim(),User.class);

            }

            //搜商品
            rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'queryByPublishID\',\'" +order.getPublishid()+ "\')");
            while (rs.next()) {
                strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                JSONObject publish_object=JSONObject.parseObject(strPublish.trim());
                System.out.println(publish_object.getString("StatusCode"));
                publish =JSONObject.parseObject(publish_object.getString("SuccessMsg").trim(),Publish.class);

            }

            DbControl.closeConnection(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }

        OrderDetail orderDetail = new OrderDetail(applyuser,serviceuser,publish,order);
        map.addAttribute("viewPublishOrderDetailEntity", orderDetail);

        return "service_user_rate_result";
    }


    //查看申请者给发布者的评价
    @RequestMapping(value = "/checkApplyUserEvaluate",method = RequestMethod.GET)
    public String checkApplyUserStartEvaluate(ModelMap map, @RequestParam String recordID){

        Order order = new Order();
        User applyuser = new User();
        User serviceuser = new User();
        Publish publish = new Publish();
        String strPublish;

        Connection conn = null;
        try {
            conn = DbControl.getConnection();
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'queryByOrderID\',\'" + recordID + "\')");
            while (rs.next()) {
                strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                JSONObject user_object=JSONObject.parseObject(strPublish.trim());
                order =JSONObject.parseObject(user_object.getString("SuccessMsg").trim(),Order.class);
            }
            //搜申请者
            rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'showMyHomepage\',\'" + order.getApplyuserid() + "\')");

            while (rs.next()) {
                strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                JSONObject user_object=JSONObject.parseObject(strPublish.trim());
                applyuser =JSONObject.parseObject(user_object.getString("SuccessMsg").trim(),User.class);

            }

            //搜发布者
            rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'showMyHomepage\',\'" + order.getServiceuserid() + "\')");

            while (rs.next()) {
                strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                JSONObject user_object=JSONObject.parseObject(strPublish.trim());
                serviceuser =JSONObject.parseObject(user_object.getString("SuccessMsg").trim(),User.class);

            }

            //搜商品
            rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'queryByPublishID\',\'" +order.getPublishid()+ "\')");
            while (rs.next()) {
                strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                JSONObject publish_object=JSONObject.parseObject(strPublish.trim());
                System.out.println(publish_object.getString("StatusCode"));
                publish =JSONObject.parseObject(publish_object.getString("SuccessMsg").trim(),Publish.class);

            }

            DbControl.closeConnection(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }

        OrderDetail orderDetail = new OrderDetail(applyuser,serviceuser,publish,order);
        map.addAttribute("viewPublishOrderDetailEntity", orderDetail);

        return "apply_user_rate_result";
    }

    //发布者评价订单
    @RequestMapping(value = "/serviceUserEvaluateRecord",method = RequestMethod.POST)
    @ResponseBody
    public String serviceUserEvaluateRecord(ModelMap map, @RequestParam String recordID, @RequestParam int rating, @RequestParam String comment, @RequestParam String userid){

        String status ="";
        Connection conn = null;
        try {
            conn = DbControl.getConnection();
            Statement st = conn.createStatement();
            String userRating = ""+rating;
            ResultSet rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'comment\',\'" + recordID + "\',\'" + userid
                    + "\',\'" + userRating + "\',\'" + comment + "\')");
            while (rs.next()) {

                JSONObject object=JSONObject.parseObject(rs.getString("message").trim());
                if(object.getString("SuccessMsg").trim().equals("commentsuccess"))
                {
                    status = "commentsuccess";
                    System.out.print("commentsuccess!!!!!!!!!!!!!");
                }
                else  status = "fail";

            }
            DbControl.closeConnection(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return  status;
    }

    //申请者跳转到评价订单页面
    @RequestMapping(value = "/applyUserStartEvaluate",method = RequestMethod.GET)
    public String applyUserStartEvaluate(ModelMap map, @RequestParam String recordID){

        Order order = new Order();
        User applyuser = new User();
        User serviceuser = new User();
        Publish publish = new Publish();
        String strPublish;

        Connection conn = null;
        try {
            conn = DbControl.getConnection();
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'queryByOrderID\',\'" + recordID + "\')");
            while (rs.next()) {
                strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                JSONObject user_object=JSONObject.parseObject(strPublish.trim());
                order =JSONObject.parseObject(user_object.getString("SuccessMsg").trim(),Order.class);
            }
            //搜申请者
            rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'showMyHomepage\',\'" + order.getApplyuserid() + "\')");

            while (rs.next()) {
                strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                JSONObject user_object=JSONObject.parseObject(strPublish.trim());
                applyuser =JSONObject.parseObject(user_object.getString("SuccessMsg").trim(),User.class);

            }

            //搜发布者
            rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'showMyHomepage\',\'" + order.getServiceuserid() + "\')");

            while (rs.next()) {
                strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                JSONObject user_object=JSONObject.parseObject(strPublish.trim());
                serviceuser =JSONObject.parseObject(user_object.getString("SuccessMsg").trim(),User.class);

            }

            //搜商品
            rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'queryByPublishID\',\'" +order.getPublishid()+ "\')");
            while (rs.next()) {
                strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                JSONObject publish_object=JSONObject.parseObject(strPublish.trim());
                System.out.println(publish_object.getString("StatusCode"));
                publish =JSONObject.parseObject(publish_object.getString("SuccessMsg").trim(),Publish.class);

            }

            DbControl.closeConnection(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }

        OrderDetail orderDetail = new OrderDetail(applyuser,serviceuser,publish,order);
        map.addAttribute("viewPublishOrderDetailEntity", orderDetail);

        return "apply_user_rate";
    }


    //申请者评价订单
    @RequestMapping(value = "/applyUserEvaluateRecord",method = RequestMethod.POST)
    @ResponseBody
    public String applyUserEvaluateRecord(ModelMap map, @RequestParam String recordID, @RequestParam int rating, @RequestParam String comment,@RequestParam String userid){
        String status ="";
        Connection conn = null;
        try {
            conn = DbControl.getConnection();
            Statement st = conn.createStatement();
            String userRating = ""+rating;
            ResultSet rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'comment\',\'" + recordID + "\',\'" + userid
                    + "\',\'" + userRating + "\',\'" + comment + "\')");
            while (rs.next()) {
                System.out.print("!!!!!!!!!start!!!!!");
                System.out.print(userid);
                JSONObject object=JSONObject.parseObject(rs.getString("message").trim());
                if(object.getString("SuccessMsg").trim().equals("commentsuccess"))
                {
                    status = "commentsuccess";
                    System.out.print("commentsuccess!!!!!!!!!!!!!");
                }
                else  status = "fail";            }
            DbControl.closeConnection(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }
    return status;
    }



}
