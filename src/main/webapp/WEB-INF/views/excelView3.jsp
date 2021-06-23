<%@ page language="java" contentType="application/vnd.ms-excel; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	response.setHeader("Content-Disposition", "attachment;filename=" + new String(("downExcel").getBytes("KSC5601"), "8859_1") + ".xls");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>엑셀 다운로드</title>
<style type="text/css">
	.txt {
		mso-number-format:"\@" 
	}
	
	.date {
		mso-number-format:"yyyy\/mm\/dd";
	}
</style>
</head>
<body>
<table id="table" border="1px">
	<tr>
		<th>순서</th>
		<th>이름(id)</th>
		<th>주제</th>
		<th>내용</th>
		<th>입력날짜</th>
		<th>수정날짜</th>
		<th>방문수</th>
	</tr>
	<c:forEach items="${list}" var="i">
		<tr>
			<td>${i.seq}</td>
			<td class="txt">${i.memName}(${i.memId})</td>
			<td class="txt">${i.boardSubject}</td>
			<td class="txt">${i.boardContent}</td>
			<td class="date">${i.regDate}</td>
			<td class="date">${i.uptDate}</td>
			<td>${i.viewCnt}</td>
		</tr>
	</c:forEach>
</table>
</body>
</html>