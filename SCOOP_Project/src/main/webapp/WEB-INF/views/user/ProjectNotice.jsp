<!-- 협업공간 공지사항 목록 jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <jsp:include page="/WEB-INF/views/commons/title.jsp"></jsp:include>
     <!-- Pignose Calender -->
    <link href="<c:url value="/resources/plugins/pg-calendar/css/pignose.calendar.min.css" />" rel="stylesheet">
    <!-- Chartist -->
    <link rel="stylesheet" href="<c:url value="/resources/plugins/chartist/css/chartist.min.css" />">
    <link rel="stylesheet" href="<c:url value="/resources/plugins/chartist-plugin-tooltips/css/chartist-plugin-tooltip.css" />">
    <!-- Custom Stylesheet -->
    <link href="<c:url value="/resources/css/style.css" />" rel="stylesheet">

</head>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<style>
.newissue{
   border-bottom: 1px solid #c8c8c8;
   padding-top: 0.7%;
   padding-bottom: 0.7%;
}
</style>
<script type="text/javascript">
$(function(){
	$('#getOutTeam').mouseover(function(){
		console.log("열려라 참깨")
		 $('#door').attr("style","font-size: 20px;color:#E71D36;");
	});
	$('#getOutTeam').mouseout(function(){
		 $('#door').attr("style","font-size: 20px;");
	});
	$('#nowrite').mouseover(function(){
	      $(this).attr("style","cursor: pointer;color:#E71D36;font-size:20px;padding-bottom:3px;");
	});
	$('#nowrite').mouseout(function(){
	      $(this).attr("style","cursor: pointer;font-size:20px;padding-bottom:3px;");
	});
   $('#myModal_Edit_Icon').mouseover(function(){
      $(this).attr("style","margin-left: 5px;cursor: pointer;font-size: 15px;color:#E71D36;");
   });
   $('#myModal_Edit_Icon').mouseout(function(){
      $(this).attr("style","margin-left: 5px;cursor: pointer;font-size: 15px;");
      });
   $('#admin_EditIcon').mouseover(function(){
      $(this).attr("style","cursor: pointer;font-size: 20px;color:#195ac2;");
   });
   $('#admin_EditIcon').mouseout(function(){
      $(this).attr("style","cursor: pointer;font-size: 20px;color:black;");
      });
   $('#c_InformationBtn').click(function(){
      $('#c_InformationBtn').attr("style","border:none; color: #E71D36;background-color: #fff;padding-left: 16px;padding-top: 16px;padding-right: 16px;");
      $('#c_ManagementBtn').attr("style","border:none; color: #000;background-color: #fff;");
      $('#c_Information').show();
      $('#c_Management').hide();
   });
   $('#c_ManagementBtn').click(function(){      
      $('#c_ManagementBtn').attr("style","border:none; color: #E71D36;background-color: #fff;");
      $('#c_InformationBtn').attr("style","border:none; color: #000;background-color: #fff;padding-left: 16px;padding-top: 16px;padding-right: 16px;");
      $('#c_Management').show();
      $('#c_Information').hide();
   });
   $('.adm').click(function(){
	   if($(this).closest(".drop-down").prev().children().length==1){
		   $(this).closest(".drop-down").prev().prepend('<i class="fas fa-user-cog" id="icon_First" style="font-size: 20px;color:#195ac2;"></i>');
		   $(this).text('관리자 권한 해제');
	   }else{
		   $(this).closest(".drop-down").prev().children().first().remove();
		   $(this).text('관리자 권한 설정');
	   }
   })
   $('#admSubmit').click(function(){
	   console.log("gd");
	   for(let i=0; i<$('.log-user').length-1; i++){
		   if($('#iconAdd'+i).first().children().eq(0).attr('class')=='fas fa-user-cog'){
			   console.log("관리자");
			   $('#admDiv').append('<input type="hidden" value="'+100+'" name="pjuserrank">')
		   }else{
			   console.log("일반");
			   $('#admDiv').append('<input type="hidden" value="'+300+'" name="pjuserrank">')
		   }
	   }
	   
   })
      $('#getOutTeam').click(function(){
	   console.log("???");
	   Swal.fire({
		   title: '정말로 협업공간을 탈퇴 하시겠습니까??',
		   text: "탈퇴하시면 프로젝트의 모든 정보가 사라집니다!",
		   icon: 'warning',
		   showCancelButton: true,
		   confirmButtonColor: '#d33',
		   cancelButtonColor: '#c8c8c8',
		   confirmButtonText: '확인',
		   cancelButtonText: '취소'
		 }).then((result) => {
		   if (result.value) {
			   if('${myInfo.pjuserrank}'==300){
				   location.href = 'getOutTeam.do?tseq='+$('#getTseq').val()+'&email='+'${sessionScope.email}';
			   }else{
				   Swal.fire({
							  title : '협업공간 탈퇴 실패',
							  text : '팀장을 위임하고 탈퇴해주세요!',
							  icon : 'warning',
							  confirmButtonColor: '#d33'
				   })
			   }
		   }
		 })
   })
   $('.banMember').click(function(){
	   var memDiv = $(this).parents(".search_NameEmail");
	   Swal.fire({
		   title: '정말로 삭제하시겠습니까?',
		   text: "확인을 누르시면 되돌릴수 없습니다!",
		   icon: 'warning',
		   showCancelButton: true,
		   confirmButtonColor: '#d33',
		   cancelButtonColor: '#c8c8c8',
		   confirmButtonText: '확인',
		   cancelButtonText: '취소'
		 }).then((result) => {
		   if (result.value) {
				$.ajax({
					type : 'post',
					url : 'banMember.do',
					data : {
						tseq:$('#getTseq').val(),
						email:$(this).attr('value')
					},
					success : function(data) {
						console.log("ajax success"+data);
						console.log(memDiv);
						$(memDiv).remove();
					}
				});
		   }
		 })
		})

		/* 북마크 */
		$('.bookmark').click(function(){
			let book = $(this);
			
			let icon = book.attr('class').split(' ');
			let status = book.attr('name');
			let tiseq = book.closest('div.row').children('input[name=tiseq]').val();
			let tseq = book.closest('div.row').children('input[name=tseq]').val();

			console.log(icon);
			console.log(status);
			console.log(tiseq);
			console.log(tseq);
			
			let dat;
			let mark;
			
			$.ajax({
				url : "tibookmark.do",
				type : "POST",
				data : {"tiseq" : tiseq ,
						"tseq" : tseq, 
						"status" : status
				       },
				success : function(datadata){
					mark = book.attr('class').split(' ');

					if(status == "bookoff"){
						console.log('bookclass ? ' + book.attr('class'));
						console.log('icon : ' + mark);
						console.log('bookoff if');
						book.removeAttr('name').attr('name', 'bookon');
						book.removeClass(mark[1]+" "+mark[2]).addClass("fas fa-bookmark");

						Swal.fire({
				    		  title: "북마크 성공",
				    		  text: "북마크 성공",
				    		  icon: "success",
				    		  button: "확인"
				    		})
					}else if(status == "bookon"){
						console.log('bookon if');
						book.removeAttr("name").attr("name", "bookoff");
						book.removeClass(mark[1]+" "+mark[2]).addClass("far fa-bookmark");

						Swal.fire({
				    		  title: "북마크 취소",
				    		  text: "북마크 취소",
				    		  icon: "worning",
				    		  button: "확인"
				    		})
					}
					

				},
				error : function(err){
					console.log('error' + err);
					Swal.fire({
			    		  title: "북마크 중 에러",
			    		  text: "북마크 중 에러발생",
			    		  icon: "error",
			    		  button: "확인"
			    		})
					return false;
				}
			});
		});
	});

	/* 프로젝트 이름 검색 - 도연 */
	function project_filter() {
		var value, name, item, i;
		value = document.getElementById("searchId").value.toUpperCase();
		item = document.getElementsByClassName("search_NameEmail");
		for (i = 0; i < item.length; i++) {
			name = item[i].getElementsByClassName("finalsearch");
			console.log(name);
			if (name[0].innerText.toUpperCase().indexOf(value) > -1
					|| name[1].innerText.toUpperCase().indexOf(value) > -1) {
				item[i].style.display = "block";
			} else {
				item[i].style.display = "none";
			}
		}
	}

	//프로젝트 공지사항작성 validation
    function checkpjnotice() {
    //이슈 제목 공백 확인
     if($("#pntitle").val() == ""){
        Swal.fire("제목을 입력해주세요.");
       $("#pntitle").focus();
       return false;
     }

     //이슈 설명 공백 확인
     if($("#pncontent").val() == ""){
        Swal.fire("내용을 입력해주세요.");
       $("#pncontent").focus();
       return false;
     }

   return true;
   }
