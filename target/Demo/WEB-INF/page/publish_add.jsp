<%@ page import="com.springmvc.entity.*" %>
<%@ page import="java.util.*" %>
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
    <title>发布物品分享</title>
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script src="../js/scan/function.js"></script>
</head>
<body >


<div class="weui-tab">
    <div class="weui-tab__panel">
        <form action="submit" method="post" id="PublishForm" enctype="multipart/form-data">
            <div class="weui-cells__title">发布物品分享</div>

            <div class="weui-cells">

                <div class="weui-cell weui-cell_select weui-cell_select-after">
                    <div class="weui-cell__hd">
                        <label class="weui-label">物品分类</label>
                    </div>
                    <div class="weui-cell__bd">
                        <select class="weui-select" name="serviceType" id = "addServiceType">

                            <option value="电子产品">电子产品</option>
                            <option value="生活用品">生活用品</option>
                            <option value="运动器械">运动器械</option>
                            <option value="书刊杂志">书刊杂志</option>
                            <option value="音乐影像">音乐影像</option>
                            <option value="其他">其他</option>
                            <%--<option value="3">专业服务</option>--%>
                            <%--<option value="4">社区O2O服务</option>--%>
                        </select>
                    </div>
                </div>

                <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label">分享标题</label>
                    </div>
                    <div class="weui-cell__bd">
                        <input  id="theme" class="weui-input" name="theme" type="text"  placeholder="请输入分享标题"/>
                    </div>
                </div>


                <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label">物品描述</label></div>
                    <div class="weui-cell__bd">
                        <div class="weui-cell__bd">
                            <textarea id="serviceDescription" class="weui-textarea" name="description" placeholder="请输入描述" rows="3" maxlength="400" oninput="checkLen(this)"></textarea>
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
                        <label class="weui-label">最晚结束日期</label>
                    </div>
                    <div class="weui-cell__bd">
                        <input id="endDate" class="weui-input" name="endDate" type="date" value="" min=<%out.print(nowTime);%>>
                    </div>
                </div>

                <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label">价格</label>
                    </div>
                    <div class="weui-cell__bd">
                        <input id="servicePrice" class="weui-input" name="price" type="number" pattern="[0-9]*" placeholder="请输入分享价格"/>
                    </div>
                    <div class="weui-cell__ft">
                        <span id = "priceUnit-span">积分/天</span>
                    </div>
                </div>

                <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label">押金</label>
                    </div>
                    <div class="weui-cell__bd">
                        <input  id="deposit" name="deposit" class="weui-input"  type="number"  pattern="[0-9]*" placeholder="请输入押金数额"/>
                    </div>
                </div>

                <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label">取件地址</label>
                    </div>
                    <div class="weui-cell__bd">
                        <input  id="address" class="weui-input" name="address" type="text"  placeholder="请输入取件地址"/>
                    </div>
                </div>

                <div class="weui-gallery" id="gallery" style="opacity: 1; display: none;">
                    <span class="weui-gallery__img" id="galleryImg" style="background-image:url(.)"></span>
                    <%--<div class="weui-gallery__opr">--%>
                    <%--<a href="javascript:" class="weui-gallery__del">--%>
                    <%--<i class="weui-icon-delete weui-icon_gallery-delete"></i>--%>
                    <%--</a>--%>
                    <%--</div>--%>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <div class="weui-uploader">
                            <div class="weui-uploader__hd">
                                <p class="weui-uploader__title">上传物品照片（最多3张,长按可删除）</p>

                            </div>
                            <div class="weui-uploader__bd">
                                <ul class="weui-uploader__files" id="uploaderFiles"></ul>
                                <div class="weui-uploader__input-box">
                                    <input id="uploaderInput"  name="uploaderInput" class="weui-uploader__input" type="file" accept="image/*" multiple="">

                                </div>

                            </div>

                        </div>
                    </div>
                </div>

            </div>

            <div class="weui-btn-area">
                    <a class="weui-btn weui-btn_primary" href="javascript:;" id="button1" type="button">发布</a>

            </div>
        </form>


</div>
<div class="weui-tabbar" style="height: 50px">
    <a href="${pageContext.request.contextPath}/index" class="weui-tabbar__item">
        <img src="../img/图标/all.png" alt="" class="weui-tabbar__icon">
        <p class="weui-tabbar__label" >首页</p>
    </a>
    <a href="${pageContext.request.contextPath}/publish/favor" class="weui-tabbar__item">
        <img src="../img/图标/favorite.png" alt="" class="weui-tabbar__icon">
        <p class="weui-tabbar__label" style="color: #999999;">收藏</p>
    </a>
    <a href="${pageContext.request.contextPath}/publish/add" class="weui-tabbar__item">
        <img src="../img/图标/加号3.png" alt="" class="weui-tabbar__icon">
        <p class="weui-tabbar__label" style="color: #20B2AA;">发布</p>
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

