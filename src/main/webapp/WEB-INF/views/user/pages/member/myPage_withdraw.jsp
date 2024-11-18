<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ELOLIA</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="shortcut icon" type="image/x-icon"
	href="/resources/assets/user/images/logo/favicon.png" />
<style>
</style>
</head>
<body>

	<!-- header -->
	<jsp:include page="../header.jsp"></jsp:include>
	<!-- / header -->
	<!-- Start Breadcrumbs -->
	<div class="breadcrumbs">
		<div class="container">
			<div class="row align-items-center">
				<div class="col-lg-6 col-md-6 col-12">
					<div class="breadcrumbs-content">
						<h1 class="page-title">회원탈퇴</h1>
					</div>
				</div>
				<div class="col-lg-6 col-md-6 col-12">
					<ul class="breadcrumb-nav">
						<li><a href="/"><i class="lni lni-home"></i> Home</a></li>
						<li><a href="/member/myPage/viewOrder">MyPage</a></li>
						<li>회원탈퇴</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<!-- End Breadcrumbs -->
	<section class="product-grids section">
		<div class="contentContainer container">
			<div class="row">
				<!-- sideBar -->
				<jsp:include page="../myPageSideBar.jsp">
					<jsp:param name="pageName" value="withdraw" />
				</jsp:include>
				<!-- / sideBar -->
				<!-- contents -->
				<div class="col-lg-9 col-12">
					<!-- Shopping Cart -->
					<div class="cart-list-head" style="border: none">
						<div class="cart-list-title">
							<div class="register-form">

								<c:if test="${empty sessionScope.auth}">
									<form class="row" action="/member/auth" method="post">
										<div class="col-sm-3"></div>
										<div class="col-sm-6">
											<div class="form-group">
												<div class="authBox">
													<h2 class="text-center authTitle">비밀번호 인증</h2>
													<input type="password" class="form-control" id="pwd"
														name="pwd">
													<div class="button">
														<button class="btn" type="submit">확인</button>
													</div>
												</div>
											</div>
										</div>
										<div class="col-sm-3"></div>
									</form>
								</c:if>
								<c:if test="${not empty sessionScope.auth}">
									<c:if test="${not empty sessionScope.auth}">
										<form class="row" id="form">
											<div class="col-sm-12">
												<div class="form-group">
													<label for="reg-id">
														<h2 class="text-center">정말 탈퇴하시겠어요?</h2>
														<div class="text-center">
															탈퇴시 회원정보는 복구되지 않으며 <br> 사용하지 않은 포인트, 쿠폰은 소멸됩니다.
														</div>
													</label> <input class="form-control" type="text" id="agree"
														name="agree" style="margin-bottom: 10px"
														placeholder="회원탈퇴"><span></span><input
														class="form-control" type="hidden" value="">
												</div>
											</div>
											<div class="button" id="button">
												<button class="btn" type="submit">탈퇴하기</button>
											</div>
										</form>
									</c:if>
								</c:if>

							</div>
						</div>
					</div>
				</div>
				<!-- / contents -->
			</div>
		</div>
	</section>

	<jsp:include page="../footer.jsp"></jsp:include>
</body>
<script type="text/javascript">
	$(function() {
		$("#button").click(function(e) {
			e.preventDefault(); // 기본 제출 동작 방지
			let agree = $("#agree").val();
			if (agree == "회원탈퇴") {
				$.ajax({
					url : "/member/withdraw",
					type : "POST",
					dataType : "json",
					success : function(data) {
						console.log(data);
						if (data.status == "success") {
							alert("탈퇴되었습니다.");
							withdraw(); // 로그아웃
						} else if (data.status == "fail") {
							alert("탈퇴실패");
						}
					},
					error : function() {
						console.log("통신 실패");
					},
					complete : function() {
					},
				});
			} else {
				alert("회원탈퇴를 입력하고 다시 시도하세요.");
			}
		});
	});
	function withdraw() {
		window.location.href = "/member/logout";
	}
</script>
</html>