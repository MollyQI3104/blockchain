package com.springmvc.controller;


//import com.springmvc.entity.UserEntity;
import com.alibaba.fastjson.JSONObject;
import com.springmvc.entity.User;
import com.springmvc.entity.Publish;
import com.springmvc.entity.Order;
import com.springmvc.weixin.model.SNSUserInfo;
import com.springmvc.weixin.model.WeixinOauth2Token;
import com.springmvc.weixin.util.AdvancedUtil;
import com.springmvc.weixin.util.Configs;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.springmvc.utils.DbControl;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

import javax.servlet.http.HttpServletRequest;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.UUID;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/")
public class IndexController {

    @RequestMapping(value = {"/", "/home**", "/index**", "/welcome**"}, method = RequestMethod.GET)
    public String indexPage() {
        return "index";
    }

    //区块链
    @RequestMapping(value = "/loginPage2", method = RequestMethod.GET)
    public String loginPage2(HttpServletRequest request, ModelMap map) {

        return "wechat_register2";
        //return "auto_login";
        // return "login";
    }

    /*
    //区块链  [web测试] 由wechat_register.jsp链接跳转
    //登录
    @RequestMapping(value = "/weblogin", method = RequestMethod.GET)
    public String webloginPage(HttpServletRequest request, ModelMap map, @RequestParam String openID) {

        //微信环境用code换取access_token（同时会得到OpenID）
        // 用户同意授权

        //web环境传参数
        UserEntity userEntity = userService.findUserEntityByOpenID(openID);
        System.out.println(openID);
        if (userEntity != null) {
            //如果用户存在,跳转到首页
            // Authentication token = new UsernamePasswordAuthenticationToken(userEntity.getPhone(), userEntity.getPassword());
            //SecurityContextHolder.getContext().setAuthentication(token);
            map.addAttribute("user", userEntity);
            return "userinfo";
                }
                //如果用户不存在
                map.addAttribute("openID", openID);
                return "wechat_register1";
    }

*/