<!-- jQuery 3 -->
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">


    //var form = document.getElementById("PublishForm");
    //var data2 = new FormData(form);

    $(document).ready(function () {
        $('.weui-tabbar:eq(0)').find('a:eq(1)').addClass("weui-bar__item_on");
        $('.weui-name:gt(0)').hide();$('.weui-name:gt(0)').find('.weui-select').attr("name","");
        $('.weui-select:eq(0)').change(function () {
            $('.weui-name').hide();$('.weui-name').find('.weui-select').attr("name","");
            $('#'+$(this).val()).show();$('#'+$(this).val()).find('.weui-select').attr("name","serviceName");
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



    var contextPath="${pageContext.request.contextPath}";
    $.fn.longPress = function(fn) {
        var timeout = undefined;
        var $this = this;
        for(var i = 0;i<$this.length;i++){
            $this[i].addEventListener('touchstart', function(event) {
                timeout = setTimeout(fn, 500);  //长按时间超过800ms，则执行传入的方法
            }, false);
            $this[i].addEventListener('touchend', function(event) {
                clearTimeout(timeout);  //长按时间少于800ms，不会执行传入的方法
            }, false);
        }
    };
    var xmlHttpRequest;
    $(function(){
        if(window.XMLHttpRequest){
            xmlHttpRequest=new XMLHttpRequest();
        }else{
            xmlHttpRequest=new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlHttpRequest.open("GET","AjaxServlet",true);
    });
    $(function(){
        var tmpl = '<li class="weui-uploader__file" style="background-image:url(#url#)"></li>',
                $gallery = $("#gallery"), $galleryImg = $("#galleryImg"),

                $uploaderInput = $("#uploaderInput"),
                $uploaderFiles = $("#uploaderFiles")

                ;

        $uploaderInput.on("change", function(e){
            for(var i=0;i<$uploaderInput[0].files.length;i++) {
                if ($uploaderInput[0].files.length <= 0)
                {
                    showAlert('至少选择一张图片');
                    return;
                }

                if ($uploaderInput[0].files.length >3 )
                {
                    $uploaderInput[0].value = '';
                    showAlert('最多选择三张图片');
                    return;
                }

                if ($uploaderInput[0].files[i].size > 1024 * 1024 * 5) {
                    $uploaderInput[0].value = '';
                    showAlert('图片过大请重新选择');
                    return;
                }
            }


           // var item=  document.getElementById("uploadItem").files[0];
            //var formData = new FormData();
            //formData.append("uploadItem",item);

            var src, url = window.URL || window.webkitURL || window.mozURL, files = e.target.files;


            for (var i = 0, len = files.length; i < len; ++i) {
                var file = files[i];

                if (url) {
                    src = url.createObjectURL(file);
                } else {
                    src = e.target.result;
                }


                $uploaderFiles.append(tmpl.replace("#url#", src));
                $uploaderInput.parent().hide();
            }



        });

        $uploaderFiles.on("click", "li", function(){
            $galleryImg.attr("style", this.getAttribute("style"));
            $gallery.fadeIn(100);
        });
        $uploaderFiles.longPress(function () {
            $uploaderFiles.empty();
            $uploaderInput.parent().show();
            $uploaderInput[0].value='';
        });


        $gallery.on("click", function(){
            $gallery.fadeOut(100);
        });


    });
    $(function() {
        $("#button1").on('click', function () {

            var addServiceType = document.getElementById("addServiceType").value;
            var serviceDescription = document.getElementById("serviceDescription").value;
            var address = document.getElementById("address").value;
            var theme = document.getElementById("theme").value;

            var deposit = document.getElementById("deposit").value;
            var endDate = document.getElementById("endDate").value;
            var servicePrice = document.getElementById("servicePrice").value;

            if(theme===""){
                showAlert("请填写分享标题");
                return false;
            }
            if(serviceDescription===""){
                showAlert("请填写物品描述");
                return false;
            }
            if(deposit===""){
                showAlert("请填写押金数额");
                return false;
            }
            if(endDate===""){
                showAlert("请填写分享结束日期");
                return false;
            }
            if(servicePrice===""){
                showAlert("请填写价格");
                return false;
            }
            if(address===""){
                showAlert("请填写取件地址");
                return false;
            }


            if(servicePrice < 0){
                showAlert("金额不能为负");
                return false;
            }



            if(jQuery("input[id='uploaderInput']").val()==""){

                showAlert('至少添加一张图片');
                return false;
            }
                post();

        });


        function post(){
            var baseUrl = "http://" + location.host,
                    uploadUrl = baseUrl + contextPath + "/publish/add/submit",
                    notiUrl = baseUrl + contextPath + "/publish/list?type="+document.getElementById("addServiceType").value;

            var formData = new FormData($("#PublishForm")[0]);

            $.ajax({
                url: uploadUrl,
                type: 'POST',
               // data: formData,
                data: formData,
                async: false,
                cache: false,
                contentType: false,// 告诉jQuery不要去设置Content-Type请求头
                processData: false,// 告诉jQuery不要去处理发送的数据
                beforeSend: function (XHR) {
                    showAlert("正在提交...");
                    dialogLoading = showLoading();
                },
                success: function (data) {
                    if(data=="upload success")
                    {
                        showAlert("发布成功！");
                        location.href=notiUrl;

                    }
                    else if(data=="failure")
                    {
                        showAlert("很抱歉，上传信息失败，请稍后尝试！");
                    }
                    else {showAlert("上传信息失败，请稍后尝试！");}
                    //...
                },
                error: function (data) {
                    showAlert("失败。很抱歉，上传信息失败，请稍后尝试！");

                    //...
                },
                complete: function (xhr, type) {
                    dialogLoading.hide();
                }
            });
            return false;
        }



    });
</script>

</body>
</html>
