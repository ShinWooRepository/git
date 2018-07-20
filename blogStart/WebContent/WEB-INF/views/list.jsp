<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.js"></script>
<script>
	$(function(){
		$('#prev').css("color","gray")
		$('#prev').removeAttr("href")
		$('#next').css("color","gray")
		$('#next').removeAttr("href")
	});
</script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>list</title>
</head>
<body>
	<table>
		<tr>
			<td colspan="3" align="right"><input type="button" value="글 작성" onclick="location.href='/blogStart/write.do'"/></td>
		</tr>
		<tr>
			<th>제목</th>
			<th>이름</th>
			<th>작성일</th>
		</tr>
		<c:forEach var="li" items="${list}">
		<tr>
			<td><a href="/blogStart/write_con.do?pageNum=${currentPage}&list_num=${li.list_num}">${li.subject}</a></td>
			<td>${li.name}</td>
			<td>${li.regdate}</td>
		</tr>
		</c:forEach>
	</table>
	
	<!-- 페이징 처리 -->
	<c:if test="${total > 0}">
		<c:set var="pageCount" value="${total / pageSize + ( total % pageSize == 0 ? 0 : 1)}"/>
		<c:set var="pageBlock" value="10"/>
		<fmt:parseNumber var="result" value="${currentPage / 10}" integerOnly="true" />
		<c:set var="startPage" value="${result * 10 + 1}" />
		<c:set var="endPage" value="${startPage + pageBlock-1}"/>
		<c:if test="${endPage > pageCount}">
		<c:set var="endPage" value="${pageCount}"/>
		</c:if>

		<fmt:parseNumber var="start" value="${startPage}" integerOnly="true"/>
		<c:if test="${currentPage == start }">
			<a href="/blogStart/list.do?pageNum=${currentPage - 1 }" id="prev">[이전]</a>		
		</c:if>
		<c:if test="${currentPage != start }">
			<a href="/blogStart/list.do?pageNum=${currentPage - 1 }">[이전]</a>		
		</c:if>
		
		<c:forEach var="i" begin="${startPage}" end="${endPage}">
		<a href="/blogStart/list.do?pageNum=${i}">[${i}]</a>
		</c:forEach>
		
		<fmt:parseNumber var="end" value="${endPage}" integerOnly="true"/>
		<c:if test="${currentPage == end}">
			<a href="/blogStart/list.do?pageNum=${currentPage + 1}" id="next">[다음]</a>
		</c:if>
		<c:if test="${currentPage != end}">
			<a href="/blogStart/list.do?pageNum=${currentPage + 1}">[다음]</a>
		</c:if>
	</c:if>
</body>
</html>