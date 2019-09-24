package com.springmvc.controller;

import com.alibaba.fastjson.JSONObject;
import com.springmvc.entity.*;

import com.springmvc.utils.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.UUID;

@Controller
@RequestMapping("/record")
public class RecordController {


    private User getCurrentUser(HttpServletRequest request) {

        User userEntity = new User();
        //openid
        Connection conn = null;
        try {
            conn = DbControl.getConnection();
            Statement st = conn.createStatement();

            HttpSession session = request.getSession();
            String openid =  (String) session.getAttribute("openid");

            ResultSet rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'showMyHomepage\',\'" + openid + "\')");

            while (rs.next()) {
                System.out.println(rs.getString("message"));
                String strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                JSONObject object=JSONObject.parseObject(strPublish.trim());
                System.out.println(object.getString("StatusCode"));
                userEntity =JSONObject.parseObject(object.getString("SuccessMsg").trim(),User.class);
                System.out.println(userEntity.getName());

                userEntity.getName();
                userEntity.getHeadImage();

                System.out.println(openid);
            }

            DbControl.closeConnection(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (userEntity != null)
            return userEntity;
        else return null;


    }


    //申请服务页面
    @RequestMapping(value = "/apply", method = RequestMethod.GET)
    public String applyPage(ModelMap map, HttpServletRequest request, @RequestParam String publishID) {
        User userEntity = getCurrentUser(request);

        Publish publish = new Publish();
        User user = new User();

        Connection conn = null;
        try {
            conn = DbControl.getConnection();
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'queryByPublishID\',\'" +publishID+ "\')");
            while (rs.next()) {
                String strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                JSONObject object=JSONObject.parseObject(strPublish.trim());
                System.out.println(object.getString("StatusCode"));
                publish =JSONObject.parseObject(object.getString("SuccessMsg").trim(),Publish.class);

            }


            rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'showMyHomepage\',\'" + publish.getUserid() + "\')");

            while (rs.next()) {
                String strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                JSONObject user_object=JSONObject.parseObject(strPublish.trim());
                user =JSONObject.parseObject(user_object.getString("SuccessMsg").trim(),User.class);

            }

            PublishDetail viewPublishEntity = new PublishDetail(user,publish);
            map.addAttribute("detail", viewPublishEntity);

            DbControl.closeConnection(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }

        map.addAttribute("name", userEntity.getName());
        map.addAttribute("phone", userEntity.getWechat());
        return "record_apply";
    }




    //申请服务页面
    @RequestMapping(value = "/applySubmit", method = RequestMethod.POST)
    public String applySubmit(ModelMap map, HttpServletRequest request,@RequestParam String serviceUserId, @RequestParam String publishId, @RequestParam String reason,@RequestParam String endDate) {


        //判断是否申请自己的服务
        //changed
        boolean isOneself = false;
        HttpSession session = request.getSession();
        String openid =  (String) session.getAttribute("openid");
        if(serviceUserId == openid){
            isOneself = true;
        }

        Connection conn = null;
        try {
            conn = DbControl.getConnection();
            Statement st = conn.createStatement();
            String orderid = "order_" + UUID.randomUUID();
            // "applyuserid","serviceuserid","publishid","estimateReturntime","orderid","reason"
          //  String str = getCurrentUser().getOpenid() + "," + serviceUserId + "," + publishId + "," + endDate + "," + orderid + "," + reason+",-1,0";
            ResultSet rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'applyBorrow\',\'" + orderid + "\',\'" + openid + "\',\'" + serviceUserId + "\',\'" + publishId + "\',\'" + endDate + "\',\'" + orderid + "\',\'" + reason + "\')");

            //ResultSet rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'applyBorrow\',\'" + orderid + "\',\'" + str + "\')");
            while (rs.next()) {
                System.out.println(rs.getString("message"));
                JSONObject object=JSONObject.parseObject(rs.getString("message").trim());
                if(object.getString("SuccessMsg").trim().equals("applysuccess"))
                    map.addAttribute("msg","ok");

            }
            DbControl.closeConnection(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }


        if(isOneself){
            map.addAttribute("msg","error");
            map.addAttribute("detail","isOneself");
        }

        return "record_apply_result";
    }



    //服务者处理订单
    @RequestMapping(value = "/handleApplicantRecord", method = RequestMethod.GET)
    public String handleApplicantRecord(ModelMap map, HttpServletRequest request,@RequestParam String recordID, @RequestParam String handle,@RequestParam String PublishID , @RequestParam String Applyuser){

        String status ="";
        User userEntity = new User();
        Publish publishEntity = new Publish();
        Order orderEntity= new Order();
        //openid
        Connection conn = null;
        try {
            conn = DbControl.getConnection();
            Statement st = conn.createStatement();

            ResultSet rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'showMyHomepage\',\'" + Applyuser + "\')");

            while (rs.next()) {

                String strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                JSONObject object=JSONObject.parseObject(strPublish.trim());

                userEntity =JSONObject.parseObject(object.getString("SuccessMsg").trim(),User.class);
            }

            rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'queryByPublishID\',\'" +PublishID+ "\')");
            while (rs.next()) {

                String strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");

                JSONObject object=JSONObject.parseObject(strPublish.trim());

                publishEntity =JSONObject.parseObject(object.getString("SuccessMsg").trim(),Publish.class);

            }

            rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'queryByOrderID\',\'" + recordID + "\')");
            while (rs.next()) {

                String strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");

                JSONObject object=JSONObject.parseObject(strPublish.trim());
                orderEntity =JSONObject.parseObject(object.getString("SuccessMsg").trim(),Order.class);

            }


        } catch (Exception e) {
            e.printStackTrace();
        }


        if(handle.equals("refuse")){
            try {
                conn = DbControl.getConnection();
                Statement st = conn.createStatement();

                HttpSession session = request.getSession();
                String openid =  (String) session.getAttribute("openid");

                ResultSet rs = st.executeQuery(
                        "INVOKE INTO 2665637542 VALUES(\'refuseOrder\',\'" + openid + "\',\'" + recordID + "\')");
                while (rs.next()) {
                    System.out.println(rs.getString("message"));
                    JSONObject object=JSONObject.parseObject(rs.getString("message").trim());
                    if(object.getString("SuccessMsg").trim().equals("refuseSuccess"))
                        status ="交易取消";


                }
                DbControl.closeConnection(conn);
            } catch (Exception e) {
                e.printStackTrace();
            }

        }

        if(handle.equals("confirm")){


            try {
                conn = DbControl.getConnection();
                Statement st = conn.createStatement();

                ResultSet rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'confirmBorrow\',\'" + recordID + "\',\'" + PublishID + "\')");
                while (rs.next()) {
                    System.out.println(rs.getString("message"));
                    JSONObject object=JSONObject.parseObject(rs.getString("message").trim());
                    if(object.getString("SuccessMsg").trim().equals("confirmsuccess"))
                        status ="已确认";
                }

                DbControl.closeConnection(conn);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }



        map.addAttribute("status",status);
        map.addAttribute("userEntity",userEntity);
        map.addAttribute("publishEntity",publishEntity);
        map.addAttribute("publishOrderEntity", orderEntity);

        return "takendetails";
    }




}
