<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
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
						<h1 class="page-title">MyPage</h1>
					</div>
				</div>
				<div class="col-lg-6 col-md-6 col-12">
					<ul class="breadcrumb-nav">
						<li><a href="index.html"><i class="lni lni-home"></i>
								Home</a></li>
						<li><a href="javascript:void(0)">MyPage</a></li>
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
				<div class="col-lg-9 col-12" id="modiInfoView">
					<main class="right-pane">

						<h1>회원 탈퇴</h1>
						<c:if test="${empty sessionScope.auth}">
							<form class="row" action="/member/auth" method="post">
								<div class="auth">
									<div class="input-group">
										<span class="input-group-text">비밀번호</span> <input
											type="password" class="form-control" id="pwd" name="pwd">
									</div>
									<button class="btn" type="submit">확인</button>
								</div>
							</form>
						</c:if>
						<c:if test="${not empty sessionScope.auth}">
							<div>정말 탈퇴하시겠어요?</div>
							<div>탈퇴시 회원정보는 복구되지 않으며</div>
							<div>사용하지 않은 포인트, 쿠폰은 소멸됩니다.</div>
							<div class="form-group input-group">
								<input type="text" id="agree" name="agree" placeholder="회원탈퇴"><input
									type="hidden" value="">
							</div>
							<button id="button" class="btn btn-info" type="button"
								value="탈퇴하기">탈퇴하기</button>
						</c:if>
					</main>
					</main>
				</div>
				<!-- / contents -->

			</div>
		</div>
	</section>

	<jsp:include page="../footer.jsp"></jsp:include>
</body>
<script type="text/javascript">
	$(function() {
		$("#button").click(function() {
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