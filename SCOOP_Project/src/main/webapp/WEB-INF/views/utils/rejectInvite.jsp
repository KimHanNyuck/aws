<!-- 무료회원이 3개 이상의 협업공간에 참여하려할 때 오류 sweetalert -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<jsp:include page="/WEB-INF/views/commons/footer.jsp"></jsp:include>
<script>
Swal.fire(
		  '협업 공간 초대 오류',
		  '무료 유저는 최대 3개의 협업공간에 참여할 수 있습니다!',
		  'warning'
		)
window.setTimeout(function() {
	location.href='index.do';
}, 2000);
</script>