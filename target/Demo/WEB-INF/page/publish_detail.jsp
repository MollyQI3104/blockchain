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

    <title>物品详情</title>
</head>
<body>

<%
    PublishDetail detail = (PublishDetail) request.getAttribute("detail");
    User currentUser = (User) request.getAttribute("currentUser");
   // MyfavorEntity  myfavor = (MyfavorEntity) request.getAttribute("myfavor");

    String icon=(String)request.getAttribute("icon");
    String status=(String)request.getAttribute("status");

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
                <p style=" margin-bottom: 0px;">
                    <img class="weui-media-box__thumb"  src="${pageContext.request.contextPath}/publish/testimgurl?imgId=<%out.print(img1);%>" alt="">
                </p>
                <div  class="weui-media-box weui-media-box_appmsg" style="padding:  10px;height: 77px;width: 330px;">
                    <div class="weui-media-box__hd">
                        <img class="weui-media-box__thumb" src="../img/物品类型/<%=detail.getPublish().getType()%>.png" alt="">
                    </div>
                    <div class="weui-media-box__bd">
                        <p  type="text"><%=detail.getPublish().getTheme()%></p>
                    </div>
                        <div class="weui-media-box__hd" style="padding-top: 12px;" a href="javascript:;" id="favor">
                            <img class="weui-media-box__thumb" id="icon"  style="width:30px;display:  inline-block;" src="../img/图标/077喜欢收藏.png" alt="">
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
                    <span><%=detail.getPublish().getAddress()%></span>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <img  class="weui-media-box__thumb" style="width:30px; display:inline" src="../img/图标/clock.png">
                    <span>

                        <%
                            SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd");

                            Date endTime = new SimpleDateFormat("yyyy-MM-dd").parse(detail.getPublish().getEndDate());
                            Date dateEnd = new Date(endTime.getTime());
                            out.print(" 至 " + bartDateFormat.format(dateEnd)+ " 结束 ");
                        %>

                    </span>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <img  class="weui-media-box__thumb" style="width:30px; display:inline" src="../img/图标/integral.png">
                    <span><%=detail.getPublish().getPrice()%> 积分/天 </span>
                </div>
            </div>

            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <img  class="weui-media-box__thumb" style="width:30px; display:inline" src="../img/图标/dollar.png">
                    <span>分享开始时将冻结押金 <%=detail.getPublish().getDeposit()%> 积分 </span>
                </div>
            </div>

            <div class="weui-cell" style="height: 60px;">
                <div class="weui-cell__bd"></div>
                <div class="weui-cell__ft">
                    <a id="serviceApply-button" class="weui-btn weui-btn_primary"
                       href="${pageContext.request.contextPath}/record/apply?publishID=<%=detail.getPublish().getPublishStatus()%>"
                       style="color:#fff;font-size:16px; border:0px;display: none;text-decoration:none;">
                        <div class="title">申请分享</div>
                    </a>

                    <a id="serviceOverDate-button" class="weui-btn weui-btn_plain-default" style="background-color: #999; color:#fff; border:0px;display: none;text-decoration:none; font-family: PingFangSC-Light;font-size:15px;" onclick="return false;">
                        分享已过期，不可申请
                    </a>

                </div>
            </div>
        </div>

        <div class="block block_tcxq mt10">
            <div class="title">
                <span style="color:#20B2AA">图文描述</span>
            </div>
            <div class="con_u">
                <p>
                    <%=detail.getPublish().getDescription()%>
                </p>
            </div>
            <p>
                    <%if(img1!=null && !img1.equals("null")  )
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
                <span style="color:#20B2AA">申请须知</span>
            </div>
            <div class="con_u">
                <p>1.申请前请看清时间、押金数额及交易地址。<br/><br/>2.提交申请后不可取消，等待提供分享者确认接受。可在已申请订单页查看。<br/><br/>3.在交易开始时请确保账户余额可支付押金,否则不能开始分享。押金将在分享结束,结算成功后解冻。<br/><br/>4.若有变动请及时与发布者联系</p>
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
            <p class="weui-tabbar__label">发布</p>
        </a>
        <a href="${pageContext.request.contextPath}/publish/category" class="weui-tabbar__item">
            <img src="../img/图标/form.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label" >订单</p>
        </a>
        <a href="${pageContext.request.contextPath}/user/" class="weui-tabbar__item">
            <img src="../img/图标/personal-center.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label">我</p>
        </a>
    </div>
</div>

