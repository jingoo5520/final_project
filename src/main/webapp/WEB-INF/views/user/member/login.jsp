<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<style type="text/css">
.body {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 50vh; /* 화면 전체 높이 */
	margin: 0; /* 기본 여백 제거 */
	background-color: white; /* 배경색 설정 */
}

.loginContainer {
	background: white; /* 배경색 설정 */
	padding: 20px 50px 20px 50px; /* 안쪽 여백 */
	/* border-radius: 10px; /* 둥근 모서리 */ */
	/* box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); /* 그림자 효과 */ */
}

input {
	display: block; /* 입력 요소를 블록으로 설정 */
	margin-bottom: 10px; /* 아래쪽 여백 */
	width: 90%; /* 너비 100% */
	padding: 10px; /* 안쪽 여백 */
	border: 1px solid #ccc; /* 테두리 */
	border-radius: 5px; /* 둥근 모서리 */
}

button {
	width: 100%; /* 버튼 너비 100% */
	padding: 10px; /* 안쪽 여백 */
	border: none; /* 기본 테두리 제거 */
	border-radius: 5px; /* 둥근 모서리 */
	background-color: #007bff; /* 버튼 배경색 */
	color: white; /* 글자 색 */
	cursor: pointer; /* 포인터 커서 */
}

button:hover {
	background-color: #0056b3; /* 버튼 호버 색상 */
}
</style>
</head>

<body>

	<jsp:include page="../header.jsp"></jsp:include>
	<div class="body">
		<form action="/member/login" method="post">
			<div class="loginContainer">
				<h1>로그인</h1>
				<div>
					id<input type="text" name="member_id" id="member_id"
						placeholder="id를 입력">
				</div>
				<div>
					pwd<input type="password" name="member_pwd" id="member_pwd"
						placeholder="pwd를 입력">
				</div>
				<div>
					<button type="submit">로그인</button>
				</div>
			</div>
		</form>
	</div>

	<jsp:include page="../footer.jsp"></jsp:include>
	<script src="/resources/assets/user/js/main.js"></script>
</body>

</html>