</script>
<body>
<c:set var="email" value="${sessionScope.email}" />
    <jsp:include page="/WEB-INF/views/commons/preloader.jsp"></jsp:include>

    <!--**********************************
        Main wrapper start
    ***********************************-->
    <div id="main-wrapper">

        <jsp:include page="/WEB-INF/views/commons/headerAndLeft.jsp"></jsp:include>

        <!--**********************************
            Content body start
        ***********************************-->
        <div class="content-body">
        <div class="container-fluid">
        <div class="card" style="padding-bottom: 30px;">
      <div class="row" style="margin: 2% 2% 15px 2%">
         <div class="col-sm-10" style="padding-left: 0">
            <h3 style="padding-left: 1%;">${tpj.pname}
            	<c:if test="${rank == 100}">
            	<span data-toggle="tooltip" data-placement="top" title="협업공간 관리" >
            	<i class="fas fa-cog" id="myModal_Edit_Icon" style="margin-left: 5px;cursor: pointer; font-size: 15px" data-toggle="modal" data-target="#myModal_Edit" ></i>
            	</span>
            	<span data-toggle="tooltip" data-placement="top" title="공지사항 관리" >
            	<span id="nowrite" class="iconify" data-icon="jam:write" style="font-size:20px;cursor: pointer;padding-bottom: 3px;" data-inline="false" data-toggle="modal" data-target="#pnoticewrite">
            	</span>
            	</span>
            	
            	</c:if>
            </h3>
            <p style="padding-left: 1%;margin-bottom: 0px;">[${tpj.pcontent}]</p>
         </div>
       <div class="col-sm-2" style="text-align: right">
        	<span id="getOutTeam" style="cursor: pointer;">
        		<span id="door" class="iconify" data-icon="vs:door-open" data-inline="false" style="font-size: 20px;"></span> 
				<span id="quit">협업공간 탈퇴하기</span>
        	</span>
        </div>
      </div>
      <div class="row" style="margin-left: 2%;">
         <ul class="nav nav-pills">
             <li class="nav-item">
               <a class="nav-link" href="projectDetail.do?tseq=${tpj.tseq}">팀이슈</a>
             </li>
             <li class="nav-item">
               <a class="nav-link" href="projectCalendar.do?tseq=${tpj.tseq }">팀 캘린더</a>
             </li>
             <li class="nav-item">
               <a class="nav-link" href="cooperation-kanban.do?tseq=${tpj.tseq}">칸반</a>
             </li>
             <li class="nav-item">
               <a class="nav-link" href="projectNotice.do?tseq=${tpj.tseq}"style="color: #E71D36;" >공지사항</a>
             </li>
             <li class="nav-item">
               <a class="nav-link" href="projectLadder.do?tseq=${tpj.tseq}">사다리 타기</a>
             </li>
          </ul>
      </div>
      <hr style="margin-top: 0;margin-left: 2%; margin-right: 2%">
      <div class="row" style="margin-left: 2%; margin-right: 2%">
         <div class="col-sm-3 newissue" >
         작성자
         </div>
         <div class="col-sm-7 newissue">
         제목 
         </div>
         <div class="col-sm-2 newissue">
         작성시간 
         </div>
      </div>
         <input type="hidden" name="tiseq" value="${ti.tiseq}" />
         <input type="hidden" name="tseq" value="${tpj.tseq}" />
      <c:forEach items="${pjn}" var="p">
         <div class="row" style="margin-left: 2%; margin-right: 2%" id="row">
         <div class="col-sm-3 newissue" >
         <a href="pjNoticeDetail.do?pnseq=${p.pnseq}&tseq=${p.tseq}">${p.name}</a>
         </div>
         <div class="col-sm-7 newissue" >
         <a href="pjNoticeDetail.do?pnseq=${p.pnseq}&tseq=${p.tseq}">${p.pntitle}</a> 
         </div>
         <div class="col-sm-2 newissue">
         <a href="pjNoticeDetail.do?pnseq=${p.pnseq}&tseq=${p.tseq}">${fn:substring(p.pntime,0,16)}</a> 
         </div>
      </div>
      </c:forEach>
      		<div id="loadPlus" data-toggle="tooltip" data-placement="bottom" title="더 보기" >
			<div id="load" class="iconify" style="font-size: 40px; color:#464a53;cursor: pointer; margin-left: 627px; margin-top: 1%;" data-icon="mdi:chevron-double-down" data-inline="false">더 보기</div>
			</div>
            <!-- #/ container -->
            </div>
            </div>
        </div>
        <!--**********************************
            Content body end
        ***********************************-->
        
