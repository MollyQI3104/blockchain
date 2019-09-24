<%@ page import="com.springmvc.weixin.util.TokenThread" %>
<%@ page import="com.springmvc.entity.*" %>
<%@ page import="com.springmvc.weixin.util.Configs" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>个人信息</title>
    <!-- 引入 WeUI -->
    <link rel="stylesheet" href="../css/weui.min.css" />
    <link href="../css/mobile-main.css" rel="stylesheet" />
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script charset="utf-8" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script src="../js/scan/function.js"></script>
    <script src="../js/scan/configs.js"></script>
</head>
<body>
<%
    User user = (User) request.getAttribute("user");
    String id = (String)request.getAttribute("id");

%>

<div class="weui-cells__title">我的二维码</div>
<div class="weui-cells weui-cells_form" id="qrcodetest">


    <div class="weui-cell weui-cell_vcode">
        <div class="weui-cell__bd">
            <label class="weui-form-preview__label" id="curqrcode" name="qrcode">当前二维码</label>
        </div>
    </div>
</div>

<div id="qrcode" style="padding-left: 19%; padding-top: 30px; width:200px;height:200px">
</div>

<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script src="../js/qrcode.js" type="text/javascript"></script>
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
    var qrcode='<%=id%>';
    var contextPath="${pageContext.request.contextPath}";
    $(function(){

            $('#curqrcode').text(qrcode);

            var qrcode1 = new QRCode(document.getElementById("qrcode"), {
                width : 200,//设置宽高
                height : 200
            });
            qrcode1.makeCode(qrcode);

    });
</script>
</body>
</html>