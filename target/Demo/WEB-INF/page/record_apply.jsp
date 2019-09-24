<%@ page import="com.springmvc.entity.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %><%--
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
    <title>申请分享</title>
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script src="../js/scan/function.js"></script>
</head>
<body>

<%
    PublishDetail detailEntity = (PublishDetail) request.getAttribute("detail");
%>


<div class="weui-tab">
    <div class="weui-tab__panel">

        <form onsubmit="return check()" action="${pageContext.request.contextPath}/record/applySubmit" method="post">

            <%--<div class="page">--%>
            <div class="weui-cells">
                <input style="display: none"  name="serviceUserId" value="<%=detailEntity.getUser().getOpenid()%>"/>
                <input style="display: none"  name="publishId" value="<%=detailEntity.getPublish().getPublishStatus()%>"/>

                <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label">昵称</label>
                    </div>
                    <div class="weui-cell__bd">
                        <input class="weui-input" name="applyUserName" type="text"
                               value="<%out.print(request.getAttribute("name"));%>"/>
                    </div>
                </div>


                <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label">微信ID</label>
                    </div>
                    <div class="weui-cell__bd">
                        <input id = "user_PhoneNumber" class="weui-input" name="applyUserPhone"
                               value="<%out.print(request.getAttribute("phone"));%>"/>
                    </div>
                </div>



                <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label">申请理由</label></div>
                    <div class="weui-cell__bd">
                        <div class="weui-cell__bd">
                            <textarea class="weui-textarea" id="reason" name="reason" placeholder="请务必输入预计使用物品时间段等申请理由" rows="3" maxlength="400" oninput="checkLen(this)"></textarea>
                            <div style="float:right; color:#999"><span id="description-count">0</span>/200</div>
                        </div>
                    </div>
                </div>

                <%
                    Date nowDate = new Date();
                    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                    String nowTime = formatter.format(nowDate);
                %>

                <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label">物品最晚归还日期</label>
                    </div>
                    <div class="weui-cell__bd">
                        <input id="endDate" class="weui-input" name="endDate" type="date" value="" min=<%out.print(nowTime);%>>
                    </div>
                </div>

                <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label"><%out.print(detailEntity.getPublish().getType());%></label>
                    </div>
                    <div class="weui-cell__bd"></div>
                    <div class="weui-cell__ft">
                        <img src="../img/物品类型/<%out.print(detailEntity.getPublish().getType());%>.png" style="height:18px;margin-right:5px;display:inline;vertical-align: text-bottom">
                        <span><%out.print(detailEntity.getPublish().getTheme());%></span>
                    </div>
                </div>

                <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label">单价</label>
                    </div>
                    <div class="weui-cell__bd"></div>
                    <div class="weui-cell__ft">
                        <span id="eachPrice"><%out.print(detailEntity.getPublish().getPrice());%>
                           积分/天</span>
                    </div>
                </div>

                <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label">押金</label>
                    </div>
                    <div class="weui-cell__bd"></div>
                    <div class="weui-cell__ft">
                        <span id="deposit"><%out.print(detailEntity.getPublish().getDeposit());%>
                           积分</span>
                    </div>
                </div>


            </div>

            <div class="weui-btn-area">
                <button type="submit" class="weui-btn weui-btn_primary">提交订单</button>
            </div>

            <%--</div>--%>

        </form>

    </div>
    <div class="weui-tabbar" style="height: 50px">
        <a href="${pageContext.request.contextPath}/index" class="weui-tabbar__item">
            <img src="../img/图标/all.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label" >首页</p>
        </a>
        <a href="${pageContext.request.contextPath}/publish/category" class="weui-tabbar__item">
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

<!-- jQuery 3 -->
<script src="../js/jquery/jquery-3.2.1.min.js"></script>

<script language="javascript">
    $(document).ready(function () {
        $('.weui-tabbar:eq(0)').find('a:eq(1)').addClass("weui-bar__item_on");
        $('#select_serveTime').change(function () {
            var hours = parseInt($(this).val());
            var eachPrice = parseInt($('#eachPrice').text());
            var sum = hours * eachPrice;
            $('#sumPrice').text(sum);
        });
    });

    function getLength(str) {
        return str.replace(/[^ -~]/g, 'AA').length;
    }

    function limitMaxLength(str, maxLength) {
        var result = [];
        for (var i = 0; i < maxLength; i++) {
            var char = str[i]
            if (/[^ -~]/.test(char))
                maxLength--;
            result.push(char);
        }
        return result.join('');
    }

    function checkLen(obj)
    {
        if (getLength(obj.value) > 400)
            obj.value = limitMaxLength(obj.value, 400);
        document.getElementById("description-count").innerHTML = Math.ceil(getLength(obj.value)/2).toString();
    }

    function check(){
        var phoneNumber = document.getElementById("user_PhoneNumber").value;
        var reason = document.getElementById("reason").value;

        if(phoneNumber == ""){
            showAlert("请填写微信ID");
            return false;
        }

        if(reason===""){
            showAlert("请填写申请理由");
            return false;
        }

        return true;
    }
</script></body>
</html>
