<%@ page import="com.springmvc.entity.*" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>支付详情</title>
    <!-- 引入 WeUI -->
    <link rel="stylesheet" href="../css/weui.min.css" />
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script src="../js/scan/function.js"></script>
    <script src="../js/scan/configs.js"></script>
    <script charset="utf-8" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script src="../js/scan/function.js"></script>
    <script src="../js/scan/configs.js"></script>
</head>
<body>
<%
    OrderDetail recordDetail = (OrderDetail) request.getAttribute("viewPublishOrderDetailEntity");
%>

<div class="weui-form-preview">
    <div class="weui-form-preview__hd">
        <label class="weui-form-preview__label">支付积分:</label>
        <em class="weui-form-preview__value" style="color: #20B2AA;"><%out.print(recordDetail.getOrder().getTxpoint());%></em>
    </div>
    <div class="weui-form-preview__bd">
        <p>
            <label class="weui-form-preview__label">订单编号:</label>
            <span class="weui-form-preview__value"><%out.print(recordDetail.getOrder().getStatus());%></span>
        </p>
        <p>
            <label class="weui-form-preview__label">物品类型:</label>
            <span class="weui-form-preview__value"><%out.print(recordDetail.getPublish().getType());%></span>
        </p>

        <p>
            <label class="weui-form-preview__label">分享标题:</label>
            <span class="weui-form-preview__value"><%out.print(recordDetail.getPublish().getTheme());%></span>
        </p>
        <p>
            <label class="weui-form-preview__label">分享发布者:</label>
            <span class="weui-form-preview__value"><%out.print(recordDetail.getServiceUser().getName());%></span>
        </p>
        <p>
            <label class="weui-form-preview__label">分享时长:</label>
            <span class="weui-form-preview__value">
                <%
                    out.print(recordDetail.getOrder().getBegintime()+" -- "+ recordDetail.getOrder().getEndtime());
                %></span>
        </p>

    </div>
    <div class="weui-form-preview__ft">
        <a class="weui-form-preview__btn weui-form-preview__btn_default" href="${pageContext.request.contextPath}/user/queryOrderWaitingPay">返回</a>
        <a class="weui-form-preview__btn weui-form-preview__btn_primary" id="payBtn">支付</a>
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
    var type='<%=recordDetail.getPublish().getType()%>';
    var recordID = '<%=recordDetail.getOrder().getStatus()%>';
    $(function(){
        $("#payBtn").on('click',function () {

           /* var targetUrl = "http://"+getDomainName()+contextPath+"/user/applyUserPayCredit";
            var targetUrl2 = "http://"+getDomainName()+contextPath+"/user/queryOrderAlreadyComplete";*/

             var targetUrl = contextPath+"/user/applyUserPayCredit";
             var targetUrl2 = contextPath+"/user/queryOrderAlreadyComplete";
             var targetUrl3 = contextPath+"/user/queryOrderWaitingPay";



            $.ajax({
                    type: 'POST',
                    cache: false,
                    url: targetUrl,
                    //dataType:'JSONP',
                    data: "recordID=" + recordID,
                    beforeSend: function (XHR) {
                        dialogLoading = showLoading();
                    },
                    success: function (data) {
                        //alert(data);
                        if(data==="borrowsuccess") {
                            showAlert("支付成功", function () {
                                goTo(targetUrl2);
                            })
                        }
                        if(data==="delaysuccess") {
                            showAlert("余额不足!", function () {
                                goTo(targetUrl3);
                            })
                        }
                        if(data==="fail") {
                            showAlert("请稍后尝试", function () {
                                goTo(targetUrl3);
                            })
                        }
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


        });
    });
</script>

</body>
</html>