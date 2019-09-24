<%--
  Created by IntelliJ IDEA.
  User: toyking
  Date: 2017/10/24
  Time: 10:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <title>首页</title>
    <link rel="stylesheet" href="css/weui.css">
    <link rel="stylesheet" href="css/weui-example.css">
    <link rel="stylesheet" href="css/swiper-3.4.0.min.css">
    <link rel="stylesheet" href="css/weui.css">
    <link rel="stylesheet" href="css/weui-example.css">
    <link rel="stylesheet" href="css/swiper-3.4.0.min.css">
    <script charset="utf-8" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script src="js/jquery/jquery-3.2.1.min.js"></script>
    <script src="js/utils.js"></script>
<%--<link rel="stylesheet" href="css/bootstrap.min.css">--%>
    <%--<link rel="stylesheet" href="css/bootstrap-touch-slider.css" media="all">--%>
</head>
<body onload="back_exit();">
<script>get_wx_config();</script>

<%--搜索框--%>
<div class="weui-search-bar" id="searchBar">
    <form class="weui-search-bar__form" action="${pageContext.request.contextPath}/publish/searchPublish" method="get">
        <div class="weui-search-bar__box">
            <i class="weui-icon-search"></i>
            <input type="search" class="weui-search-bar__input" id="searchInput"  name="searchInput" placeholder="输入关键词搜索" onkeypress="keySearch(event)" onkeydown="keySearch()" required="">
            <a href="javascript:" class="weui-icon-clear" id="searchClear"></a>
            <button id="goSearch" type="submit" style="display:none;"></button>
        </div>
        <label class="weui-search-bar__label" id="searchText" style="transform-origin: 0px 0px 0px; opacity: 1; transform: scale(1, 1);">
            <i class="weui-icon-search"></i>
            <span>搜索</span>
        </label>
    </form>
    <a href="javascript:" class="weui-search-bar__cancel-btn" id="searchCancel">取消</a>
</div>

<div>
<%--轮播图--%>
<div class="swiper-container"  >
    <div class="swiper-wrapper" >
<%--<div class="swiper-slide"><img src="http://www.linyunli.com/timebankWeb/publish/imgurl" ></div>--%>
<div class="swiper-slide"><img src="img/test2.JPG" ></div>
<div class="swiper-slide"><img src="img/desk.jpg" ></div>
</div>
<div class="swiper-pagination"></div>
</div>
<script src="js/jquery/jquery-3.2.1.min.js"></script>
<script src="js/zepto/weui.min.js"></script>
<script src="js/swiper-4.1.6.min.js"></script>
<script type="text/javascript">
var mySwiper = new Swiper('.swiper-container',
   {
       speed:1000,//播放速度
       autoHeight:true,
       loop:true,//是否循环播放
       setWrapperSize:true,
       autoplay:
       {
           delay: 5000,
           disableOnInteraction: false,
       },
       pagination:  '.swiper-pagination',//分页
       effect : 'slide',//动画效果
   }
);
</script>

<div class="weui-tab">
<div class="weui-tab__panel">

   <div class="weui-grids">
       <a href="${pageContext.request.contextPath}/publish/list?type=电子产品" class="weui-grid">
           <div class="weui-grid__icon">
               <img src="img/物品类型/电子产品.png" alt="">
           </div>
           <p class="weui-grid__label">
               电子产品
           </p>
       </a>

       <a href="${pageContext.request.contextPath}/publish/list?type=生活用品" class="weui-grid">
           <div class="weui-grid__icon">
               <img src="img/物品类型/生活用品.png" alt="">
           </div>
           <p class="weui-grid__label">
               生活用品
           </p>
       </a>

       <a href="${pageContext.request.contextPath}/publish/list?type=运动器械" class="weui-grid">
           <div class="weui-grid__icon">
               <img src="img/物品类型/运动器械.png" alt="">
           </div>
           <p class="weui-grid__label">
               运动器械
           </p>
       </a>

       <a href="${pageContext.request.contextPath}/publish/list?type=书刊杂志" class="weui-grid">
           <div class="weui-grid__icon">
               <img src="img/物品类型/书刊杂志.png" alt="">
           </div>
           <p class="weui-grid__label">
               书刊杂志
           </p>
       </a>

       <a href="${pageContext.request.contextPath}/publish/list?type=音乐影像" class="weui-grid">
           <div class="weui-grid__icon">
               <img src="img/物品类型/音乐影像.png" alt="">
           </div>
           <p class="weui-grid__label">
               音乐影像
           </p>
       </a>

       <a href="${pageContext.request.contextPath}/publish/list?type=其他" class="weui-grid">
           <div class="weui-grid__icon">
               <img src="img/物品类型/其他.png" alt="">
           </div>
           <p class="weui-grid__label">
               其他
           </p>
       </a>



   </div>
