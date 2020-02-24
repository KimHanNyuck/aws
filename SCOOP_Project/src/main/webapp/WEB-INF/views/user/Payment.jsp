<!-- 내정보에서 가격 및 결제 jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="role" value="${sessionScope.role}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1">

<jsp:include page="/WEB-INF/views/commons/title.jsp"></jsp:include>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<!-- Custom Stylesheet -->
<link href="<c:url value="/resources/css/style.css"/>" rel="stylesheet">

</head>
<script>
function requestPay(){
	$(function(){
        var IMP = window.IMP; // 생략가능
        IMP.init('imp86112746'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
        var msg;
        
        IMP.request_pay({
            pg : 'kakaopay',
            pay_method : 'card',
            merchant_uid : 'merchant_' + new Date().getTime(),
            name : 'SCOOP PRIMIUM',
            amount : 100,
            buyer_email : '<%=session.getAttribute("email")%>',
            buyer_name : '',
            buyer_tel : '010-1111-1111',
            buyer_addr : '서울특별시 강남구 서초동',
            buyer_postcode : '123-456',
            //m_redirect_url : 'http://www.naver.com'
        }, function(rsp) {
            if ( rsp.success ) {
                //[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
                jQuery.ajax({
                	 url: "updateRole.do", //cross-domain error가 발생하지 않도록 주의해주세요
          			 type: 'POST',
          			 dataType: 'json',
                    data: {
                        imp_uid : rsp.imp_uid
                        //기타 필요한 데이터가 있으면 추가 전달
                    }
                }).done(function(data) {
                    //[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
                    if ( everythings_fine ) {
            	    		
                    } else {
                        //[3] 아직 제대로 결제가 되지 않았습니다.
                        //[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
                    }
                });
                Swal.fire(
                        '결제를 성공하셨습니다.',
                        '스쿱 프리미엄이 되신 것을 환영합니다!',
                        'success'
                      )
                window.setTimeout(function() {
                   location.href='userindex.do';
                }, 1500);
            } else {
                //실패시 이동할 페이지
                location.href="paymentPage.do";
                Swal.fire({
  	    		  title: "결제에 실패하였습니다",
  	    		  text: rsp.error_msg,
  	    		  icon: "error",
  	    		  button: "확인"
  	    		})
            }
        });
        
    });
    
	
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
.myinfo {
	border: 0;
	border-bottom: 1px solid #c8c8c8;
	background-color: white;
}

.form-control[readonly] {
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
			
			<div class="container-fluid">
				<div class="card" >
					<div class="row" style="margin: 2%">
						<div class="col-sm-12" style="padding-left: 0">
							<h3>결제 및 가격정보</h3>
						</div>
					</div>
					<div class="row" style="margin-left: 2%;">
						<ul class="nav nav-pills">
							<li class="nav-item"><a class="nav-link"
								href="memberEdit.do?${sessionScope.email}">내 정보</a></li>
							<li class="nav-item"><a class="nav-link"
								href="paymentPage.do" style="color: #E71D36;">가격 및 결제</a></li>
							<li class="nav-item">
								<a class="nav-link" href="javascript:getOutMember();">회원 탈퇴</a>
						    </li>
						</ul>
					</div>
					<hr style="margin-top: 0">
					<div class="row" style="margin-left: 4%;"></div>
					<!-- #/ container -->
					<section class="pt-4" id="pricing" style="height: 500px;">
						<div id="pricing_area"></div>
						<div class="container">
							<div class="row">
								<div class="col-md-7 mx-auto text-center">
									<h2>
										<spring:message code="payment.title" />
									</h2>
									
									<p class="text-muted lead">
										<spring:message code="payment.content" />
									</p>
								</div>
							</div>
							<!--pricing tables-->
							<div class="row pricing-table">
								<div class="col-sm-12">
									<div class="card-deck pricing-table">
										<div class="card text-center" style="border-color: #fff;min-height: 20px;height: 100%;">
											<div class="card-body">
												<h4 class="card-title pt-3" style="color: #0E2866">CHOICE</h4>
												<h2 class="card-title pt-4" style="color: #0E2866">PRICE</h2>
												<div class="text-muted mt-4">
													<spring:message code="payment.date" />
												</div>
												<ul class="list-unstyled pricing-list">
													<li><spring:message code="payment.alam" /></li>
													<li><spring:message code="payment.team" /></li>
													<li><spring:message code="payment.upload" /></li>
													<li><spring:message code="payment.teamMgm" /></li>
													<li><spring:message code="payment.cs" /></li>
													<li><spring:message code="payment.api" /></li>
												</ul>
												<h5>
													<spring:message code="payment.start" />
												</h5>
											</div>
										</div>

										<div class="card text-center" style="border-color: #fff;min-height: 20px;height: 100%;">
											<div class="card-body">
												<h4 class="card-title pt-3">Free</h4>
												<h2 class="card-title pt-4">$0</h2>
												<div class="text-muted mt-4">
													<span class="iconify" data-icon="ion:infinite-sharp"
														data-inline="false"></span>
												</div>
												<ul class="list-unstyled pricing-list">
													<li>-</li>
													<li>3개</li>
													<li>20MB</li>
													<li><span class="iconify" data-icon="bx:bx-check"
														data-inline="false" style="color: #E71D36;"></span></li>
													<li><span class="iconify" data-icon="bx:bx-check"
														data-inline="false" style="color: #E71D36;"></span></li>
													<li>-</li>
												</ul>
												<c:choose>
													<c:when test="${role == 'ROLE_CHARGE' || role == 'ROLE_ADMIN'}">
													<a href="#" data-toggle="modal" data-target="#login"class="btn btn-secondary">-</a>
													</c:when>
													<c:otherwise>
													<a href="#" data-toggle="modal" data-target="#login"class="btn btn-secondary"> 사용중  </a>
													</c:otherwise>
												</c:choose>
												
											</div>
										</div>
										 <c:choose>
                  							<c:when test="${role == 'ROLE_CHARGE' || role == 'ROLE_ADMIN'}">
										<div class="card text-center" style="border-color: #fff;min-height: 20px;height: 100%;">
											<div class="card-body">
												<h4 class="card-title text-primary pt-3">Premium</h4>
												<h2 class="card-title text-primary pt-4">$4</h2>
												<div class="text-muted mt-4">30일</div>
												<ul class="list-unstyled pricing-list">
													<li><spring:message code="payment.unlimited" /></li>
													<li><spring:message code="payment.unlimited" /></li>
													<li>100MB</li>
													<li><span class="iconify" data-icon="bx:bx-check"
														data-inline="false" style="color: #E71D36;"></span></li>
													<li><span class="iconify" data-icon="bx:bx-check"
														data-inline="false" style="color: #E71D36;"></span></li>
													<li>구글 드라이브</li>
												</ul>
												<button class="btn btn-primary" onclick="charge();" 
													type="button">사용 중</button>
												<!-- <a href="#" data-toggle="modal"
													class="btn btn-primary" id="check_module"> Get
													Started </a> -->

											</div>
										</div>
										</c:when>
										<c:otherwise>
										<div class="card text-center" style="border-color: #fff;min-height: 20px;height: 100%;">
											<div class="card-body">
												<h4 class="card-title text-primary pt-3">Premium</h4>
												<h2 class="card-title text-primary pt-4">$4</h2>
												<div class="text-muted mt-4">per month</div>
												<ul class="list-unstyled pricing-list">
													<li><spring:message code="payment.unlimited" /></li>
													<li><spring:message code="payment.unlimited" /></li>
													<li>100MB</li>
													<li><span class="iconify" data-icon="bx:bx-check"
														data-inline="false" style="color: #E71D36;"></span></li>
													<li><span class="iconify" data-icon="bx:bx-check"
														data-inline="false" style="color: #E71D36;"></span></li>
													<li>구글 드라이브</li>
												</ul>
												<button class="btn btn-primary" onclick="requestPay()"
													type="button">유료회원 전환</button>
												<!-- <a href="#" data-toggle="modal"
													class="btn btn-primary" id="check_module"> Get
													Started </a> -->

											</div>
										</div>
										</c:otherwise>
										</c:choose>
									</div>
								</div>
							</div>

						</div>

					</section>
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
	<script src="<c:url value="/resources/plugins/common/common.min.js"/>"></script>
	<script src="<c:url value="/resources/js/custom.min.js"/>"></script>
	<script src="<c:url value="/resources/js/settings.js"/>"></script>
	<script src="<c:url value="/resources/js/gleek.js"/>"></script>
	<script src="<c:url value="/resources/js/styleSwitcher.js"/>"></script>
	<script type="text/javascript">
	function charge(){
		Swal.fire({
    		  title: "이미 결제를 했습니다.",
    		  text: "이미 결제를 했습니다.",
    		  icon: "error",
    		  button: "확인"
    		})
		}
	</script>
</body>

</html>