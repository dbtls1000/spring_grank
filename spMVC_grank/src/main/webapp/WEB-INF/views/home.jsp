<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="include/include.jsp" %>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/searchbox.css?ver=20191024">
<link rel="stylesheet" type="text/css" href="${path}/resources/css/gcard.css?ver=20191024">
<link rel="stylesheet" type="text/css" href="${path}/resources/css/board-list.css?ver=20191024">
<%@ include file="include/header.jsp" %>
<div style="height: 110px;"></div>
	<!-- 검색기능 box -->
    <div class="s-box-wrapper">
        <div class="middle">
            <form class="search-box">
                <input type="text" id="s-box-search" class="s-box-input">
                <button class="s-box-button" type="button"></button>
            </form>
        </div>
    </div>
    <!-- 출시 예정작 -->
	 <div class="wrapper">
        <div class="wrapper-header"><span class="header-text">출시예정작</span></div>
        <div id="g-list">
            <div class="flex-wrapper">
            	<c:forEach items="${cList}" var="c">
                <div class="g-card">
                    <div class="g-card-item g-card-header">${c.platform}</div>
                    <div class="g-card-item"><img src="${c.c_img}"></div>
                    <div class="g-card-item g-card-content game-name">${c.c_name}</div>
                    <div class="g-card-item g-card-content">날짜 :  ${c.c_date}</div>
                </div>
                </c:forEach>
                <div class="more"><a class="a-button a-common" href="${path}/game/comingsoonmoreview">more+</a></div>
            </div>
        </div>
    </div>
    <!-- 게임평가 순위 -->
    <div class="wrapper">
        <div class="wrapper-header"><span class="header-text">게임평가 순위</span></div>
            <ul class="home-game-nav">
                <li><span class="platform"><input class="input" type="hidden" value="PS4">PS4</span></li>
                <li><span class="platform"><input class="input" type="hidden" value="XONE">XBOX</span></li>
                <li><span class="platform"><input class="input" type="hidden" value="Switch">SWITCH</span></li>
               <li><span class="platform"><input class="input" type="hidden" value="PC">PC</span></li>
            </ul>
        <div>
            <div class="flex-item item1">
     			<div id="gameranklist" class="gameranklist">
     			</div>
            </div>
            <div class="more"><a class="a-button a-common" href ="${path}/game/rankmoreview">more+</a></div>
        </div>
    </div>
    <!-- 오늘의 화제글 -->
    <div class="wrapper">
        <div class="wrapper-header"><span class="header-text">인기 게시글</span></div>
        <table class="board-list">
			<tr>
				<th class="recordNum">No.</th>
				<th class="board-title">제목</th>
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
					<td class="board-content title"><a data-seq="${list.bno}" class="view-one" style="cursor:pointer">[${list.b_platform}] ${list.b_title}
						<c:if test="${list.b_replycnt > 0}"> 
						(${list.b_replycnt})
						</c:if>
						<c:if test="${today == regdate}">
							<span id="board-new">New</span>
						</c:if>
					</a>
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
    </div>
<%@ include file="include/footer.jsp" %>
<script>
	
 	// 게임순위 리스트 띄워주는 Ajax메소드 생성
 	$(document).on('click','.platform',function(){
 		// 플랫폼별로 클릭했을 때 보여주기 위해 변수를 받아옴
 		var platform = $(this).children('input').val();
		$.ajax({
			url:'${path}/grank?platform='+platform,
			type:'GET',
			success:function(page){
				$('#gameranklist').html(page);
			},
			error:function(){
				alert('error');
			}
		})
 	})
 	
	function gameranklist(){
			$.ajax({
			url:'${path}/grank?platform=PS4',
			type:'GET',
			success:function(page){
				$('#gameranklist').html(page);
			}
		})
 	}
	// 페이지가 준비되면 메소드 호출
	$(document).ready(function(){
		gameranklist();
	})
	$(document).on('keypress','#s-box-search',function(evt){
		if(evt.keyCode == 13){
			evt.preventDefault();
			alert("게임을 검색하는 박스")
		}
	})
</script>