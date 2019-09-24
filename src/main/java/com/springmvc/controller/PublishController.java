package com.springmvc.controller;


import com.alibaba.fastjson.JSONObject;
import com.springmvc.entity.*;
import com.springmvc.utils.DbControl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/publish")
public class PublishController {


    //发布服务页面
    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String addPage(ModelMap map,HttpServletRequest request) {

        User currentUser = getCurrentUser(request);

        return "publish_add";
    }


//发布服务提交接口
@RequestMapping(value = "/add/submit", method = RequestMethod.POST)
@ResponseBody
public String addSubmitPage(ModelMap map, HttpServletRequest request,@RequestParam String serviceType, @RequestParam String description, @RequestParam String deposit, @RequestParam String endDate, @RequestParam String price, @RequestParam String address, @RequestParam String theme,
                            @RequestParam(value = "uploaderInput", required = false) MultipartFile[] uploaderInput

) throws SQLException {
    String msg = "";
    Connection conn =null;
    try {

        long current= System.currentTimeMillis();//当前时间毫秒数

        HttpSession session = request.getSession();
        String openid =  (String) session.getAttribute("openid");

        System.out.println("current"+current);
        System.out.println("idNum"+openid);
        System.out.println(uploaderInput.length);

        //用户上传照片

        String idImg1 = null;
        String idImg2 = null;
        String idImg3 = null;

        File imgFile1 = null;
        File imgFile2 = null;
        File imgFile3 = null;

        //File uploadDir = new File("/home/ubuntu/timebank/picture/publish");
        File uploadDir = new File("/Users/Molly/Desktop/pictures");

        if (!uploadDir.exists()){
            uploadDir.mkdir();
        }
        // 构建上传目录及文件对象，不存在则自动创建
        //String path = "/home/ubuntu/timebank/picture/publish";
        String path = "/Users/Molly/Desktop/pictures";

        if(uploaderInput.length >=1) {

            String suffix1 = uploaderInput[0].getOriginalFilename().substring(uploaderInput[0].getOriginalFilename().lastIndexOf("."));
            idImg1 = openid + "_" +current+"_"+ 1 +suffix1;
            imgFile1 = new File(path, idImg1);

            if (uploaderInput.length >=2) {

                String suffix2 = uploaderInput[1].getOriginalFilename().substring(uploaderInput[1].getOriginalFilename().lastIndexOf("."));
                idImg2 = openid + "_" +current+"_" +2+ suffix2;
                imgFile2 = new File(path, idImg2);

                if (uploaderInput.length >=3) {

                    String suffix3 = uploaderInput[2].getOriginalFilename().substring(uploaderInput[2].getOriginalFilename().lastIndexOf("."));
                    idImg3 = openid + "_" +current+"_" + 3 + suffix3;
                    imgFile3 = new File(path, idImg3);

                }
            }
        }


        // 保存文件
        try {
            if(imgFile1!=null && idImg1!=null){
                uploaderInput[0].transferTo(imgFile1);
            }
            if(imgFile2!=null && idImg2!=null)
            {
                uploaderInput[1].transferTo(imgFile2);
            }
            if(imgFile3!=null && idImg3!=null)
            {
                uploaderInput[2].transferTo(imgFile3);
            }
        } catch (Exception e) {
            msg = "failure";
            e.printStackTrace();
        }


        conn  = DbControl.getConnection();
        Statement st=conn.createStatement();
        //主键K
        String publishid = "publish_"+UUID.randomUUID();
        ResultSet rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'publishgoods\',\'" + publishid + "\',\'" + openid + "\',\'" + address + "\',\'" + description + "\',\'" + endDate + "\',\'" + idImg1 + "\',\'" + idImg2 + "\',\'" + idImg3 + "\',\'" + price + "\',\'" + theme + "\',\'" + deposit + "\',\'" + serviceType + "\',\'" + publishid + "\')");
        // ResultSet rs=st.executeQuery("INVOKE INTO 2665637542 VALUES(\'publishgoods\',\'"+publishid+"\',\'"+ str +"\')");
        while(rs.next()){
            System.out.println(rs.getString("message"));
        }
        DbControl.closeConnection(conn);
        msg = "upload success";

    } catch (Exception e) {
        e.printStackTrace();
    }

    map.addAttribute("type", serviceType);
    return msg;
    //return "redirect:/publish/list";
}


    //服务种类页面
    @RequestMapping(value = "/category")

    public String categoryPage() {
        return "publish_category";
    }


