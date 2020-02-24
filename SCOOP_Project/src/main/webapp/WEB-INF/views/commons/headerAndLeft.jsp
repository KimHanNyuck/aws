<!-- 페이지에서 대부분 공통으로 쓰이는 head and left jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="role" value="${sessionScope.role}" />
<c:set var="count" value="${sessionScope.count}" />
<c:set var="img" value="${sessionScope.img}" />
<c:set var="status" value="${sessionScope.status}" />
<style>
input::placeholder {
   color: #fff;
}
.card{
	box-shadow: 0px 1px 10px 0px rgba(0, 0, 0, 0.5);
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<%-- <link rel="stylesheet" href="<c:url value="/resources/lib/codemirror.css" />">
<script src="<c:url value="/resources/lib/codemirror.js" />"></script> --%>
<%-- <link rel="stylesheet"
   href="<c:url value="/resources/dist/summernote.css" />">
<script src="<c:url value="/resources/dist/summernote.min.js" />"></script> --%>
<meta property="og:title" content>
<meta name="google-signin-client_id" content="806433148370-o0ss3i4kp8dhj6p0d2cvkdjfus8kivds.apps.googleusercontent.com">
<script src="https://apis.google.com/js/platform.js?onload=loadAuthClient" async defer></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
<!-- <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6/jquery.min.js" type="text/javascript"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script> 얘 위로가면 구글살고
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
 -->
    <link href= 'https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/ui-lightness/jquery-ui.css' rel='stylesheet'> 
    <script src= "https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js" ></script> 
<!-- <link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script> -->
<script type="text/javascript">
   $(function() {
	   for(let i=0; i<$('#memlist').children().length-1; i++){ //멘션에서 멤버리스트 불러올때 서로 다른 협업공간에 중복되는 유저 제거
			for(let j=i+1; j<$('#memlist').children().length;j++){
				if($('#memlist').children().eq(i).attr('id').split("/")[1] == $('#memlist').children().eq(j).attr('id').split("/")[1]){
					$('#memlist').children().eq(j).hide();
				}
			}
		}
	   $('#searchFile').keypress(function(event){ //파일함에서 파일 검색
		   if (event.keyCode == 13) {
			   $.ajax({
					url : 'teamFileSearch.do',
					dataType:"json",
					data : {word : $('#searchFile').val()},
					success : function(data) {
						$('#fileLocation').empty();
						$.each(data,function(index,object){
							tempFname = object.fdname;
							tempPname = object.pname;
							src = '/upload/'+object.fdname;
							if(object.fdname.length>=14){
								tempFname = object.fdname.substr(0, 14) + ' ...';
							}
							if(object.pname.length>=4){
								tempPname = object.pname.substr(0, 4) + ' ...';
							}
							if(object.fdname.substring(object.fdname.length-4, object.fdname.length)=='.zip'){
								src = '/SCOOP/resources/images/logo/ScoopSmall.png';
							}
							$('#fileLocation').append(
									'<div class="fileDown" id="'+object.fdname+'" style="width: 150px; height:150px; margin: 1%;">'+
							      	'<a href="fileDownload.do?fileName='+object.fdname+'">'+
							         '<img id="'+object.tseq+'" width="100px" height="100px" style="margin: 1%; display: block; margin-left: auto; margin-right: auto"'+
							            'src="<c:url value="'+src+'" />">'+
							        '</a><p style="font-size: 15px; text-align: center">'+
							        tempFname+'<br>'+tempPname+
							         '</p></div>'		
							)
						})	
					}
				}); 
			   $.ajax({
					url : 'myFileSearch.do',
					dataType:"json",
					data : {word : $('#searchFile').val()},
					success : function(data) {
						$.each(data,function(index,object){
							tempFname = object.pfdname;
							if(object.pfdname.length>=14){
								tempFname = object.pfdname.substr(0, 14) + ' ...';
							}
							$('#fileLocation').append(
									'<div class="fileDown" id="'+object.pfdname+'" style="width: 150px; height:150px; margin: 1%;">'+
							      	'<a href="fileDownload.do?fileName='+object.pfdname+'">'+
							         '<img id="'+object.tseq+'" width="100px" height="100px" style="margin: 1%; display: block; margin-left: auto; margin-right: auto"'+
							            'src="<c:url value="/upload/'+object.pfdname+'" />">'+
							        '</a><p style="font-size: 15px; text-align: center">'+
							        tempFname+'<br>프라이빗 공간'+
							         '</p></div>'		
							)
						})	
					}
				}); 
	         }
	   })
	   function clickMyFile(){ //파일함에서 프라이빗공간 선택시 비동기로 불러오기
		   var tseq = 0;
 			$.ajax({
				url : 'myFileSelect.do',
				dataType:"json",
				success : function(data) {
					$('#fileLocation').empty();
					$.each(data,function(index,object){
						tempFname = object.pfdname;
						if(object.pfdname.length>=14){
							tempFname = object.pfdname.substr(0, 14) + ' ...';
						}
						$('#fileLocation').append(
								'<div class="fileDown" id="'+object.pfdname+'" style="width: 150px; height:150px; margin: 1%;">'+
						      	'<a href="fileDownload.do?fileName='+object.pfdname+'">'+
						         '<img id="'+object.tseq+'" width="100px" height="100px" style="margin: 1%; display: block; margin-left: auto; margin-right: auto"'+
						            'src="<c:url value="/upload/'+object.pfdname+'" />">'+
						        '</a><p style="font-size: 15px; text-align: center">'+
						        tempFname+'<br>프라이빗 공간'+
						         '</p></div>'		
						)
					})	
				}
			}); 
	   }
	   $('#selectFile').change(function(){ //파일함에서 협업공간 선택시 비동기로 불러오기
		   var tseq = $(this).val();
		   if(tseq=='myFile'){
			   clickMyFile();
			   return;
		   }
 			$.ajax({
				url : 'fileChange.do',
				dataType:"json",
				data : {
					tseq:tseq,
				},
				success : function(data) {
					$('#fileLocation').empty();
					$.each(data,function(index,object){
						tempFname = object.fdname;
						tempPname = object.pname;
						if(object.fdname.length>=14){
							tempFname = object.fdname.substr(0, 14) + ' ...';
						}
						if(object.pname.length>=4){
							tempPname = object.pname.substr(0, 4) + ' ...';
						}
						$('#fileLocation').append(
								'<div class="fileDown" id="'+object.fdname+'" style="width: 150px; height:150px; margin: 1%;">'+
						      	'<a href="fileDownload.do?fileName='+object.fdname+'">'+
						         '<img id="'+object.tseq+'" width="100px" height="100px" style="margin: 1%; display: block; margin-left: auto; margin-right: auto"'+
						            'src="<c:url value="/upload/'+object.fdname+'" />">'+
						        '</a><p style="font-size: 15px; text-align: center">'+
						        tempFname+'<br>'+tempPname+
						         '</p></div>'		
						)
					})	
				}
			}); 
	   })
	/* 파일함 링크 데이터 띄우기 */
	$('#selectLink').change(function(){
		let tseq = $(this).val()
		if(tseq == 'myLink'){
			myLinkList()
			return;
		}
		$.ajax({
			url: 'getTLink.do',
			type: 'POST',
			dataType: 'json',
			data: { tseq: tseq },
			success: function(data){
				console.log(data.toString())
				$('#fileLocation').empty()
				
				$.each(data, function(index, list){
					let link = list.tlink.split(',')
					let pname = list.pname
					console.log(pname)
					for(let i = 0; i < link.length - 1; i++){
						var url = link[i];
						if(link[i] != "" || link[i] != null || link[i] != undefined){
							console.log(link[i])
							$.ajax({
								url: 'http://192.168.6.45:8091/index',
								type: 'GET',
								data: 'url='+link[i],
								dataType: 'json',
								async: true,
								success: function(data){
									console.log('url : ' + url)
									let pname = $('#selectLink option:checked').text()
									tempTitle = data.message.title
									tempPname = pname
									if(data.message.url == undefined || data.message.url == null){
										data.message.url = url;
									}
									if(data.message.title.length>=14){
										tempTitle = data.message.title.substr(0, 14) + ' ...';
									}
									if(pname.length>=4){
										tempPname = pname.substr(0, 4) + ' ...';
									}
									let target = 'target="_blank"'
									$('#fileLocation').append(
										'<div class="fileDown" id="" style="width: 150px; height:150px; margin: 1%;">'+
						      			'<a href="'+data.message.url+'" '+ target + '>'+
										'<img id="" width="100px" height="100px" style="margin: 1%; display: block; margin-left: auto; margin-right: auto"'+
										'src="<c:url value="'+data.message.img+'" />" onError="this.src='+"'resources/images/logo/ScoopTitle.png'"+'">'+
						        		'</a><p style="font-size: 15px; text-align: center">'+
						        		tempTitle+'<br>'+tempPname+
						         		'</p></div>'		
									)
								},
								error: function(xhr, status, error){
									console.log('xhr : ' + xhr.status)
									console.log(error)
								}
							})
						}
					}
				})
				
			}
		})
	})
	/* 파일함 링크 */
	function myLinkList(){
		let tseq = 0;
		$.ajax({
			url: 'getMyLink.do',
			dataType: 'json',
			type: 'POST',
			success: function(resData){
				$('#fileLocation').empty()
				$.each(resData, function(index, list){
					let link = list.plink.split(',')
					for(let i = 0; i < link.length-1; i++){
						var url = link[i];
						if(link[i] != "" || link[i] != null || link[i] != undefined){
							$.ajax({
								url: 'http://192.168.6.45:8091/index',
								type: 'GET',
								data: 'url='+link[i],
								dataType: 'json',
								success: function(data){
									if(data.message.url == '' || data.message.url == undefined || data.message.url == null){
										data.message.url = url;
									}
									tempTitle = data.message.title
									if(data.message.title.length>=14){
										tempTitle = data.message.title.substr(0, 14) + ' ...';
									}
									$('#fileLocation').append(
										'<div class="fileDown" id="" style="width: 150px; height:150px; margin: 1%;">'+
						      			'<a href="'+data.message.url+'">'+
										'<img id="" width="100px" height="100px" style="margin: 1%; display: block; margin-left: auto; margin-right: auto"'+
										'src="<c:url value="'+data.message.img+'" />" onError="defaultImg()">'+
						        		'</a><p style="font-size: 15px; text-align: center">'+
						        		tempTitle+'<br>프라이빗 공간'+
						         		'</p></div>'		
									)
								},
								error: function(xhr, status, error){
									console.log('xhr : ' + xhr.status)
									console.log(error)
								}
							})
						}
					}
				})
			}
		})
	}

	   function defaultImg(){
			return "/SCOOP/resources/images/logo/ScoopBig.png";
	   }
	   $('#searchSubmitIcon').click(function(){ //이슈 전체 키워드 검색 돋보기 클릭
		   $('#searchSubmit').submit();
	   })
	   $('#sIssue').focus(function(){ //이슈 전체 키워드 검색 Enter로
		   $('#sIssue').keypress(function(event) {
			   if (event.keyCode == 13) {
		            $('#searchSubmit').submit();
		         }
		   })
	   })
	   $('#invitebtn').click(function(){ //협업공간 이메일 초대에서 Enter를 누르면 모달에서 자동으로 submit이 되기때문에 Enter 방지
		   $('#inviteForm').append($('#inviteContent'));
		   $('#invitebtn').click();
	   });
      var number = 0;

      var target = 1;
     
      $('#invite_Submit').keyup(function(event) { //협업공간 이메일 초대 이메일 자동완성
         $('#invite_email_append').show();
         $('#invite_email_append').empty();

         if ($('#invite_Submit').val().match('@')){
            $('#invite_email_append')
                  .append(
                        '<div id="email_append_1" class="email_append" style="margin:10px;color:#000;">'
                              + $(this).val());
         } else {
            $('#invite_email_append')
                  .append(
                        '<div id="email_append_1" class="email_append" style="margin:10px 7px 10px 7px;color:#000;">'
                              + $(this).val()
                              + '@naver.com</div>');
            $('#invite_email_append')
                  .append(
                        '<div id="email_append_2" class="email_append" style="margin:10px 7px 10px 7px;color:#000;">'
                              + $(this).val()
                              + '@gmail.com</div>');
            $('#invite_email_append')
                  .append(
                        '<div id="email_append_3" class="email_append" style="margin:10px 7px 10px 7px;color:#000;">'
                              + $(this).val()
                              + '@daum.net</div>');
         }

         if ($('#invite_Submit').val() == "") {
            $('#invite_email_append').hide();
         } else {
            $('#invite_email_append').show();
         }

         if (event.keyCode == 13) {
            $('#invite_email_append').hide();
         }

         var key = event.keyCode;
         switch (key) {
         case 38:
            target--;
            break;
         case 40:
            target++;
            break;
         case 39:
            break;
         case 37:
            break;
         }
         if (target < 1) {
            target = 1;
         }
         if (target > 3) {
            target = 3;
         }
         $('#email_append_' + target).focus();
         if ($('#email_append_' + target).focus()) {
            $('.email_append').css('background-color', '#fff');
            $('#email_append_' + target).css(
                  'background-color',
                  'rgba(225, 225, 225,0.5)');

            if (event.keyCode == 13) { //Enter눌렀을때 이메일 정규표현식
            	if ($('#invite_Submit').val().match('@')){
            		target=1;
            	}
               var u_email = $('#email_append_' + target);
               var regEmail = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
          
               if (u_email.text() == "@naver.com") {
                  alert("이메일을 입력하세요");
                  u_email.focus();
                  return false;
               } else {
                  if (!regEmail.test(u_email.text())) {
                     alert("유효한 이메일 형식이 아닙니다.");
                     u_email.focus();
                     return false;
                  }
               }
               
               if (event.shiftKey && event.keyCode == 50) { //만약 @를 입력하면 자동완성 없앰
            	   target=1;
                  $('#invite_email_append').hide();
                  $('#invite_Input')
                        .append(
                              '<span class="emailList" style="border:1px solid rgba(124, 119, 119,0.5);border-radius:0.25rem; padding-top: 1%;padding-bottom: 1%;padding-left: 2%;padding-right: 2%;margin:2%;"><i class="far fa-paper-plane" style="color:#9e6767;padding-right: 5px;"></i><input type="text" value='
                                    + $(this).val()
                                    + ' name=email'
                                    + (number++)
                                    + ' style="border:0px; width:200px;margin-left:3px;" readonly><button type="button" id=""  class="invite_close" style="border:0;background-color:#fff;border-radius:0.25rem;"><i class="fas fa-times" style="color:#A84747;padding-left: 10px;"></i></button></span>');
                  $(this).val('');
                  $('#invitebtn').removeAttr('disabled');
                  $('#invitecnt').val(number);
                  $('#invitebtn').empty();
                  $('#invitebtn')
                        .prepend(
                              $('#invite_Input')
                                    .children().length
                                    - 2 + '명의 멤버 초대하기');

               } else {
                  $('#invite_Input')
                        .append(
                              '<span class="emailList" style="border:1px solid rgba(124, 119, 119,0.5);border-radius:0.25rem; padding-top: 1%;padding-bottom: 1%;padding-left: 2%;padding-right: 2%;margin:2%;"><i class="far fa-paper-plane" style="color:#9e6767;padding-right: 5px;"></i><input type="text" value='
                                    + $(
                                          '#email_append_'
                                                + target)
                                          .text()
                                    + ' name=email'
                                    + (number++)
                                    + ' style="border:0px; width:200px;margin-left:3px;" readonly><button type="button" id=""  class="invite_close" style="border:0;background-color:#fff;border-radius:0.25rem;"><i class="fas fa-times" style="color:#A84747;padding-left: 10px;"></i></button></span>');
                  $(this).val('');
                  $('#invitebtn').removeAttr('disabled');
                  $('#invitecnt').val(number);
                  $('#invitebtn').empty();
                  $('#invitebtn')
                        .prepend(
                              $('#invite_Input')
                                    .children().length
                                    - 2 + '명의 멤버 초대하기');

               }
               target = 1;
            }

            $('.invite_close') //모달 닫으면 안에 내용 초기화
                  .click(
                        function() {
                           $('#invitebtn').empty();
                           $('#invitebtn')
                                 .prepend(
                                       $(
                                             '#invite_Input')
                                             .children().length
                                             - 2
                                             + '명의 멤버 초대하기');
                           $(this).parent().remove();
                           if ($('#invite_Input')
                                 .children().length == 2) {
                              $('#invitebtn').empty();
                              $('#invitebtn').prepend(
                                    '멤버 초대하기');
                              $('#invitebtn').attr(
                                    'disabled',
                                    'disabled');
                              $('#invite_Input1').show();
                              $('#invite_Input2').show();
                           }
                        });

            if ($('#invite_Input').children().length > 2) {
               $('#invite_Input1').hide();
               $('#invite_Input2').hide();
            }

         }

      });

      //내정보 열기 (드롭다운)
      $('#myprofileEdit').click(function(){
    	  location.href="memberEdit.do?${sessionScope.email}";
          });
      //잠금 모드 (드롭다운)
      $('#lockScoop').click(function(){
			location.href="page-lock.jsp";
          });
      //일반 회원 로그아웃 (드롭다운)
      $('#logout').click(function(){
			location.href="logout.do";
          });  
      //구글 회원 로그아웃 (드롭다운)    
      $('#logoutGoogle').click(function(){
    	  	signOut();
          });
      //네이버 회원 로그아웃 (드롭다운)
      $('#logoutNaver').click(function(){
			location.href="logout.do";
          });
      //파일함 열기
      $('#fileopen').click(function() {
         $('#filediv').show();
         $('#fileclose').show();
         $('#fileclose').attr('name', 'on');
         $('#pagelogo').attr('style', 'opacity:0.5');
         $('#scnav').attr('style', 'opacity:0.5');
         $('.content-body').attr('style', 'opacity:0.5');
         $('.header').attr('style', 'opacity:0.5');
         $('#helpopen').hide();
         $('#filediv2').show();
      });
      //파일함 닫기
      $('#fileclose').click(function() {
         $('#filediv').hide();
         $('#fileclose').hide();
         $('#pagelogo').attr('style', 'opacity:1');
         $('#scnav').attr('style', 'opacity:1');
         $('.content-body').attr('style', 'opacity:1');
         $('.header').attr('style', 'opacity:1');
         $('#helpopen').show();
         $('#filediv2').hide();
      });
      //파일함 왼쪽 투명한 부분 클릭하면 닫힘
      $('#filediv2').click(function() {
         $('#filediv').hide();
         $('#fileclose').hide();
         $('#pagelogo').attr('style', 'opacity:1');
         $('#scnav').attr('style', 'opacity:1');
         $('.content-body').attr('style', 'opacity:1');
         $('.header').attr('style', 'opacity:1');
         $('#helpopen').show();
         $('#filediv2').hide();
      });
      //파일함 단축키 ctrl + .
      $(document).keydown(function(event) {
         if (event.ctrlKey && event.keyCode == 190) {
            if ($('.fileon').attr('class') == 'fileon') {
               $('#filediv').attr('class', 'fileoff');
               $('#filediv').show();
               $('#fileclose').show();
               $('#fileclose').attr('name', 'on');
               $('#pagelogo').attr('style', 'opacity:0.5');
               $('#scnav').attr('style', 'opacity:0.5');
               $('.content-body').attr('style', 'opacity:0.5');
               $('.header').attr('style', 'opacity:0.5');
               $('#helpopen').hide();
               $('#filediv2').show();
            } else {
               $('#filediv').attr('class', 'fileon');
               $('#filediv').hide();
               $('#fileclose').hide();
               $('#pagelogo').attr('style', 'opacity:1');
               $('#scnav').attr('style', 'opacity:1');
               $('.content-body').attr('style', 'opacity:1');
               $('.header').attr('style', 'opacity:1');
               $('#helpopen').show();
               $('#filediv2').hide();
            }
         }
      });
		//알람 버튼
      $('#alarmbtn').click(function(event) {
          let status = $('#alarmbox').attr('name');
         event.stopPropagation();
         if ($('#alarmbox').attr('name') == 'on') {
           
            
            $.ajax({
             	 url: "updateAlarm.do", //cross-domain error가 발생하지 않도록 주의해주세요
       			 type: 'POST',
       			 dataType: 'json',
                 data: {
						"status": status
                     //기타 필요한 데이터가 있으면 추가 전달
                 },
                 success: function(data){
              	 		console.log($("#alarm_power").val())
                     }
             }) 
             $('#alarmbox').attr('name', 'off');
            $('#alarm_power').text('OFF');
         } else {
           
            
             $.ajax({
              	 url: "updateAlarm.do", //cross-domain error가 발생하지 않도록 주의해주세요
        			 type: 'POST',
        			 dataType: 'json',
                  data: {
						"status": status
                      //기타 필요한 데이터가 있으면 추가 전달
                  },
                  success: function(data){
               	 		console.log($("#alarm_power").val())
                      }
              })  
              $('#alarmbox').attr('name', 'on');
             $('#alarm_power').text('ON');
         }

      });

  

		
   });
   /* 프로젝트 이름 검색 */
   function filter() {
      var value, name, item, i;
      value = document.getElementById("searchpjt").value.toUpperCase();
      item = document.getElementsByClassName("search_project");

      for (i = 0; i < item.length; i++) {
         name = item[i].getElementsByClassName("resultsearch");
         if (name[0].innerHTML.toUpperCase().indexOf(value) > -1) {
            item[i].style.display = "flex";
         } else {
            item[i].style.display = "none";
         }
      }
   }
	/*언어 변경 : 한글 ,영어*/
	$('#kor').click(function(){
		$('#selectLang').text("한국어");
	});
	
	$('#eng').click(function(){
		$('#selectLang').text("English");
	});
</script>
<script type="text/javascript"> //구글 picker(구글드라이브 api)
   // The Browser API key obtained from the Google API Console.
   var developerKey = 'AIzaSyAu4AzZjAr2mdObRPPmSvAw_n-BPrsaADE';

   // The Client ID obtained from the Google API Console. Replace with your own Client ID.
   var clientId = "806433148370-o0ss3i4kp8dhj6p0d2cvkdjfus8kivds.apps.googleusercontent.com";

   // Scope to use to access user's photos.
   var scope = 'https://www.googleapis.com/auth/drive.file';

   var pickerApiLoaded = false;
   var oauthToken;

   // Use the API Loader script to load google.picker and gapi.auth.
   function onApiLoad() {
      gapi.load('auth2', onAuthApiLoad);
      gapi.load('picker', onPickerApiLoad);
   }

   function onAuthApiLoad() {
      var authBtn = document.getElementById('auth');
      authBtn.disabled = false;
      authBtn.addEventListener('click', function() {
         gapi.auth2.init({
            client_id : clientId
         }).then(function(googleAuth) {
            googleAuth.signIn({
               scope : scope
            }).then(function(result) {
               handleAuthResult(result.getAuthResponse());
            })
         })
      });
   }

   function onPickerApiLoad() {
      pickerApiLoaded = true;
      createPicker();
   }

   function handleAuthResult(authResult) {
      if (authResult && !authResult.error) {
         oauthToken = authResult.access_token;
         createPicker();
      }
   }
   // Create and render a Picker object for picking from Google Photos.
   function createPicker() {
      if (pickerApiLoaded && oauthToken) {
         var picker = new google.picker.PickerBuilder().addView(
               google.picker.ViewId.DOCS).setOAuthToken(oauthToken)
               .setDeveloperKey(developerKey).setCallback(pickerCallback)
               .build();
         picker.setVisible(true);
         $('.picker-dialog').attr('style', 'z-index:1051;top:5%;left:20%')
      }
   }

   var url = '';
   var drivename = '';
   // A simple callback implementation.
   function pickerCallback(data) {
      if (data[google.picker.Response.ACTION] == google.picker.Action.PICKED) {
         var doc = data[google.picker.Response.DOCUMENTS][0];
         url = doc[google.picker.Document.URL];
         drivename = doc.name;
      }
      var message = url;
      if (url != '') { //url이 비어있지 않다면 이슈작성 첨부에 append
         $('#todoresult').append('<div style="padding:5px"><a href='+url+'><span class="iconify" data-icon="whh:googledrive" data-inline="false"></span>'+ drivename + '</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="annoDelete" style="cursor:pointer;" onclick="annotationDelete('+annotation+')"><span class="iconify" data-icon="octicon:x" data-inline="false"></span></span></div>');
         $('#todoresult').append('<input type="hidden" name="googleDrive" value="'+url+'~'+drivename+'">');
         $('#todoresult').show();
         if('#edittodoresult'){
        	 $('#edittodoresult').append('<div class="myissueDetail" id="myissueGoogledrive">'+
        				'<i class="fab fa-google-drive"></i>'+
        				'<a href="'+url+'" onclick="window.open(this.href,"팝업창","width=800, height=800");return false;">'+drivename+'</a>'+
        				'<span class="divDelete" style="cursor:pointer;"><span class="iconify" style="font-size: 20px" data-icon="octicon:x" data-inline="false"></span></span>'+
        				'<input type="hidden" name="editGfilename" value="'+drivename+'">'+
        				'<input type="hidden" name="editGurl" value="'+url+'">'+
        				'<br>');
        	 $('.divDelete').click(function(){
        			$(this).parent().remove();
        		});				
         }
      }
   }
   // notification 시간설정
   function calculate() {
       setTimeout(function () {
           notify();
       }, 10);
   }
   
	// notification 아이콘 및 body 설정, permission 
   function notify() {
       if (Notification.permission !== 'granted') {
           
       }
       else {
       	Notification.requestPermission();
           
       }
   }

   $(function() { // onload
		connect();	//연결
		

		$('#logout').onclick(function(){
			disconnect();
		});
		$('#logoutNaver').onclick(function(){
			disconnect();
		});
		$('#logoutGoogle').onclick(function(){
			disconnect();
		});
	});
	
	/* function connect() { //입장 버튼 클릭시 작동 함수(웹소켓 생성)
		wsocket = new WebSocket("ws://scoop.com:8090/SCOOP/Chat-ws.do?cmd=join&room=${room}");

		//해당 함수 정의
		wsocket.onmessage = onMessage;
	}
	
	function disconnect() {
		wsocket.close();
	}

	function onMessage(evt) { 
		var data = JSON.parse(evt.data);
		notificationMessage(data);
	}

	function send(message) { //전송할때 json형태로 전송
		let data = { message : message
						, cmd : "message"
						, room : "${room}"
						, img : "${sessionScope.img}"
						 };
		
		wsocket.send(JSON.stringify(data));
	}

	function notificationMessage(data) { //메시지 뷰단에 append
		alert(data);
	}
 */
   //이슈작성 validation
    function checkz() {
    //공지사항 제목 공백 확인
     if($("#issuetitle").val() == ""){
        Swal.fire("제목을 입력해주세요.");
       $("#issuetitle").focus();
       return false;
     }

     //공지사항 설명 공백 확인
     if($("#issuecontent").val() == ""){
        Swal.fire("내용을 입력해주세요.");
       $("#issuecontent").focus();
       return false;
     }
     
     var sessionEmail = "<%=session.getAttribute("email")%>";
     var sessionNickName = "<%=session.getAttribute("name")%>";
     if($('#selectpro').val() != sessionEmail){
    	 calculate();
    	 var notification = new Notification('SCOOP Notification', {
             icon: '<c:url value="/resources/images/logo/ScoopNoti.png" />',
             body: sessionNickName+'님이 새로운 이슈를 발의하셨습니다. :)',
         });
         // 클릭 시 링크

         var title = '새로운 팀 이슈가 생성되었습니다.';
         var options = {
           body: sessionNickName+'님이 새로운 이슈를 발의하셨습니다. :)'
         };
         let data = { message : message
					, cmd : "message"
					, room : $('#selectpro').val()
					 };
		 
		 wsocket.send(JSON.stringify(data));
         // onsubmit시 notification
         registration.showNotification(title, options);
    		
     }
     
   return true;
   }

  //공지사항작성 validation
    function checknotice() {
    //이슈 제목 공백 확인
     if($("#bntitle").val() == ""){
        Swal.fire("제목을 입력해주세요.");
       $("#bntitle").focus();
       return false;
     }

     //이슈 설명 공백 확인
     if($("#bncontent").val() == ""){
        Swal.fire("내용을 입력해주세요.");
       $("#bncontent").focus();
       return false;
     }

   return true;
   } 

   //협업공간 생성 validation
    function checkz2() {
    //협업공간 이름 확인
     if($("#pname").val() == ""){
        Swal.fire("제목을 입력해주세요.");
       $("#pname").focus();
       return false;
     }

     //협업공간 내용 확인
     if($("#pcontent").val() == ""){
        Swal.fire("내용을 입력해주세요.");
       $("#pcontent").focus();
       return false;
     }

   return true;
   }
     
</script>
<style>
.modal-content.modal-fullsize {
   height: auto;
   min-height: 100%;
   border-radius: 0;
   min-width: 950px;
   right: 230px;
}

#filediv {
   position: fixed;
   bottom: 0;
   right: 0;
   font-size: 18px;
   z-index: 2;
   width: 84.6%;
   height: 100%;
}

