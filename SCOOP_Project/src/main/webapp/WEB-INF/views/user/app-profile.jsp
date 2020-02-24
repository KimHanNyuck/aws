<!-- 내정보 jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
    <c:set var="img" value="${sessionScope.img}" />
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <jsp:include page="/WEB-INF/views/commons/title.jsp"></jsp:include>
    <!-- Custom Stylesheet -->
    <link href="<c:url value="/resources/css/style.css" />" rel="stylesheet">
</head>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script language="javascript" src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
<script>
function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("sample6_extraAddress").value = extraAddr;
            
            } else {
                document.getElementById("sample6_extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample6_postcode').value = data.zonecode;
            document.getElementById("sample6_address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("sample6_detailAddress").focus();
        }
    }).open();
}

$(function(){
	$('[data-toggle="tooltip"]').tooltip();
	$('#profile').click(function(){
		$('#Photo').click();
	})
  $('#address_btn').click(function(){
     var realaddr = $('#sample6_postcode').val() + "/" + $('#sample6_address').val() + "/" + $('#sample6_detailAddress').val();
     console.log(realaddr);
     $('#address').val(realaddr);
  });
  if($('#address').val()!=''){
     var addr1 = ""; 
     var addr2 = ""; 
     var addr3 = "";
     var tempaddress = $('#address').val().split("/"); 
     addr1 = tempaddress[0];
     addr2 = tempaddress[1];
     addr3 = tempaddress[2];
     $('#sample6_postcode').val(addr1);
     $('#sample6_address').val(addr2);
     $('#sample6_detailAddress').val(addr3);
     }
  $('#sample6_postcode').change(function(){
     console.log("바뀌니?");
     })
});


$(function(){
	
	$('#Photo').change(function(){
		var reader = new FileReader();
		
		reader.onload = function(e) {
			
			document.getElementById("profile").src = e.target.result;
		};
		
		reader.readAsDataURL(this.files[0]);
	});
});

	//회원정보 유효성검사
	function pwdcheck() {
			var getCheck = RegExp(/^[a-zA-Z0-9]{8,16}$/);
			var getName= RegExp(/^[가-힣|a-z|A-Z]+$/);
			if($('#name').val().length>7){
				alert("name은 7자 까지 입력가능합니다.")
				return false;
			}
			
			 //이름 유효성
		      if (!getName.test($("#name").val())) {
		    	Swal.fire("이름 형식에 맞게 입력해주세요.");
		        $("#name").val("");
		        $("#name").focus();
		        return false;
		      }
		    //이름 공백 확인
		      if($("#name").val() == ""){
		    	Swal.fire("이름을 입력해주세요");
		        $("#name").focus();
		        return false;
		      }
			
			//회원가입 시 메일 보낼 때 얼럿창


	   		
   			Swal.fire({
   				  icon: 'success',
   				  title: '정보수정 완료!',
   				  showConfirmButton: false,
   				  timer: 2000
   				})
			return true;
	}


	function getOutMember(){
	 Swal.fire({
		   title: '정말로 회원 탈퇴하시겠습니까??',
		   text: "삭제하시면 스쿱의 모든 정보가 사라집니다!",
		   icon: 'warning',
		   showCancelButton: true,
		   confirmButtonColor: '#d33',
		   cancelButtonColor: '#c8c8c8',
		   confirmButtonText: '확인',
		   cancelButtonText: '취소'
		 }).then((result) => {
		   if (result.value) {
			   location.href = 'memberDelete.do';
		   }
		 })
		}

</script>

