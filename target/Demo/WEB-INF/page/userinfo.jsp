
<%@ page import="com.springmvc.entity.User" %><%--
  Created by IntelliJ IDEA.
  User: toyking
  Date: 2017/10/24
  Time: 14:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <title>我的信息</title>
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <script src="../js/jquery/jquery-3.2.1.min.js"></script>
    <script src="../js/utils.js"></script>
    <script charset="utf-8" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
</head>
<body onload="back_exit();">
<script>get_wx_config();</script>
<div class="weui-tab__panel">
    <%
        User userEntity = (User) request.getAttribute("user");
    %>
    <a class="weui-cell weui-cell_access" href="${pageContext.request.contextPath}/user/userdetail">
        <div class="weui-cell__hd" style="position: relative;margin-right: 10px;">
            <img src="<%out.print(userEntity.getHeadImage());%>" style="width: 50px;display: block">
        </div>
        <div class="weui-cell__bd">
            <p><%out.print(userEntity.getName());%></p>

        </div>
        <div class="weui-cell__ft">
        </div>
    </a>
    <div style="background-color: #f8f8f8; height:10px;"></div>

    <a class="weui-cell weui-cell_access" href="${pageContext.request.contextPath}/user/credit">
        <div class="weui-cell__hd"><img src="../img/图标/dollar.png" alt="" style="width:20px;margin-right:5px;display:block"></div>
        <div class="weui-cell__bd">
            <p>积分余额</p>
        </div>
        <div class="weui-cell__ft"style="color: #20B2AA;"><%out.print(userEntity.getPoint());%></div>
    </a>
    <div style="background-color: #f8f8f8; height:10px;"></div>





    <a href="${pageContext.request.contextPath}/user/queryPublishAlreadyPublish" class="weui-cell weui-cell_access" >
        <div class="weui-cell__hd"><img src="../img/图标/text.png" alt="" style="width:20px;margin-right:5px;display:block"></div>
        <div class="weui-cell__bd">
            <p>已发布</p>
        </div>
        <div class="weui-cell__ft"></div>
    </a>
    <div style="background-color: #f8f8f8; height:10px;"></div>


    <div class="weui-cell">

        <div class="weui-cell__hd"><img src="../img/图标/bussiness-man.png" alt="" style="width:20px;margin-right:5px;display:block"></div>
        <div class="weui-cell__bd">
            <p style="display: block">信誉分值</p>
        </div>
        <div class="weui-cell__ft">
            <p style="color:#20B2AA;"><%out.print(userEntity.getEvaluation());%>星</p>
        </div>
    </div>


    <div style="background-color: #f8f8f8; height:10px;"></div>
    <div class="weui-cell">
        <div class="weui-cell__bd">
            <div class="weui-flex">
                <div class="weui-flex__item" display="none">
                   <%-- <a href="${pageContext.request.contextPath}/user/scan" class="weui-btn weui-btn_mini weui-btn_primary">扫码</a>--%>
                </div>
                <div class="weui-flex__item" display="none"></div>
                <div class="weui-flex__item" display="none"></div>
                <div class="weui-flex__item"><a href="${pageContext.request.contextPath}/user/logout" class="weui-btn weui-btn_mini weui-btn_primary" style="float:right;">退出</a></div>
            </div>
        </div>
    </div>

    </div>

<div class="weui-tabbar" style="height: 50px">
    <a href="${pageContext.request.contextPath}/index" class="weui-tabbar__item">
        <img src="../img/图标/all.png" alt="" class="weui-tabbar__icon">
        <p class="weui-tabbar__label" >首页</p>
    </a>
    <a href="${pageContext.request.contextPath}/publish/favor" class="weui-tabbar__item">
        <img src="../img/图标/favorite.png" alt="" class="weui-tabbar__icon">
        <p class="weui-tabbar__label">收藏</p>
    </a>
    <a href="${pageContext.request.contextPath}/publish/add" class="weui-tabbar__item">
        <img src="../img/图标/加号.png" alt="" class="weui-tabbar__icon">
        <p class="weui-tabbar__label">发布</p>
    </a>
    <a href="${pageContext.request.contextPath}/publish/category" class="weui-tabbar__item">
        <img src="../img/图标/form.png" alt="" class="weui-tabbar__icon">
        <p class="weui-tabbar__label"style="color: #999999;">订单</p>
    </a>
    <a href="${pageContext.request.contextPath}/user/" class="weui-tabbar__item">
        <img src="../img/图标/personal-center3.png" alt="" class="weui-tabbar__icon">
        <p class="weui-tabbar__label" style="color: #20B2AA;">我</p>
    </a>
</div>


<!-- jQuery 3 -->
<script src="../js/jquery/jquery-3.2.1.min.js"></script>

<script>
    $(document).ready(function () {
        $('.weui-tabbar:eq(0)').find('a:eq(3)').addClass("weui-bar__item_on");
    });
</script>

</body>
</html>