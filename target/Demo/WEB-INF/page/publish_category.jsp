<%--
  Created by IntelliJ IDEA.
  User: bobo9978
  Date: 2017/10/24
  Time: 10:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>订单</title>
    <!-- 引入样式 -->
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <script charset="utf-8" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script src="../js/jquery/jquery-3.2.1.min.js"></script>
    <script src="../js/utils.js"></script>
</head>
<body onload="back_exit();">
<script>get_wx_config();</script>
<div class="page js_show">
    <div class="page__bd" style="height: 100%;">
        <div class="weui-tab">
            <div class="weui-tab__panel">
                <div class="weui-panel weui-panel_access" style="margin-bottom: 50px">
                    <div style="background-color: #f8f8f8; height:10px;"></div>
                    <div class="weui-cell">

                        <div class="weui-cell__hd">
                            <img src="../img/图标/account-filling.png" alt="" style="width:20px;margin-right:5px;display:block">
                        </div>
                        <div class="weui-cell__bd">
                            <p style="color: #20B2AA;">我发布的分享</p>
                        </div>
                    </div>


                    <a href="${pageContext.request.contextPath}/user/queryPublishWaitingConfirm" class="weui-cell weui-cell_access" href="javascript:;">
                        <div class="weui-cell__hd"><img src="../img/图标/folder.png" alt="" style="width:20px;margin-right:5px;display:block"></div>
                        <div class="weui-cell__bd">
                            <p>待确认</p>
                        </div>
                        <div class="weui-cell__ft"></div>
                    </a>
                    <a href="${pageContext.request.contextPath}/user/queryPublishWaitingService" class="weui-cell weui-cell_access" href="javascript:;">
                        <div class="weui-cell__hd"><img src="../img/图标/clock.png" alt="" style="width:20px;margin-right:5px;display:block"></div>
                        <div class="weui-cell__bd">
                            <p>待分享</p>
                        </div>
                        <div class="weui-cell__ft"></div>
                    </a>

                    <a href="${pageContext.request.contextPath}/user/queryPublishWaitingCollect" class="weui-cell weui-cell_access" href="javascript:;">
                        <div class="weui-cell__hd"><img src="../img/图标/Smile.png" alt="" style="width:20px;margin-right:5px;display:block"></div>
                        <div class="weui-cell__bd">
                            <p>待结算</p>
                        </div>
                        <div class="weui-cell__ft"></div>
                    </a>

                    <a href="${pageContext.request.contextPath}/user/queryPublishAlreadyComplete" class="weui-cell weui-cell_access" href="javascript:;">
                        <div class="weui-cell__hd"><img src="../img/图标/template-default.png" alt="" style="width:20px;margin-right:5px;display:block"></div>
                        <div class="weui-cell__bd">
                            <p>已完成</p>
                        </div>
                        <div class="weui-cell__ft"></div>
                    </a>


                    <div style="background-color: #f8f8f8; height:10px;"></div>


                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <img src="../img/图标/account-filling.png" alt="" style="width:20px;margin-right:5px;display:block">
                        </div>
                        <div class="weui-cell__bd">
                            <p style="color: #20B2AA;">我申请的分享</p>
                        </div>
                        <div class="weui-cell__ft"></div>
                    </div>

                    <a href="${pageContext.request.contextPath}/user/queryOrderAlreadyApply" class="weui-cell weui-cell_access" href="javascript:;">
                        <div class="weui-cell__hd"><img src="../img/图标/text.png" alt="" style="width:20px;margin-right:5px;display:block"></div>
                        <div class="weui-cell__bd">
                            <p>已申请</p>
                        </div>
                        <div class="weui-cell__ft"></div>
                    </a>

                    <a href="${pageContext.request.contextPath}/user/queryOrderWaitingService" class="weui-cell weui-cell_access" href="javascript:;">
                        <div class="weui-cell__hd"><img src="../img/图标/clock.png" alt="" style="width:20px;margin-right:5px;display:block"></div>
                        <div class="weui-cell__bd">
                            <p>待分享</p>
                        </div>
                        <div class="weui-cell__ft"></div>
                    </a>

                    <a href="${pageContext.request.contextPath}/user/queryOrderWaitingPay" class="weui-cell weui-cell_access" href="javascript:;">
                        <div class="weui-cell__hd"><img src="../img/图标/Smile.png" alt="" style="width:20px;margin-right:5px;display:block"></div>
                        <div class="weui-cell__bd">
                            <p>待结算</p>
                        </div>
                        <div class="weui-cell__ft"></div>
                    </a>

                    <a href="${pageContext.request.contextPath}/user/queryOrderAlreadyComplete" class="weui-cell weui-cell_access" href="javascript:;">
                        <div class="weui-cell__hd"><img src="../img/图标/template-default.png" alt="" style="width:20px;margin-right:5px;display:block"></div>
                        <div class="weui-cell__bd">
                            <p>已完成</p>
                        </div>
                        <div class="weui-cell__ft"></div>
                    </a>


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

</body>

<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script>
    $(document).ready(function () {
        $('.weui-tabbar:eq(0)').find('a:eq(1)').addClass("weui-bar__item_on");
    });
</script>

</html>
