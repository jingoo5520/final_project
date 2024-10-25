<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Test Page</title>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<a href="${pageContext.request.contextPath}/test/auth""><h1>권한 테스트 페이지1</h1></a>
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>