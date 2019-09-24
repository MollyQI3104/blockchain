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
    <title>申请结果</title>
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
</head>
<body>

<div class="weui-msg">
    <div class="weui-msg__icon-area">
       <%
            String msg=(String)request.getAttribute("msg");
            String detail=(String)request.getAttribute("detail");
            if(msg.equals("ok")){
                out.print("<i class='weui-icon-success weui-icon_msg'></i>");
            }
            if(msg.equals("error")){
                out.print("<i class='weui-icon-warn weui-icon_msg'></i>");
             }
        %>
    </div>
    <div class="weui-msg__text-area" >
        <label class="weui-msg__title" id="status" >预约成功</label>
        <p class="weui-msg__desc" id="msg">等待分享分布者确认   <a href="${pageContext.request.contextPath}/user/queryOrderAlreadyApply">查看我的订单</a></p>
    </div>
    <div class="weui-msg__opr-area">
        <p class="weui-btn-area">
            <a href="${pageContext.request.contextPath}/index" class="weui-btn weui-btn_primary">返回首页</a>
        </p>
    </div>
</div>

<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
    var status='<%=msg%>';
    var detail='<%=detail%>';
    $(function(){
        if (status==='ok'){
            $('#status').html('预约成功');
        }
        if(status==='error'){
            $('#status').html('预约失败');
            $('#msg').html(' ');

        }

        if((status==='error')&&(detail==='isOneself')){
            $('#status').html('不能预约自己的服务');
            $('#msg').html(' ');
        }
    });
</script>
</body>
</html>
