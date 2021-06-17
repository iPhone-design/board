<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<table id="table" border="1px">
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