    // 自动登录判断
    @RequestMapping(value = "/loginPage", method = RequestMethod.GET)
    public String webloginPage(ModelMap map,HttpServletRequest request) {

        //登录使设置session
        HttpSession session = request.getSession();
        session.setAttribute("openid", "oOcwj06rZ4bJtOT20cgI2RU_d_gWW");

        String openid =  (String) session.getAttribute("openid");


        Connection conn = null;
        try {
            conn = DbControl.getConnection();
            Statement st = conn.createStatement();

            //String openid = openID;
            ResultSet rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'login\',\'" +  openid + "\')");
            while (rs.next()) {
                System.out.println(rs.getString("message"));
                String strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");

                JSONObject object=JSONObject.parseObject(strPublish.trim());
                if (object.getString("SuccessMsg").trim().equals("needRegister")) {
                   // map.addAttribute("openID", openID);
                    //return "wechat_register1";
                    return "wechat_register2";
                }
            }
            DbControl.closeConnection(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }

        map.addAttribute("user", getCurrentUser(request));
        return "userinfo";
    }

    /*
    //区块链 [ 微信 ] 由auto_login.jsp链接跳转
    //未改
    //自动登录
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String loginPage(HttpServletRequest request, ModelMap map, @RequestParam String code) {
        System.out.println("授权码：" + code);
        // 用户同意授权
        if (null != code) {
            // 用code换取access_token（同时会得到OpenID）
            WeixinOauth2Token wot = AdvancedUtil.getOAuth2AceessToken(Configs.APPID, Configs.APPSECRET, code);
            if (wot != null) {
                System.out.println("======用户的OPENID：" + wot.getOpenId());

                String openId = wot.getOpenId();
                String accessToken = wot.getAccessToken();
                UserEntity userEntity = userService.findUserEntityByOpenID(wot.getOpenId());
                SNSUserInfo snsUserInfo = AdvancedUtil.getSNSUserInfo(accessToken, openId);
                if (userEntity != null) {
                    //如果用户存在,跳转到首页
                    String headImgUrl = userEntity.getHeadImgUrl();
                    String url = snsUserInfo.getHeadimgurl();
                    String localHeadUrl = "";
                    if (url != null && !url.equals(headImgUrl)) {
                        userEntity.setHeadImgUrl(url);
                        localHeadUrl = userService.saveUserHeadImgUrl(userEntity, request.getSession().getServletContext().getRealPath("/") + "WEB-INF/img/userAvatar/");
                    }
                    String country = snsUserInfo.getCountry();
                    String province = snsUserInfo.getProvince();
                    String city = snsUserInfo.getCity();
                    String nickname = snsUserInfo.getNickName();

                    System.out.println("======nickName:" + nickname + "======headImgUrl:" + url);
                    int sex = snsUserInfo.getSex();
                    String sex1;
                    if (sex == 1) {
                        sex1 = "男";
                    } else {
                        sex1 = "女";
                    }

                    userEntity.setSex(sex1);
                    userEntity.setRemark(nickname);
                    userService.updateUserEntity(userEntity);
                    Authentication token = new UsernamePasswordAuthenticationToken(userEntity.getPhone(), userEntity.getPassword());
                    SecurityContextHolder.getContext().setAuthentication(token);
                    return "redirect:/user/";
                }
                //如果用户不存在,跳转到wechat_register1.jsp
                map.addAttribute("openID", openId);
            } else {

                map.addAttribute("openID", "noID");

            }

        }
        return "wechat_register1";
    }

*/
    //区块链 由wechat_register1.jsp链接跳转
    //注册第一步,拿微信信息
    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public String registerPage(HttpServletRequest request, ModelMap map, @RequestParam String code) {
        System.out.println("授权码：" + code);

        // 用户同意授权
        if (null != code) {
            // 用code换取access_token（其中包含OpenID）
            WeixinOauth2Token wot = AdvancedUtil.getOAuth2AceessToken(Configs.APPID, Configs.APPSECRET, code);
            if (wot != null) {
                System.out.println("用户的OPENID：" + wot.getOpenId());

                String openId = wot.getOpenId();
                String accessToken = wot.getAccessToken();


                // 获取用户基本信息
                SNSUserInfo snsUserInfo = AdvancedUtil.getSNSUserInfo(accessToken, openId);
                String nickname = snsUserInfo.getNickName();
                System.out.println("昵称：" + nickname);

                String headimgurl = snsUserInfo.getHeadimgurl();

                //userService.saveUserHeadImgUrl(null,openId, accessToken, request.getSession().getServletContext().getRealPath("/") + "WEB-INF/img/userAvatar/");
                map.addAttribute("code", code);
                map.addAttribute("openID", wot.getOpenId());
                map.addAttribute("nickname", nickname);
                map.addAttribute("headimgurl", headimgurl);
            } else {
                map.addAttribute("code", code);
                map.addAttribute("openID", "noID");
                map.addAttribute("nickname", "nonickname");
                map.addAttribute("headimgurl", "noheadimgurl");
            }

        } else {
            map.addAttribute("code", "noCode");
            map.addAttribute("openID", "noID");
            map.addAttribute("nickname", "nonickname");
            map.addAttribute("headimgurl", "noheadimgurl");

        }

        return "wechat_register2";
    }

    // 区块链 注册、登陆请求提交接口 
// 由wechat_register2.jsp跳转 
// 保存信息,初始化用户 
    @RequestMapping(value = "/register_login", method = RequestMethod.POST)
    @ResponseBody
    public String registerLogin(ModelMap map, HttpServletRequest request,@RequestParam String wechatid, @RequestParam String nickname, @RequestParam String headimgurl, @RequestParam String openID) {
        String status = "";

            /*

            UserEntity userEntity = new UserEntity();
            userEntity.setName(nickname);
            userEntity.setPhone(wechatid);
            userEntity.setOpenId(openID);
            userEntity.setHeadImgUrl(headimgurl);
            userService.saveUserEntity(userEntity);
            */
            Connection conn = null;
            try {
                conn = DbControl.getConnection();
                Statement st = conn.createStatement();
                // 主键K
                //String name, String wechat, String openid, String point, String evaluation, String times,
//			String myfavorid, String mypublish, String needConfirm, String needSerShare, String needSerPay,
//			String publishfinish, String myapply, String needAppshare, String needAppPay, String applyfinish


               // String userid = "user_" + UUID.randomUUID();
                String userid = openID;
               // name; wechat; openid;point; evaluation; times;  headImage; frozenPoint;
                String str = nickname + "," + wechatid +  "," + openID + ","+"1000"+","+"4"+","+"0"+","+headimgurl+","+"0";
              //  String str = "Harden2222,weixin_id,da2312,1000,4,0, , , , , , , , , , , ,0,";
                ResultSet rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'init\',\'" + userid + "\',\'" + str + "\')");
                System.out.println("INVOKE INTO 2665637542 VALUES(\'init\',\'" + userid + "\',\'" + str + "\')");
                while (rs.next()) {
                    System.out.println(rs.getString("message"));
                }

               // Authentication token = new UsernamePasswordAuthenticationToken(openID,openID);
                //SecurityContextHolder.getContext().setAuthentication(token);
                status = "success";

                DbControl.closeConnection(conn);
            } catch (Exception e) {
                status = "fail";
                e.printStackTrace();

            }

            status = "ok";


        return status;
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
            String userid = openid;
            ResultSet rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'showMyHomepage\',\'" + userid + "\')");

            while (rs.next()) {
                String strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
                JSONObject object=JSONObject.parseObject(strPublish.trim());
                System.out.println(object.getString("StatusCode"));
                userEntity =JSONObject.parseObject(object.getString("SuccessMsg").trim(),User.class);

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