<div class="modal fade" id="myModal_Edit">
   <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">

         <!-- Modal Header -->
         <div class="modal-header">
            <h4 class="modal-title">협업공간 관리</h4>
            <button type="button" class="close" data-dismiss="modal">&times;</button>
         </div>
            <div style="padding-left: 25px;">
            <button id="c_InformationBtn" style=" border:none; border:hidden; ; color: #E71D36;background-color: #fff;padding-left: 16px;padding-top: 16px;padding-right: 16px;"><i class="far fa-edit" style="padding-right: 5px;"></i>협업공간 정보</button>
            <button id="c_ManagementBtn" style="border:none; color: #000;background-color: #fff;" ><i class="fas fa-user-friends" style="padding-right: 5px;"></i>멤버 관리</button>
            </div>

         <!-- Modal body -->
         <form action="teamSetting.do" method="post">
            <div class="modal-body" id="admDiv" style="width: 450px;height: 250px;margin-left: 25px;">
               <div  id="c_Information">
               <label for="pname_Edit">협업공간 이름</label> 
               <input class="form-control createmodal" type="text" id="pname_Edit" name="pname" style="width: 100%" value="${tpj.pname}"> <br> 
                  <label for="pcontent_Edit">협업공간 설명</label>
               <textarea class="form-control createmodal" rows="3" id="pcontent_Edit"name="pcontent" style="width: 100%">${tpj.pcontent }</textarea>
               </div>

               <div id="c_Management" class="nav-label" style="display: none;padding-left: 0px;padding-right: 0px;">
               <input onkeyup="project_filter()" type="search" id="searchId" class="form-control" style="border-radius: 0.25rem; height: 20px;margin-bottom: 15px;width: 400px;margin-left: 10px;" placeholder="이름  또는 이메일 주소로 멤버 검색">
                  <div class="row" style="overflow: auto;height: 150px;">
                  <c:forEach items="${projectmember}" var="pm" varStatus="status">
                     <div class="search_NameEmail col-sm-6">
                        <span class="nav-text finalsearch" id="member_Name${status.index}" style="color: #4d4d46;font-size: 13px;padding-bottom:5px;padding-top: 10px;"> &nbsp;${pm.name}</span>
                        <span class="log-user" id="iconAdd${status.index}" data-toggle="dropdown" style="float: right;top: 0px;padding-top: 10px;">
                        <c:choose>
                        	<c:when test="${pm.pjuserrank==100}"><i class="fas fa-user-cog" id="icon_First${status.index}" style="font-size: 20px;color:#195ac2;"></i></c:when>
                        	<%-- <c:when test="${pm.pjuserrank==200}">매니저</c:when> --%>
                        </c:choose>
                           <i class="fas fa-cog admin_EditIcon" id="admin_EditIcon${status.index}" style="cursor: pointer;font-size: 20px;color:black;"></i>
                        </span>
                        <div class="drop-down dropdown-language animated fadeIn  dropdown-menu"  id="admindrop">
                        <div class="dropdown-content-body">
                        <ul style="margin-bottom: 0px; padding-bottom: 0px;padding-top: 0px;">
                        <c:choose>
                        	<c:when test="${pm.pjuserrank==100}">
	                           <li id="adminCancle${status.index}" value="off" class="adm">관리자 권한 해제</li>
	                           <li class="banMember" value="${pm.email}">멤버 탈퇴</li>
                        	</c:when>
                        	<%-- <c:when test="${pm.pjuserrank==200}">매니저</c:when> --%>
                        	<c:when test="${pm.pjuserrank==300}">
	                           <li id="adminPlus${status.index}" value="on" class="adm">관리자로 설정</li>
                        	   <li class="banMember" value="${pm.email}">멤버 탈퇴</li>
                        	</c:when>
                        </c:choose>
                        </ul> 
                        </div>
                        </div>
                        
                        <span class="nav-text finalsearch" id="member_Email${status.index}" style="padding-bottom: 1%; padding-top:5px; font-weight: normal;"> &nbsp;${pm.email}</span>
			            <input type="hidden" name="email" value="${pm.email}">
                        
                     </div>
                  </c:forEach>
               </div>
               </div>
            </div>

            <!-- Modal footer -->

            <input type="hidden" id="getTseq" name="tseq" value="${tpj.tseq}">
            <!-- <input type="hidden" name="ischarge" value="0"> -->
            <!-- <input type="hidden" name="istpalarm" value="0"> -->
            <!-- <input type="hidden" name="ptime" value="20/01/08"> -->
            <div class="modal-footer" id="c_InformationSubmit">
               <input type="submit" class="btn btn-secondary" id="admSubmit" value="수정 완료"
                  style="background-color: #E71D36; border-color: #CCCCCC; color: #fff; cursor: pointer;">
               <input type="button" class="btn btn-secondary" value="취소"
                  style="background-color: #E71D36; border-color: #CCCCCC; color: #fff; cursor: pointer;"
                  data-dismiss="modal">
            </div>
         </form>
      </div>
   </div>
