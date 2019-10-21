<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="include.jsp"%>
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
				<li><a href="#">PS4</a></li>
				<li><a href="#">XBOX</a></li>
				<li><a href="#">SWITCH</a></li>
				<li><a href="#">PC</a></li>
			</ul>
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
			$('#home-img').click(function() {
				location.href = '${path}/'
			})
			$('.s-box-button').click(function() {
				$('.s-box-input').toggleClass('inclicked')
				$('.s-box-button').toggleClass('close')
			})
			$('#community-btn').click(function() {
				location.href = "${path}/board/list"
			})
			$('#game-btn').click(function() {
				$('#game-dropdown').toggleClass('active')
			})
			$(window).scroll(function() {
				if ($(this).scrollTop() > 40) {
					$('#top-btn').fadeIn()
				} else {
					$('#top-btn').fadeOut()
				}
			})
			$('#logout-btn').click(function(){
				location.href = "${path}/member/logout"
			})
			$('#mypage-btn').click(function() {
				location.href = "${path}/member/mypage?userid=${sessionScope.userid}"
			})
			$('#top-btn').click(function() {
				$('html,body').animate({
					scrollTop : 0
				}, 400)
			})
			$('#login-btn').click(function() {
				$('#modal-login').css('display', 'block')
			})
			$('#join-btn').click(function() {
				location.href = "${path}/member/join"
			})
			$('.modal-close').click(function() {
				$('#modal-login').css('display', 'none')
				$('#login-id').val('');
				$('#login-pw').val('');
				$('.err-msg').css('visibility','hidden')
			})
			$("#login-submit").click(
					function() {
						var id = $.trim($('#login-id').val())
						var pw = $.trim($('#login-pw').val())
						if (id.length == 0 || id == '') {
							$('#login-id').next().next().text('아이디를 입력해주세요')
									.css('visibility', 'visible')
							return false;
						}
						if (pw.length == 0 || pw == '') {
							$('#login-pw').next().next().text('비밀번호를 입력해주세요')
									.css('visibility', 'visible')
							return false;
						}
						$.ajax({
							url : '${path}/member/login',
							type : 'POST',
							async : true,
							dataType : 'text',
							data : 'userid=' + id + '&passwd=' + pw,
							success : function(data) {
								if (data == '1') {
									location.reload();
								} else if (data == '-1') {
									$('#login-id').focus();
									$('.err-msg').text(
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