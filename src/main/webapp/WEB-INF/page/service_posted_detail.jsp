<%@ page import="com.springmvc.entity.*" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%@ page import="java.util.List" %>

<%--
  Created by IntelliJ IDEA.
  User: caozihan
  Date: 2017/12/20
  Time: 15:43
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
    <link href="../css/dj_base_838a930.css" rel="stylesheet" type="text/css">
    <link href="../css/dj_dc_content_f60f458.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="../css/swiper-3.4.0.min.css">
    <script src="../js/scan/function.js"></script>
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script charset="utf-8" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script src="../js/scan/configs.js"></script>

    <title>已发布物品详情</title>
</head>
<body>

<%
    PublishDetail detail = (PublishDetail) request.getAttribute("detail");

    String img1 = detail.getPublish().getImg1();
    String img2 = detail.getPublish().getImg2();
    String img3 = detail.getPublish().getImg3();

    System.out.print(img1);
    System.out.print(img2);
    System.out.print(img3);


%>

<div class="weui-tab">
    <div class="weui-tab__panel">

        <!--以下内容在右侧显示-->
        <div class="enterbar bar_shop border_b mt10" style="
    padding-left: 0px;
    padding-right:  0px;
    padding-top:  0px;
    padding-bottom: 0px;
     margin-top: 0px;
">
            <div align="left">
                <div  class="weui-media-box weui-media-box_appmsg" style="padding:  10px;height: 77px;width: 330px;">
                    <div class="weui-media-box__hd">
                        <img class="weui-media-box__thumb" src="../img/物品类型/<%=detail.getPublish().getType()%>.png" alt="">
                    </div>
                    <div class="weui-media-box__bd">
                        <p >分享主题 :<%=detail.getPublish().getTheme()%></p>
                    </div>


                </div>

            </div>
        </div>


        <div class="block block_tcxq mt10">
            <div class="title">
                <span style="color:#20B2AA">物品详情</span>

            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <img  class="weui-media-box__thumb" style="width:30px; display:inline" src="../img/图标/map.png">
                    <span>交易地址 :<%=detail.getPublish().getAddress()%></span>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <img  class="weui-media-box__thumb" style="width:30px; display:inline" src="../img/图标/phone.png">
                    <span>预留联系方式 :<%=detail.getUser().getWechat()%></span>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <img  class="weui-media-box__thumb" style="width:30px; display:inline" src="../img/图标/clock.png">
                    <span>分享时间 :

                        <%
                            out.print(" 至 " + detail.getPublish().getEndDate()+" 结束 " );
                        %>

                    </span>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <img  class="weui-media-box__thumb" style="width:30px; display:inline" src="../img/图标/integral.png">
                    <span>单价 :<%=detail.getPublish().getPrice()%>积分/天 </span>
                </div>
            </div>

            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <img  class="weui-media-box__thumb" style="width:30px; display:inline" src="../img/图标/dollar.png">
                    <span>押金 :<%=detail.getPublish().getDeposit()%> 积分 </span>
                </div>
            </div>

        </div>

        <div class="block block_tcxq mt10">
            <div class="title">
                <span style="color:#20B2AA">图文描述</span>
            </div>
            <div class="con_u">
                <p>
                    物品描述 :<%=detail.getPublish().getDescription()%>
                </p>
            </div>
            <p>
                    <%if(img1!=null && !img1.equals("null") )
                {
                %>
                <img src="${pageContext.request.contextPath}/publish/testimgurl?imgId=<%out.print(img1);%>" alt="">
            <div style="background-color: #f8f8f8; height:10px;"></div>

            <%
                }
            %>
            <%if(img2!=null && !img2.equals("null") )
            {
            %>
            <img src="${pageContext.request.contextPath}/publish/testimgurl?imgId=<%out.print(img2);%>" alt="">
            <div style="background-color: #f8f8f8; height:10px;"></div>

            <%
                }
            %>
            <%if(img3!=null && !img3.equals("null") )
            {
            %>
            <img src="${pageContext.request.contextPath}/publish/testimgurl?imgId=<%out.print(img3);%>" alt="">
            <div style="background-color: #f8f8f8; height:10px;"></div>

            <%
                }
            %>
            </p>
        </div>


        <div class="block block_tcxq mt10">
            <div class="title">
                <span style="color:#20B2AA">接受申请须知</span>
            </div>
            <div class="con_u">
                <p>申请者申请您的分享后，您可以选择接受或拒绝<br/><br/>请认真查看申请者提交的理由及时间,谨慎接受或拒绝申请。接受申请后不可取消。<br/><br/>若有任何变动请及时与申请者联系</p>
            </div>
        </div>

    </div>

    <div class="weui-tabbar" style="height: 50px">
        <a href="${pageContext.request.contextPath}/index" class="weui-tabbar__item">
            <img src="../img/图标/all.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label" >首页</p>
        </a>
        <a href="${pageContext.request.contextPath}/publish/favor" class="weui-tabbar__item">
            <img src="../img/图标/favorite.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label"style="color: #999999;">收藏</p>
        </a>
        <a href="${pageContext.request.contextPath}/publish/add" class="weui-tabbar__item">
            <img src="../img/图标/加号.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label" >发布</p>
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

</body>
</html>
