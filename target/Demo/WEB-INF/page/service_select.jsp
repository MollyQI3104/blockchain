<%@ page import="com.springmvc.entity.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.*" %>
<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2017/12/21
  Time: 15:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/jquery.range.css">
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script src="../js/scan/configs.js"></script>
    <script src="../js/scan/function.js"></script>
    <style>
        .slider-container {
            width: 250px;
        }
        .slider-container{
            margin-top: 30px;
        }
        table{
            width: 100%;
            margin:auto;
        }
        td{
            width:25%;
        }
        .select-button {
            display: inline-block;
            width: 85%;
            margin:auto;
            height: 30px;
            margin-top: 20px;
            border: 1px solid #515151;
            border-radius: 8px;
            text-align: center;
            padding-top: 2px;
            background-color:#ffffff ;
            color: #515151;
        }
        .active{
            background-color:#76b852 ;
            color: #ffffff;
        }
        .back-bar{
            width:250px;
        }
    </style>
    <title>筛选<%out.print(request.getAttribute("type"));%></title>
</head>
<body>

<%
    Map<String, ArrayList<String>> map = new HashMap<String, ArrayList<String>>();
%>

<div class="weui-tab">
    <div class="weui-tab__panel">
        <div class="weui-panel__hd">
            <span>筛选<span class="select-title"><%out.print(request.getAttribute("type"));%></span></span>
        </div>
        <%--<form action="${pageContext.request.contextPath}/publish/list_select" method="post" onsubmit="return check();">--%>
            <div class="weui-panel__bd">

                <div class="weui-media-box weui-media-box_text">
                    <div style="margin-left: 15px">
                        <span style="color:#20B2AA">点击选择分享时间范围</span>
                        <div style="margin: 10px;margin-bottom: 30px">
                            <span>

                        <%
                            SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd");
                            Date currentDate = new Date();

                            Date dateEnd = new Date(currentDate.getTime());
                            out.print(bartDateFormat.format(dateEnd));
                        %>

                    </span>
                            <span style="margin:0 auto; vertical-align:middle">--</span>
                            <input id='select-endtime' class="weui-input" type="date" style="height: 50px;line-height: 34px;display: inline-block;width:40%;float: right" placeholder="结束时间">
                        </div>
                    </div>
                </div>
                <div class="weui-media-box weui-media-box_text" style="padding-bottom: 25px">
                    <div style="margin-left: 15px">
                        <span style="color:#20B2AA">积分单价</span>
                        <div class="range-slider" id="choice1"></div>
                    </div>
                </div>
                <div class="weui-media-box weui-media-box_text" style="padding-bottom: 25px">
                    <div style="margin-left: 15px">
                        <span style="color:#20B2AA">押金范围</span>
                        <div class="range-slider" id="choice2"></div>
                    </div>
                </div>
                <div class="weui-media-box weui-media-box_text" style="padding-bottom: 25px">
                    <div style="margin-left: 15px; margin-top: 20px;margin-bottom: 30px; float:right">
                        <a class="weui-btn weui-btn_mini weui-btn_default" href="${pageContext.request.contextPath}/publish/list?type=<%out.print(request.getAttribute("type"));%>">取消</a>
                        <a class="weui-btn weui-btn_mini weui-btn_primary" id="select-confirm" >完成</a>
                    </div>
                </div>
            </div>
        <%--</form>--%>
        <div class="weui-tabbar" style="height: 50px">
            <a href="${pageContext.request.contextPath}/index" class="weui-tabbar__item">
                <img src="../img/图标/all3.png" alt="" class="weui-tabbar__icon">
                <p class="weui-tabbar__label" >首页</p>
            </a>
            <a href="${pageContext.request.contextPath}/publish/favor" class="weui-tabbar__item">
                <img src="../img/图标/favorite.png" alt="" class="weui-tabbar__icon">
                <p class="weui-tabbar__label" style="color: #999999;">收藏</p>
            </a>
            <a href="${pageContext.request.contextPath}/publish/add" class="weui-tabbar__item">
                <img src="../img/图标/加号.png" alt="" class="weui-tabbar__icon">
                <p class="weui-tabbar__label" >发布</p>
            </a>
            <a href="${pageContext.request.contextPath}/publish/category" class="weui-tabbar__item">
                <img src="../img/图标/form.png" alt="" class="weui-tabbar__icon">
                <p class="weui-tabbar__label">订单</p>
            </a>
            <a href="${pageContext.request.contextPath}/user/" class="weui-tabbar__item">
                <img src="../img/图标/personal-center.png" alt="" class="weui-tabbar__icon">
                <p class="weui-tabbar__label">我</p>
            </a>
        </div>
    </div>
</div>
    <script src="../js/jquery/jquery-3.2.1.min.js"></script>
    <script src="../js/range/jquery.range.js"></script>
    <script>
        $('.range-slider').jRange({
            from: 0,
            to: 250,
            step: 1,
            scale: [0,50,100,150,200,250],
            format: '%s',
            width: 250,
            showLabels: true,
            isRange : true, //theme:'theme-blue'
            theme:'theme-blue'
        });
        $('.select-button').click(function(){
            $(this).toggleClass('active');
        });
        $('#select-confirm').click(function(){
            var type = $(".select-title").html();

            var i =0;

            var upperDate = $('#select-endtime').val();
            //var aa = $(".range-slider").val();
            var aa = $("#choice1").val();
            var range = aa.split(',');
            var upperPrice = range[1];
            var lowerPrice = range[0];
            //console.log("upperPrice",upperPrice);
            //console.log("lowerPrice",lowerPrice);

            var bb = $("#choice2").val();
            var range1 = bb.split(',');
            var upperDeposit = range1[1];
            var lowerDeposit = range1[0];

            if(upperDate===""){
                upperDate = "2010-01-01";
            }

            if(upperPrice==0 && lowerPrice==0){
                lowerPrice = 0
                upperPrice = 200;

            }

            if(upperDeposit==0 && lowerDeposit==0){
                lowerDeposit = 0
                upperDeposit = 200;

            }


            location.href="${pageContext.request.contextPath}/publish/selectList?type="+ type +"&upperPrice="+ upperPrice + "&lowerPrice=" + lowerPrice
                + "&upperDate=" + upperDate +"&upperDeposit="+ upperDeposit + "&lowerDeposit=" + lowerDeposit ;
        });

        /*function check(serviceName, lowerDate, upperDate, upperPrice, lowerPrice){
            if(serviceName===""){
                showAlert("请选择服务名称");
                return false;
            }
            if(lowerDate===""){
                showAlert("请填写服务开始日期");
                return false;
            }
            if(upperDate===""){
                showAlert("请填写服务结束日期");
                return false;
            }
            if(upperPrice===0 && lowerPrice===0){
                showAlert("请选择服务价格");
                return false;
            }
            return true;
        }*/
    </script>
</body>
</html>
