<!-- 
	협업공간 초대 인증 jsp
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<%
String tseq = request.getParameter("tseq");
session.setAttribute("tseq", tseq);
String mailTo = request.getParameter("mailTo");
session.setAttribute("mailTo", mailTo);
/* if(session.getAttribute("email").equals(mailTo)){
	System.out.println("성공 왔니"); */
	%>
	<script>
	alert('성공');
	swal({
		  title: "협업공간 초대 인증 성공",
		  text: "협업공간초대에 인증 되셨습니다",
		  icon: "success",
		  button: "확인"
		})
	</script>
	<%
	response.sendRedirect("inviteOk.do");
	%>
<%-- }else{
	<script>
	System.out.println("실패 왔니");
	alert('에러');
	swal({
		  title: "협업공간 초대 인증실패",
		  text: "세션이 만료되었습니다 새로운 이메일을 받아 인증해주세요",
		  icon: "error",
		  button: "확인"
		})
	</script>
	<%
	response.sendRedirect("index.do");
}
%> --%>
</head>
<body>

</body>
</html>