<%@ page import="com.springmvc.entity.*" %><%--
  Created by IntelliJ IDEA.
  User: bobo9978
  Date: 2017/12/7
  Time: 15:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>评价</title>
    <!-- 引入样式 -->
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <link rel="stylesheet" href="../css/weui.min.css" />
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script src="../js/scan/configs.js"></script>
    <script src="../js/scan/function.js"></script>
</head>
<body>
<%
    OrderDetail record = (OrderDetail) request.getAttribute("viewPublishOrderDetailEntity");
%>
<div class="page">
    <div class="page__bd" style="height: 100%;">
        <div style="background-color: #f8f8f8; height:10px;"></div>

        <div class="weui-cells__title">信誉评分</div>
        <div class="weui-cells weui-cells_form">
            <div class="weui-cell" style=" height: 60px;">
                <div class="weui-cell__bd">
                    <div id="app">
                        <el-rate v-model="value3" show-text>
                        </el-rate>
                    </div>
                </div>
            </div>
        </div>

        <%--<div class="weui-cell">
            <div class="weui-cell__bd">
                <div class="weui-flex">
                    <div class="weui-flex__item"diaplay="none">
                        <p>服务者态度</p>
                    </div>
                    <div class="weui-flex__item">
                        <div class="weui-flex__item">
                            <div id="app2">
                                <el-rate v-model="value3" show-text>
                                </el-rate>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>--%>
        <div style="background-color: #f8f8f8; height:10px;"></div>
        <div class="weui-cells__title">评价</div>
        <div class="weui-cells weui-cells_form">
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <textarea name="text" class="weui-textarea" id="text" placeholder="例:xxxxxx" rows="3" maxlength="400" oninput="checkLen(this)"></textarea>
                    <div class="weui-textarea-counter"><span id ="evaluation-count">0</span>/200</div>
                </div>
            </div>
        </div>
        <div class="weui-cell">
            <div class="weui-cell__bd">
                <div class="weui-flex">
                    <div class="weui-flex__item"diaplay="none"></div>
                    <div class="weui-flex__item"display="none"></div>
                    <div class="weui-flex__item"display="none"></div>
                    <div class="weui-flex__item"><div class="weui-btn weui-btn_mini weui-btn_primary" id="btn" style="float:right;">提交</div></div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
<!-- 先引入 Vue -->
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script src="//unpkg.com/vue/dist/vue.js"></script>
<!-- 引入组件库 -->
<script src="//unpkg.com/element-ui@2.0.7/lib/index.js"></script>
<%--<script>
    new Vue({
        el:'#app',
        data:function(){
            return {
                value3: 4
            }
        }
    })
</script>--%>
<%--<script>
    new Vue({
        el:'#app2',
        data:function(){
            return {
                value3: 4
            }
        }
    })
</script>--%>
<script type="text/javascript">
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
        document.getElementById("evaluation-count").innerHTML = Math.ceil(getLength(obj.value)/2).toString();
    }
    var xmlHttpRequest;
    $(function(){
        if(window.XMLHttpRequest){
            xmlHttpRequest=new XMLHttpRequest();
        }else{
            xmlHttpRequest=new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlHttpRequest.open("GET","AjaxServlet",true);
    });

    new Vue({
        el:'#app',
        data:function(){
            return {
                value3: 4
            }
        }
    })
    var contextPath="${pageContext.request.contextPath}";
    var recordID='<%=record.getOrder().getStatus()%>';
    var userID='<%=record.getOrder().getServiceuserid()%>';//发布者给申请者评价

    $(function() {
        $("#btn").on('click', function () {
           /* var targetUrl = "http://"+getDomainName()+contextPath+"/user/serviceUserEvaluateRecord";
            var targetUrl2 = "http://"+getDomainName()+contextPath+"/user/queryPublishAlreadyComplete";*/
            var targetUrl = contextPath+"/user/serviceUserEvaluateRecord";
            var targetUrl2 = contextPath+"/user/queryPublishAlreadyComplete";
            var starNum = 0;
            var starText = $('#app').text();
            var comment = $('#text').val()
            if(starText==="极差"){
                starNum = 1;
            }
            if(starText==="失望"){
                starNum = 2;
            }
            if(starText==="一般"){
                starNum = 3;
            }
            if(starText==="满意"){
                starNum = 4;
            }
            if(starText==="惊喜"){
                starNum = 5;
            }

            if(comment == ""){
                showAlert("请填写评价");
                return false;
            }
            //alert("服务评分："+$('#app').text()+"\n"+"服务者态度："+$('#app2').text()+"\n"+"详细评价："+$('#text').val());
            //alert("服务评分："+$('#app').text()+"\n"+"详细评价："+$('#text').val()+starNum);
            $.ajax({
                type: 'POST',
                cache: false,
                url: targetUrl,
                data: "recordID=" + recordID + "&userid="+ userID+ "&rating=" +  starNum + "&comment=" + comment,
                success: function (data) {
                    if(data==="commentsuccess"){
                    showAlert("评价成功",function () {
                        goTo(targetUrl2);
                    })
                    }

                    if(data==="fail"){
                        showAlert("评价失败",function () {
                            goTo(targetUrl2);
                        })
                    }

                },
                error: function (xhr, type) {
                    alert(type);
                    showAlert("评价失败");
                },
                complete: function (xhr, type) {
                    dialogLoading.hide();
                }
            });
        });
    });
</script>
<style scoped>
    .el-rate__icon{
        font-size: 30px;
    }

</style>


</html>
