<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="zh">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <title>注册页面</title>
    <!-- 引入 WeUI -->
    <link href="../css/weui.min.css" type="text/css" rel="stylesheet" />


    <script charset="utf-8" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>


    <script src="../js/scan/configs.js"></script>
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script src="../js/scan/function.js"></script>


</head>

<body>

<%
    //String openID = (String) request.getAttribute("openID");
    //String nickname = (String) request.getAttribute("nickname");
    //String headimgurl = (String) request.getAttribute("headimgurl");

    String openID=(String) request.getSession().getAttribute("openid");
    String nickname="sc";
    String headimgurl="http://thirdwx.qlogo.cn/mmopen/vi_32/F9Ddu2X60RraBO5v0AwB06xdpWPwAYFcPcZnhoiaKxsfBZVRuH0A0KROicpR3elRCAOSDnqRibUUmTepLs2qVfMZg/132";

%>
<div id="login_form" class="weui-cells weui-cells_form" style="margin: 100px 25px 0;
">


        <div class="weui-cell">
        <div class="weui-cell__hd"><label class="weui-label">微信ID</label></div>
        <div class="weui-cell__bd">
            <input class="weui-input"  id="wechatid" name="wechatid" placeholder="请输入正确微信ID" >
        </div>
    </div>


    <div>
        <a href="javascript:;" class="weui-btn weui-btn_primary" id="login">注册并登录</a>
    </div>



</div>


<script src="http://lib.sinaapp.com/js/jquery/1.12.4/jquery-1.12.4.min.js"></script>
<script src="../js/jquery/jquery-3.2.1.min.js"></script>

<script type="text/javascript">
    var xmlHttpRequest;
    $(function(){
        if(window.XMLHttpRequest){
            xmlHttpRequest=new XMLHttpRequest();
        }else{
            xmlHttpRequest=new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlHttpRequest.open("GET","AjaxServlet",true);
    });

    var openID='<%=openID%>';
    var nickname='<%=nickname%>';
    var headimgurl='<%=headimgurl%>';
    var contextPath="${pageContext.request.contextPath}";

    $("#login").on('click', function () {
        //var targetUrl = "http://localhost:8080"+contextPath+"/register_login";
        var targetUrl = "http://localhost:8080"+contextPath+"/register_login";
       // var targetUrl2 = "http://localhost:8080"+contextPath+"/weblogin";
        var targetUrl2 = "http://localhost:8080"+contextPath+"/user/user_login";

        var wechatid=document.getElementById("wechatid").value;


       if(wechatid == "")
        {
            showAlert("请输入微信ID!");
            return false;
        }

        login(wechatid,openID,nickname,headimgurl,targetUrl,targetUrl2);

    });

    function login(wechatid,openID,nickname,headimgurl,targetUrl,targetUrl2) {
        $.ajax({
            type: 'POST',
            cache: false,
            url: targetUrl,
            data: "wechatid=" + wechatid + "&nickname=" + nickname + "&headimgurl=" + headimgurl+ "&openID=" +openID,
            success: function (data) {

                if(data==="fail"){
                    showAlert("注册失败");
                }

                if(data===""){
                    showAlert("程序失败");
                }

                if(data==="ok"){
                    showAlert("注册登录成功,自动跳转",function () {
                        goTo(targetUrl2+"?openID="+openID);
                       // goTo(targetUrl2);

                    });

                }
            },
            error: function (xhr, type) {
                showAlert("发送失败");
            }

        });

    }
</script>

</body>
<style scoped>
    .weui-cell{
        padding-bottom: 20px;
    }
    .weui-label{
        width: 75px;
    }
</style>

</html>
