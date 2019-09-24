<%@ page import="com.springmvc.entity.*" %>

<%@ page import="java.text.SimpleDateFormat" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>订单详情</title>
    <!-- 引入 WeUI -->
    <link rel="stylesheet" href="../css/weui.min.css" />
</head>
<body>
<%
    Order publishOrderEntity = (Order) request.getAttribute("publishOrderEntity");
    User userEntity = (User) request.getAttribute("userEntity");
    Publish publishEntity = (Publish) request.getAttribute("publishEntity");
    String status = (String)request.getAttribute("status");

%>
<div class="weui-cells">
    <div class="weui-cell">
        <div class="weui-cell__bd">
            <p>订单编号</p>
        </div>
        <div class="weui-cell__ft"><%out.print(publishOrderEntity.getStatus());%></div>
    </div>
</div>
<div class="weui-form-preview">
    <div class="weui-form-preview__hd">
        <label class="weui-form-preview__label">分享状态</label>
        <em class="weui-form-preview__value"><%=status%></em>
    </div>
    <div class="weui-form-preview__bd">
        <p>
            <label class="weui-form-preview__label">申请人</label>
            <span class="weui-form-preview__value"><%out.print(userEntity.getName());%></span>
        </p>

        <p>
            <label class="weui-form-preview__label">申请理由</label>
            <span class="weui-form-preview__value"><%out.print(publishOrderEntity.getReason());%></span>
        </p>


    </div>
    <div class="weui-form-preview__ft">
        <a class="weui-form-preview__btn weui-form-preview__btn_primary" href="${pageContext.request.contextPath}/user/queryPublishWaitingConfirm">返回</a>
    </div>
</div>
</body>
</html>