</div>




</div>
<div class="weui-tabbar" style="height: 50px">
<a href="${pageContext.request.contextPath}/index" class="weui-tabbar__item">
<img src="img/图标/all3.png" alt="" class="weui-tabbar__icon">
<p class="weui-tabbar__label" style="color: #20B2AA;">首页</p>
</a>
<a href="${pageContext.request.contextPath}/publish/favor" class="weui-tabbar__item">
<img src="img/图标/favorite.png" alt="" class="weui-tabbar__icon">
<p class="weui-tabbar__label">收藏</p>
</a>
<a href="${pageContext.request.contextPath}/publish/add" class="weui-tabbar__item">
<img src="img/图标/加号.png" alt="" class="weui-tabbar__icon">
<p class="weui-tabbar__label">发布</p>
</a>
<a href="${pageContext.request.contextPath}/publish/category" class="weui-tabbar__item">
<img src="img/图标/form.png" alt="" class="weui-tabbar__icon">
<p class="weui-tabbar__label">订单</p>
</a>
<a href="${pageContext.request.contextPath}/user/" class="weui-tabbar__item">
<img src="img/图标/personal-center.png" alt="" class="weui-tabbar__icon">
<p class="weui-tabbar__label">我</p>
</a>
</div>
</div>

</div>


<script src="js/jquery/jquery-3.2.1.min.js"></script>
<script src="js/bootstrap/jquery-1.11.0.min.js" type="text/javascript"></script>
<script src="js/bootstrap/bootstrap.min.js"></script>
<script src="js/bootstrap/jquery.touchSwipe.min.js"></script>
<script src="js/bootstrap/bootstrap-touch-slider.js"></script>

<script type="text/javascript" class="searchbar js_show">
$(function () {
var $searchBar = $('#searchBar'),
   $searchResult = $('#searchResult'),
   $searchText = $('#searchText'),
   $searchInput = $('#searchInput'),
   $searchClear = $('#searchClear'),
   $searchCancel = $('#searchCancel');

    //键盘按值
    function keySearch(event) {
        var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
        if (keyCode == 13) {
            document.getElementById("goSearch").click();
        }
    }

function hideSearchResult() {
   $searchResult.hide();
   $searchInput.val('');
}

function cancelSearch() {
   hideSearchResult();
   $searchBar.removeClass('weui-search-bar_focusing');
   $searchText.show();
}

$searchText.on('click', function () {
   $searchBar.addClass('weui-search-bar_focusing');
   $searchInput.focus();
});
$searchInput
   .on('blur', function () {
       if (!this.value.length) cancelSearch();
   })
   .on('input', function () {
       if (this.value.length) {
           $searchResult.show();
       } else {
           $searchResult.hide();
       }
   })
;
$searchClear.on('click', function () {
   hideSearchResult();
   $searchInput.focus();
});
$searchCancel.on('click', function () {
   cancelSearch();
   $searchInput.blur();
});
});
</script>

<script>
$('#bootstrap-touch-slider').bsTouchSlider();
$(document).ready(function () {
$('.weui-tabbar:eq(0)').find('a:eq(0)').addClass("weui-bar__item_on");
});
</script>

</body>
</html>