<!-- 내정보에서 알람 jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <script language="javascript" src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
    <jsp:include page="/WEB-INF/views/commons/title.jsp"></jsp:include>
    <!-- Custom Stylesheet -->
    <link href="<c:url value="/resources/css/style.css" />" rel="stylesheet">

</head>
<style>
.myinfo{
 border: 0;
 border-bottom: 1px solid #c8c8c8;
 background-color: white;
}
.form-control[readonly]{
	background-color: white;
}
.switch {
  position: relative;
  display: inline-block;
  width: 60px;
  height: 34px;
  vertical-align:middle;
}

/* Hide default HTML checkbox */
.switch input {display:none;}

/* The slider */
.slider {
  position: absolute;
  cursor: pointer;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: #ccc;
  -webkit-transition: .4s;
  transition: .4s;
}

.slider:before {
  position: absolute;
  content: "";
  height: 26px;
  width: 26px;
  left: 4px;
  bottom: 4px;
  background-color: white;
  -webkit-transition: .4s;
  transition: .4s;
}

input:checked + .slider {
  background-color: #E71D36;
}

input:focus + .slider {
  box-shadow: 0 0 1px #E71D36;
}

input:checked + .slider:before {
  -webkit-transform: translateX(26px);
  -ms-transform: translateX(26px);
  transform: translateX(26px);
}

/* Rounded sliders */
.slider.round {
  border-radius: 34px;
}

.slider.round:before {
  border-radius: 50%;
}

p ,d ,c ,f{
	margin:0px;
	display:inline-block;
	font-size:15px;
	font-weight:bold;
}

</style>

<body>

    <jsp:include page="/WEB-INF/views/commons/preloader.jsp"></jsp:include>

    
    <!--**********************************
        Main wrapper start
    ***********************************-->
    <div id="main-wrapper">

      <jsp:include page="/WEB-INF/views/commons/headerAndLeft.jsp"></jsp:include>

        <!--*********************************	*
            Content body start
        ***********************************-->
        <div class="content-body">
            <div class="container-fluid">
        <div class="card">
		<div class="row" style="margin: 2%">
			<div class="col-sm-12" style="padding-left: 0">
				<h3>알림</h3>
			</div>
		</div>
		<div class="row" style="margin-left: 2%;">
			<ul class="nav nav-pills">
			    <li class="nav-item">
			      <a class="nav-link" href="memberEdit.do?${sessionScope.email}">내 정보</a>
			    </li>
			    <!-- <li class="nav-item">
			      <a class="nav-link" href="app-external.do">외부 서비스 연결</a>
			    </li> -->
			    <li class="nav-item">
			      <a class="nav-link" href="paymentPage.do">가격 및 결제</a>
			    </li>
			     <li class="nav-item">
			      <a class="nav-link" href="memberDelete.do">회원 탈퇴</a>
			    </li>
		    </ul>
		</div>
		<hr style="margin-top: 0">
		<div class="row" style="margin-left: 4%; margin-right: 2%; margin-top: 1%">
			<div class="col-sm-12" style="padding-left: 0">
				<h4>알림</h4>
				<br>
				<h5>알림 여부</h5>
			<label class="switch">
  			<input type="checkbox" name="pnalert" id="checkAll" class="danger" onclick="cAll()">
 			 <span class="slider round"></span>
			</label>
			<p>OFF</p><p style="display:none;">ON</p>
			<hr>
			<h5>댓글 알림</h5>
			<label class="switch">
  			<input type="checkbox" name="replyalert" id="reply">
 			 <span class="slider round"></span>
			</label>
			<d>OFF</d><d style="display:none;">ON</d>
			<hr>
			<h5>팀이슈 알림</h5>
			<label class="switch">
  			<input type="checkbox" name="tialert" id="issue">
 			 <span class="slider round"></span>
			</label>
			<c>OFF</c><c  style="display:none;">ON</c>
			<hr>
			<h5>멘션 알림</h5>
			<label class="switch">
  			<input type="checkbox" name="votealert" id="mention" >
 			 <span class="slider round"></span>
			</label>
			<f>OFF</f><f style="display:none;">ON</f>
			</div>
			<hr>
		</div>
            <!-- #/ container -->
            </div>
            </div>
        </div>
        <!--**********************************
            Content body end
        ***********************************-->
       
        <!--**********************************
            Footer start
        ***********************************-->
       <jsp:include page="/WEB-INF/views/commons/footer.jsp"></jsp:include>
        <!--**********************************
            Footer end
        ***********************************-->
    </div>
    <!--**********************************
        Main wrapper end
    ***********************************-->

    <!--**********************************
        Scripts
    ***********************************-->
 	<script src="<c:url value="/resources/plugins/common/common.min.js" />"></script>
    <script src="<c:url value="/resources/js/custom.min.js" />"></script>
    <script src="<c:url value="/resources/js/settings.js" />"></script>
    <script src="<c:url value="/resources/js/gleek.js" />"></script>
    <script src="<c:url value="/resources/js/styleSwitcher.js" />"></script>
	<script type="text/javascript">
	
 	

	var check2 = $("#reply");
	check2.click(function(){
		$("d").toggle();
	});

	var check3 = $("#issue");
	check3.click(function(){
		$("c").toggle();
	});

	var check4 = $("#mention");
	check4.click(function(){
		$("f").toggle();
		console.log($("#mention"));
	}); 

		function cAll() {
            if ($("#checkAll").is(':checked')) {
                
                $("p").toggle();
                $("d").toggle();
                $("c").toggle();
                $("f").toggle();
                
                 $.ajax({
               	 url: "updateAlarm.do", //cross-domain error가 발생하지 않도록 주의해주세요
         			 type: 'POST',
         			 dataType: 'json',
                   data: {
 						
                       //기타 필요한 데이터가 있으면 추가 전달
                   },
                   success: function(data){
                	   $("input[type=checkbox]").prop("checked", true);
                	    $("#reply").prop("disabled", false);
                        $("#issue").prop("disabled", false);
                        $("#memtion").prop("disabled", false);
                       }
               }) 
               
            } else {
                $("input[type=checkbox]").prop("checked", false);
                $("#reply").prop("disabled", true);
                $("#issue").prop("disabled", true);
                $("#memtion").prop("disabled", true);
                $("p").toggle();
                $("d").toggle();
                $("c").toggle();
                $("f").toggle();
            }
        }
		
	


</script>
</body>

</html>