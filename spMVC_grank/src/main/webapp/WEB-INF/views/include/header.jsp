<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="include.jsp"%>
<%
	String uri = request.getParameter("uri");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
	<div id="header">
		<img id="home-img" style="float: left;" width="150px"
			src="${path}/resources/images/ranklogo.png">
		<div class="dropdown">
			<button id="game-btn">Game</button>
			<ul id="game-dropdown">
				<li><a href="${path}/game/comingsoonmoreview">Commingsoon</a></li>
				<li><a href="${path}/game/rankmoreview">All</a></li>
				<li><a href="${path}/game/rankmoreview?platform=PS4">PS4</a></li>
				<li><a href="${path}/game/rankmoreview?platform=XONE">XBOX</a></li>
				<li><a href="${path}/game/rankmoreview?platform=Switch">SWITCH</a></li>
				<li><a href="${path}/game/rankmoreview?platform=PC">PC</a></li>
			</ul>
			<input type="hidden" id="href-id" value="all"/>
			<button id="community-btn">Community</button>
		</div>
		<c:choose>
			<c:when test="${!empty sessionScope.name}">
				<div class="member-nav">
					<a class="a-member a-button" id="logout-btn">로그아웃</a> 
					<a class="a-member a-button" id="mypage-btn">마이페이지</a>
				</div>
			</c:when>
			<c:otherwise>
				<div class="member-nav">
					<a class="a-member a-button" id="join-btn">회원가입</a> 
					<a class="a-member a-button" id="login-btn">로그인</a>
				</div>
			</c:otherwise>
		
		</c:choose>
	</div>

	<i class="fas fa-arrow-circle-up" id="top-btn"></i>
	<%@ include file="login-modal.jsp"%>
	<%@ include file="delete-modal.jsp"%>
	<script>
	
		$(function() {
			// 로고 클릭시
			$('#home-img').click(function() {
				location.href = '${path}/'
			})
			// 검색박스 클릭시
			$('.s-box-button').click(function() {
				$('.s-box-input').toggleClass('inclicked');
				$('.s-box-button').toggleClass('close');
				$('#s-box-search').val('');
			})
			// Community버튼 클릭시
			$('#community-btn').click(function() {
				location.href = "${path}/board/list"
			})
			// 게임버튼클릭시 드랍다운메뉴
			$('#game-btn').click(function() {
				$('#game-dropdown').toggleClass('active')
			})
			// 윈도우를 스크롤하면 스크롤위치에따라 top버튼이 나왔다 사라짐
			$(window).scroll(function() {
				if ($(this).scrollTop() > 40) {
					$('#top-btn').fadeIn()
				} else {
					$('#top-btn').fadeOut()
				}
			})
			// 로그아웃 버튼 클릭시
			$('#logout-btn').click(function(){
				$.ajax({
					url:'${path}/member/logout',
					type:'GET',
					success:function(){
						location.reload();	
					}
				})
				
			})
			// 마이페이지 버튼 클릭시
			$('#mypage-btn').click(function() {
				location.href = "${path}/member/mypage"
			})
			// 탑버튼 클릭시 상단으로 이동 0.4초
			$('#top-btn').click(function() {
				$('html,body').animate({
					scrollTop : 0
				}, 400)
			})
			// 로그인버튼 클릭시 모달창 출력
			$('#login-btn').click(function() {
				$('#modal-login').css('display', 'block')
				$("#login-id").focus()
			})
			// 회원가입버튼 클릭시 이동
			$('#join-btn').click(function() {
				location.href = "${path}/member/join"
			})
			// 로그인 모달창에서 회원가입 클릭시 이동
			$('.login-join-btn').click(function() {
				location.href = "${path}/member/join"
			})
			// 로그인 모달창에서 아이디 찾기 클릭시 이동
			$('.login-idcheck').click(function() {
				location.href = "${path}/member/login_check?code=idcheck"
			})
			// 로그인 모달창에서 비밀번호 찾기 클릭시 이동
			$('.login-pscheck').click(function() {
				location.href = "${path}/member/login_check?code=pscheck"
			})
			// 모달창 닫기 클릭시 input태그의 값과 유효성검사 경고메세지 숨김
			$('.modal-close').click(function() {
				$('#modal-login').css('display', 'none')
				$('#login-id').val('');
				$('#login-pw').val('');
				$('.login-err-msg').css('visibility','hidden')
			})
			// 로그인모달창의 로그인버튼 클릭시
			$("#login-submit").click(function() {
				var uri = '${uri}'
				var id = $.trim($('#login-id').val())
				var pw = $.trim($('#login-pw').val())
				var check= true;
				// 공백문자
				var regEmpty = /\s/g;
				if (id.length == 0 || id == '') {
					$('.login-err-msg').text('아이디를 입력해주세요')
							.css('visibility', 'visible')
					return false;
				} else if (id.match(regEmpty)) {
					$('.login-err-msg').text('공백 없이 입력해주세요')
					.css('visibility', 'visible')
					return false;
				}
				if (pw.length == 0 || pw == '') {
					$('.login-err-msg').text('비밀번호를 입력해주세요')
							.css('visibility', 'visible')
					return false;
				} else if (pw.match(regEmpty)) {
					$('.login-err-msg').text('공백 없이 입력해주세요')
					.css('visibility', 'visible')
					return false;
				}
				$.ajax({
					url : '${path}/member/login',
					type : 'POST',
					async : true,
					dataType : 'text',
					data : 'userid=' + id + '&passwd=' + pw + '&check='+ check,
					success : function(data) {
						if (data == '1') {
							if(uri == ''){
								location.reload();
							} else{
								location.href=uri;
							}
						} else if (data == '-1') {
							$('#login-id').focus();
							$('.login-err-msg').text(
									'회원 아이디 또는 비밀번호가 일치하지 않습니다').css(
									'visibility', 'visible');
						} else {
							alert("Error")
						}
					},
					error : function() {
						alert("System Error")
					}
				})
			})
		
		})
	</script>