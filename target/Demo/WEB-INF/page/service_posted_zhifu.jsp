<%@ page import="java.util.List" %>
<%@ page import="com.springmvc.entity.*" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="java.util.Calendar" %>

<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>待结算</title>
    <!-- 引入 WeUI -->
    <link rel="stylesheet" href="../css/weui.min.css" />
    <link rel="stylesheet" href="../css/Item.css"/>
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script src="../js/scan/function.js"></script>
    <script src="../js/scan/configs.js"></script>
    <script src="../js/scan/configs.js"></script>
    <script src="../js/scan/function.js"></script>
    <script src="../js/utils.js"></script>
</head>
<body>
<%
    List<OrderDetail> recordDetailList = (List<OrderDetail>) request.getAttribute("recordDetailList");
%>
<div class="main-container">
    <div class="main-content">
<div class="page">
    <div class="page__bd" style="height: 100%;">
        <div class="weui-tab">
            <%--<div class="weui-cell" style="font-size: 15px;background-color: #f8f8f8;position:fixed;width:100%;z-index:1000;padding-bottom:0px">
                <div class="weui-flex__item"id="return" onclick="history.go(-1)" >
                    <p><img src="../img/返回.png" width="20" height="15"alt="">待收款</p>
                </div>
                <div class="weui-flex__item"></div>
                <div class="weui-flex__item"></div>
            </div>--%>
            <div class="weui-navbar" style="position:fixed;">

                <div class="weui-navbar__item"id="navbar2">
                    待确认
                </div>
                <div class="weui-navbar__item"id="navbar3">
                    待分享
                </div>
                <div class="weui-navbar__item weui-bar__item_on"id="navbar4" style="color: #20B2AA;">
                    待结算
                </div>
                <div class="weui-navbar__item"id="navbar5">
                    已完成
                </div>
            </div>
            <!--tab_pannel为navbar中自带的显示界面详细-->
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
                                <div class="weui-flex__item"diaplay="none"><h4 class="weui-media-box__title" style="color:#20B2AA">待收 :
                                    <%
                                        out.print(recordDetailList.get(i).getOrder().getTxpoint());

                                    %>积分</h4></div>
                                <div class="weui-flex__item"display="none"></div>
                                <div class="weui-flex__item"display="none"></div>
                            </div>
                            <p class="weui-media-box__desc">分享标题: <%out.print(recordDetailList.get(i).getPublish().getTheme());%></p>
                            <p class="weui-media-box__desc">分享对象: <%out.print(recordDetailList.get(i).getServiceUser().getName());%></p>
                            <p class="weui-media-box__desc">分享开始时间:
                                <%
                                    out.print(recordDetailList.get(i).getOrder().getBegintime());
                                %></p>
                            <p class="weui-media-box__desc">分享结束时间:
                                <%
                                    out.print(recordDetailList.get(i).getOrder().getEndtime());
                                %></p>
                            <p class="weui-media-box__desc">分享单价:
                                <%
                                    out.print(recordDetailList.get(i).getPublish().getPrice()+"积分/天");
                                %></p>
                            <p class="weui-media-box__desc">分享结束后十天内未收到支付,可结束订单获得押金。
                            </p>
                            <%--<ul class="weui-media-box__info">
                                <li class="weui-media-box__info__meta"><%out.print(recordDetailList.get(i).getAddress());%></li>
                                <li class="weui-media-box__info__meta weui-media-box__info__meta_extra">其他信息</li>
                            </ul>--%>
                        </div>

                    </div>
                    <div class="weui-cell">
                        <div class="weui-cell__bd">
                            <div class="weui-flex">
                                <div class="weui-flex__item"diaplay="none"></div>
                                <div class="weui-flex__item"display="none"></div>
                                <div class="weui-flex__item">
                                    <%
                                        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                                        Date myEndtime = dateFormat.parse(recordDetailList.get(i).getOrder().getEndtime());
                                        Calendar cal = Calendar.getInstance();
                                        cal.setTime(myEndtime);
                                        cal.add(Calendar.DAY_OF_YEAR,10);
                                        Date DateEndReturntime = cal.getTime();

                                        String str = dateFormat.format(new Date());
                                        Date nowTime=dateFormat.parse(str);
                                        cal.setTime(nowTime);
                                        Date now = cal.getTime();

                                        int flag = DateEndReturntime.compareTo(now);
                                        if(flag <= 0){


                                    %><a id="button1" class="weui-btn weui-btn_mini weui-btn_primary" style="float:right;"href="${pageContext.request.contextPath}<%out.print("/user/serviceUserFinishOrder?recordID="+recordDetailList.get(i).getOrder().getStatus());%>">结束订单</a></div>
                                <%}
                                else{%>
                                    <a id="button2" class="weui-btn weui-btn_mini weui-btn_primary" style="background-color: #999; color:#fff; border:0px;float:right;"onclick="return false;">结束订单</a></div>
                                <% }%>

                            </div>
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

</div>
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
    var url='${pageContext.request.contextPath}';
    $("#create").on("click", function() {
        goTo(url+"/publish/add");
    });
    var xmlHttpRequest;
    $(function(){
        if(window.XMLHttpRequest){
            xmlHttpRequest=new XMLHttpRequest();
        }else{
            xmlHttpRequest=new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlHttpRequest.open("GET","AjaxServlet",true);
    });




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