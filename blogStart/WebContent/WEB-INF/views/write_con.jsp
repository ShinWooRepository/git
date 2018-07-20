<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Writing</title>
</head>
<body>
	<input type="text" name="subject" placeholder="제목" value="${dto.subject}" disabled="disabled"/><br/>
	<input type="text" name="name" placeholder="성명" value="${dto.name}" disabled="disabled"/><br/>
	<textarea name="content" placeholder="본문" rows="15" disabled="disabled">${dto.content}</textarea><br/>
	<img src="${pageContext.request.contextPath}/resources/img/${dto.img}" width="200" height="200">
</body>
</html>