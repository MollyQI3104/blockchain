<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.springmvc.entity.*" %>
<%@ page import="javax.xml.crypto.Data" %>
<%@ page import="javafx.scene.chart.PieChart" %>
<%@ page import="java.sql.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <title>我的信息</title>
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
</head>
<body>
<div class="weui-cells__title">个人信息</div>
<a class="weui-tab__panel">
    <%
        User userEntity = (User) request.getAttribute("user");
    %>
        <div class="weui-cell">
        <div class="weui-cell__bd">
            <p>头像</p>
        </div>
        <div class="weui-cell__ft"style="">
            <img src="<%out.print(userEntity.getHeadImage());%>" style="width: 50px;display: block">
        </div>
        </div>

    <a class="weui-cell weui-cell_access" href="${pageContext.request.contextPath}/user/ChangePassword">
        <div class="weui-cell__bd">
            <p>昵称: <%out.print(userEntity.getName());%></p>
        </div>
        <div class="weui-cell__ft"style="">
            <p>修改</p>
        </div>
    </a>



    <a class="weui-cell weui-cell_access" href="${pageContext.request.contextPath}/user/ChangePassword">
        <div class="weui-cell__bd">
            <p>微信ID: <%out.print(userEntity.getWechat());%></p>
        </div>
        <div class="weui-cell__ft"style="">
            <p>修改</p>
        </div>
    </a>
    <div style="background-color: #f8f8f8; height:10px;"></div>
</div>
<!-- jQuery 3 -->
<script src="../js/jquery/jquery-3.2.1.min.js"></script>


</body>
</html>
