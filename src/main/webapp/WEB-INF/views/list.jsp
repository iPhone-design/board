<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 목록</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script type="text/javascript">

	function list(num){
		$("#curPage").val(num);
		$("#searchBtn").click();
	}

	$(function () {
		$("#allChk").click(function () {
			if ($("#allChk").is(":checked")) {
				$(".chk").prop("checked", true);
			} else {
				$(".chk").prop("checked", false);
			}
		})
		
		$(".chk").click(function () {
			var checkbox = $(".chk").length;
			var checked = $(".chk:checked").length;
			
			if (checkbox == checked) {
				$("#allChk").prop("checked", true);
			} else {
				$("#allChk").prop("checked", false);
			}
		})
		
		
		$("#deleteBtn").click(function () {
			if ($(".chk").is(":checked")) {
				$("#listFrm").attr("action", "delete").attr("method", "post").submit();
			} else {
				alert("하나라도 체크 하세요");
			}
		})
		
		$("#searchBtn").click(function () {
			$("#search").attr("action", "list").attr("method", "post").submit();
			
			$.ajax({

			    url: "list", // 클라이언트가 요청을 보낼 서버의 URL 주소
			    data: { name: "홍길동" },                // HTTP 요청과 함께 서버로 보낼 데이터
			    type: "POST",                             // HTTP 요청 방식(GET, POST)
			    dataType: "json"                         // 서버에서 보내줄 데이터의 타입

			})
		})
		
		$("#choose").val('${dataMap.choose}');
		$("#searchTxt").val('${dataMap.searchTxt}');
		$("#cal2").val('${dataMap.cal2}');
		$("#cal1").val('${dataMap.cal1}');
		
		$.datepicker.setDefaults({
             dateFormat: 'yy-mm-dd' //Input Display Format 변경
             ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
             ,showMonthAfterYear: true //년도 먼저 나오고, 뒤에 월 표시
             ,changeYear: true //콤보박스에서 년 선택 가능
             ,changeMonth: true //콤보박스에서 월 선택 가능                
             ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
             ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
             ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
             ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
             ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
             ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
             ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
             ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
             ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
             ,minDate: "-1Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
             ,maxDate: "+1Y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)                    
         });
		
		$("#cal1").datepicker();
		$("#cal2").datepicker();
		
// 		$('#cal1').datepicker('setDate', '-1D'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
//    	$('#cal2').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
	})
</script>
</head>
<body>
	<div>
		<form name="search" id="search">
			<input type="button" name="btn" id="btn" value="글쓰기" onclick="location.href='write'">
			<input type="button" name="deleteBtn" id="deleteBtn" value="삭제">
			<input type = "hidden" name="curPage" id="curPage" value = "1">
			<input type = "hidden" name="pageScale" id="pageScale" value = "10">
			<select name="choose" id="choose">
				<option value="">선택</option>
				<option value="name">작성자</option>
				<option value="subject">제목</option>
				<option value="subCont">제목 + 내용</option>
			</select>
			<input type="text" name="searchTxt" id="searchTxt" size="30">
			<input type="button" name="searchBtn" id="searchBtn" value="검색"><br>
			<input type="text" name="cal1" id="cal1"> ~ <input type="text" name="cal2" id="cal2">
			<input type="button" name="canBtn" id="canBtn" value="취소" onclick="location.href='/list'">
		</form>
	</div>
	<form name="listFrm" id="listFrm">
		<table border="1px">
			<tr>
				<th><input type="checkbox" name="allChk" id="allChk"></th>
				<th>순서</th>
				<th>이름(id)</th>
				<th>주제</th>
				<th>내용</th>
				<th>입력날짜</th>
				<th>수정날짜</th>
				<th>방문수</th>
			</tr>
			<tr>
				<c:forEach items="${list}" var="i" varStatus="num">
					<tr>
						<td><input type="checkbox" class="chk" name="chk" id="chk${num.index}" value="${i.seq}"></td>
						<td>${i.seq}</td>
						<td>${i.memName}(${i.memId})</td>
						<td><a href="detail?seq=${i.seq}">${i.boardSubject}</a></td>
						<td>${i.boardContent}</td>
						<td>${i.regDate}</td>
						<td>${i.uptDate}</td>
						<td>${i.viewCnt}</td>
					</tr>
				</c:forEach>
			</tr>
			<tr>
				<td colspan="8">
					 <!-- **처음페이지로 이동 : 현재 페이지가 1보다 크면  [처음]하이퍼링크를 화면에 출력-->
	                <c:if test="${pageMap.curBlock > 1}">
	                    <a href="javascript:list('1')">[처음]</a>
	                </c:if>
	                
	                <!-- **이전페이지 블록으로 이동 : 현재 페이지 블럭이 1보다 크면 [이전]하이퍼링크를 화면에 출력 -->
	                <c:if test="${pageMap.curBlock > 1}">
	                    <a href="javascript:list('${pageMap.prevPage}')">[이전]</a>
	                </c:if>
	                <!-- **하나의 블럭에서 반복문 수행 시작페이지부터 끝페이지까지 -->
	                <c:forEach var="num" begin="${pageMap.blockBegin}" end="${pageMap.blockEnd}">
	                    <!-- **현재페이지이면 하이퍼링크 제거 -->
	                    <c:choose>
	                        <c:when test="${num == pageMap.curPage}">
	                            <span style="color: red">${num}</span>&nbsp;
	                        </c:when>
	                        <c:otherwise>
	                            <a href="javascript:list('${num}')">${num}</a>&nbsp;
	                        </c:otherwise>
	                    </c:choose>
	                </c:forEach>
	                
	                <!-- **다음페이지 블록으로 이동 : 현재 페이지 블럭이 전체 페이지 블럭보다 작거나 같으면 [다음]하이퍼링크를 화면에 출력 -->
	                <c:if test="${pageMap.curBlock <= pageMap.totBlock}">
	                    <a href="javascript:list('${pageMap.nextPage}')">[다음]</a>
	                </c:if>
	                
	                <!-- **끝페이지로 이동 : 현재 페이지가 전체 페이지보다 작거나 같으면 [끝]하이퍼링크를 화면에 출력 -->
	                <c:if test="${pageMap.curPage <= pageMap.totPage}">
	                    <a href="javascript:list('${pageMap.totPage}')">[끝]</a>
	                </c:if>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>