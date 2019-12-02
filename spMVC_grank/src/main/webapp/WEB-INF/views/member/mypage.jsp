<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/include.jsp"%>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/mypage.css?ver=2019101703">
<link rel="stylesheet" type="text/css" href="${path}/resources/css/board-list.css?ver=20191113">
<link rel="stylesheet" type="text/css" href="${path}/resources/css/gcard.css?ver=20191113">
<%@ include file="../include/header.jsp"%>

<div class="wrapper">
	<div class="wrapper-header">
		<span class="header-text">마이 페이지</span>
	</div>
	<div class="member_header">
        <h2>회원 정보</h2>
        <p>${mDto.userid}님의 회원정보입니다. <br>회원정보는 개인정보처리방침에 따라 안전하게 보호되며, 회원님의 명백한 동의 없이 공개 또는 제 3자에게 제공되지 않습니다.</p>
    </div>
	<table class="member_table">
        <tr>
            <th class="member_my">
                <div class="member_thcell"><span>사용자 이름</span></div>
            </th>
            <td class="member_my">
                <div class="member_div">${mDto.name}</div>
            </td>
        </tr>
         <tr>
            <th class="member_my">
                <div class="member_thcell"><span>전화번호</span></div>
            </th>
            <td class="member_my">
                <div>${mDto.phone}</div>
            </td>
        </tr>
        <tr>
            <th class="member_my">
                <div class="member_thcell"><span>주소</span></div>
            </th>
            <td class="member_my">
                <div>${mDto.addr1} ${mDto.addr2}</div>
            </td>
        </tr>
        <tr>
            <th class="member_my member_bottom">
                <div class="member_thcell"><span>이메일</span></div>
            </th>
            <td class="member_my member_bottom">
                <div>${mDto.email}</div>
            </td>
        </tr>
	</table>
	<div class="member_button">
		<a class="a-button a-common" id="member_up">회원수정</a>
		<a class="a-button a-common" id="member_password">비밀번호 변경</a>
		<a class="a-button a-delete" id="member_de">회원 탈퇴</a>
	</div>
</div>
<div class="wrapper">
	<div class="wrapper-header"><span class="header-text">작성한 게시글</span></div>
	<table class="board-list">
		<tr>
			<th class="recordNum">No.</th>
			<th class="board-platform">구분</th>
			<th class="board-title">제목</th>
			<th class="board-file">첨부파일</th>
			<th class="board-writer">작정사</th>
			<th class="board-regdate">작성일자</th>
			<th class="board-viewcnt">조회수</th>
		</tr>
		<c:forEach items="${bList}" var='list'>
			<jsp:useBean id="now" class="java.util.Date"/>
			<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today"/>
			<fmt:formatDate value="${list.b_regdate}" pattern="yyyy-MM-dd" var="regdate"/>
			<tr>
				<td class="board-content center">${list.bno}</td>
				<td class="board-content center">[${list.b_platform}]</td>
				<td class="board-content title"><a data-seq="${list.bno}" class="view-one" style="cursor:pointer">[${list.b_platform}] ${list.b_title}
					<c:if test="${list.b_replycnt > 0}"> 
					(${list.b_replycnt})
					</c:if>
					<c:if test="${today == regdate}">
						<span id="board-new">New</span>
					</c:if>
				</a>
				</td>
				<td class="board-content center">
					<c:choose>
						<c:when test="${list.fcount > 0}">
							<i class="far fa-file"></i>
						</c:when>
						<c:otherwise>
							<i class="fas fa-times"></i>
						</c:otherwise>
					</c:choose>
				</td>
				<td class="board-content center">${list.b_writer}</td>
				<td class="board-content center">
					<c:choose>
						<c:when test="${today == regdate}">
							<fmt:formatDate value="${list.b_regdate}" pattern="HH:mm:ss"/>
						</c:when>
						<c:otherwise>
							${regdate}
						</c:otherwise>
					</c:choose>
				</td>
				<td class="board-content center">${list.b_viewcnt}</td>
			</tr>
		</c:forEach>
	</table>
	<ul class="pagination">
		<c:if test="${page.curBlock > 1}">
			<li><a href="${path}/member/mypage?curPage=1&userid=${sessionScope.userid}"><i class="fas fa-angle-double-left"></i></a></li>
			<li><a href="${path}/member/mypage?curPage=${page.blockBegin -10}&userid=${sessionScope.userid}"><i class="fas fa-angle-left"></i></a></li>
		</c:if>
		<c:forEach begin="${page.blockBegin}" end="${page.blockEnd}" var="idx">
			<li><a <c:out value="${page.curPage == idx ? 'class=active' : '' }"/>  href="${path}/member/mypage?curPage=${idx}&userid=${sessionScope.userid}" >${idx}</a></li>
		</c:forEach>
		<c:if test="${page.curBlock < page.totalBlock}">
			<li><a href="${path}/member/mypage?curPage=${page.blockEnd+1}&userid=${sessionScope.userid}"><i class="fas fa-angle-right"></i></a></li>
			<li><a href="${path}/member/mypage?curPage=${page.totalPage}&userid=${sessionScope.userid}"><i class="fas fa-angle-double-right"></i></a></li>
		</c:if>
	</ul>
</div>
<div class="wrapper">
	<div class="wrapper-header"><span class="header-text">즐겨찾기한 게임</span></div>
	<div class="flex-wrapper">
	<c:forEach items="${mgList}" var="g">
		<div id="gSize"></div>
		<div class="g-card" data-code="${g.game_code}">
			<c:if test="${g.platform == 'Switch'}">				
			<div class="g-card-item g-card-header switch-color">${g.platform}</div>
			</c:if>
			<c:if test="${g.platform == 'PC'}">				
			<div class="g-card-item g-card-header PC-color">${g.platform}</div>
			</c:if>
			<c:if test="${g.platform == 'PS4'}">				
			<div class="g-card-item g-card-header PS4-color">${g.platform}</div>
			</c:if>
			<c:if test="${g.platform == 'XONE'}">				
			<div class="g-card-item g-card-header XONE-color">${g.platform}</div>
			</c:if>
			<div class="g-card-item">
				<img src="${g.img_src}">
			</div>
			<div class="g-card-item g-card-content game-name"> 게임명 : ${g.game_name}</div>
			<div class="g-card-item g-card-content">전문가 평점:&nbsp;<span class='c-score'>${g.m_score}</span></div>
			<div class="g-card-item g-card-content">유저 평점:&nbsp;<span class="u-score">${g.u_score}</span></div>
		    <c:choose>
				<c:when test="${g.tot_score <= 70}">
					<c:if test="${g.tot_score >= 30}">
						<div class="g-card-item g-card-content">Grank:&nbsp;<span class="middle-score">A</span></div>
					</c:if>
	`				<c:if test="${g.tot_score < 30}">
						<div class="g-card-item g-card-content">Grank:&nbsp;<span class="low-score">B</span></div>
					</c:if>
				</c:when>
				<c:otherwise>
					<div class="g-card-item g-card-content">Grank:&nbsp;<span class="high-score">S</span></div>
				</c:otherwise>
			</c:choose>
		</div>
	</c:forEach>
</div>
</div>
<%@ include file="../include/footer.jsp" %>
<script>
$(function() {
	$('#member_up').click(function() {
		location.href="${path}/member/update";
	})
	$('#member_de').click(function() {
		location.href="${path}/member/member_delete";
	})
	$('#member_password').click(function() {
		location.href="${path}/member/member_password";
	})
	$('.view-one').click(function(){
		var bno = $(this).attr('data-seq');
		location.href="${path}/board/view?bno="+bno;
	})
})
</script>