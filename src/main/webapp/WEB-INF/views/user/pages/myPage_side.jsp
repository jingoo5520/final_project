<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	
<style>
body {
	font-family: Arial, sans-serif; /* 기본 글꼴 설정 */
	margin: 0; /* 기본 마진 제거 */
	padding: 0; /* 기본 패딩 제거 */
}

.contentContainer {
	display: flex; /* 플렉스 박스 레이아웃 활성화 */
	flex-direction: row; /* 자식 요소들을 수평으로 나열 */
	padding: 20px; /* 내부 여백 설정 */
}

.left-pane {
	width: 250px; /* 사이드바의 너비 설정 */
	background-color: #f4f4f4; /* 사이드바 배경색 설정 */
	padding: 20px; /* 사이드바 내부 여백 설정 */
	box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1); /* 사이드바에 그림자 효과 추가 */
}

.right-pane {
	flex-grow: 1; /* 남은 공간을 차지하도록 설정 */
	padding: 20px; /* 콘텐츠 영역 내부 여백 설정 */
}
</style>
</head>
<body>
	<div>
		<aside class="left-pane">
			<h2>마이페이지</h2>
			<ul>
				<h4>회원 정보</h4>
				<li><a
					href="${pageContext.request.contextPath}/member/myPage/modiInfo">회원
						정보 수정</a></li>
				<li><a href="${pageContext.request.contextPath}/member/myPage/modiPwd">비밀번호 변경</a></li>
				<li><a href="${pageContext.request.contextPath}/member/myPage/history">구매 내역</a></li>
				<li><a href="${pageContext.request.contextPath}/member/myPage/withdraw">회원 탈퇴</a></li>
				<h4>나의 활동</h4>
				<li><a href="">리뷰</a></li>
				<li><a href="#">찜</a></li>
				<li><a href="#">문의</a></li>
				<h4>나의 혜택</h4>
				<li><a href="#">보유 쿠폰</a></li>
				<li><a href="#">보유 포인트</a></li>
			</ul>
		</aside>
	</div>
</body>
</html>