#filediv2 {
   position: fixed;
   bottom: 0;
   right: left;
   font-size: 18px;
   z-index: 2;
   width: 15.4%;
   height: 100%;
   background-color: black;
   opacity: 0.5;
}

#fileclose {
   position: fixed;
   bottom: 95%;
   left: 1%;
   font-size: 18px;
   z-index: 3;
}

/* The switch - the box around the slider */
.switch_alarm {
   position: relative;
   display: inline-block;
   width: 60px;
   height: 34px;
   vertical-align: middle;
}

/* Hide default HTML checkbox */
.switch_alarm input {
   display: none;
}

/* The slider */
.slider_alarm {
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

.slider_alarm:before {
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

input:checked+.slider_alarm {
   background-color: #00D63D;
}

input:focus+.slider_alarm {
   box-shadow: 0 0 1px #00D63D;
}

input:checked+.slider_alarm:before {
   -webkit-transform: translateX(26px);
   -ms-transform: translateX(26px);
   transform: translateX(26px);
}

/* Rounded sliders */
.slider_alarm.round_alarm {
   border-radius: 34px;
}

.slider_alarm.round_alarm:before {
   border-radius: 50%;
}

span {
   margin: 0px;
   display: inline-block;
   font-size: 15px;
   font-weight: bold;
}
</style>

<!--**********************************
            Nav header start
        ***********************************-->
<div id="pagelogo" class="nav-header">
   <div class="brand-logo">
      <a href="userindex.do" style="padding-top: 0px;"> <b
         class="logo-abbr"><img class="img-responsive center-block"
            src="<c:url value="/resources/images/logo/ScoopTitle.png" />"
            alt="mini"
            style="width: 100px; height: auto; padding-top: 0; margin-top: 30px;">
      </b> <span class="logo-compact"><img
            class="img-responsive center-block"
            src="<c:url value="/resources/images/logo/ScoopBig.png" />" alt=""
            style="margin-top: 20px; text-align: center;"></span> <span
         class="brand-title"> <img class="img-responsive center-block"
            src="<c:url value="/resources/images/logo/ScoopBig.png" />" alt=""
            style="margin-top: 3%;">
      </span>
      </a>
   </div>
</div>
<!--**********************************
            Nav header end
        ***********************************-->

<!--**********************************
            Header start
        ***********************************-->
<div class="header">
   <div class="header-content clearfix">

      <div class="nav-control">
         <div class="hamburger">
            <span class="toggle-icon"><i class="icon-menu"></i></span>
         </div>
      </div>
      <div class="header-left">
         <div class="input-group icons">
            <div class="input-group-prepend">
               <span class="input-group-text bg-transparent border-0 pr-2 pr-sm-3"
                  id="searchSubmitIcon"><i class="mdi mdi-magnify" style="cursor: pointer;"></i></span>
            </div>
            <form action="searchIssue.do" id="searchSubmit">
            <input type="search" id="sIssue" name="word" class="form-control" placeholder="검색 후 Enter치세요"
               aria-label="Search">
            <input type="hidden" id="searchEmail" name="email" value=<%=session.getAttribute("email")%>>
            </form>
               <c:choose>
                  <c:when test="${role == 'ROLE_ADMIN'}">
               <input type="button"class="form-control"
               style="background-color: #E71D36; border-color: #CCCCCC; margin-left: 2%; color: #fff; cursor: pointer;width: 126px;"
               value="공지사항 작성" data-toggle="modal" data-target="#makenotice">
               <input type="button"class="form-control"
               style="background-color: #E71D36; border-color: #CCCCCC; margin-left: 2%; color: #fff; cursor: pointer;width: 126px;"
               value="이슈 작성" data-toggle="modal" data-target="#makeissue">
               </c:when>
               <c:otherwise>
               <input type="button"class="form-control"
               style="background-color: #E71D36; border-color: #CCCCCC; margin-left: 2%; color: #fff; cursor: pointer;width: 126px;"
               value="이슈 작성" data-toggle="modal" data-target="#makeissue">
               </c:otherwise>
               </c:choose>
            <div class="drop-down animated flipInX d-md-none">
               <form action="#">
                  <input type="text" class="form-control" placeholder="Search">
               </form>
            </div>
         </div>
      </div>
      <div class="header-right">
         <ul class="clearfix">
            <li class="icons dropdown d-none d-md-flex"><a
               href="javascript:void(0)" class="log-user" data-toggle="dropdown">
                  <span id="selectLang">${sessionScope.defaultlang}</span> <i class="fa fa-angle-down f-s-14"
                  aria-hidden="true"></i>
            </a>
               <div
                  class="drop-down dropdown-language animated fadeIn  dropdown-menu">
                  <div class="dropdown-content-body">
                     <ul>
                        <li><a href="userindex.do?lang=ko" >한국어</a></li>
                        <li><a href="userindex.do?lang=en" >English</a></li>
                     </ul>
                  </div>
               </div></li>

            <li class="icons dropdown d-none d-md-flex"><i
               class="fas fa-user-plus" data-toggle="modal" id="inviteModal_id"
               data-target="#inviteModal"
               style="cursor: pointer; color: #535359; font-size: 18px; padding-bottom: 12px;"></i>

            </li>
            
         <c:if test="${role == 'ROLE_CHARGE'}">
            <li class="icons dropdown"><a href="javascript:void(0)"
               data-toggle="dropdown">
                <i class="mdi mdi-bell-outline"></i>
                 <span class="badge badge-pill gradient-2">0</span>
            </a>
               <div
                  class="drop-down animated fadeIn dropdown-menu dropdown-notfication">
                  <div class="dropdown-content-body">
                     <ul>
                     	<c:if test="${status=='ON'}">
                        <li>
                           <p style="display: inline-block; padding-right: 33%">전체 알람
                              설정</p> <label class="switch_alarm"> <input type="checkbox"
                              checked="checked" id="alarmbox" name="on"> <span
                              class="slider_alarm round_alarm" id="alarmbtn"></span>
                        </label> <span id="alarm_power">${sessionScope.status}</span>
                        </li>
                     	</c:if>
                     	<c:if test="${status=='OFF'}">
                     	 <li>
                           <p style="display: inline-block; padding-right: 33%">전체 알람
                              설정</p> <label class="switch_alarm"> <input type="checkbox"
                              id="alarmbox" name="off"> <span
                              class="slider_alarm round_alarm" id="alarmbtn"></span>
                        </label> <span id="alarm_power">${sessionScope.status}</span>
                        </li>
                     	</c:if>     
                        <li><a href="javascript:void()"> <span
                              class="mr-3 avatar-icon bg-success-lighten-2"><i
                                 class="icon-present"></i></span>
                              <div class="notification-content">
                                 <h6 class="notification-heading">팀이슈 알림</h6>
                                 <span class="notification-text">팀이슈의 알림을 받을 수 있습니다.</span>
                              </div>
                        </a></li>
                        <li><a href="javascript:void()"> <span
                              class="mr-3 avatar-icon bg-danger-lighten-2"><i
                                 class="icon-present"></i></span>
                              <div class="notification-content">
                                 <h6 class="notification-heading">댓글 알림</h6>
                                 <span class="notification-text">댓글이 달리면 알림을 받을 수 있습니다.</span>
                              </div>
                        </a></li>
                        <li><a href="javascript:void()"> <span
                              class="mr-3 avatar-icon bg-success-lighten-2"><i
                                 class="icon-present"></i></span>
                              <div class="notification-content">
                                 <h6 class="notification-heading">멘션 알림</h6>
                                 <span class="notification-text">사용자가 멘션이 되면 알림을 받을 수 있습니다.</span>
                              </div>
                        </a></li>
                        <li><a href="javascript:void()"> <span
                              class="mr-3 avatar-icon" style="background-color: #000000"><i
                                 class="icon-present"></i></span>
                              <div class="notification-content">
                                 <h6 class="notification-heading">할일 알림</h6>
                                 <span class="notification-text">다른 팀원이 할일을 주면 알림을 받을 수 있습니다.</span>
                              </div>
                        </a>
                        </li>
                     </ul>

                  </div>
               </div>
               </li>
         </c:if>           	

            <li class="icons dropdown">
               <div class="user-img c-pointer position-relative"
                  data-toggle="dropdown">
                  <span class="activity active"></span>
                  <c:choose>
                  	<c:when test="${img==null}">
                  <img src="<c:url value="/resources/images/avatar/avatar.png" />"
                     height="40" width="40" alt="">
                  	</c:when>
                  	<c:otherwise>
                  	<img src="<c:url value="/user/upload/${img}" />"
                     height="40" width="40" alt="">
                  	</c:otherwise>
                  </c:choose> 
               </div>
               <div
                  class="drop-down dropdown-profile animated fadeIn dropdown-menu">
                  <div class="dropdown-content-body">
                     <ul>
                        <li>
                        	<span id="myprofileEdit" style="cursor: pointer;">
                        	<span class="icon-user"></span> 
                        	<span>&nbsp;&nbsp;내 정보</span>
                        	</span>
                        </li>
                        <li>
                        	<span id="fileopen" style="cursor: pointer;">
                        	<span class="iconify" data-icon="ion:folder-open-outline" data-inline="false"style="font-size: 15px"></span> 
                        	<span>&nbsp;&nbsp;파일함</span></span>
                        </li>
                        <hr class="my-2">
                       <!--  <li>
                        	<span id="lockScoop" style="cursor: pointer;">
                        	<a href="page-lock.jsp">
                        	<span class="icon-lock"></span>
                        	<span>&nbsp;&nbsp;잠금모드</span>
                        	</span>
                        </li> -->
                        <c:choose>
                           <c:when test="${kind=='normal'}">
                          		<li>
                          			<span id="logout" style="cursor: pointer;">
                              			<span class="icon-key"></span> 
                              			<span>&nbsp;&nbsp;로그아웃</span>
                              		</span>
                              	</li>
                           </c:when>
                           <c:when test="${kind=='google'}">
                              <li>
                              	<span id="logoutGoogle" style="cursor: pointer;">
                             		<span class="icon-key" ></span> 
                              		<span>&nbsp;&nbsp;로그아웃</span>
                              	</span>
                              </li>
                           </c:when>
                           <c:when test="${kind=='naver'}">
                              <li>
                              	<span id="logoutNaver" style="cursor: pointer;">
	                              	<span class="icon-key"></span> 
	                              	<span>&nbsp;&nbsp;로그아웃</span>
                              	</span>
                              </li>
                           </c:when>
                           <c:otherwise></c:otherwise>
                        </c:choose>

                        <li><%=session.getAttribute("email")%></li>
                     </ul>
                  </div>
               </div>
            </li>

         </ul>
      </div>
   </div>
</div>
<!--**********************************
            Header end ti-comment-alt
        ***********************************-->

<!--**********************************
            Sidebar start
        ***********************************-->
<c:set var="kind" value="${session.kind}}"></c:set>
<c:set var="email" value="${session.email}}"></c:set>

<div class="nk-sidebar" style="z-index: 0;">
   <div id="scnav" class="nk-nav-scroll">
      <ul class="metismenu" id="menu">
         <li class="nav-label" style="padding-bottom: 10px;">
         <b style="padding-bottom: 2%;font-size:15px;"><spring:message code="boardtitle" /></b></li>
         <%-- <li><a href="dashboard.do" aria-expanded="false"><span class="iconify" data-icon="ps:megaphone" data-inline="false"></span>
         <span class="nav-text">
                  &nbsp;<spring:message code="dashboard" /></span> <!-- <i class="icon-speedometer menu-icon"> -->
         </a></li> --%>
         <li><a href="notice.do" aria-expanded="false"><span class="iconify" data-icon="ps:megaphone" data-inline="false"></span>
         <span class="nav-text">
                  &nbsp;<spring:message code="notice" /></span> <!-- <i class="icon-speedometer menu-icon"> -->
         </a></li>
         <li><a href="userindex.do" aria-expanded="false"> <span
               class="iconify" data-icon="bx:bx-file-blank" data-inline="false"
               style="width: 20px; height: auto;"> </span><span class="nav-text">
                  &nbsp;<spring:message code="newissue" /></span> <!-- <i class="icon-speedometer menu-icon"> -->
         </a></li>
         <li><a href="myissue.do" aria-expanded="false"> <span
               class="iconify" data-icon="simple-line-icons:emotsmile"
               data-inline="false" style="width: 17px; height: auto;font: bold;"> </span><span
               class="nav-text"> &nbsp;<spring:message code="myissue" /></span>
         </a></li>
         <li><a href="calendar.do" aria-expanded="false"> <span
               class="iconify" data-icon="bx:bx-calendar" data-inline="false"
               style="width: 20px; height: auto;"> </span><span class="nav-text">
                  &nbsp;<spring:message code="calendar" /></span>
         </a></li>
         <li class="nav-label" style="padding-bottom: 0"><b><spring:message code="private.title" /></b></li>
         <li><a href="private.do" aria-expanded="false"> <span
               class="iconify" data-icon="ic:baseline-person" data-inline="false"
               style="width: 20px; height: auto;"> </span><span class="nav-text">
                  &nbsp;<spring:message code="private.issue" /></span>
         </a></li>
         <li><a href="bookmark.do" aria-expanded="false"> <span
               class="iconify" data-icon="ic:round-bookmark" data-inline="false"
               style="width: 20px; height: auto;"> </span><span class="nav-text">
                  &nbsp;<spring:message code="private.book" /></span>
         </a></li>
         <li class="nav-label" style="padding-bottom: 0"><b style="font-size:15px;"><spring:message code="team.title" /></b></li>
         <li class="nav-label">
         <c:choose>
         <c:when test="${count >= 3 and role == 'ROLE_USER'}">
         <button type="button" class="btn"
               style="background-color: #E71D36; border-color: #CCCCCC; color: #fff; cursor: pointer;"
               data-toggle="modal" data-target="#myModal" disabled="disabled">
               <i class="icon-note menu-icon"></i> <spring:message code="team.limit" />
        </button>
        </c:when>
        <c:otherwise>
         <button type="button" class="btn"
               style="background-color: #E71D36; border-color: #CCCCCC; color: #fff; cursor: pointer;"
               data-toggle="modal" data-target="#myModal">
               <i class="icon-note menu-icon"></i> <spring:message code="team.create" />
        </button>
        </c:otherwise>
        </c:choose>
            </li>
         <li class="nav-label" style="padding-top: 0"><input
            onkeyup="filter()" type="search" id="searchpjt" class="form-control"
            style="border-radius: 0.25rem; height: 20px" placeholder="협업공간 검색"></li>
         <c:forEach items="${pjtlist}" var="p">
            <c:choose>
           <c:when test="${fn:length(p.pname) > 11}">
            <li class="search_project"><a
               href="projectDetail.do?tseq=${p.tseq}" class="projecthref" aria-expanded="false"><span
                  class="iconify" data-icon="bx:bxs-flag-alt" data-inline="false"
                  style="width: 20px; height: auto;"> </span><span
                  class="nav-text resultsearch"> &nbsp; <c:out value="${fn:substring(p.pname,0,11)}"/> ...</span></a></li>
               </c:when>
               <c:otherwise>
               <li class="search_project"><a
               href="projectDetail.do?tseq=${p.tseq}" class="projecthref" aria-expanded="false"><span
                  class="iconify" data-icon="bx:bxs-flag-alt" data-inline="false"
                  style="width: 20px; height: auto;"> </span><span
                  class="nav-text resultsearch"> &nbsp; <c:out value="${p.pname}"/></span></a></li>
           </c:otherwise> 
          </c:choose>    
         </c:forEach>
         <li class="nav-label" style="padding-bottom: 30px"></li>
      </ul>
   </div>
</div>
<!--**********************************
            Sidebar end
        ***********************************-->
<!-- 
              협업공간 만들기 모달 생성
         -->
<style>
.createmodal {
   border: 1px solid rgba(0,0,0,0.5);
   background-color: white;
}
</style>

<!-- The Modal -->

<div class="modal fade" id="myModal">
   <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">

         <!-- Modal Header -->
         <div class="modal-header">
            <h3 class="modal-title">새 협업공간 만들기</h3>
            <button type="button" class="close" data-dismiss="modal">&times;</button>
         </div>

         <!-- Modal body -->
         <form onsubmit="return checkz2()" action="team.do" method="post">
            <div class="modal-body">
               <p style="font-size: 12px">
                  협업공간은 함께 일하는 멤버들끼리만 자료를 공유하고 협업할 수 있는 공간입니다.<br> 협업공간을 만들고 함께
                  일할 멤버들을 초대해보세요.
               </p>
               <label for="pname">협업공간 이름</label> <input
                  class="form-control createmodal" type="text" id="pname"
                  name="pname" style="width: 100%"> <br> <label
                  for="pcontent">협업공간 설명</label>
               <textarea class="form-control createmodal" rows="3" id="pcontent"
                  name="pcontent" style="width: 100%"></textarea>
            </div>

            <!-- Modal footer -->

            <!-- <input type="hidden" name="tseq" value="1"> -->
            <!-- <input type="hidden" name="ischarge" value="0"> -->
            <input type="hidden" name="email" value="${sessionScope.email}">
            <!-- <input type="hidden" name="istpalarm" value="0"> -->
            <!-- <input type="hidden" name="ptime" value="20/01/08"> -->
            <div class="modal-footer">
               <input type="submit" id="chatmake" class="btn btn-secondary" value="만들기"
                  style="background-color: #E71D36; border-color: #CCCCCC; color: #fff; cursor: pointer;">
               <input type="button" class="btn btn-secondary" value="취소"
                  style="background-color: #E71D36; border-color: #CCCCCC; color: #fff; cursor: pointer;"
                  data-dismiss="modal">
            </div>
         </form>
      </div>
   </div>
</div>

<div id="filediv" class="fileon"
   style="display: none; background-color: white;">
   <div class="row" style="margin: 2%;">
      <div class="col-sm-12">
         <h3>파일함(Ctrl + .)</h3>
         <h6>파일을 클릭하시면 다운로드 됩니다.</h6>
      </div>
   </div>
   <div class="row" style="margin: 2%;">
      <ul class="nav nav-pills">
         <!-- <li class="nav-item"><a class="nav-link" id="myFile" style="cursor: pointer;">내 파일</a></li> -->
         <li class="nav-item" style="margin-right: 10px">
          <select id="selectFile" name="tseq" class="form-control" style="border: 1px solid rgba(0,0,0,0.5) ; color: #000; font-size: 18px; padding-top: 0;">
                 <option value="0">프로젝트 전체 파일</option>
          		<option value="myFile">프라이빗 공간</option>
              <c:forEach items="${pjtlist}" var="p">
                 <option value="${p.tseq}">${p.pname}</option>
              </c:forEach>
          </select>
         </li>
         <li class="nav-item" style="margin-right: 10px">
          <select id="selectLink" name="tlink" class="form-control" style="border: 1px solid rgba(0,0,0,0.5) ; color: #000; font-size: 18px; padding-top: 0;">
                 <option value="0">프로젝트 전체 링크</option>
          		<option value="myLink">프라이빗 공간</option>
              <c:forEach items="${pjtlist}" var="p">
                 <option value="${p.tseq}">${p.pname}</option>
              </c:forEach>
          </select>
         </li>
         <li class="nav-item"><input type="search" id="searchFile" class="form-control"
            style="border-radius: 0.25rem; height: 20px" placeholder="검색 후 Enter치세요">
         </li>
      </ul>
   </div>
   <div class="row" id="fileLocation" style="margin: 2%; overflow: auto; height: 600px">
   <c:forEach items="${filed}" var="f">
      <div class="fileDown" id="${f.fdname}" style="width: 150px; height:150px; margin: 1%;">
      <c:if test="${fn:substring(f.fdname,fn:length(f.fdname)-4,fn:length(f.fdname))=='.jpg'}">
      	<a href="fileDownload.do?fileName=${f.fdname}">
         <img id="${f.tseq}" width="100px" height="100px" style="margin: 1%; display: block; margin-left: auto; margin-right: auto"
            src="<c:url value="/upload/${f.fdname}" />">
        </a>
        </c:if>
      <c:if test="${fn:substring(f.fdname,fn:length(f.fdname)-5,fn:length(f.fdname))=='.jpeg'}">
      	<a href="fileDownload.do?fileName=${f.fdname}">
         <img id="${f.tseq}" width="100px" height="100px" style="margin: 1%; display: block; margin-left: auto; margin-right: auto"
            src="<c:url value="/upload/${f.fdname}" />">
        </a>
        </c:if>
      <c:if test="${fn:substring(f.fdname,fn:length(f.fdname)-4,fn:length(f.fdname))=='.png'}">
      	<a href="fileDownload.do?fileName=${f.fdname}">
         <img id="${f.tseq}" width="100px" height="100px" style="margin: 1%; display: block; margin-left: auto; margin-right: auto"
            src="<c:url value="/upload/${f.fdname}" />">
        </a>
        </c:if>
        <c:if test="${fn:substring(f.fdname,fn:length(f.fdname)-4,fn:length(f.fdname))=='.zip'}">
         <img id="${f.tseq}" width="100px" height="100px" style="margin: 1%; display: block; margin-left: auto; margin-right: auto"
            src="<c:url value="/resources/images/logo/ScoopSmall.png" />">
        </c:if>
         <p style="font-size: 15px; text-align: center">
            <c:choose>
           <c:when test="${fn:length(f.fdname) > 12 || fn:length(f.pname) > 12}">
            <c:out value="${fn:substring(f.fdname,0,14)}"/> ...<br>  <c:out value="${fn:substring(f.pname,0,11)}"/> ...
            </c:when>
            <c:otherwise>
            	<c:out value="${f.fdname}"/><br> <c:out value="${f.pname}"/>
            </c:otherwise>
            </c:choose>
         </p>
      </div>
   </c:forEach>
   </div>
</div>
<div id="filediv2" style="display: none;"></div>
<img src="<c:url value="/resources/images/chat/close.png" />"
   id="fileclose" name="on" width=20px height=auto
   style="cursor: pointer; display: none;">

<div class="modal fade" id="makeissue">
   <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">

         <!-- Modal Header -->
         
         <div class="modal-header">
            <h3 class="modal-title">이슈 작성</h3>
            <button type="button" class="close" data-dismiss="modal">&times;</button>
         </div>
   
         <form onsubmit="return checkz()" action="writeIssue.do" method="POST" enctype="multipart/form-data">
            <!-- Modal body -->
            <div class="modal-body">
               <!-- <p style="font-size: 12px">협업공간은 함께 일하는 멤버들끼리만 자료를 공유하고 협업할 수 있는 공간입니다.<br>
             협업공간을 만들고 함께 일할 멤버들을 초대해보세요.</p> -->
               <label for="title">이슈 제목</label> <input
                  class="form-control createmodal" type="text" id="issuetitle"
                  name="issuetitle" style="width: 100%;border-radius:0.5rem;" placeholder="제목을 입력해 주세요.">
               <br> <label for="content">이슈 설명</label> <span id="filename"></span>
               <img id="imgpreview" alt="사진 미리보기 자리"
                  style="display: none; width: 40px; height: 40px" src="#" /> 
                  <input type="file" multiple="multiple"  id="fileclick" name="files" hidden="">
               <button type="button" id="auth" disabled hidden="">Authenticate</button>
               <textarea class="form-control createmodal" rows="5"
                  id="issuecontent" name="issuecontent" style="width: 100%;border-radius: 0.5rem;"
                  placeholder="@를 입력하여 멘션, 할 일, 파일 등을 추가해 보세요."></textarea>
               <br>
               <label for="annota">첨부</label>
               <div id="todoresult" style="overflow: auto; height: 100px; border: 1px solid #000; border-radius: 0.5rem;">
                  <!-- mention -->
               </div>
               <!-- The Google API Loader script. -->
               <script type="text/javascript"
                  src="https://apis.google.com/js/api.js?onload=onApiLoad"></script>
            </div>
            <!-- Modal footer -->
            <div class="modal-footer">
               <select id="selectpro" name="selectTeam" class="form-control">
                  <option value="${sessionScope.email}">프라이빗 공간</option>
                  <c:forEach items="${pjtlist}" var="p">
                           <option value="${p.tseq}">${p.pname}</option>
                           <%-- <c:set value="${p.pname}" var="pname"></c:set> --%>
                           <%-- <input type="hidden" value="${p.pname}" name="pname"  readonly> --%>
                  </c:forEach>
               </select>
               <%-- <c:if test="${tseq!=null} }">
               <input type="hidden" value="${pname }" name="pname"  readonly>
               </c:if> --%>
               <button type="submit" class="btn btn-secondary"
                  style="background-color: #E71D36; border-color: #CCCCCC; color: #fff; cursor: pointer;">만들기</button>
               <button type="button" class="btn btn-secondary"
                  style="background-color: #E71D36; border-color: #CCCCCC; color: #fff; cursor: pointer;"
                  data-dismiss="modal">취소</button>
            </div>
         </form>
      </div>
   </div>

   <div class="list-group" id="mentionlist" style="display: none;border:10px solid #cbc9d4">
      <a href="#" class="list-group-item list-group-item-action menli" id="men1"style="padding: 5px;">@ 멘션</a> 
      <a href="#" class="list-group-item list-group-item-action menli" id="men2"style="padding: 5px"><span class="iconify" data-icon="whh:googledrive" data-inline="false"></span> 구글 드라이브</a> 
      <a href="#" class="list-group-item list-group-item-action menli" id="men3"style="padding: 5px"><span class="iconify" data-icon="si-glyph:file-box" data-inline="false"></span> 파일</a> 
      <a href="#" class="list-group-item list-group-item-action menli" id="men4"style="padding: 5px"><span class="iconify" data-icon="bx:bx-check-circle" data-inline="false"></span> 할 일</a> 
      <a href="#" class="list-group-item list-group-item-action menli" id="men5"style="padding: 5px"><span class="iconify" data-icon="bx:bx-calendar" data-inline="false"></span> 일정</a>
   </div>
   <!--  -->
   <!-- 멘션할 사람 목록 -->
   <div class="list-group" id="memlist" style="display: none">
   <c:forEach items="${tpmemlist}" var="t">
   	<a href="#" class="list-group-item list-group-item-action todo projectmem${t.tseq}" style="padding: 5px; border-radius: 0" id="${t.tseq}/${t.email}">${t.name}</a>
   </c:forEach>
   </div>
   <div class="list-group" id="todo" style="display: none;">
      <label for="todomem">담당자</label> <input
         class="form-control createmodal" type="text" id="todomem"
         style="width: 100%" name=""> <br> <label for="todolist">할
         일</label>
      <textarea class="form-control createmodal" rows="3" id="todolist"
         style="width: 100%; margin-bottom: 2%" placeholder="할 일을 작성해주세요."></textarea>
      <button type="button" id="todomake" class="btn btn-secondary"
         style="background-color: #E71D36; border-color: #CCCCCC; color: #fff; cursor: pointer;">만들기</button>
      <button type="button" id="todocancle" class="btn btn-secondary"
         style="background-color: #E71D36; border-color: #CCCCCC; color: #fff; cursor: pointer;">취소</button>
   </div>
   <div class="list-group" id="datepick" style="display: none;">
      <label>일정 작성</label>
      <div class="row">
         <div class="col-sm-5" style="padding-right: 0;">
            <span class="iconify" data-icon="bx:bx-calendar" data-inline="false"
               style="width: 25px; height: auto;"></span> <input type="text"
               id="from" name="from" style="width: 70%; border: none;"
               placeholder="시작날짜">
         </div>
         <div class="col-sm-2" style="padding-left: 0; padding-right: 0;">
            ~</div>
         <div class="col-sm-5" style="padding-left: 0;">
            <span class="iconify" data-icon="bx:bx-calendar" data-inline="false"
               style="width: 25px; height: auto;"></span> <input type="text"
               id="to" name="to" style="width: 70%; border: none;"
               placeholder="종료날짜">
         </div>
      </div>
      <br> <!-- <label>할 일</label>
      <textarea class="form-control createmodal" rows="3" id="datecontent"
         style="width: 100%; margin-bottom: 2%" placeholder="일정을 작성해주세요."></textarea> -->
         <div class="row">
         <div class="col-sm-6" style="padding-right: 2px">
      <button type="button" id="datemake" class="btn btn-secondary"
         style="background-color: #E71D36; border-color: #CCCCCC; color: #fff; cursor: pointer; width: 100%">만들기</button>
         </div>
         <div class="col-sm-6" style="padding-left: 2px">
      <button type="button" id="datecancle" class="btn btn-secondary"
         style="background-color: #E71D36; border-color: #CCCCCC; color: #fff; cursor: pointer; width: 100%">취소</button>
         </div>
         </div>
   </div>
</div>
<!-- 파트너 초대 모달 -->
<div class="modal fade" id="inviteModal">
   <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content modal-fullsize"
         style="border-radius: 0.5rem;">
         <!-- Modal Header -->
         <div class="modal-header" style="padding-bottom: 0px;height: 67px;">
            <h5 style="padding-top: 2%; padding-left: 5px;"><spring:message code="invite.title" /></h5>
            <button type="button" class="close" data-dismiss="modal">&times;</button>
         </div>

         <!-- Modal body -->
         <form action="inviteTeam.do" method="post" id="inviteForm">
         </form>
            <div class="row" style="margin-bottom: 1%;" id="inviteContent">
               <div class="col-sm-6"
                  style="border-right: 1px solid rgba(0,0,0,0.5); padding-left: 20px;">
                  <div class="modal-body">
                     <p style="font-size: 12px">
		              <spring:message code="invite.content1" /><br> 
		              <spring:message code="invite.content2" />
                     </p>
                     <label for="title"><spring:message code="invite.subject" /></label> <input
                        class="form-control createmodal" type="text" id="invite_Submit"
                        placeholder="<spring:message code='invite.holder' />"
                        style="width: 100%; border-radius: 0.25rem;">
                     <p style="font-size: 13px; margin-top: 2%; margin-left: 1%;">
                     	<spring:message code="invite.subcon" />
                     </p>
                     <div id="invite_email_append"
                        style="min-width: 35%; border: 1px solid #c8c8c8; border-radius: 0.25rem; background-color: #fff; display: none; position: absolute; top: 145px; left: 18px;">

                     </div>
                     <label for="content"><spring:message code="invite.team" /></label> <select id="select_invite"
                        name="tseq" class="form-control" style="border-radius: 0.25rem;">
                        <c:forEach items="${pjtlist}" var="p">
                           <option value="${p.tseq}">${p.pname}</option>
                        </c:forEach>
                     </select>
                  </div>
               </div>
               <div class="col-sm-6">
                  <label for="content" style="margin-top: 3%; margin-bottom: 0px;">
                  	<spring:message code="invite.list" />
                  </label>
                  <div id="invite_Input"
                     style="border: 2px solid rgba(0,0, 0, 0.3); border-radius: 0.5rem; margin-right: 3%; height: 280px; overflow: auto; margin-bottom: 10px;">
                     <span id="invite_Input1"
                        style="margin-left: 35%; margin-top: 18%;"> <img
                        src="<c:url value="/resources/images/icon/mail.png" />"
                        style="width: 75px; height: 75px; margin-left: 40%;' ">
                     </span>
                     <p id="invite_Input2" style="text-align: center;">
                       <spring:message code="invite.listcon1" /><br>
                       <spring:message code="invite.listcon2" />
                     </p>
                  </div>
                  <input type="hidden" name="invitecnt" id="invitecnt">
                  <button type="submit" class="btn btn-secondary" id="invitebtn"
                     style="background-color: #E71D36; border-color: #CCCCCC; color: #fff; cursor: pointer; margin-left: 100px; padding-left: 75px; padding-right: 75px;"
                     disabled="disabled"><spring:message code="invite.invite" /></button>
               </div>
            </div>



      </div>
   </div>
</div>
<div class="modal fade" id="makenotice">
   <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">

         <!-- Modal Header -->
         <div class="modal-header">
            <h3 class="modal-title">공지사항 작성</h3>
            <button type="button" class="close" data-dismiss="modal">&times;</button>
         </div>
   
         <form action="noticeWrite.do" method="POST" onsubmit="return checknotice()">
            <!-- Modal body -->
            <div class="modal-body">
               <!-- <p style="font-size: 12px">협업공간은 함께 일하는 멤버들끼리만 자료를 공유하고 협업할 수 있는 공간입니다.<br>
             협업공간을 만들고 함께 일할 멤버들을 초대해보세요.</p> -->
               <label for="bntitle">공지사항</label> <input
                  class="form-control createmodal" type="text" id="bntitle"
                  name="bntitle" style="width: 100%;border-radius: 0.5rem;" placeholder="제목을 입력해 주세요.">
               <br> <label for="noticecontent">공지 설명</label>
               <textarea class="form-control createmodal" rows="5"
                  id="bncontent" name="bncontent" style="width: 100%"
                  placeholder="내용을 적어주세요."></textarea>   
                  <input type="hidden" name="email" value="${sessionScope.email}">      
            <!-- Modal footer -->
            <div class="modal-footer">
               <button type="submit" class="btn btn-secondary"
                  style="background-color: #E71D36; border-color: #CCCCCC; color: #fff; cursor: pointer;">만들기</button>
               <button type="button" class="btn btn-secondary"
                  style="background-color: #E71D36; border-color: #CCCCCC; color: #fff; cursor: pointer;"
                  data-dismiss="modal">취소</button>
               </div>
            </div>
         </form>
      </div>
   </div>
   </div>
<script type="text/javascript">
var annotation = 0;
$('.modal').on('hidden.bs.modal', function(e) { //모달이 닫힌다면 안에 내용 초기화
   $('#memlist').hide();
   $('.CodeMirror').hide();
   $('#filename').empty();
   $('#imgpreview').hide();
   $('#issuecontent').show();
   $('#todo').hide();
   $('#todomem').empty();
   $('#todolist').empty();
   $('#todoresult').empty();
   $('#todoresult').hide();
   $('#datepick').hide();
   $('#from').val('');
   $('#to').val('');
   $('#memlist').attr('class', 'list-group');
   $(this).find('form')[0].reset();
   $('#invite_Input').children('.emailList').remove();
   $('#invite_Submit').val('');
   $('#invite_email_append').hide();
   $('.emailList').remove();
   $('#invite_Submit').val('');
   $('#invite_email_append').hide();
   $('#invite_Input1').show();
   $('#invite_Input2').show();
});
var tar = 0;
var tar2 = 1;
$('.menli').keydown(function(event) { //이슈작성에서 @단축키 사용했을때 방향키로 조절가능
   var key = event.keyCode;
    switch (key) {
    case 38:
       tar2--;
       break;
    case 40:
       tar2++;
       break;
    case 39:
       break;
    case 37:
       break;
    }
    if (tar2 < 0) {
       tar2 = 0;
    }
    if (tar2 > 5) {
       tar2 = 5;
    }
    $('#men' + tar2).focus();
    if ($('#men' + tar2).focus()) {
       $('.menli').css('background-color', '#fff');
       $('#men' + tar2).css(
             'background-color',
             'rgba(225, 225, 225,0.5)');
    }
    if(event.keyCode == 13){
       $(this).click();
    }
});
	$('#issuecontent').keydown( //이슈작성에서 @단축키 사용했을때 방향키로 조절가능
			function(event) {
				if($('#mentionlist').css('display')==('flex')){
					var key = event.keyCode;
		               switch (key) {
		               case 38:
		                  tar--;
		                  break;
		               case 40:
		                  tar++;
		                  break;
		               case 39:
		                  break;
		               case 37:
		                  break;
		               }
		               if (tar < 0) {
		                  tar = 0;
		               }
		               if (tar > 5) {
		                  tar = 5;
		               }
		               $('#men' + tar).focus();
		               if ($('#men' + tar).focus()) {
		                  $('.menli').css('background-color', '#fff');
		                  $('#men' + tar).css(
		                        'background-color',
		                        'rgba(225, 225, 225,0.5)');
		               }
		               if(event.keyCode == 13){
		               	$(this).click();
		               }
				}
				var top = ($('#issuecontent').offset().top);
				var left = ($('#issuecontent').offset().left + 490);
				if (event.shiftKey && event.keyCode == 50) {
					$('#mentionlist').attr(
							'style',
							'position:fixed;border:1px solid black;border-radius:0.5rem; width:20%;top:' + top + 'px;left:'
									+ left + 'px; z-index:4');
					$('#mentionlist').show();
					$('div').not('#mentionlist').click(function() {
						$('#mentionlist').hide();
					});
				}
			});
	$('#selectpro').change(function(){ //이슈작성에서 협업공간 선택했을때
		$('#todoresult').empty();
		if($(selectpro).val()=="${sessionScope.email}"){
			$('.todo').show();
			for(let i=0; i<$('#memlist').children().length-1; i++){
				for(let j=i+1; j<$('#memlist').children().length;j++){
					if($('#memlist').children().eq(i).attr('id').split("/")[1] == $('#memlist').children().eq(j).attr('id').split("/")[1]){
						$('#memlist').children().eq(j).hide();
					}
				}
			}
		}else{
			$('.todo').hide();
			for(let i=0; i<$('#memlist').children().length; i++){
				if($('#memlist').children().eq(i).attr('id').split("/")[0] == $(selectpro).val()){
					$('.projectmem'+$(selectpro).val()).show();
				}
			}
		}
	})
	$('#men1').click( //멘션 클릭하면 멤버 목록 나옴
			function() {
				var top = ($('#issuecontent').offset().top);
				var left = ($('#issuecontent').offset().left + 490);
				$('#mentionlist').hide();
				$('#memlist').attr(
						'style',
						'position:fixed; width:20%;top:' + top + 'px;left:'
								+ left + 'px; z-index:4;height:160px;overflow:auto;');
				$('#memlist').show();
				$('#memlist').attr('class', 'list-group mem');
				$('.modal-content').not('#memlist').click(function() {
					$('#memlist').hide();
					$('#memlist').attr('class', 'list-group');
				});
			});
	$('#men2').click(function() { //구글드라이브 클릭하면 구글picker 실행
		$('#mentionlist').hide();
		var text = "";
		text = $('#issuecontent').val().replace("@", "");
		$('#issuecontent').val(text);
		if("${role}"=="ROLE_USER"){
			   Swal.fire({
					  title : '이용 불가',
					  text : '무료회원은 구글드라이브를 이용할 수 없습니다!',
					  icon : 'warning',
					  confirmButtonColor: '#d33'
		   })
		   return;
		}
		$('#auth').click();
		$('#issuecontent').append($('.picker-dialog'));

	});
	$('#men3').click(function() { //파일 클릭하면 hidden으로 숨겨놓은 파일선택 실행
		$('#mentionlist').hide();
		$('#fileclick').click();
	});
	function readURL(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				$('#imgpreview').attr('src', e.target.result);
				if (e.target.result.substring(5, 10) == 'image') {
					//$('#imgpreview').show();
				} else {
					$('#imgpreview').hide();
				}
			}
			reader.readAsDataURL(input.files[0]);
		}
	}
	$("#fileclick").change(function() { //파일들을 선택하면 첨부에 append
		readURL(this);
		var files = $("#fileclick")[0].files;
		$('#filename').empty();
		var text = "";
		text = $('#issuecontent').val().replace("@", "");
		$('#issuecontent').val(text);
		for(let i=0; i<$("#fileclick")[0].files.length;i++){
		$('#todoresult')
		.append(
				'<div style="padding:5px"><span class="iconify" data-icon="si-glyph:file-box" data-inline="false"></span> '
						+ files[i].name
						+ '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="annoDelete'+(++annotation)+'" style="cursor:pointer;" onclick="annotationDelete('+annotation+')"><span class="iconify" data-icon="octicon:x" data-inline="false"></span></span></div>');
		}
$('#todoresult').show();
		
	});
	$('#men4').click( //할 일을 선택하면 멤버목록 불러오기
			function() {
				var text = "";
				text = $('#issuecontent').val().replace("@", "");
				$('#issuecontent').val(text);
				var top = ($('#issuecontent').offset().top);
				var left = ($('#issuecontent').offset().left + 490);
				$('#mentionlist').hide();
				$('#memlist').attr(
						'style',
						'position:fixed; width:20%;top:' + top + 'px;left:'
								+ left + 'px; z-index:4;height:160px;overflow:auto;');
				$('#memlist').show();
			});
	$('.todo') //멘션에서 멤버목록을 클릭하면 @로 첨부에 append 그리고 할 일에서 멤버목록을 클릭하면 할일 div 불러오기
			.click(
					function() {
						var top = ($('#issuecontent').offset().top);
						var left = ($('#issuecontent').offset().left + 490);
						if ($(this).parents('#memlist').attr('class') == 'list-group mem') {
							var text = "";
							text = $('#issuecontent').val().replace("@", "");
							$('#issuecontent').val(text);
							$('#todoresult').append('<div style="padding:5px; width:100%"><input type="text" id="'+$(this).attr('id')+'" value="@'+ $(this).text() + '" style="border:none;width:100px" readonly><span id="annoDelete'+(++annotation)+'" style="cursor:pointer;" onclick="annotationDelete('+annotation+')"><span class="iconify" data-icon="octicon:x" data-inline="false"></span></span></div>');
							$('#todoresult').append('<input type="hidden" name="mentions" value="'+ $(this).attr('id').split('/')[1] + '">');
							$('#todoresult').show();
							$('#memlist').hide();
							$('#memlist').attr('class', 'list-group');
						} else {
							$('#memlist').hide();
							$('#todo')
									.attr(
											'style',
											'border-radius:0.25em;padding:1%;position:fixed; width:20%;top:'
													+ (top - 208)
													+ 'px;left:'
													+ left
													+ 'px; z-index:4;background-color:white');
							$('#todo').show();
							$('#todomem').val($(this).text());
							$('#todomem').attr('name', $(this).attr('id'));
						}

						$('.modal-content').not('#todo').click(function() {
							$('#todo').hide();
						});
					});
	$('#todomake') //할 일div에서 만들기를 클릭하면 담당자와 내용을 첨부에 append
			.click(
					function() {
						$('#todo').hide();
						var text = "";
						text = $('#issuecontent').val().replace("@", "");
						$('#issuecontent').val(text);
						$('#todoresult')
								.append(
										'<div style="padding:5px"><span class="iconify" data-icon="bx:bx-check-circle" data-inline="false"></span>'
												+ $('#todomem').val()
												+ ' <span class="iconify" data-icon="bytesize:arrow-right" data-inline="false"></span> '
												+ $('#todolist').val()
												+ '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="annoDelete'+(++annotation)+'" style="cursor:pointer;" onclick="annotationDelete('+annotation+')"><span class="iconify" data-icon="octicon:x" data-inline="false"></span></span></div>');
						$('#todoresult').append('<input type="hidden" name="toWork" value="'+$('#todomem').attr('name').split("/")[1]+'">');
						$('#todoresult').append('<input type="hidden" name="doWork" value="'+$('#todolist').val()+'">');
						$('#todoresult').show();
						$('#todolist').val('');
					})
	$('#todocancle').click(function() { //할 일 div 닫기
		$('#todo').hide();
		var text = "";
		text = $('#issuecontent').val().replace("@", "");
		$('#issuecontent').val(text);
		$('#todolist').val('');
	});
	$('#men5').click( //일정을 클릭하면 datepicker 불러오기
			function() {
				var top = ($('#issuecontent').offset().top);
				var left = ($('#issuecontent').offset().left + 490);
				$('#mentionlist').hide();
				var text = "";
				text = $('#issuecontent').val().replace("@", "");
				$('#issuecontent').val(text);
				$('#datepick').attr(
						'style',
						'border-radius:0.25em;padding:1%;position:fixed; width:20%;top:'
								+ top + 'px;left:' + left
								+ 'px; z-index:4;background-color:white');
				$('#datepick').show();
				$('.modal-content').not('#datepick').click(function() {
					$('#datepick').hide();
				});
				$('.hasDatepicker').click(function() {
					$('#datepick').append($('#ui-datepicker-div'));
				});
			});
	$('#datemake') //일정 만들면 첨부에 append
			.click(
					function() {
						if(($('#to').val()=='') || ($('#from').val()=='')){
							   Swal.fire({
									  title : '일정을 둘다 넣어야 합니다!',
									  icon : 'warning',
									  confirmButtonColor: '#d33'
						   })
						   return;
						}
						$('#datepick').hide();
						var text = "";
						text = $('#issuecontent').val().replace("@", "");
						$('#issuecontent').val(text);
						$('#todoresult').append(
										'<div style="padding:5px"><span class="iconify" data-icon="bx:bx-calendar" data-inline="false"></span>'
												+ $('#from').val()
												+ '~'
												+ $('#to').val()
												+ '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="annoDelete'+(++annotation)+'" style="cursor:pointer;" onclick="annotationDelete('+annotation+')"><span class="iconify" data-icon="octicon:x" data-inline="false"></span></span></div>');
						$('#todoresult').append('<input type="hidden" name="fromDate" value="'+$('#from').val()+'">');
						$('#todoresult').append('<input type="hidden" name="toDate" value="'+$('#to').val()+'">');
						$('#todoresult').show();
						$('#todolist').val('');
					})
	$('#datecancle').click(function() { //일정 취소버튼 누르기
		$('#datepick').hide();
		var text = "";
		text = $('#issuecontent').val().replace("@", "");
		$('#issuecontent').val(text);
		$('#todolist').val('');
	});
	$("#to").datepicker({ dateFormat: 'yy-mm-dd' });
	$("#from").datepicker({ dateFormat: 'yy-mm-dd' });
   if(!gapi.auth2){
		    gapi.load('auth2', function() {
		        gapi.auth2.init();
		    });
		 }
	 
	function signOut(){
		var auth2 = gapi.auth2.getAuthInstance();
		auth2.signOut().then(function(){
			location.href="logout.do";
			});
		auth2.disconnect();
		}

	$('#inviteModal_id')
			.mouseover(
					function() {
						$(this)
								.attr('style',
										'cursor: pointer;color:#e71d36;font-size: 18px;padding-bottom: 12px;');
					});
	$('#inviteModal_id')
			.mouseleave(
					function() {
						$(this)
								.attr('style',
										'cursor: pointer;color:#535359;font-size: 18px;padding-bottom: 12px;');
					});
	function annotationDelete(annotation){ //첨부에서 x버튼 누르면 삭제
		$('#annoDelete'+annotation).parent().remove();
	}

    $('#issuetitle').on('keyup', function() { //이슈 제목은 30자까지만 제한
  		if(($(this).val().length) > 30) {
  			 Swal.fire("글자수를 초과 하셨습니다.");
  			$("#issuetitle").focus();
  			 $(this).val($(this).val().substring(0, 30));
  		}
  	});

    
    
    

</script>