<%--
  Created by IntelliJ IDEA.
  User: xu
  Date: 2017/7/12
  Time: 下午2:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta name="full-screen" content="yes">
    <meta name="x5-fullscreen" content="true">
    <title>扫码</title>
    <link href="../css/weui.min.css" rel="stylesheet" />
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script charset="utf-8" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script src="../js/scan/function.js"></script>
    <script src="../js/scan/configs.js"></script>
</head>
<body>
<%
    String recordID = (String) request.getAttribute("recordID");
%>
<div class="page">
    <div class="weui-msg">
        <div class="weui-msg__icon-area">
            <i class='weui-icon-warn weui-icon_msg'></i>
        </div>

        <div class="weui-msg__text-area">

            <p class="weui-msg__desc">
                在物品最迟归还日期到期后,点击确认结束将获得押金,结束订单!
            </p>
        </div>
        <!--以上~~-->
        <div class="weui-msg__opr-area">
            <p class="weui-btn-area">
                <a class="weui-btn weui-btn_primary" id="button1">确认结束</a>
            </p>
        </div>
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

    var contextPath="${pageContext.request.contextPath}";


            $("#button1").on('click', function () {
                var targetUrl = contextPath+"/user/serviceUserFinishGiveBack2";
                var targetUrl2 =contextPath+"/user/queryPublishAlreadyComplete";
                var targetUrl3 =contextPath+"/user/queryPublishWaitingService";

                var recordID = getQueryString("recordID");

                            $.ajax({
                                type: 'POST',
                                cache: false,
                                url: targetUrl,
                                data: "recordID=" + recordID,
                                beforeSend: function (XHR) {
                                    dialogLoading = showLoading();
                                },
                                success: function (data) {

                                    if(data==="success"){
                                        showAlert("订单已结束!",function () {
                                            goTo(targetUrl2);
                                        })
                                    }
                                    if(data==="fail"){
                                        showAlert("当前时间不能结束订单!",function () {
                                            goTo(targetUrl3);
                                        })
                                    }


                                },
                                error: function (xhr, type) {
                                    showAlert("失败",function () {
                                        goTo(targetUrl2);
                                    })
                                },
                                complete: function (xhr, type) {
                                    dialogLoading.hide();
                                }
                            });
                //window.location.href = "http://www.baidu.com?t="+new Date().getTime();
            });

    </script>
</body>
</html>
