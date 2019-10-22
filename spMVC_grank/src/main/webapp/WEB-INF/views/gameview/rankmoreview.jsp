<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fnt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<style>
.c-cards{
	display:flex;
	
}
.c-cards a{
	text-decoration:none;
	color:black;
}
.game-nav{
	display: flex;
	width:900px;
	justify-content: space-between;	
}
.game-nav li{
	list-style:none;
	cursor: pointer;
}
</style>
<%@ include file="../include/header.jsp" %>
	   <div class="wrapper">
        <div class="wrapper-header"><span class="header-text">게임평가 순위</span></div>
            <div class="flex-game">
                <ul class="game-nav">
                    <li class="platform"><input class="input" type="hidden" value="ALL">ALL</li>
                    <li class="platform"><input class="input" type="hidden" value="PS4">PS4</li>
                    <li class="platform"><input class="input" type="hidden" value="XONE">XBOX</li>
                    <li class="platform"><input class="input" type="hidden" value="Switch">SWITCH</li>
                    <li class="platform"><input class="input" type="hidden" value="PC">PC</li>
                </ul>
            </div>
		    <div id="rankmoreviewlist"></div>
		    <div>
		    <div id="platformlist"></div>
				<a class="rankmoreviewlist a-button a-common">more<i class="fas fa-plus"></i></a>
			</div>
		    <input type="hidden" id="limit-count" value="20">
		</div>
<script>
	// rankmoreviewlist 생성
	function rankmoreviewlist() {
		$.ajax({
			url : '${path}/game/rankmoreviewlist',
			type : 'GET',
			success : function(page) {
				$('#rankmoreviewlist').html(page);
			},
			error : function() {
				alert('system error');
			}
		})
	}
	
	// 클릭 시 20개씩 list 보여줌
	$(document).on('click', '.rankmoreviewlist' ,function(){
		var count = Number($("#limit-count").val());
		var max = ${gSize};
		count += 20;
		
		if(count > max){
			count = max;
			$('.rankmoreviewlist').remove();
		}
		$('#limit-count').val(count);
		
		$.ajax({
			url : '${path}/game/rankmoreviewlist?count='+count,
			type : 'GET',
			success : function(page) {
				$('#rankmoreviewlist').html(page);
			},
			error : function() {
				alert('system error!');
			}
		})
	})
	
	$(document).ready(function(){
		rankmoreviewlist();
	})
	
	$(document).on('click', '.platform', function(){
		var platform =$(this).children('input').val();
 		$.ajax({
			url : '${path}/game/rankmoreview?platform'+platform,
			type : 'GET',
			success:function(page){
				$('#rankmoreviewlist').html(page);
			},
			error:function(){
				alert('system error');
			}
		})
 	})
</script>
<%@ include file="../include/footer.jsp" %>