<script src="http://lib.sinaapp.com/js/jquery/1.12.4/jquery-1.12.4.min.js"></script>
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script language="javascript"></script>
<script type="text/javascript">


    var icon='<%=icon%>';

    var xmlHttpRequest;
    $(function(){
        if(window.XMLHttpRequest){
            xmlHttpRequest=new XMLHttpRequest();
        }else{
            xmlHttpRequest=new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlHttpRequest.open("GET","AjaxServlet",true);
    });



    //点击收藏
    $("#favor").on('click', function () {
        var targetUrl = "${pageContext.request.contextPath}/user/setfavor";
        var targetUrl2 = "${pageContext.request.contextPath}/user/isfavor";
        var targetUrl3 = "${pageContext.request.contextPath}/user/deletefavor";
        var publishID = '<%=detail.getPublish().getPublishStatus()%>';

        isFavor(publishID,targetUrl,targetUrl2,targetUrl3);

    });

    function isFavor(publishID,targetUrl,targetUrl2,targetUrl3) {
        $.ajax({
            type: 'POST',
            cache: false,
            url: targetUrl2,
            data: "publishID=" + publishID ,
            beforeSend: function (XHR) {

            },
            success: function (data) {
                //进行接下来所有的操作
                if(data==="yes"){
                    deleteFavor(publishID,targetUrl3);
                }
                if(data==="no"){
                    setFavor(publishID,targetUrl);
                }

            },
            error: function (xhr, type) {
                showAlert("返回失败");
            }

        });
    }
    function deleteFavor(publishID,targetUrl3) {
        $.ajax({
            type: 'POST',
            cache: false,
            url: targetUrl3,
            data: "publishID=" + publishID ,
            beforeSend: function (XHR) {

            },
            success: function (data) {
                //发送成功后进行接下来所有的操作
                if(data==="ok"){

                    showAlert("取消收藏成功!");

                    $('#icon').attr("src","../img/图标/077喜欢收藏.png");

                }

                else {
                    showAlert("取消收藏失败!");
                }
            }

        });
    }
    function setFavor(publishID,targetUrl) {
        $.ajax({
            type: 'POST',
            cache: false,
            url: targetUrl,
            data: "publishID=" + publishID ,
            beforeSend: function (XHR) {

            },
            success: function (data) {
                //发送成功后进行接下来所有的操作
                if(data==="ok"){

                    showAlert("收藏成功!");

                    $('#icon').attr("src","../img/图标/078喜欢已收藏-4.png");

                }
                if(data==="fail"){
                    showAlert("收藏失败!");

                }

            }

        });
    }

    function ifFavor(publishID,targetUrl2) {
        var bol;
        $.ajax({
            type: 'POST',
            cache: false,
            url: targetUrl2,
            data: "publishID=" + publishID ,
            async:false,
            success: function (data) {
                //发送成功后进行接下来所有的操作
                if(data==="yes"){

                    bol = true;

                }
                if(data==="no"){
                    bol = false;

                }

            }

        });
        return bol;
    }




    $(document).ready(function () {
        var detailEndDate = "<%out.print(detail.getPublish().getEndDate().toString().substring(0,10));%>";

        detailEndDate =detailEndDate.replace(/\-/gi,"/");
        var detailEndTime = new Date(detailEndDate).getTime();
        var nowDate = new Date(new Date().Format("yyyy/MM/dd"))
        var nowTime = nowDate.getTime();

        var targetUrl4 = "${pageContext.request.contextPath}/user/isfavor";
        var publishID = '<%=detail.getPublish().getPublishStatus()%>';


        if(ifFavor(publishID,targetUrl4)){

            $('#icon').attr("src","../img/图标/078喜欢已收藏-4.png");
        }
        else{

            $('#icon').attr("src","../img/图标/077喜欢收藏.png");
        }

        if(detailEndTime < nowTime){
            $("#serviceApply-button").hide();
            $("#serviceOverDate-button").show();
        } else{
              $("#serviceApply-button").show();
              $("#serviceOverDate-button").hide();
        }

        var currentUserId = "";
        if(<%out.print(currentUser != null);%>) {
            currentUserId ='<%=currentUser.getOpenid()%>';
        }
        var publishUserId ='<%=detail.getPublish().getUserid()%>';

        if(currentUserId != "" && currentUserId == publishUserId){
             $("#serviceApply-button").hide();
             $("#serviceOverDate-button").show();
             $("#serviceOverDate-button").html("不可申请自己发布的分享");
        }



    });
    Date.prototype.Format = function (fmt) { //author: meizz
        var o = {
            "M+": this.getMonth() + 1, //月份
            "d+": this.getDate(), //日
            "h+": this.getHours(), //小时
            "m+": this.getMinutes(), //分
            "s+": this.getSeconds(), //秒
            "q+": Math.floor((this.getMonth() + 3) / 3), //季度
            "S": this.getMilliseconds() //毫秒
        };
        if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var k in o)
            if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        return fmt;
    }
</script>

</body>

<style scoped>
    .weui-cell{
        align-items: flex-end;
    }

</style>

</html>
