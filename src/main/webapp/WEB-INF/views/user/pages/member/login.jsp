<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<!-- ========================= CSS here ========================= -->
<link rel="stylesheet"
	href="/resources/assets/user/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="/resources/assets/user/css/LineIcons.3.0.css" />
<link rel="stylesheet" href="/resources/assets/user/css/tiny-slider.css" />
<link rel="stylesheet"
	href="/resources/assets/user/css/glightbox.min.css" />
<link rel="stylesheet" href="/resources/assets/user/css/main.css" />

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>

<body>
	<!--[if lte IE 9]>
      <p class="browserupgrade">
        You are using an <strong>outdated</strong> browser. Please
        <a href="https://browsehappy.com/">upgrade your browser</a> to improve
        your experience and security.
      </p>
    <![endif]-->

	<!-- Preloader -->
 	<div class="preloader">
		<div class="preloader-inner">
			<div class="preloader-icon">
				<span></span> <span></span>
			</div>
		</div>
	</div>
	<!-- /End Preloader -->

	<jsp:include page="../header.jsp"></jsp:include>


	<!-- Start Breadcrumbs -->
	<div class="breadcrumbs">
		<div class="container">
			<div class="row align-items-center">
				<div class="col-lg-6 col-md-6 col-12">
					<div class="breadcrumbs-content">
						<h1 class="page-title">로그인</h1>
					</div>
				</div>
				<div class="col-lg-6 col-md-6 col-12">
					<ul class="breadcrumb-nav">
						<li><a href="/"><i class="lni lni-home"></i>Home</a></li>
						<li>로그인</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<!-- End Breadcrumbs -->

	<!-- Start Account Login Area -->
	<div class="account-login section">
		<div class="container">
			<div class="row">
				<div class="col-lg-6 offset-lg-3 col-md-10 offset-md-1 col-12">
					<form class="card login-form" action="/member/login" method="post">
						<div class="card-body">
							<div class="title">
								<h3>로그인 하세요</h3>
								<p>You can login using your social media account or email
									address.</p>
							</div>
							<div class="social-login">
								<div class="row">
									<div class="col-lg-6 col-md-4 col-12">
										<a
											href="${pageContext.request.contextPath}/member/kakao/login"><img
											src="/resources/images/kakao_login_medium.png"></a>
									</div>
									<div class="col-lg-6 col-md-4 col-12">
										<a
											href="${pageContext.request.contextPath}/member/naver/login"><img
											src="/resources/images/btnG_완성형.png"></a>
									</div>
								</div>
							</div>
							<div class="alt-option">
								<span>Or</span>
							</div>
							<div class="form-group input-group">
								<label for="reg-fn">아이디</label> <input class="form-control"
									type="text" name="member_id" id="member_id" required>
							</div>
							<div class="form-group input-group">
								<label for="reg-fn">비밀번호</label> <input class="form-control"
									type="password" name="member_pwd" id="member_pwd" required>
							</div>
							<div
								class="d-flex flex-wrap justify-content-between bottom-content">
								<div class="form-check">
									<input type="checkbox" class="form-check-input width-auto"
										name="autologin_code" id="autologin_code"> <label
										class="form-check-label">자동 로그인</label>
								</div>
								<a class="lost-pass"
									href="${pageContext.request.contextPath}/member/find_id">아이디
									찾기</a> <a class="lost-pass"
									href="${pageContext.request.contextPath}/member/find_pwd">비밀번호
									찾기</a>
							</div>
							<div class="button">
								<button class="btn" type="submit">로그인</button>
							</div>
							<p class="outer-link">
								아직 회원이 아니신가요? <a
									href="${pageContext.request.contextPath}/member/viewSignUp">회원가입
									하기 </a>
							</p>
							
							<span id="nonMemberFunction"></span>
							<!-- working... -->
							<!-- TODO : 모델이든 세션이든 정보 받아서 비회원이 장바구니에서 결제하기 버튼 누르면  '비회원으로 결제하기' 링크 만들어야 함-->
<%-- 							<c:if test="${sessionScope.sentByOrderRequest eq null}">
								<p class="outer-link"><a href="${pageContext.request.contextPath}/orderByNonMemberPage">
									비회원으로 주문조회 하기
								</a></p>
							</c:if>
							
							<c:if test="${true}">
								<p class="outer-link"><a href="${pageContext.request.contextPath}/orderByNonMemberPage">
									비회원으로 주문조회 하기
								</a></p>
							</c:if> --%>
<%-- 						<c:if test="${not empty sentByOrderRequest}">
								<p class="outer-link"><a onclick="goToOrderPageOfNonMember()">
									비회원으로 주문결제 하기
								</a></p>
							</c:if> --%>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- End Account Login Area -->

	<jsp:include page="../footer.jsp"></jsp:include>

	<!-- ========================= scroll-top ========================= -->
	<a href="#" class="scroll-top"> <i class="lni lni-chevron-up"></i>
	</a>

	<!-- ========================= JS here ========================= -->
	<script src="/resources/assets/user/js/bootstrap.min.js"></script>
	<script src="/resources/assets/user/js/tiny-slider.js"></script>
	<script src="/resources/assets/user/js/glightbox.min.js"></script>
	<script src="/resources/assets/user/js/main.js"></script>
	<script>
		window.addEventListener('load', function() {
			let sentByOrderRequest = null
			$.ajax({
				async: false,
				type: "GET",
				url: "/order/sessionState",
				dataType: "json",
				success : function(res) {
					sentByOrderRequest = res.sentByOrderRequest
				},
				error : function(request, status, error) {
					console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);       
				}
			})
			console.log("sentByOrderRequest : " + sentByOrderRequest)
			const params = new URLSearchParams(window.location.search);
			console.log(params)
			console.log(params.get('goToOrder'))
			if (params.get('goToOrder') == "True") {
				let tags = `<p class="outer-link">
					<a onclick="goToOrderPageOfNonMember()">비회원으로 주문결제 하기
				</a></p>`
				$("#nonMemberFunction").after(tags)
			} else {
				let tags = `<p class="outer-link">
					<a href="${pageContext.request.contextPath}/orderByNonMemberPage">비회원으로 주문조회 하기
				</a></p>`
				$("#nonMemberFunction").after(tags)
			}
		})
	
		function goToOrderPageOfNonMember() {
			  $.ajax({
				  async : false,
				  type : 'POST',
				  url : "/order/session",
				  data: {
					  requestByNonMember: "True"
				  },
				  dataType: "json",
				  success : function(res) {
					  console.log(res)
				  },
			      error : function(request, status, error) {
					  console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);       
				  }
			  })
			location.href = "${pageContext.request.contextPath}/order" // GET 요청
		}
	</script>
</body>

</html>
