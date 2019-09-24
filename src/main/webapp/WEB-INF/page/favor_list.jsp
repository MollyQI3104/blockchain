<%@ page import="com.springmvc.entity.PublishDetail" %>
<%@ page import="com.springmvc.entity.Publish" %>
<%@ page import="com.springmvc.entity.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%--
  Created by IntelliJ IDEA.
  User: caozihan
  Date: 2017/12/20
  Time: 13:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <title>收藏列表</title>
    <style>
        .overtimeFlag{
            float:right;
            font-size:16px;
            color:#848c99;
            margin-top: 28px;
        }
    </style>
</head>
<body>
<div class="weui-tab">
    <div class="weui-tab__panel">
        <div class="weui-panel weui-panel_access">
            <div class="weui-panel__hd">
                <span><%out.print(request.getAttribute("type"));%></span>
                <a href="${pageContext.request.contextPath}/publish/select?type=<%out.print(request.getAttribute("type"));%>" style="float:right;color:#20B2AA; ">
                    筛选  <img class="weui-media-box__thumb" src="../img/图标/product-features.png" style="height: 13px;" alt="">
                </a>
            </div>

            <div class="weui-panel__bd">

                <%
                    List<PublishDetail> list = (List<PublishDetail>) request.getAttribute("list");
                    for (int i = 0; i < list.size(); i++) {
                        PublishDetail viewPublishEntity = list.get(i);

                %>

                <a href="<%out.print("detail?publishID="+viewPublishEntity.getPublish().getPublishStatus());%>" class="weui-media-box weui-media-box_appmsg">
                    <div class="weui-media-box__hd">
                        <img class="weui-media-box__thumb" style="" src="<%out.print(viewPublishEntity.getUser().getHeadImage());%>">
                    </div>
                    <div class="weui-media-box__bd">
                        <h4 class="weui-media-box__title" style="display:inline-block"><%out.print(viewPublishEntity.getPublish().getTheme());%></h4>

                        <%
                            Date currentDate = new Date();
                            SimpleDateFormat sdf=new SimpleDateFormat("yyyy/MM/dd");
                            String currentTime = sdf.format(currentDate);

                            Date endTime = new SimpleDateFormat("yyyy-MM-dd").parse(viewPublishEntity.getPublish().getEndDate());

                            if(endTime.getTime() < new Date(currentTime).getTime()){
                                out.print("<span class='overtimeFlag'>已过期</span>");
                            }
                        %>
                        <div style="color: #20B2AA;">
                            <%
                                out.print(viewPublishEntity.getPublish().getPrice()+"积分/天"+"、"+viewPublishEntity.getPublish().getDeposit()+"积分押金");
                            %></div>
                        <div><p class="weui-media-box__desc">
                            <%out.print(viewPublishEntity.getUser().getName()+" (信誉值 "+viewPublishEntity.getUser().getEvaluation()+"星)");%> &nbsp;&nbsp;&nbsp;
                            <%out.print(viewPublishEntity.getPublish().getAddress());%>
                        </p></div>
                    </div>

                </a>

                <%}%>

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
        <img src="../img/图标/favorite3.png" alt="" class="weui-tabbar__icon">
        <p class="weui-tabbar__label" style="color: #20B2AA;">收藏</p>
    </a>
    <a href="${pageContext.request.contextPath}/publish/add" class="weui-tabbar__item">
        <img src="../img/图标/加号.png" alt="" class="weui-tabbar__icon">
        <p class="weui-tabbar__label" >发布</p>
    </a>
    <a href="${pageContext.request.contextPath}/publish/category" class="weui-tabbar__item">
        <img src="../img/图标/form.png" alt="" class="weui-tabbar__icon">
        <p class="weui-tabbar__label">订单</p>
    </a>
    <a href="${pageContext.request.contextPath}/user/" class="weui-tabbar__item">
        <img src="../img/图标/personal-center.png" alt="" class="weui-tabbar__icon">
        <p class="weui-tabbar__label">我</p>
    </a>
</div>
</div>
</div>

</body>
</html>


