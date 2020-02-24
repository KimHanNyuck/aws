<!-- 
	비밀번호 찾기 인증 jsp
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- sweetalert2 -->
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
  <script src="https://cdn.jsdelivr.net/npm/promise-polyfill"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<%
	if(session.getAttribute("email") != null){
	%>
	<script>
	alert('인증 성공');
	Swal.fire({
		  title: "본인 인증 성공",
		  text: "비밀번호를 변경해 주세요",
		  icon: "success",
		  button: "확인"
		})
	</script>
	<%
	response.sendRedirect("changePwd.do");
}else{
	%>
	<script>
	alert('error');
	Swal.fire({
		  title: "본인 인증 실패",
		  text: "인증 실패 새로운 이메일을 받아 인증해주세요",
		  icon: "error",
		  button: "확인"
		})
	</script>
	<%
	response.sendRedirect("index.do");
}
%>
</head>
<body>

</body>
</html>