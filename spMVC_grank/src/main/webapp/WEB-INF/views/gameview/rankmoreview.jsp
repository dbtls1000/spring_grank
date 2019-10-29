<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fnt"%>
<%@ include file="../include/include.jsp"%>
<link rel="stylesheet" type="text/css"
	href="${path}/resources/css/gcard.css?ver=20191029">
<%@ include file="../include/header.jsp"%>
<div class="wrapper">
	<div class="wrapper-header">
		<span class="header-text">게임평가 순위</span>
	</div>
	<div class="flex-game">
		<ul class="game-nav">
			<li class="platform" id="All">ALL</li>
			<li class="platform" id="PS4">PS4</li>
			<li class="platform" id="XONE">XBOX</li>
			<li class="platform" id="Switch">SWITCH</li>
			<li class="platform" id="PC">PC</li>
		</ul>
		<input id="platform-id" type="hidden" value="All">
	</div>
	<div id="rankmoreviewlist"></div>
	<div class="more" id="more-btn">
		<a class="rankmoreviewlist a-button a-common">More+</a>
	</div>
	<input type="hidden" id="limit-count" value="20">
</div>
<script>
	// rankmoreviewlist 생성
	function rankmoreviewlist() { //function start
		var platform = '${platform}';
		$('#platform-id').val(platform);
		$.ajax({ // ajax start
			url : '${path}/game/rankmoreviewlist?platform='+platform,
			type : 'GET',
			success : function(page) {
				$('#rankmoreviewlist').html(page);
			},
			error : function() {
				alert('System error');
			}
		}) // ajax start
	} // function end
	
	// 페이지가 로딩이 되면
	$(document).ready(function() {  // function start 
		rankmoreviewlist();
	}) // function end
	
	// 클릭 시 20개식 list 보여줌
	$(document).on('click', '.rankmoreviewlist', function() { // function start
		// more 클릭시 더해줄 카운트 수
		var count = Number($("#limit-count").val());
		// input tag hidden에 담겨진 값을 platform 변수에 담음
		var platform = $('#platform-id').val();
		// size값
		var max = $('#gsize').val();
		count += 20;

		// count 값이 max 값을 초과하면 count에 max값을 넣어주고 more 버튼이 없어짐
		if (count > max) { // if start
			count = max;
			$('#more-btn').hide();
		} // if end 
		// count값을 담아야 +count 값이 됨
		$('#limit-count').val(count);

		$.ajax({ // ajax start
			url : '${path}/game/rankmoreviewlist?count=' + count +'&platform=' + platform,
			type : 'GET',
			success : function(page) {
				$('#rankmoreviewlist').html(page);
			},
			error : function() {
				alert('system error!');
			}
		}) // ajax end 
	}) // function end

	// platform 클릭 시 해당 플랫폼별로 게임을 보여줌 
	$(document).on('click', '.platform', function() { // function start
		// 해당하는 platform id 값을 불러옴
		var platform = $(this).attr('id');
		// 불러온 id값을 input tag에 넣어줌
		$('#platform-id').val(platform);
		$('#limit-count').val('20');
		$('#more-btn').show();
		$.ajax({  // ajax start
			url : '${path}/game/rankmoreviewlist?platform=' + platform,
			type : 'GET',
			success : function(page) {
				$('#rankmoreviewlist').html(page);
			},
			error : function() {
				alert('system error');
			} 
		})// ajax end
	})// function end
</script>
<%@ include file="../include/footer.jsp"%>