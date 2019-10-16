<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="include.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
<div id="header">
	<img id="home-img" style="float: left;" width="150px" src="${path}/resources/images/ranklogo.png">
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
	<div class="member-nav">
		<a class="a-member a-button" id="join-btn">회원가입</a> 
		<a class="a-member a-button" id="login-btn">로그인</a>
	</div>
</div>

<i class="fas fa-arrow-circle-up" id="top-btn"></i>
<%@ include file="login-modal.jsp" %>
<script>
	$(function(){
		$('#home-img').click(function(){
			location.href = '${path}/'
		})
	    $('.s-box-button').click(function(){
	        $('.s-box-input').toggleClass('inclicked')
	        $('.s-box-button').toggleClass('close')
	    })
	    $('#community-btn').click(function(){
	    	location.href="${path}/board/list"
	    })
	    $('#game-btn').click(function(){
	        $('#game-dropdown').toggleClass('active')
	    })
	    $(window).scroll(function(){
	        if($(this).scrollTop() > 40){
	            $('#top-btn').fadeIn()
	        } else{
	            $('#top-btn').fadeOut()
	        }
	    })
	    $('#top-btn').click(function(){
	        $('html,body').animate({
	            scrollTop:0
	        },400)
	    })
	    $('#login-btn').click(function(){
            $('#modal-login').css('display','block')
        })
        $('#join-btn').click(function(){
        	location.href="${path}/member/join"
        })
        $('.modal-close').click(function(){
        	$('#modal-login').css('display','none')
        })
        $("#login-submit").click(function(){
            var id = $.trim($('#login-id').val())
            if(id.length==0||id==''){
                $('#login-id').next().next().text('아이디를 입력해주세요').css('visibility','visible')
            }
        })
	})
</script>
