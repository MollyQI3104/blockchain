<%@ page import="com.springmvc.entity.*" %>
<%@ page import="java.util.List" %>

<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <style>
        li{
            padding:2px;
        }

    </style>
    <title>已发布</title>
    <!-- 引入 WeUI -->
    <link rel="stylesheet" href="../css/weui.min.css" />
    <script src="../js/utils.js"></script>
</head>
<body onpageshow="back_to('${pageContext.request.contextPath}/publish/category');">
<%
    List<PublishDetail> publishList = (List<PublishDetail>) request.getAttribute("publishList");
%>
<div class="page">
    <div class="page__bd" style="height: 100%;">
        <%--<div class="weui-cell" style="font-size: 15px;background-color: #f8f8f8;position:fixed;width:100%;z-index:1000;padding-bottom:0px">
            <div id="return" onclick="history.go(-1)"><img src="../img/返回.png" width="20" height="15"alt="">已发布</div>
        </div>--%>


        <div class="weui-tab">
            <div class="weui-panel__hd">
                <span>已发布的物品分享</span>

            </div>
            <!--tab_pannel为navbar中自带的显示界面详细-->
            <div class="weui-tab__panel" style="padding-bottom: 50px; ">
                <!--以下为界面显示部分，需要循环的部分，以下可修改-->
                <%
                    for (int i=0;i<publishList.size();i++) {
                %>
                <div class="weui-panel__bd">
                    <div class="weui-media-box weui-media-box_appmsg">
                        <div class="weui-media-box__hd">
                            <img class="weui-media-box__thumb" width="60" height="60"src="../img/物品类型/<%out.print(publishList.get(i).getPublish().getType());%>.png" alt="">
                        </div>
                        <div class="weui-media-box__bd">
                            <div class="weui-flex">
                                <div class="weui-flex__item"diaplay="none"><h4 class="weui-media-box__title" style="color: #20B2AA;"><%out.print(publishList.get(i).getPublish().getTheme());%></h4></div>
                                <div class="weui-flex__item"display="none"></div>
                                <div class="weui-flex__item"display="none"></div>
                            </div>
                            <ul>
                            <li class="weui-media-box__desc">物品类型 : <%out.print(publishList.get(i).getPublish().getType());%></li>
                            <li class="weui-media-box__desc">交易地址 : <%out.print(publishList.get(i).getPublish().getAddress());%></li>
                            <li class="weui-media-box__desc">预留微信ID : <%out.print(publishList.get(i).getUser().getWechat());%></li>
                            <li class="weui-media-box__desc">物品分享时间至
                                <%
                                    PublishDetail viewPublishDetailEntity = publishList.get(i);
                                    out.print(viewPublishDetailEntity.getPublish().getEndDate());
                                %>结束</li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="weui-cell">
                <div class="weui-cell__bd">
                    <div class="weui-flex">
                        <div class="weui-flex__item"diaplay="none"></div>
                        <div class="weui-flex__item"display="none"></div>
                        <div class="weui-flex__item"><a href="<%out.print("deletePublish?id="+viewPublishDetailEntity.getPublish().getPublishStatus());%>" class="weui-btn weui-btn_mini weui-btn_default" style="float:right;">删除</a></div>
                        <div class="weui-flex__item"><a href="<%out.print("fabuDetail?id="+viewPublishDetailEntity.getPublish().getPublishStatus());%>" class="weui-btn weui-btn_mini weui-btn_primary" style="float:right;">查看</a></div>
                    </div>
                </div>
                </div>
                <div style="background-color: #f8f8f8; height:10px;"></div>
                <%}%>
                <!--一个订单详情结束，以上可修改-->
            </div>
            <!--weui-tab_panel的结束位置-->
        </div>
    </div>
    <div class="weui-tabbar" style="height: 50px">
        <a href="${pageContext.request.contextPath}/index" class="weui-tabbar__item">
            <img src="../img/图标/all.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label" >首页</p>
        </a>
        <a href="${pageContext.request.contextPath}/publish/favor" class="weui-tabbar__item">
            <img src="../img/图标/favorite.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label"style="color: #999999;">收藏</p>
        </a>
        <a href="${pageContext.request.contextPath}/publish/add" class="weui-tabbar__item">
            <img src="../img/图标/加号.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label">发布</p>
        </a>
        <a href="${pageContext.request.contextPath}/publish/category" class="weui-tabbar__item">
            <img src="../img/图标/form3.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label" style="color: #20B2AA;">订单</p>
        </a>
        <a href="${pageContext.request.contextPath}/user/" class="weui-tabbar__item">
            <img src="../img/图标/personal-center.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label">我</p>
        </a>
    </div>
</div>
</div>
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
    $(function(){
        $("#navbar1").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            location.href="queryPublishAlreadyPublish";
        });
        $("#navbar2").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            location.href="queryPublishWaitingConfirm";

        });
        $("#navbar3").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            location.href="queryPublishWaitingService";

        });
        $("#navbar4").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            location.href="queryPublishWaitingCollect";
        });
        $("#navbar5").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            location.href="queryPublishAlreadyComplete";
        });
    });
</script>

</body>
</html>