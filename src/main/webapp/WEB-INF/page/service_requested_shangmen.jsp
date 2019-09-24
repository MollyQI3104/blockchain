<%@ page import="java.util.List" %>
<%@ page import="com.springmvc.entity.*" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>待分享</title>
    <!-- 引入 WeUI -->
    <link rel="stylesheet" href="../css/weui.min.css" />
    <script src="../js/utils.js"></script>
</head>
<body onpageshow="back_to('${pageContext.request.contextPath}/publish/category');">
<%
    List<OrderDetail> recordDetailList = (List<OrderDetail>) request.getAttribute("recordDetailList");
%>
<div class="page">
    <div class="page__bd" style="height: 100%;">
            <%--<div class="weui-cell" style="font-size: 15px;background-color: #f8f8f8;position:fixed;width:100%;z-index:1000;padding-bottom:0px">
                <div class="weui-flex__item"id="return" onclick="history.go(-1)" >
                    <p><img src="../img/返回.png" width="20" height="15"alt="">待服务</p>
                </div>
                <div class="weui-flex__item"></div>
                <div class="weui-flex__item"></div>
            </div>--%>
            <div class="weui-navbar" style="position:fixed;">
                <div class="weui-navbar__item "id="navbar1">
                    已申请
                </div>
                <div class="weui-navbar__item weui-bar__item_on"id="navbar2" style="color: #20B2AA;">
                    待分享
                </div>
                <div class="weui-navbar__item"id="navbar3">
                    待结算
                </div>
                <div class="weui-navbar__item"id="navbar4">
                    已完成
                </div>
            </div>
            <!--tab_pannel为navbar中自带的显示界面详细-->
        <div class="weui-tab">
            <div class="weui-tab__panel" style="padding-bottom: 50px; padding-top: 70px">
                <!--以下为界面显示部分，需要循环的部分，以下可修改-->
                <%
                    for (int i=0;i<recordDetailList.size();i++) {
                %>
                <div class="weui-panel__bd">
                    <div class="weui-media-box weui-media-box_appmsg">
                        <div class="weui-media-box__hd">
                            <img class="weui-media-box__thumb" width="60" height="60"src="../img/物品类型/<%out.print(recordDetailList.get(i).getPublish().getType());%>.png" alt="">
                        </div>
                        <div class="weui-media-box__bd">
                            <div class="weui-flex">
                                <div class="weui-flex__item"diaplay="none"><h4 class="weui-media-box__title"><%out.print(recordDetailList.get(i).getPublish().getTheme());%></h4></div>
                                <div class="weui-flex__item"display="none"></div>
                                <div class="weui-flex__item"display="none"></div>
                            </div>
                            <p class="weui-media-box__desc">订单编号 : <%out.print(recordDetailList.get(i).getOrder().getStatus());%>
                            </p>

                            <p class="weui-media-box__desc">物品最迟归还日期:  <%
                                out.print(recordDetailList.get(i).getOrder().getEstimateReturntime());
                            %></p>
                            <p class="weui-media-box__desc">押金: <%out.print(recordDetailList.get(i).getPublish().getDeposit());%>积分</p>

                            <p class="weui-media-box__desc">分享发布者 : <%out.print(recordDetailList.get(i).getServiceUser().getName());%></p>
                            <p class="weui-media-box__desc">发布者微信ID : <%out.print(recordDetailList.get(i).getServiceUser().getWechat());%></p>
                            <p class="weui-media-box__desc">订单状态:  <%
                                if(recordDetailList.get(i).getOrder().getBegintime()==null){
                                    out.print("已确认");
                                }else if(recordDetailList.get(i).getOrder().getEndtime()==null){
                                    out.print("分享中");
                                }else{
                                    out.print("分享结束");
                                }
                            %></p>
                            <p class="weui-media-box__desc"><%
                                if(recordDetailList.get(i).getOrder().getBegintime()!=null && recordDetailList.get(i).getOrder().getEndtime()==null){
                                    out.print("请在"+recordDetailList.get(i).getOrder().getEstimateReturntime()+"前联系发布者扫码结束分享");
                                }
                            %></p>
                        </div>
                    </div>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <div class="weui-flex">
                            <div class="weui-flex__item" display="none"></div>
                            <div class="weui-flex__item" display="none"></div>
                            <div class="weui-flex__item"><a href="${pageContext.request.contextPath}/user/show_qrcode?id=<%out.print(recordDetailList.get(i).getOrder().getStatus());%>" class="weui-btn weui-btn_mini weui-btn_primary" style="float:right;">二维码</a></div>
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
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
    $(function(){
        $("#navbar1").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            location.href="queryOrderAlreadyApply";
        });
        $("#navbar2").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            location.href="queryOrderWaitingService";

        });
        $("#navbar3").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            location.href="queryOrderWaitingPay";

        });
        $("#navbar4").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            location.href="queryOrderAlreadyComplete";
        });
    });
</script>

</body>
</html>