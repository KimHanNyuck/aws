<!-- 협업공간에 이메일 초대 중복 에러 sweetalert -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/commons/footer.jsp"></jsp:include>
<script>
Swal.fire(
		  '이메일 전송 에러',
		  '이미 협업공간에 초대되어있는 멤버가 있습니다!',
		  'question'
		)
window.setTimeout(function() {
	location.href='userindex.do';	
}, 1000);
</script>