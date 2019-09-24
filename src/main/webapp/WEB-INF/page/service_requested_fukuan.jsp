<%@ page import="java.util.List" %>
<%@ page import="com.springmvc.entity.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>待结算</title>
    <!-- 引入 WeUI -->
    <link rel="stylesheet" href="../css/weui.min.css" />
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script src="../js/scan/function.js"></script>
    <script src="../js/utils.js"></script>
</head>
<body onpageshow="back_to('${pageContext.request.contextPath}/publish/category');">

<%
    List<OrderDetail> recordDetailList = (List<OrderDetail>) request.getAttribute("recordDetailList");
%>
<%!
    String formatTime(Long ms){
        Integer mi = 60;
        Integer hh = mi * 60;
        Integer dd = hh * 24;

        Long day = ms / dd;
        Long hour = (ms - day * dd) / hh;
        Long minute = (ms - day * dd - hour * hh) / mi;
        Long second = (ms - day * dd - hour * hh - minute * mi) ;
        //Long milliSecond = ms - day * dd - hour * hh - minute * mi - second * ss;

        StringBuffer sb = new StringBuffer();
        if(day > 0) {
            sb.append(day+"天");
        }
        if(hour > 0) {
            sb.append(hour+"小时");
        }
        if(minute > 0) {
            sb.append(minute+"分");
        } else {
            sb.append(0+"分");
        }
        if(second > 0) {
            sb.append(second+"秒");
        } else {
            sb.append(0+"秒");
        }

        return sb.toString();
    }
%>

<div class="page">
    <div class="page__bd" style="height: 100%;">
            <%--<div class="weui-cell"style="font-size: 15px;background-color: #f8f8f8;position:fixed;width:100%;z-index:1000;padding-bottom:0px">
                <div class="weui-flex__item"id="return" onclick="history.go(-1)" >
                    <p><img src="../img/返回.png" width="20" height="15"alt="">待付款</p>
                </div>
                <div class="weui-flex__item"></div>
                <div class="weui-flex__item"></div>
            </div>--%>
            <div class="weui-navbar" style="position:fixed;">
                <div class="weui-navbar__item"id="navbar1">
                    已预约
                </div>
                <div class="weui-navbar__item"id="navbar2">
                    待分享
                </div>
                <div class="weui-navbar__item weui-bar__item_on"id="navbar3" style="color: #20B2AA;">
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
                                <div class="weui-flex__item"diaplay="none"><h4 class="weui-media-box__title"style="color: #20B2AA;">待支付
                                    <%
                                        out.print(recordDetailList.get(i).getOrder().getTxpoint());

                                    %>积分</h4></div>
                                <div class="weui-flex__item"display="none"></div>
                                <div class="weui-flex__item"display="none"></div>
                            </div>
                            <p class="weui-media-box__desc">订单号编号 <%out.print(recordDetailList.get(i).getOrder().getStatus());%></p>
                            <p class="weui-media-box__desc">分享标题: <%out.print(recordDetailList.get(i).getPublish().getTheme());%></p>
                            <p class="weui-media-box__desc">分享开始时间
                                <%
                                    out.print(recordDetailList.get(i).getOrder().getBegintime());

                                %></p>
                            <p class="weui-media-box__desc">分享结束时间
                                <%
                                    out.print(recordDetailList.get(i).getOrder().getEndtime());

                                %></p>

                            <p class="weui-media-box__desc">分享发布者：<%out.print(recordDetailList.get(i).getServiceUser().getName());%></p>
                            <p class="weui-media-box__desc">请在分享结束后十天内完成支付,否则将损失押金。
                                </p>

                        </div>
                    </div>
                    <div class="weui-cell">
                        <div class="weui-cell__bd">
                            <div class="weui-flex">
                                <div class="weui-flex__item"diaplay="none"></div>
                                <div class="weui-flex__item"display="none"></div>
                                <div class="weui-flex__item"> <a class="weui-btn weui-btn_mini weui-btn_primary" style="float:right;"href="${pageContext.request.contextPath}<%out.print("/user/applyUserStartPay?recordID="+recordDetailList.get(i).getOrder().getStatus());%>">支付积分</a></div>
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

    //var recordList=<%=recordDetailList%>;
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

        /*$("#payBtn").on('click',function () {
            //location.href="/user/applyUserPayTimeCoin?recordID="+$("#payBtn").attr("value");
            //alert($("#payBtn").attr("value"));
            $.ajax({
                type: 'POST',
                cache: false,
                url: "http://www.hlb9978.com/user/applyUserPayTimeCoin",
                //dataType:'JSONP',
                data: "recordID=" + $("#payBtn").attr("value"),
                beforeSend: function (XHR) {
                    dialogLoading = showLoading();
                },
                success: function (data) {
                    //alert(data);
                    showAlert("支付成功",function () {
                        goTo("http://www.hlb9978.com/user/queryOrderAlreadyComplete");
                    })
                },
                error: function (xhr, type) {
                    //alert(type);
                    showAlert("支付失败",function () {
                        //goTo("http://www.hlb9978.com/user/queryOrderWaitingPay");
                    })
                },
                complete: function (xhr, type) {
                    dialogLoading.hide();
                }
            });
        });*/
    });
</script>

</body>
</html>