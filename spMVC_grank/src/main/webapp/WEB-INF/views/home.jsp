<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="include/include.jsp" %>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/searchbox.css?ver=2019101811">
<%@ include file="include/header.jsp" %>
<div style="height: 110px;"></div>
	<!-- 검색기능 box -->
    <div class="s-box-wrapper">
        <div class="middle">
            <form class="search-box">
                <input type="text" class="s-box-input">
                <button class="s-box-button" type="button"></button>
            </form>
        </div>
    </div>
    <!-- 출시 예정작 -->
    <div class="wrapper">
        <div class="wrapper-header"><span class="header-text">출시예정작</span></div>
        	<article class="flex-wrapper">
	        	<c:forEach items="${cList}" var="c">
			        <div class="c-cards">
            			<a class="c-card" href="#">
                		<span class="card-header" >
                		<img src='${c.c_img}'>
                    	<span class="card-title">
                        <h3>${c.c_name}</h3>
                    </span>
		                </span>
		                <span class="card-summary">
		                        ${c.platform}
		                </span>
		                <span class="card-meta">
		                        ${c.c_date}
		                </span>
            			</a>
            		</div>
					</c:forEach>
		    </article>
		      <div class="right"><span class="more"><a href="#">more..</a></span></div>
	    </div>

    <!-- 게임평가 순위 -->
    <div class="wrapper">
        <div class="wrapper-header"><span class="header-text">게임평가 순위</span></div>
        <div class="flex-wrapper">
            <div class="flex-item item1">
     			<div id="gameranklist" class="gameranklist">
     			</div>
                <div class="right"><span class="more">더 보기</span></div>
            </div>
            <div class="flex-item item2">
                <ul>
                    <li class="platform"><input class="input" type="hidden" value="PS4">PS4</li>
                    <li class="platform"><input class="input" type="hidden" value="XONE">XBOX</li>
                    <li class="platform"><input class="input" type="hidden" value="Switch">SWITCH</li>
                    <li class="platform"><input class="input" type="hidden" value="PC">PC</li>
                </ul>
            </div>
        </div>
    </div>
    <!-- 오늘의 화제글 -->
    <div class="wrapper">
        <div class="wrapper-header"><span class="header-text">오늘의 화제글</span></div>
    </div>
<%@ include file="include/footer.jsp" %>
<script>
	
 	// 게임순위 리스트 띄워주는 Ajax메소드 생성
 	$(document).on('click','.platform',function(){
 		var platform = $(this).children('input').val();
		$.ajax({
			url:'${path}/grank?platform='+platform,
			type:'GET',
			success:function(page){
				$('#gameranklist').html(page);
			},
			error:function(){
				alert('error')
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
</script>