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
		var i = 0;
		$("#reg").click(function () {
			$("#frm").attr("action", "insert").attr("method", "post").submit();
		})
		
		$("#updateRow").click(function () {
			$("#frm").attr("action", "updateRow").attr("method", "post").submit();
		})
		
		$(document).on("click", "#deleteBtn", function() {
			$("#div" + i).remove();
			i--;
		})
		
		$("#fileUpload").click(function () {
			if (i < 5) {
				i++;
				$("#upload").append("<div id='div" + i + "\'" + "> <input type='file' name='fileBtn" + i + "\'" +  " id='fileBtn" + i + "\'" + "accept='image/*' onchange='fileCheck(this)'>"
						+ " <input type='button' name='deleteBtn' id='deleteBtn' value='삭제'></div>");
			} else {
				alert("최대 5개만 업로드 가능");
			}
		})
	})
	
	function fileCheck(fileData) {
		var ext = $(fileData).val().split(".").pop().toLowerCase();
	    
	    if($.inArray(ext, ["gif","jpg","jpeg","png","bmp"]) == -1) {
	        alert("gif, jpg, jpeg, png, bmp 파일만 업로드 해주세요.");
	        $(fileData).val("");
	        return;
	    }
	    
// 	    var fileSize = fileData.files[0].size;
// 	    var maxSize = 1024 * 1024;
// 	    if(fileSize > maxSize) {
// 	        alert("파일용량을 초과하였습니다.");
// 	        return;
// 	    }
	    
	    var file  = fileData.files[0];
	    var _URL = window.URL || window.webkitURL;
	    var img = new Image();
	    
	    img.src = _URL.createObjectURL(file);
	    img.onload = function() {
	        if(img.width > 500 || img.height > 500) {
	            alert("이미지 가로 500px, 세로 500px로 맞춰서 올려주세요.");
	            $(fileData).val("");
	        } 
	    }
	}
</script>
</head>
<body>
	<form name="frm" id="frm" enctype="multipart/form-data">
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
			<c:choose>
				<c:when test="${empty fileList}">
					<input type="button" name="fileUpload" id="fileUpload" value="파일추가">
				</c:when>
				<c:otherwise>
					<div>
						<c:forEach items="${fileList}" var="file" varStatus="i">
							<img src="${pageContext.request.contextPath}/resources/image/${file.saveName}" width="300" height="200">
							<a href="downLoad?saveName=${file.saveName}&realName=${file.realName}">${file.realName}</a><br>
						</c:forEach>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
		<div id="upload">
		</div>
	</form>
</body>
</html>