    //服务显示列表
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String listPage(ModelMap map, @RequestParam String type) {

        ArrayList<Publish> list=new ArrayList<Publish>();
        ArrayList<PublishDetail> Detaillist= new ArrayList<PublishDetail>();
        User userEntity = new User();

        Connection conn = null;
        try {
            conn = DbControl.getConnection();
            Statement st = conn.createStatement();

            ResultSet rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'canBorrowlist\',\'" + type + "\')");
            while (rs.next()) {
                String strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");


                JSONObject object=JSONObject.parseObject(strPublish.trim());

                JSONObject object2=JSONObject.parseObject(object.getString("SuccessMsg"));

    			list=(ArrayList<Publish>) JSONObject.parseArray(object2.getString("Records").trim(),Publish.class);

                System.out.println(list.size());


                for (int i = 0; i < list.size(); i++) {
                    rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'showMyHomepage\',\'" + list.get(i).getUserid() + "\')");

                    while (rs.next()) {

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

        map.addAttribute("list", Detaillist);
        map.addAttribute("type", type);

        return "publish_list";
       // return "index";

    }


    //收藏显示列表
    @RequestMapping(value = "/favor", method = RequestMethod.GET)
    public String favorlistPage(ModelMap map,HttpServletRequest request) {

        ArrayList<Publish> list=new ArrayList<Publish>();
        ArrayList<PublishDetail> Detaillist= new ArrayList<PublishDetail>();
        User userEntity = new User();


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
                    rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'showMyHomepage\',\'" + list.get(i).getUserid() + "\')");

                    while (rs.next()) {
                        System.out.println(rs.getString("message"));
                        JSONObject user_object=JSONObject.parseObject(rs.getString("message").trim());
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


        map.addAttribute("list", Detaillist);
        map.addAttribute("type", "收藏列表");

        return "favor_list";

    }

    //服务详细列表
    @RequestMapping(value = "/detail", method = RequestMethod.GET)
    public String detailPage(ModelMap map, HttpServletRequest request,@RequestParam String publishID) {

        Publish publish = new Publish();
        User user = new User();
        String strPublish;

        Connection conn = null;
        try {
            conn = DbControl.getConnection();
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'queryByPublishID\',\'" +publishID+ "\')");
            while (rs.next()) {

                strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");

                JSONObject object=JSONObject.parseObject(strPublish.trim());

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

        User userEntity = getCurrentUser(request);
        map.addAttribute("currentUser", userEntity);
        return "publish_detail";

    }

    //条件筛选服务
    @RequestMapping(value = "/select", method = RequestMethod.GET)
    public String selectService(ModelMap map, @RequestParam String type) {
        map.addAttribute("type", type);
        return "service_select";
    }

   @RequestMapping(value = "/selectList", method = RequestMethod.GET)
    //public String listPage(ModelMap map, @RequestParam String type, @RequestParam String[] serviceName, @RequestParam Date upperDate, @RequestParam Date lowerDate, @RequestParam String upper, @RequestParam String lower) {
    public String selectPublishList(ModelMap map, @RequestParam String type, @RequestParam String lowerPrice, @RequestParam String upperPrice, @RequestParam String upperDate, @RequestParam String upperDeposit,@RequestParam String lowerDeposit ) {
       ArrayList<Publish> list=new ArrayList<Publish>();
       ArrayList<PublishDetail> Detaillist= new ArrayList<PublishDetail>();
       User userEntity = new User();
       System.out.println(type);

       Connection conn = null;
            try {
                conn = DbControl.getConnection();
                Statement st = conn.createStatement();

                ResultSet rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'screening\',\'" + type + "\',\'" + upperDate + "\',\'" + lowerPrice + "\',\'" + upperPrice + "\',\'" + lowerDeposit + "\',\'" + upperDeposit+ "\')");
                while (rs.next()) {
                    System.out.println(rs.getString("message"));

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


            map.addAttribute("list", Detaillist);
            map.addAttribute("type", type);


            return "publish_list";


    }






    //显示服务器图片
    @RequestMapping(value = "/imgurl",method = RequestMethod.GET)
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //读取本地图片输入流
        FileInputStream inputStream = new FileInputStream("/home/ubuntu/timebank/picture/profile/370785199512190078_1.JPG");
        int i = inputStream.available();
        //byte数组用于存放图片字节数据
        byte[] buff = new byte[i];
        inputStream.read(buff);
        //记得关闭输入流
        inputStream.close();
        //设置发送到客户端的响应内容类型
        response.setContentType("image/*");
        OutputStream out = response.getOutputStream();
        out.write(buff);
        //关闭响应输出流
        out.close();
    }


    //显示服务器图片
    @RequestMapping(value = "/testimgurl",method = RequestMethod.GET)
    public void doPost(@RequestParam String imgId , HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.print(imgId);
        //读取本地图片输入流
       // FileInputStream inputStream = new FileInputStream("/home/ubuntu/timebank/picture/publish/"+ imgId );
        FileInputStream inputStream = new FileInputStream("/Users/Molly/Desktop/pictures/"+ imgId );

        int i = inputStream.available();
        //byte数组用于存放图片字节数据
        byte[] buff = new byte[i];
        inputStream.read(buff);
        //记得关闭输入流
        inputStream.close();
        //设置发送到客户端的响应内容类型
        response.setContentType("image/*");
        OutputStream out = response.getOutputStream();
        out.write(buff);
        //关闭响应输出流
        out.close();
    }

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

            ResultSet rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'showMyHomepage\',\'" + openid + "\')");

            while (rs.next()) {

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



}