</div>
      <div class="modal fade" id="pnoticewrite">
   <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">

         <!-- Modal Header -->
         <div class="modal-header">
            <h3 class="modal-title">공지사항 작성</h3>
            <button type="button" class="close" data-dismiss="modal">&times;</button>
         </div>
   
         <form action="PnoticeWrite.do" method="POST" onsubmit="return checkpjnotice()">
            <!-- Modal body -->
            <div class="modal-body">
               <!-- <p style="font-size: 12px">협업공간은 함께 일하는 멤버들끼리만 자료를 공유하고 협업할 수 있는 공간입니다.<br>
             협업공간을 만들고 함께 일할 멤버들을 초대해보세요.</p> -->
               <label for="bntitle">공지사항</label> <input
                  class="form-control createmodal" type="text" id="pntitle"
                  name="pntitle" style="width: 100%" placeholder="제목을 입력해 주세요.">
               <br> <label for="noticecontent">공지 설명</label>
               <textarea class="form-control createmodal" rows="5"
                  id="pncontent" name="pncontent" style="width: 100%"
                  placeholder="내용을 적어주세요."></textarea>   
                  <input type="hidden" name="email" value="${sessionScope.email}">      
                  <input type="hidden" name="tseq" value="${tpj.tseq}">      
            <!-- Modal footer -->
            <div class="modal-footer">
               <button type="submit" class="btn btn-secondary"
                  style="background-color: #E71D36; border-color: #CCCCCC; color: #fff; cursor: pointer;">작성 완료</button>
               <button type="button" class="btn btn-secondary"
                  style="background-color: #E71D36; border-color: #CCCCCC; color: #fff; cursor: pointer;"
                  data-dismiss="modal">취소</button>
               </div>
            </div>
         </form>
      </div>
   </div>
   </div>
  <jsp:include page="/WEB-INF/views/commons/footer.jsp"></jsp:include>
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

    <!-- Chartjs -->
    <script src="<c:url value="/resources/plugins/chart.js/Chart.bundle.min.js" />"></script>
    <!-- Circle progress -->
    <script src="<c:url value="/resources/plugins/circle-progress/circle-progress.min.js" />"></script>
    <!-- Datamap -->
    <script src="<c:url value="/resources/plugins/d3v3/index.js"/>"></script>
    <script src="<c:url value="/resources/plugins/topojson/topojson.min.js"/>"></script>
    <script src="<c:url value="/resources/plugins/datamaps/datamaps.world.min.js"/>"></script>
    <!-- Morrisjs -->
    <script src="<c:url value="/resources/plugins/raphael/raphael.min.js"/>"></script>
    <script src="<c:url value="/resources/plugins/morris/morris.min.js"/>"></script>
    <!-- Pignose Calender -->
    <script src="<c:url value="/resources/plugins/moment/moment.min.js"/>"></script>
    <script src="<c:url value="/resources/plugins/pg-calendar/js/pignose.calendar.min.js"/>"></script>
    <!-- ChartistJS -->
    <script src="<c:url value="/resources/plugins/chartist/js/chartist.min.js"/>"></script>
    <script src="<c:url value="/resources/plugins/chartist-plugin-tooltips/js/chartist-plugin-tooltip.min.js"/>"></script>

    <script src="<c:url value="/resources/js/dashboard/dashboard-1.js"/>"></script>
	<script type="text/javascript">
