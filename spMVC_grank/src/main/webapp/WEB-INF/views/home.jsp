<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="include/include.jsp" %>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/searchbox.css?ver=20191106">
<link rel="stylesheet" type="text/css" href="${path}/resources/css/gcard.css?ver=20191106">
<link rel="stylesheet" type="text/css" href="${path}/resources/css/board-list.css?ver=20191106">
<%@ include file="include/header.jsp" %>
<div style="height: 110px;"></div>
	<!-- 검색기능 box -->
	<div class="s-box-comment">버튼을 클릭해 게임을 검색해주세요.</div>
    <div class="s-box-wrapper">
        <div class="middle s-box">
            <form class="search-box">
                <input autocomplete="off" type="text" id="s-box-search" class="s-box-input s-box">
                <button class="s-box-button s-box" type="button"></button>
            </form>
        </div>
        <div id="search-result">
        </div> 
    </div>
    <!-- 출시 예정작 -->
	 <div class="wrapper">
        <div class="wrapper-header"><span class="header-text">출시예정작</span></div>
        <div id="g-list">
            <div class="flex-wrapper">
            	<c:forEach items="${cList}" var="c">
                <div class="g-card">
                	<c:if test="${c.platform == 'PS4' }">
	                    <div class="g-card-item g-card-header PS4-color">${c.platform}</div>
                    </c:if>
                   	<c:if test="${c.platform == 'XONE' }">
    	                <div class="g-card-item g-card-header XONE-color">${c.platform}</div>
                    </c:if>
                   	<c:if test="${c.platform == 'PC' }">
        	            <div class="g-card-item g-card-header PC-color">${c.platform}</div>
                    </c:if>
                   	<c:if test="${c.platform == 'Switch' }">
            	        <div class="g-card-item g-card-header switch-color">${c.platform}</div>
                    </c:if>
                    <div class="g-card-item"><img src="${c.c_img}"></div>
                    <div class="g-card-item g-card-content game-name">${c.c_name}</div>
                    <div class="g-card-item g-card-content">${c.c_date}</div>
                </div>
                </c:forEach>
                <div class="more"><a class="a-button a-common" href="${path}/game/comingsoonmoreview">more+</a></div>
            </div>
        </div>
    </div>
    <!-- 게임평가 순위 -->
    <div class="g-wrapper">
        <div class="wrapper-header"><span class="header-text">게임평가 순위</span></div>
            <ul class="home-game-nav">
                <li><span class="platform"  id="PS4"><input class="input" type="hidden" value="PS4">PS4</span></li>
                <li><span class="platform"  id="XONE"><input class="input" type="hidden" value="XONE">XONE</span></li>
                <li><span class="platform" id="Switch"><input class="input" type="hidden" value="Switch" >SWITCH</span></li>
               <li><span class="platform" id="PC"><input class="input" type="hidden" value="PC" >PC</span></li>
            </ul>
        <div>
            <div class="flex-item item1">
     			<div id="gameranklist" class="gameranklist">
     			</div>
            </div>
            <div class="g-more"><a class="a-button a-common" href ="${path}/game/rankmoreview">more+</a></div>
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
 		var p_color = $(this).attr('id');
 		
 		if(platform == 'PS4'){
			$('#PS4').css('color', 'white').css('background-color', '#4834d4').css('font-weight', 'bold').css('font-size', '20px');
		}else{
			$('#PS4').css('color', '').css('background', '').css('font-weight', '').css('font-size', '');
		}
		if(platform == 'XONE'){
			$('#XONE').css('color', 'white').css('background-color', '#6ab04c').css('font-weight', 'bold').css('font-size', '20px');
		}else{
			$('#XONE').css('color', '').css('background', '').css('font-weight', '').css('font-size', '');
		}
		if(platform == 'Switch'){
			$('#Switch').css('color', 'white').css('background-color', '#eb4d4b').css('font-weight', 'bold').css('font-size', '20px');
		}else{
			$('#Switch').css('color', '').css('background', '').css('font-weight', '').css('font-size', '');
		}
		if(platform == 'PC'){
			$('#PC').css('color', 'white').css('background-color', '#130f40').css('font-weight', 'bold').css('font-size', '20px');
		}else{
			$('#PC').css('color', '').css('background', '').css('font-weight', '').css('font-size', '');
		}
		
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
 	// 게임 검색결과를담은 jsp를 search-result에 담는 함수 생성 
 	function search_list(){
 		var keyword = $.trim($('#s-box-search').val());
 		$.ajax({
 			url:'${path}/game/search?keyword='+keyword,
 			type:'GET',
 			success:function(page){
 				$('#search-result').html(page);
 			}
 		})
 	}
	// 페이지가 준비되면 메소드 호출
	$(document).ready(function(){
		gameranklist();
	})
	// 검색박스 클릭시
	$('.s-box-button').click(function() {
		$('.s-box-input').toggleClass('inclicked');
		$('.s-box-button').toggleClass('close');
		$('#s-box-search').val('');
	})
	// search-box에 글자를 입력하면
	$(document).on('keyup','#s-box-search',function(evt){
		evt.preventDefault();
		var keyword = $.trim($('#s-box-search').val());
		// s-box-search input태그의 값 길이가 3이상일때 검색 결과 리스트 출력
		if(keyword.length >= 3){
			search_list();	
		} else{ // 2이하일때는 리스트 출력x
			$('#search-result').html('');
		}
	})
	// search-box에 포커스 되면
	$(document).on('focus','#s-box-search',function(){
		var keyword = $.trim($('#s-box-search').val());
		// s-box-search input태그의 값 길이가 3이상일때
		if(keyword.length >= 3){
			search_list();	
		}
	})
	// search-box의 x버튼 누를경우
	$(document).on('click','.s-box-button',function(){
		// ajax로 띄어준 작은 페이지 없애기
		$('#search-result').html('');
	})
	// s-box 클래스영역 밖을 클릭할 시
	$(document).on('click',function(evt){
		if(!$(evt.target).hasClass('s-box')){
			$('#search-result').html('');
		}
	})
    $(document).on('click', '#g_img', function(){
    	let game_code = $(this).attr("data-code");
		location.href = '${path}/game/gameview?game_code='+game_code;
	})
	$(document).on('click','.view-one',function(){
		var bno = $(this).attr('data-seq');
		location.href = '${path}/board/view?bno='+bno;
	})
	
</script>