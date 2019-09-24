<%--
  Created by IntelliJ IDEA.
  User: toyking
  Date: 2017/10/24
  Time: 10:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <title>结果</title>
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
</head>
<body>

<div class="weui-msg">
    <div class="weui-msg__icon-area">
       <%
            String msg=(String)request.getAttribute("msg");
            if(msg.equals("ok")){
                out.print("<i class='weui-icon-success weui-icon_msg'></i>");
            }
            if(msg.equals("error")){
                out.print("<i class='weui-icon-warn weui-icon_msg'></i>");
             }
        %>
    </div>
    <div class="weui-msg__text-area" >
        <label class="weui-msg__title" id="status" >订单已结束</label>
    </div>
    <div class="weui-msg__opr-area">
        <p class="weui-btn-area">
            <a href="${pageContext.request.contextPath}/index" class="weui-btn weui-btn_primary"> 返回首页</a>
        </p>
    </div>
</div>

<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
    var status='<%=msg%>';

    $(function(){
        if (status==='ok'){
            $('#status').html('订单已结束');
        }
        if(status==='error'){
            $('#status').html('出错,稍后再试');
            $('#msg').html(' ');

        }

    });
</script>
</body>
</html>
