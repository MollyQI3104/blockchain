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
                        <el-rate v-model="value3" disabled >
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
                    <p><%out.print(record.getOrder().getServiceuserComment());%></p>
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

    var rate='<%=record.getOrder().getServiceuserRating()%>';
    new Vue({
        el:'#app',
        data:function(){
            return {
                value3: rate
            }
        }
    })

</script>
<style scoped>
    .el-rate__icon{
        font-size: 30px;
    }

</style>


</html>
