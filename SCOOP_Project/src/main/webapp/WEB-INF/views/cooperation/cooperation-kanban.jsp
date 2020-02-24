<!-- 협업공간 칸반 jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <jsp:include page="/WEB-INF/views/commons/title.jsp"></jsp:include>
    <!-- Custom Stylesheet -->
    <link href="<c:url value='/resources/css/style.css' />" rel="stylesheet">

</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<style>
.myinfo{
 border: 0;
 border-bottom: 1px solid #c8c8c8;
 background-color: white;
}
.form-control[readonly]{
	background-color: white;
}
.kanban{
  float: left;
}
.realkan{
  margin:2%;
  border: 1px solid #c8c8c8;
  min-height: 400px;
  height:400px;
  padding: 4%;
  border-radius: 0.625rem;
  overflow: auto;
}
.drags{
  border: 1px solid #c8c8c8;
  height: 40px;
  font-size: 14px;
  padding: 10px;
  border-radius: 0.625rem;
}
h5{
  margin-bottom: 10%;
}
</style>

<script>
$(function(){

	$('#getOutTeam').mouseover(function(){
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
    $('#getOutTeam').click(function(){ //협업공간 탈퇴 함수 but 팀장은 탈퇴할 수 없음
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
 $('.banMember').click(function(){ //팀장이 멤버 강제 탈퇴시키기
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
	//칸반 진행사항 별 갯수 세기
	$('#todolistCnt').text($('#first').children().length-1);
	$('#doingCnt').text($('#second').children().length-1);
  	$('#validateCnt').text($('#third').children().length-1);
  	$('#completeCnt').text($('#fourth').children().length-1);
});
function project_filter() { //협업공간에서 멤버 검색
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
/* 칸반 비동기 함수들 */
function allowDrop(ev) {
  ev.preventDefault();
}

function drag(ev) {
  ev.dataTransfer.setData("text", ev.target.id);
}
var tseq = document.location.href.split("tseq=")[1]; 
function drop(ev) {
  ev.preventDefault();
  var data = ev.dataTransfer.getData("text");
 

  console.log(document.getElementById(data).getAttribute("name"));
  console.log(ev.target.parentElement);
  console.log(ev.target.parentElement.parentElement);
  if(ev.target.parentElement.getAttribute("id")=="todolist"){
	  if(document.getElementById(data).getAttribute("name")!=0){
	    ev.target.appendChild(document.getElementById(data));
	    $.ajax({
		    url:'kanbanEdit.do', //request 보낼 서버의 경로
		    type:'post', // 메소드(get, post, put 등)
		    data:{'tiseq':document.getElementById(data).getAttribute("id"),
		    	'isprocess':0,
		    	'tseq':tseq
		    	}, //보낼 데이터
		    success: function(data) {
		    	Swal.fire({
		    		  title: "변경 성공",
		    		  text: "변경 성공",
		    		  icon: "success",
		    		  button: "확인"
		    		})
		    	
		    },
		    error: function(err) {
		    	Swal.fire({
		    		  title: "변경 실패",
		    		  text: "변경 실패",
		    		  icon: "error",
		    		  button: "확인"
		    		})
		    }
		});
	  }
	}else if(ev.target.parentElement.parentElement.getAttribute("id")=="todolist"){
		if(document.getElementById(data).getAttribute("name")!=0){
		    ev.target.parentElement.appendChild(document.getElementById(data));
		    $.ajax({
			    url:'kanbanEdit.do', //request 보낼 서버의 경로
			    type:'post', // 메소드(get, post, put 등)
			    data:{'tiseq':document.getElementById(data).getAttribute("id"),
			    	'isprocess':0,
			    	'tseq':tseq
			    	}, //보낼 데이터
			    success: function(data) {
			    	Swal.fire({
			    		  title: "변경 성공",
			    		  text: "변경 성공",
			    		  icon: "success",
			    		  button: "확인"
			    		})
			    	
			    },
			    error: function(err) {
			    	Swal.fire({
			    		  title: "변경 실패",
			    		  text: "변경 실패",
			    		  icon: "error",
			    		  button: "확인"
			    		})
			    }
			});
		  }
		}else if(ev.target.parentElement.parentElement.parentElement.getAttribute("id")=="todolist"){
			if(document.getElementById(data).getAttribute("name")!=0){
			    ev.target.parentElement.parentElement.appendChild(document.getElementById(data));
			    $.ajax({
				    url:'kanbanEdit.do', //request 보낼 서버의 경로
				    type:'post', // 메소드(get, post, put 등)
				    data:{'tiseq':document.getElementById(data).getAttribute("id"),
				    	'isprocess':0,
				    	'tseq':tseq
				    	}, //보낼 데이터
				    success: function(data) {
				    	Swal.fire({
				    		  title: "변경 성공",
				    		  text: "변경 성공",
				    		  icon: "success",
				    		  button: "확인"
				    		})
				    	
				    },
				    error: function(err) {
				    	Swal.fire({
				    		  title: "변경 실패",
				    		  text: "변경 실패",
				    		  icon: "error",
				    		  button: "확인"
				    		})
				    }
				});
			  }
			} 
	 else if(ev.target.parentElement.parentElement.getAttribute("id")=="doing"){
		if(document.getElementById(data).getAttribute("name")!=1){
		    ev.target.parentElement.appendChild(document.getElementById(data));
		    $.ajax({
			    url:'kanbanEdit.do', //request 보낼 서버의 경로
			    type:'post', // 메소드(get, post, put 등)
			    data:{'tiseq':document.getElementById(data).getAttribute("id"),
			    	'isprocess':1,
			    	'tseq':tseq
			    	}, //보낼 데이터
			    success: function(data) {
			    	Swal.fire({
			    		  title: "변경 성공",
			    		  text: "변경 성공",
			    		  icon: "success",
			    		  button: "확인"
			    		})
			    		
			    },
			    error: function(err) {
			    	Swal.fire({
			    		  title: "변경 실패",
			    		  text: "변경 실패",
			    		  icon: "error",
			    		  button: "확인"
			    		})
			    }
			});
		  }
	} else if(ev.target.parentElement.parentElement.parentElement.getAttribute("id")=="doing"){
		if(document.getElementById(data).getAttribute("name")!=1){
		    ev.target.parentElement.parentElement.appendChild(document.getElementById(data));
		    $.ajax({
			    url:'kanbanEdit.do', //request 보낼 서버의 경로
			    type:'post', // 메소드(get, post, put 등)
			    data:{'tiseq':document.getElementById(data).getAttribute("id"),
			    	'isprocess':1,
			    	'tseq':tseq
			    	}, //보낼 데이터
			    success: function(data) {
			    	Swal.fire({
			    		  title: "변경 성공",
			    		  text: "변경 성공",
			    		  icon: "success",
			    		  button: "확인"
			    		})
			    		
			    },
			    error: function(err) {
			    	Swal.fire({
			    		  title: "변경 실패",
			    		  text: "변경 실패",
			    		  icon: "error",
			    		  button: "확인"
			    		})
			    }
			});
		  }
	}
		else if(ev.target.parentElement.getAttribute("id")=="doing"){
		if(document.getElementById(data).getAttribute("name")!=1){
		    ev.target.appendChild(document.getElementById(data));
		    $.ajax({
			    url:'kanbanEdit.do', //request 보낼 서버의 경로
			    type:'post', // 메소드(get, post, put 등)
			    data:{'tiseq':document.getElementById(data).getAttribute("id"),
			    	'isprocess':1,
			    	'tseq':tseq
			    	}, //보낼 데이터
			    success: function(data) {
			    	Swal.fire({
			    		  title: "변경 성공",
			    		  text: "변경 성공",
			    		  icon: "success",
			    		  button: "확인"
			    		})
			    		
			    },
			    error: function(err) {
			    	Swal.fire({
			    		  title: "변경 실패",
			    		  text: "변경 실패",
			    		  icon: "error",
			    		  button: "확인"
			    		})
			    }
			});
		  }
	}
		else if(ev.target.parentElement.getAttribute("id")=="validate"){
		if(document.getElementById(data).getAttribute("name")!=2){
		    ev.target.appendChild(document.getElementById(data));
		    $.ajax({
			    url:'kanbanEdit.do', //request 보낼 서버의 경로
			    type:'post', // 메소드(get, post, put 등)
			    data:{'tiseq':document.getElementById(data).getAttribute("id"),
			    	'isprocess':2,
			    	'tseq':tseq
			    	}, //보낼 데이터
			    success: function(data) {
			    	Swal.fire({
			    		  title: "변경 성공",
			    		  text: "변경 성공",
			    		  icon: "success",
			    		  button: "확인"
			    		})
			    },
			    error: function(err) {
			    	Swal.fire({
			    		  title: "변경 실패",
			    		  text: "변경 실패",
			    		  icon: "error",
			    		  button: "확인"
			    		})
			    }
			});
		  }
	}else if(ev.target.parentElement.parentElement.getAttribute("id")=="validate"){
		if(document.getElementById(data).getAttribute("name")!=2){
		    ev.target.parentElement.appendChild(document.getElementById(data));
		    $.ajax({
			    url:'kanbanEdit.do', //request 보낼 서버의 경로
			    type:'post', // 메소드(get, post, put 등)
			    data:{'tiseq':document.getElementById(data).getAttribute("id"),
			    	'isprocess':2,
			    	'tseq':tseq
			    	}, //보낼 데이터
			    success: function(data) {
			    	Swal.fire({
			    		  title: "변경 성공",
			    		  text: "변경 성공",
			    		  icon: "success",
			    		  button: "확인"
			    		})
			    },
			    error: function(err) {
			    	Swal.fire({
			    		  title: "변경 실패",
			    		  text: "변경 실패",
			    		  icon: "error",
			    		  button: "확인"
			    		})
			    }
			});
		  }
	}else if(ev.target.parentElement.parentElement.parentElement.getAttribute("id")=="validate"){
		if(document.getElementById(data).getAttribute("name")!=2){
		    ev.target.parentElement.parentElement.appendChild(document.getElementById(data));
		    $.ajax({
			    url:'kanbanEdit.do', //request 보낼 서버의 경로
			    type:'post', // 메소드(get, post, put 등)
			    data:{'tiseq':document.getElementById(data).getAttribute("id"),
			    	'isprocess':2,
			    	'tseq':tseq
			    	}, //보낼 데이터
			    success: function(data) {
			    	Swal.fire({
			    		  title: "변경 성공",
			    		  text: "변경 성공",
			    		  icon: "success",
			    		  button: "확인"
			    		})
			    },
			    error: function(err) {
			    	Swal.fire({
			    		  title: "변경 실패",
			    		  text: "변경 실패",
			    		  icon: "error",
			    		  button: "확인"
			    		})
			    }
			});
		  }
	}
	
		 else if(ev.target.parentElement.getAttribute("id")=="complete"){
		if(document.getElementById(data).getAttribute("name")!=3){
		    ev.target.appendChild(document.getElementById(data));
		    $.ajax({
			    url:'kanbanEdit.do', //request 보낼 서버의 경로
			    type:'post', // 메소드(get, post, put 등)
			    data:{'tiseq':document.getElementById(data).getAttribute("id"),
			    	'isprocess':3,
			    	'tseq':tseq
			    	}, //보낼 데이터
			    success: function(data) {
			    	Swal.fire({
			    		  title: "변경 성공",
			    		  text: "변경 성공",
			    		  icon: "success",
			    		  button: "확인"
			    		})
			    },
			    error: function(err) {
			    	Swal.fire({
			    		  title: "변경 실패",
			    		  text: "변경 실패",
			    		  icon: "error",
			    		  button: "확인"
			    		})
			    }
			});
		  }
	}else if(ev.target.parentElement.parentElement.getAttribute("id")=="complete"){
		if(document.getElementById(data).getAttribute("name")!=3){
		    ev.target.parentElement.appendChild(document.getElementById(data));
		    $.ajax({
			    url:'kanbanEdit.do', //request 보낼 서버의 경로
			    type:'post', // 메소드(get, post, put 등)
			    data:{'tiseq':document.getElementById(data).getAttribute("id"),
			    	'isprocess':3,
			    	'tseq':tseq
			    	}, //보낼 데이터
			    success: function(data) {
			    	Swal.fire({
			    		  title: "변경 성공",
			    		  text: "변경 성공",
			    		  icon: "success",
			    		  button: "확인"
			    		})
			    },
			    error: function(err) {
			    	Swal.fire({
			    		  title: "변경 실패",
			    		  text: "변경 실패",
			    		  icon: "error",
			    		  button: "확인"
			    		})
			    }
			});
		  }
	}else if(ev.target.parentElement.parentElement.parentElement.getAttribute("id")=="complete"){
		if(document.getElementById(data).getAttribute("name")!=3){
		    ev.target.parentElement.parentElement.appendChild(document.getElementById(data));
		    $.ajax({
			    url:'kanbanEdit.do', //request 보낼 서버의 경로
			    type:'post', // 메소드(get, post, put 등)
			    data:{'tiseq':document.getElementById(data).getAttribute("id"),
			    	'isprocess':3,
			    	'tseq':tseq
			    	}, //보낼 데이터
			    success: function(data) {
			    	Swal.fire({
			    		  title: "변경 성공",
			    		  text: "변경 성공",
			    		  icon: "success",
			    		  button: "확인"
			    		})
			    },
			    error: function(err) {
			    	Swal.fire({
			    		  title: "변경 실패",
			    		  text: "변경 실패",
			    		  icon: "error",
			    		  button: "확인"
			    		})
			    }
			});
		  }
	}

	//칸반 진행사항 별 갯수 변경
  	$('#todolistCnt').text($('#first').children().length-1);
  	$('#doingCnt').text($('#second').children().length-1);
  	$('#validateCnt').text($('#third').children().length-1);
  	$('#completeCnt').text($('#fourth').children().length-1);
  
}
</script>
<body>

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
        <div class="card">
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
			      <a class="nav-link"  href="projectDetail.do?tseq=${tpj.tseq}">팀이슈</a>
			    </li>
			    <li class="nav-item">
			      <a class="nav-link"  href="projectCalendar.do?tseq=${tpj.tseq }">팀 캘린더</a>
			    </li>
			    <li class="nav-item">
			      <a class="nav-link" href="cooperation-kanban.do?tseq=${tpj.tseq}" style="color:#E71D36;" >칸반</a>
			    </li>
			    <li class="nav-item">
               <a class="nav-link" href="projectNotice.do?tseq=${tpj.tseq}">공지사항</a>
             </li>
			    <li class="nav-item">
               <a class="nav-link" href="projectLadder.do?tseq=${tpj.tseq}">사다리 타기</a>
             </li>
		    </ul>
		</div>
		<hr style="margin-top: 0;margin-left: 2%; margin-right: 2%;margin-bottom: 0px;">
		<div class="row" style="margin-left: 2%; margin-right: 2%;">
			<div id="todolist" class="col-sm-3 kanban">
			<div class="realkan" id="first" ondrop="drop(event)" ondragover="allowDrop(event)" style="border-top: 4px solid #ff6384;height: 500px;overflow: auto;">
			<div style="margin-bottom: 7%;">
			<div class="iconify" data-icon="uil:file-exclamation-alt" data-inline="false" style="width: 25px;height: auto;color:#ff6384"></div>
			<span style="font-size:15px;padding-top:1%;">발의됨(<span id="todolistCnt">0</span>)</span>
			<hr>
			</div>
			
			  <c:forEach items="${tissuelist}" var="tl">
			  	  <c:set value="${tl.tseq}" var="tseq"></c:set>
			  	  <c:if test="${tl.isprocess==0 }">
			  	  <div draggable="true" ondragstart="drag(event)" id="${tl.tiseq }" name="${tl.isprocess }" class="drags" style="margin-bottom: 5%;" >
			  	   <c:choose>
           				<c:when test="${fn:length(tl.tititle) > 15}">
			  	  			<a name="${tl.tiseq }" href="teamissueDetail.do?tiseq=${tl.tiseq}" >${fn:substring(tl.tititle,0,15)}...</a>
               			</c:when>
               		<c:otherwise>
               				<a name="${tl.tiseq }" href="teamissueDetail.do?tiseq=${tl.tiseq}" >${tl.tititle}</a>
           			</c:otherwise> 
          			</c:choose>     
			      </div>
			  	  </c:if>
			  </c:forEach>
			</div>
			</div>
			<div id="doing" class="col-sm-3 kanban">
				<div class="realkan"id="second" ondrop="drop(event)" ondragover="allowDrop(event)" style="border-top: 4px solid #36a2eb;height: 500px;overflow: auto">
				<div style="margin-bottom: 7%;">
				<div class="iconify" data-icon="uil:file-edit-alt" data-inline="false"style="width: 25px;height: auto;color:#36a2eb"></div>
				<span style="font-size:15px;padding-top:1%;">진행중 (<span id="doingCnt">0</span>)</span><hr>
				</div>
				
				<c:forEach items="${tissuelist}" var="tl">
			  	  <c:if test="${tl.isprocess==1 }">
			  	  <div draggable="true" ondragstart="drag(event)" id="${tl.tiseq }" name="${tl.isprocess }" class="drags" style="margin-bottom: 5%;">
			  	  	  	   <c:choose>
           				<c:when test="${fn:length(tl.tititle) > 15}">
			  	  			<a name="${tl.tiseq }" href="teamissueDetail.do?tiseq=${tl.tiseq}" >${fn:substring(tl.tititle,0,15)}...</a>
               			</c:when>
               		<c:otherwise>
               				<a name="${tl.tiseq }" href="teamissueDetail.do?tiseq=${tl.tiseq}" >${tl.tititle}</a>
           			</c:otherwise> 
          			</c:choose>  
			      </div>
			  	  </c:if>
				  </c:forEach>
				</div>
			</div>
			<div id="validate" class="col-sm-3 kanban" ondrop="drop(event)">
				<div class="realkan" id="third" ondrop="drop(event)" ondragover="allowDrop(event)" style="border-top: 4px solid #e3ad29;height: 500px;overflow: auto">
				<div style="margin-bottom: 7%;">
				<div class="iconify" data-icon="uil:file-block-alt" data-inline="false" style="width: 25px;height: auto;color:#e3ad29"></div>
				<span style="font-size:15px;padding-top:1%;">일시중지 (<span id="validateCnt">0</span>)</span><hr>
				</div>
				
				<c:forEach items="${tissuelist}" var="tl">
			  	  <c:if test="${tl.isprocess==2 }">
			  	  <div draggable="true" ondragstart="drag(event)" id="${tl.tiseq }" name="${tl.isprocess }" class="drags" style="margin-bottom: 5%;">
			  	  	  	   <c:choose>
           				<c:when test="${fn:length(tl.tititle) > 15}">
			  	  			<a name="${tl.tiseq }" href="teamissueDetail.do?tiseq=${tl.tiseq}" >${fn:substring(tl.tititle,0,15)}...</a>
               			</c:when>
               		<c:otherwise>
               				<a name="${tl.tiseq }" href="teamissueDetail.do?tiseq=${tl.tiseq}" >${tl.tititle}</a>
           			</c:otherwise> 
          			</c:choose>  
			      </div>
			  	  </c:if>
			  </c:forEach>
				</div>
			</div>
			<div id="complete" class="col-sm-3 kanban" ondrop="drop(event)">
				<div class="realkan" id="fourth" ondrop="drop(event)" ondragover="allowDrop(event)" style="border-top: 4px solid #4bc09b;height: 500px;overflow: auto">
				<div style="margin-bottom: 7%;">
				<div class="iconify" data-icon="uil:file-check-alt" data-inline="false" style="width: 25px;height: auto;color:#4bc09b"></div>
				<span style="font-size:15px;padding-top:1%;">완료 (<span id="completeCnt">0</span>)</span><hr>
				</div>
				
				<c:forEach items="${tissuelist}" var="tl">
			  	  <c:if test="${tl.isprocess==3 }">
			  	  <div draggable="true" ondragstart="drag(event)" id="${tl.tiseq }" name="${tl.isprocess }" class="drags" style="margin-bottom: 5%;">
			  	  	  	   <c:choose>
           				<c:when test="${fn:length(tl.tititle) > 15}">
			  	  			<a name="${tl.tiseq }" href="teamissueDetail.do?tiseq=${tl.tiseq}" >${fn:substring(tl.tititle,0,15)}...</a>
               			</c:when>
               		<c:otherwise>
               				<a name="${tl.tiseq }" href="teamissueDetail.do?tiseq=${tl.tiseq}" >${tl.tititle}</a>
           			</c:otherwise> 
          			</c:choose>  
			      </div>
			  	  </c:if>
			  </c:forEach>
				</div>
			</div>
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
    <script src="<c:url value='/resources/plugins/common/common.min.js' />"></script>
    <script src="<c:url value='/resources/js/custom.min.js' />"></script>
    <script src="<c:url value='/resources/js/settings.js' />"></script>
    <script src="<c:url value='/resources/js/gleek.js' />"></script>
    <script src="<c:url value='/resources/js/styleSwitcher.js' />"></script>

</body>

</html>