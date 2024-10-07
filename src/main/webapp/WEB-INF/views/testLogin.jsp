<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 테스트!!</title>
</head>
<body>
	<form action="/test/testLogin" method="post">
		<div>
			<h1>로그인 테스트</h1>
			id<input type="text" name="userId" id="userId" placeholder="id를 입력">
			pwd<input type="password" name="userPwd" id="userPwd"
				placeholder="pwd를 입력">
		</div>
	</form>
</body>
</html>
