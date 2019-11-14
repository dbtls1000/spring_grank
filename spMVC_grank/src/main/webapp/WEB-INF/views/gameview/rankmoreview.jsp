<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fnt"%>
<%@ include file="../include/include.jsp"%>
<link rel="stylesheet" type="text/css"
	href="${path}/resources/css/gcard.css?ver=20191114">
<%@ include file="../include/header.jsp"%>
<div class="wrapper">
	<div class="wrapper-header">
		<span class="header-text">게임평가 순위</span>
	</div>
	<div class="flex-game">
		<ul class="game-nav">
			<li class="platform" id="All">ALL</li>
			<li class="platform" id="PS4">PS4</li>
			<li class="platform" id="XONE">XONE</li>
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
		var count = Number($("#limit-count").val());
		
		$('#platform-id').val(platform);
		$.ajax({ // ajax start
			url : '${path}/game/rankmoreviewlist?platform=' + platform,
			type : 'GET',
			success : function(page) {
				$('#rankmoreviewlist').html(page);
			},
			error : function() {
				alert('System error');
			}
		}) // ajax start
		platform_color(platform);
	} // function end
	
	
	
	// 클릭 시 20개식 list 보여줌
	$(document).on('click',	'.rankmoreviewlist', function() { // function start
		// more 클릭시 더해줄 카운트 수
		var count = Number($("#limit-count").val());
		// input tag hidden에 담겨진 값을 platform 변수에 담음
		var platform = $('#platform-id').val();
		// rankmorerviewlist.jsp에서 가져온 size값
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
			url : '${path}/game/rankmoreviewlist?count=' + count + '&platform=' + platform,
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
		platform_color(platform);
		// 불러온 id값을 input tag에 넣어줌
		$('#platform-id').val(platform);
		$('#limit-count').val('20');
		$('#more-btn').show();
		$.ajax({ // ajax start
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

	$(window).scroll(function() {
		var height = $(document).scrollTop();
	});

	$(document).ready(function() {
		// 문서가 로드 될 때마다 hash 체크
		checkForHash();
		// click 이벤트를 걸어 이벤트가 발생할 때마다 현제 페이지를 내부링크처럼 hash에 저장
		$(document).on('click', ".g-card", function() {
			// 쿼리스트링으로 따라다닐 값 
			var platform = $('#platform-id').val();
			var count = Number($("#limit-count").val());
			var height = $(document).scrollTop(); // 윈도우 스크롤에서 가지고 있는 값
			// 이 페이지에서 세개의 값을 ^로 구분해서 현제페이지정보에 마킹
			str_hash = platform + "^" + count + "^" + height;
			document.location.hash = "#" + str_hash;
		})
		// keydown이 발생했을때
		document.onkeydown = function(event) {
			// f5키 , ctrl + r 눌렀을때
			if((event.ctrlKey == true && event.keyCode == 82) || event.keyCode == 116) {
				var platform = $('#platform-id').val();
				var count = Number($("#limit-count").val());
				var height = $(document).scrollTop();
				str_hash = platform + "^" + count + "^" + height;
				document.location.hash = "#" + str_hash;
			}
			return document.location.hash;
		}
		 
		function checkForHash() {
			if (document.location.hash) {
				// hash가 있다면 ^ 를 구분자로하여 string을 추출하여 각각 페이지정보를 가져옴
				var str_hash = document.location.hash;
				str_hash = str_hash.replace("#", "");
				arr_hash = str_hash.split("^");
				var platform = arr_hash[0];
				var count = Number(arr_hash[1]);
	            var height = arr_hash[2];
	            // 뒤로가기 했을 때 나타날 현재 페이지
	           
				$.ajax({ // ajax start
					url : '${path}/game/rankmoreviewlist?count=' + count + '&platform=' + platform,
					type : 'GET',
					success : function(page) {
						$('#rankmoreviewlist').html(page);
						
					},
					error : function() {
						alert('system error!');
					}
				}) // ajax end 
					$('#limit-count').val(count);
	            	$('#platform-id').val(platform);
				// 현재 담겨있는 스크롤값으로 이동
		        	$('html,body').animate({
						scrollTop : height
					}, 15)
					
					// 플랫폼 값이 같으면 css 변경
					platform_color(platform);
					// #뒤에오는것 삭제
					history.replaceState({}, null, location.pathname);
			} else {// document.location.hash
				// rankmoreviewlist 페이지 생성
				rankmoreviewlist();	
			}
			
		}
	})
	
	// color 함수
	function platform_color(platform){
		if (platform == 'All') {
			$('#All').css('color', 'white').css('background-color',
					'#00b894').css('font-weight', 'bold').css(
					'font-size', '20px').css('border-radius', '5px').css('padding', '3px 5px');
			
		} else {
			$('#All').css('color', '').css('background', '').css(
					'font-weight', '').css('font-size', '').css('border-radius', '').css('padding', '');
		}
		if (platform == 'PS4') {
			$('#PS4').css('color', 'white').css('background-color',
					'#4834d4').css('font-weight', 'bold').css(
					'font-size', '20px').css('border-radius', '5px').css('padding', '3px 5px');
		} else {
			$('#PS4').css('color', '').css('background', '').css(
					'font-weight', '').css('font-size', '').css('border-radius', '').css('padding', '');
		}
		if (platform == 'XONE') {
			$('#XONE').css('color', 'white').css('background-color',
					'#6ab04c').css('font-weight', 'bold').css(
					'font-size', '20px').css('border-radius', '5px').css('padding', '3px 5px');
		} else {
			$('#XONE').css('color', '').css('background', '').css(
					'font-weight', '').css('font-size', '').css('border-radius', '').css('padding', '');
		}
		if (platform == 'Switch') {
			$('#Switch').css('color', 'white').css('background-color',
					'#eb4d4b').css('font-weight', 'bold').css(
					'font-size', '20px').css('border-radius', '5px').css('padding', '3px 5px');
		} else {
			$('#Switch').css('color', '').css('background', '').css(
					'font-weight', '').css('font-size', '').css('border-radius', '').css('padding', '');
		}
		if (platform == 'PC') {
			$('#PC').css('color', 'white').css('background-color',
					'#130f40').css('font-weight', 'bold').css(
					'font-size', '20px').css('border-radius', '5px').css('padding', '3px 5px');
		} else {
			$('#PC').css('color', '').css('background', '').css(
					'font-weight', '').css('font-size', '').css('border-radius', '').css('padding', '');
		}
	}
</script>
<%@ include file="../include/footer.jsp"%>