$(document).ready(function(){
	//더보기 스타일 변경
	$('#load').mouseover(function(){
		$(this).css("color","#E71D36");
	});
	$('#load').mouseout(function(){
		$(this).css("color","#464a53");
	});
	var temp = 0;
	var moreEventArray = document.querySelectorAll(".card > #row ");
	if(moreEventArray.length<=10){
		 $('#load').remove();
        $('#loadPlus').remove();
        $('.tooltip').remove();
	}
	 $(moreEventArray).attr("hidden","hidden");	
	 $(moreEventArray).slice(0,10).removeAttr("hidden");
	 $(moreEventArray).slice(0,10);
	 temp = 10;
	$("#load").click(function(e){
		console.log(moreEventArray);
		/* console.log($('.card'));
		console.log($('.card > a'));
		console.log($('.card > a > .row'));
		console.log($(".card > a > .row").val()); */
		console.log("if");
		$(moreEventArray).slice(temp,temp+10).removeAttr("hidden");
		 temp +=10;
		if(moreEventArray.length<temp+10){
			$(moreEventArray).slice(temp,10).removeAttr("hidden");
				if(temp-moreEventArray.length>=0){
		            $('#load').remove();
		            $('#loadPlus').remove();
		            $('.tooltip').remove();
		         }

			}
		
			
	}); 

});
</script>
</body>
</html>