<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<form action="find_PW_change.do" method="POST" class="content">
		<div class="textbox">
			<input id="pw" name="pw" type="password"><label>새비밀번호</label>
			<div class="error">Invalid password</div>
		</div>
		<div class="textbox">
			<input id="pw2" type="password" onchange="isSame();"><label>새비밀번호
				확인</label>
			<div class="error">Invalid password</div>
		</div>
		<span id=same></span> <br>
		<br> <input type="submit" id="check" value="비밀번호변경"> <input
			type="hidden" name="email" value="${memEmail }">
	</form>
</body>
</html>