<style>
.myinfo{
 border: 0;
 border-bottom: 1px solid #c8c8c8;
 background-color: white;
}
.form-control[readonly]{
	background-color: white;
}
</style>
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
        <br>
            <div class="container-fluid">
        <div class="card" style="min-height: 1080px">
		<div class="row" style="margin:2% 2% 15px 2%">
			<div class="col-sm-12" style="padding-left: 0">
				<h3 style="padding-left: 1%;">내 정보</h3>
			</div>
		</div>
		<div class="row" style="margin-left: 2%;">
			<ul class="nav nav-pills">
			    <li class="nav-item">
			      <a class="nav-link" href="memberEdit.do?${sessionScope.email}" style="color: #E71D36;">내 정보</a>
			    </li>
			    <li class="nav-item">
			      <a class="nav-link" href="paymentPage.do">가격 및 결제</a>
			    </li>
			    <li class="nav-item">
			      <a class="nav-link" href="javascript:getOutMember();">회원 탈퇴</a>
			    </li>
		    </ul>
		</div>
		<hr style="margin-top: 0">
	<form onsubmit="return pwdcheck()" action="editCheck.do" method="post" enctype="multipart/form-data">
		<div class="row" style="margin-left: 4%; margin-right: 2%; margin-top: 1%">
			<div class="media align-items-center mb-4">
					<c:choose>
						<c:when test="${img==null}">
							<img id ="profile" class="mr-3 img-circle" src="<c:url value='/resources/images/avatar/avatar.png' />" width="120" height="120" alt="" name="profile" style="cursor: pointer;" data-placement="bottom" data-toggle="tooltip" title="변경하려면 클릭하세요!">
							<input type="file" name="filesrc" id="Photo" accept="image/*" hidden="">
						</c:when>
						<c:otherwise>
                             <img id ="profile" class="mr-3 img-circle" src="<c:url value='/user/upload/${img}' />" width="120" height="120" alt="" name="profile" style="cursor: pointer;" data-placement="bottom" data-toggle="tooltip" title="변경하려면 클릭하세요!">
                             <input type="file" name="filesrc" id="Photo" accept="image/*" hidden="">
						</c:otherwise>
					</c:choose>
                                    <div class="media-body">
                                        <h3 class="mb-0" style="padding-left: 2%;">${member.name}</h3>
                                        <p class="text-muted mb-0" style="margin-left: 2%; width: 300px;">${member.email}</p>
                                    </div>
                                </div>
		</div>
		<div class="row" style="margin-left: 4%; margin-top: 2%">
		<div class="form-group" style="width: 100%">
    		<label for="email">이메일</label>
    		<input class="form-control myinfo" type="text" id="email" name="email" style="width: 60%" readonly="readonly" value="${member.email}">
    		<br>
    		<c:choose>
    		<c:when test="${kind == 'google'}">
    		<label for="pwd">비밀번호</label>
    		<input class="form-control myinfo" type="text" id="pwd_google" name="pwd" style="width: 60%" value="구글에 문의하세요" readonly="readonly">
    		</c:when>
    		<c:when test="${kind == 'naver'}">
    		<label for="pwd">비밀번호</label>
    		<input class="form-control myinfo" type="text" id="pwd_naver" name="pwd" style="width: 60%" value="네이버에 문의하세요" readonly="readonly">
    		</c:when>
    		<c:otherwise>
    		<label for="pwd">비밀번호</label>
    		<input class="form-control myinfo" type="password" id="pwd" name="pwd" style="width: 60%" ><br>
    		<label for="pwdchk">비밀번호 확인</label>
    		<input class="form-control myinfo" type="password" id="pwdchk" name="pwdchk" style="width: 60%" >
    		</c:otherwise>
    		</c:choose>
    		<div id="chkmsg" style="color: green;"><br></div>
    		<br>
    		<label for="name">이름</label>
    		<input class="form-control myinfo" type="text" id="name" name="name" style="width: 60%" placeholder="7자까지 입력가능합니다" value="${member.name}">
    		<br>
    		<label for="dname">부서</label>
    		<input class="form-control myinfo" type="text" id="dname" name="dname" style="width: 60%" value="${member.dname}">
    		<br>
    		<label for="drank">직함</label>
    		<input class="form-control myinfo" type="text" id="drank" name="drank" style="width: 60%" value="${member.drank}">
    		<br>
    		<label for="address">주소</label><br>
    		<input class="form-control myinfo" type="hidden" id="address" name="address" style="width: 60%; " value="${member.address}">
          	<input type="text" id="sample6_postcode" style="border-radius: 0.25rem;padding-left:5px;padding-right: 5px;" placeholder="우편번호">
         	<input type="button" onclick="sample6_execDaumPostcode()" style="margin-bottom: 1%;margin-left:5px;border-radius: 0.25rem;padding-left:5px;padding-right: 5px;background-color: #E71D36;color:#fff;border-color: #E71D36; " value="우편번호 찾기"><br>
         	<input type="text" id="sample6_address" style="min-width:500px;border-radius: 0.25rem;padding-left:5px;padding-right: 5px;" placeholder="주소"><br>
         	<input type="text" id="sample6_detailAddress"style="min-width:250px;border-radius: 0.25rem;padding-left:5px;padding-right: 5px;" placeholder="상세주소">
         	<input type="text" id="sample6_extraAddress"style="min-width:247px;margin-top: 1%;border-radius: 0.25rem;padding-left:5px;padding-right: 5px; " placeholder="참고항목">
          	<br>
    		
    		<input type="submit" id="address_btn" class="btn" style="background-color: #E71D36; border-color: #CCCCCC; color: #fff; cursor: pointer;margin-top: 3%;" value="수정완료">
    		
    		</div>
    		</div>
    		</form>	
    
    	</div>
    	
    	</div>
            <!-- #/ container -->
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
	$(function(){
   		
   		$('#pwd').keypress(function(event) {
	if(event.keyCode==13){
		$('#pwdchk').focus();
	}
});
$('#pwdchk').keypress(function(){
	if(event.keyCode==13){
		$('#pwdBtn').submit();
	}
});
$('#pwd').keyup(function(){
	console.log('pwd');
	let pwd = $('#pwd').val();
	let chk = $('#pwdchk').val();
	
	if(chk != "") {
		if(pwd != chk){
			$('#chkmsg').empty().css("color", "red").text('비밀번호가 일치하지 않습니다.');
		} else{
			$('#chkmsg').empty().css("color", "#069e03").text('비밀번호가 일치합니다.');
		} 
	}
	if(pwd == "" && chk == ""){
		$('#chkmsg').empty().append('<br>');
	}
});

$('#pwdchk').keyup(function(event) {
	console.log('pwdchk');
	let pwd = $('#pwd').val();
	let chk = $('#pwdchk').val();

	if(pwd != chk){
		$('#chkmsg').empty().css("color", "red").text('비밀번호가 일치하지 않습니다');
	} else{
		$('#chkmsg').empty().css("color", "#069e03").text('비밀번호가 일치합니다');
	} 
});
	

		});
	</script>
</body>

</html>