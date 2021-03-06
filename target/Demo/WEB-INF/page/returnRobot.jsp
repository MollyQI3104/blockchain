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
    <link href="../css/mobile-main.css" rel="stylesheet" />
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script charset="utf-8" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script src="../js/scan/function.js"></script>
    <script src="../js/scan/refundRobot5.js"></script>
    <script src="../js/scan/configs.js"></script>
</head>
<body>
<%
    String recordID = (String) request.getAttribute("recordID");
    boolean isFirst = (boolean) request.getAttribute("isFirst");
%>
<div class="page">
    <div class="weui-msg">
        <div class="weui-msg__icon-area">
            <img src="../img/扫一扫示例2.png" width="250" height="250">
        </div>
        <!--第一次扫码时h2和p内都显示/前的部分，第二次扫码显示后半部分-->
        <div class="weui-msg__text-area">
            <h2 class="weui-msg__title">
                <%
                    if(isFirst)
                        out.print("扫码开始物品共享");
                    else
                        out.print("扫码结束物品共享");
                %>
            </h2>
            <p class="weui-msg__desc">
                <%
                    if(isFirst)
                        out.print("您这是第一次扫码，将开始物品共享，共享结束后，请及时进行第二次扫码");
                    else
                        out.print("您这是第二次扫码，扫码成功后将结束此次共享");
                %>
            </p>
        </div>
        <!--以上~~-->
        <div class="weui-msg__opr-area">
            <p class="weui-btn-area">
                <a class="weui-btn weui-btn_primary" id="button1">扫码</a>
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
    $(function() {
            $("#button1").on('click', function () {
                var targetUrl = "http://"+getDomainName()+contextPath+"/user/serviceUserCompleteScan";
                var targetUrl2 = "http://"+getDomainName()+contextPath+"/user/queryPublishWaitingService";
                wx.scanQRCode(
                    {
                        needResult:1,
                        success:function(res){

                            //alert(JSON.stringify(res.resultStr));

                            var recordID = getQueryString("recordID");
                            //alert(JSON.stringify(recordID));
                            //setTimeout("window.location.href(/"http://www.baidu.com/")",500);
                            //window.location.href = "http://www.baidu.com?t="+new Date().getTime();
                            //return View("register");

                            $.ajax({
                                type: 'POST',
                                cache: false,
                                url: targetUrl,
                                data: "qrcode=" + res.resultStr + "&recordID=" + recordID,
                                beforeSend: function (XHR) {
                                    dialogLoading = showLoading();
                                },
                                success: function (data) {
                                    if(data==="notOneself"){
                                        showAlert("请扫描正确二维码",function () {
                                            goTo(targetUrl2);
                                        })
                                    }
                                    if(data==="success"){
                                        showAlert("扫码成功",function () {
                                            goTo(targetUrl2);
                                        })
                                    }
                                    if(data==="fail"){
                                        showAlert("申请者支付押金失败,无法开始共享",function () {
                                            goTo(targetUrl2);
                                        })
                                    }

                                },
                                error: function (xhr, type) {
                                    showAlert("扫码失败",function () {
                                        goTo(targetUrl2);
                                    })
                                },
                                complete: function (xhr, type) {
                                    dialogLoading.hide();
                                }
                            });
                        }
                    }
                );
                //window.location.href = "http://www.baidu.com?t="+new Date().getTime();
            });
        });
    </script>
</body>
</html>
