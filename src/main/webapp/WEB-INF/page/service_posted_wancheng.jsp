<%@ page import="com.springmvc.entity.*" %>

<%@ page import="java.util.List" %>

<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.Timestamp" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>已完成</title>
    <!-- 引入 WeUI -->
    <link rel="stylesheet" href="../css/bootstrap.min.css" />
    <link rel="stylesheet" href="../css/weui.min.css" />
    <script src="../js/utils.js"></script>
</head>
<body onpageshow="back_to('${pageContext.request.contextPath}/publish/category');">
<%
    List<OrderDetail> recordDetailList = (List<OrderDetail>) request.getAttribute("recordDetailList");
%>
<div class="page">
    <div class="page__bd" style="height: 100%;">
        <div class="weui-tab">
           <%-- <div class="weui-cell" style="font-size: 15px;background-color: #f8f8f8;position:fixed;width:100%;z-index:1000;padding-bottom:0px;height:34px;">
                <div class="weui-flex__item"id="return" onclick="history.go(-1)" >
                    <p style="margin:0"><img src="../img/返回.png" width="20" height="15"alt="">已完成</p>
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
                <div class="weui-navbar__item"id="navbar4">
                    待结算
                </div>
                <div class="weui-navbar__item weui-bar__item_on"id="navbar5" style="color: #20B2AA;">
                    已完成
                </div>
            </div>
            <!--tab_pannel为navbar中自带的显示界面详细-->
            <div class="weui-tab__panel" style="padding-bottom: 50px; padding-top: 70px">
                <!--以下为界面显示部分，需要循环的部分，以下可修改-->
                <%
                    for (int i=0;i<recordDetailList.size();i++) {
                %>
                <div class="page__bd">
                    <div class="weui-form-preview">
                        <div class="weui-form-preview__hd">
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label" style="font-size: 1.2em;" >订单状态</label>
                                <em class="weui-form-preview__value" style="font-size: 1.4em;"><%
                                    if(recordDetailList.get(i).getOrder().getFlag().equals("1")) {
                                        out.print("交易取消");
                                    }
                                    else out.print("交易完成");
                                %>
                                </em>
                            </div>
                        </div>
                        <div class="weui-form-preview__bd">
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">订单号</label>
                                <span class="weui-form-preview__value">
                                    <%
                                        out.print(recordDetailList.get(i).getOrder().getStatus());
                                    %>
                                </span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">分享交易积分</label>
                                <span class="weui-form-preview__value">
                                    <%
                                        if(recordDetailList.get(i).getOrder().getFlag().equals("0")){
                                            out.print(recordDetailList.get(i).getOrder().getTxpoint()+"积分");

                                        }
                                        if(recordDetailList.get(i).getOrder().getFlag().equals("1"))
                                        {
                                            out.print("分享未进行，未产生费用");
                                        }
                                        if(recordDetailList.get(i).getOrder().getFlag().equals("2"))
                                        {
                                            out.print("发布者结束未归还订单,申请者支付押金"+recordDetailList.get(i).getPublish().getDeposit());
                                        }
                                        if(recordDetailList.get(i).getOrder().getFlag().equals("3"))
                                        {
                                            out.print("发布者结束未支付订单,申请者支付押金"+recordDetailList.get(i).getPublish().getDeposit());
                                        }
                                    %>
                                </span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">分享对象</label>
                                <span class="weui-form-preview__value"><%out.print(recordDetailList.get(i).getApplyUser().getName());%></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">分享开始时间</label>
                                <span class="weui-form-preview__value">
                                     <%
                                         if(recordDetailList.get(i).getOrder().getFlag().equals("0")){
                                             out.print(recordDetailList.get(i).getOrder().getBegintime());
                                         }else{
                                             out.print("分享未进行，无分享时间");
                                         }
                                     %>
                                </span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">分享结束时间</label>
                                <span class="weui-form-preview__value"  >
                                     <%
                                         if(recordDetailList.get(i).getOrder().getFlag().equals("0")){

                                             out.print(recordDetailList.get(i).getOrder().getEndtime());
                                         }else{
                                             out.print("分享未进行，无分享时间");
                                         }
                                     %>
                                </span>
                            </div>
                            <div class="weui-panel__ft">
                                <%--<a href="javascript:void(0);" class="weui-cell weui-cell_access weui-cell_link">
                                    <div class="weui-cell__bd">查看更多</div>
                                    <span class="weui-cell__ft"></span>
                                </a>--%>
                            </div>
                        </div>

                    </div>
                    <%

                        if(recordDetailList.get(i).getOrder().getFlag().equals("0")){


                    %>
                    <div class="weui-form-preview__ft">
                    <%
                        if(recordDetailList.get(i).getOrder().getServiceuserRating()==null){
                    %>
                    <div class="weui-form-preview__btn weui-form-preview__btn_default" >
                        暂未收到评价
                    </div>
                    <%
                    }
                    else{
                    %>
                        <a class="weui-form-preview__btn weui-form-preview__btn_default" href="${pageContext.request.contextPath}/user/checkApplyUserEvaluate?recordID=<%out.print(recordDetailList.get(i).getOrder().getStatus());%>">
                        查看收到的评价
                    </a>
                    <%
                        }
                    %>

                    <%
                        if(recordDetailList.get(i).getOrder().getApplyuserRating()==null){
                    %>
                    <a class="weui-form-preview__btn weui-form-preview__btn_primary" href="${pageContext.request.contextPath}/user/serviceUserStartEvaluate?recordID=<%out.print(recordDetailList.get(i).getOrder().getStatus());%>">
                        去评价
                    </a>
                    <%
                    }
                    else{
                    %>
                        <a class="weui-form-preview__btn weui-form-preview__btn_default" href="${pageContext.request.contextPath}/user/checkServiceUserEvaluate?recordID=<%out.print(recordDetailList.get(i).getOrder().getStatus());%>">
                        已评价,点击查看
                    </a>
                    <%
                        }
                    %>

                </div>
                    <%
                        }

                    %>
                    <div style="background-color: #f8f8f8; height:15px;"></div>
                </div>
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
            <img src="../img/图标/form.png" alt="" class="weui-tabbar__icon">
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