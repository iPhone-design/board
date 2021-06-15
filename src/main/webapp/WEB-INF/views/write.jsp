<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 쓰기</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function () {
		$("#reg").click(function () {
			$("#frm").attr("action", "insert").attr("method", "post").submit();
		})
		
		$("#updateRow").click(function () {
			$("#frm").attr("action", "updateRow").attr("method", "post").submit();
		})
	})
</script>
</head>
<body>
	<form name="frm" id="frm">
		작성자 : <input type="text" name="writer" id="writer" value="${rowList.memName}"><br>
		ID : <input type="text" name="id" id="id" value="${rowList.memId}"><br>
		제목 : <input type="text" name="title" id="title" value="${rowList.boardSubject}"><br>
		내용 :<br>
		<textarea name="text" id="text" rows="10" cols="30">${rowList.boardContent}</textarea><br>
		<div>
			<c:if test="${empty rowList}">
				<input type="button" name="reg" id="reg" value="등록">
			</c:if>
			<c:if test="${not empty rowList}">
				<input type="button" name="updateRow" id="updateRow" value="수정">
				<input type="hidden" name="seq" id="seq" value="${rowList.seq}">
			</c:if>
			<input type="button" name="cancle" id="cancle" value="취소" onclick="history.go(-1)">
		</div>
	</form>
</body>
</html>