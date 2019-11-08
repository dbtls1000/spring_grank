<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/include.jsp" %>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/join.css?ver=20191031">
<%@ include file="../include/header.jsp" %>
<c:choose>
	<c:when test="${mDto.userid == null}">
		<c:if test="${sessionScope.userid != null}">
			<script>
				alert("로그아웃 후 사용해주세요");
				location.href="${path}/";
			</script>
		</c:if>
	</c:when>
	<c:otherwise>
		<c:if test="${sessionScope.userid == null}">
			<script>
				alert("로그인 후 사용해주세요.");
				location.href="${path}/";
			</script>
		</c:if>
	</c:otherwise>
</c:choose>
	<div class="join-wrapper">
        <div class="join-wrapper-header"><span class="join-header-text">회원가입</span></div>
        <div class="join-wrapper-content">
            <form method="POST" id="frm_mem">
                <div class="member_hidden">
	                <div class="join-label">
	                    <span>아이디</span>
	                </div>
	                <div class="input-field">
	                    <input autocomplete="off" class="join-input" id="join-id" type="text" name="userid" >
	                	<div class="join-err">
	                		<span></span>
	                	</div>
	                </div>
                </div>
                <div class="member_hidden">
	                <div class="join-label">
	                    <span>비밀번호</span>
	                </div>
	                <div class="input-field">
	                    <input class="join-input" id="join-ps" type="password" name="passwd" >
	                	<div class="join-err">
	                		<span></span>
	                	</div>
	                </div>
                </div>
                <div class="member_hidden">
	                <div class="join-label">
	                    <span>비밀번호확인</span>
	                </div>
	                <div class="input-field">
	                    <input class="join-input"  id="join-rps" type="password" name="" >
	                	<div class="join-err">
	                		<span></span>
	                	</div>
	                </div>
                </div>
                <div class="join-label">
                    <span>닉네임</span>
                </div>
                <div class="input-field">
                    <input autocomplete="off" class="join-input" id="join-name" type="text" name="name"  value="${mDto.name}">
                	<div class="join-err">
	                		<span></span>
	                	</div>
                </div>
                <div class="join-label">
                    <span>전화번호</span>
                </div>
                <div class="input-field">
                    <input autocomplete="off" class="join-input" id="join-phone" type="text" name="phone"   value="${mDto.phone}">
                	<div class="join-err">
	                		<span></span>
	                	</div>
                </div>
                <div class="join-label">
                    <span>이메일</span>
                </div>
                <div class="input-field">
                    <input autocomplete="off" class="join-input" id="join-email" type="text" name="email"  value="${mDto.email}">
                	<div class="join-err">
	                		<span></span>
	                	</div>
                </div>
                <div class="join-address">
                    <input class="address-btn" type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
                </div>
                <div style="display: flex;">
                	<div>
                		<div class="join-label"><span>우편번호</span></div>
                	<input class="address" type="text" name="zipcode" readonly="readonly" id="sample6_postcode" value="${mDto.zipcode}">
                	</div>
                	<div>
                		<div class="join-label"><span>주소</span></div>
                	<input class="address" type="text" name="addr1" readonly="readonly" id="sample6_address" value="${mDto.addr1}">
                	</div>
                </div>
                <div class="join-label">
                    <span>상세주소</span>
                </div>
                <div class="input-field">
                    <input autocomplete="off" class="join-input" name="addr2" type="text" id="sample6_detailAddress" value="${mDto.addr2}">
                	<div class="join-err">
	                		<span></span>
	                	</div>
                </div>
                <input type="hidden" id="sample6_extraAddress" placeholder="참고항목">
                <input id="join-join-btn" type="button" value="회원가입">
            </form>
        </div>
    </div>
<%@ include file="../include/footer.jsp" %>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="${path}/resources/js/daumpost.js"></script>
<script type="text/javascript" src="${path}/resources/js/validation.js?ver=20191108"></script>
<script>
$(function() {
	var id = '${sessionScope.userid}';
	$('.join-input').focus(function(){
        $(this).parent().css('border','1px solid #00b894')
    })
    $('.join-input').blur(function(){
        $(this).parent().css('border','solid 1px #dadada')
    })
    // 회원 가입 및 수정
    var join_id = false;
	var join_ps = false;
	var join_rps = false;
	var join_name = false;
	var join_phone = false;
	var join_email = false;
	var join_addr = false;
	// 유효성 검사 false이면 false인곳으로 focus이동 true이면 통과
	$('#join-join-btn').click(function() {
		if(!join_id) {
			$('#join-id').focus();
			$('#join-id').next().css("display","block").css('color','crimson');
			return false;
		} else if(!join_ps) {
			$('#join-ps').focus();
			$('#join-ps').next().css("display","block").css('color','crimson');
			return false;
		} else if(!join_rps) {
			$('#join_rps').focus();
			$('#join_rps').next().css("display","block").css('color','crimson');
			return false;
		} else if(!join_name) {
			$('#join_name').focus();
			$('#join_name').next().css("display","block").css('color','crimson');
			return false;
		} else if(!join_phone) {
			$('#join_phone').focus();
			$('#join_phone').next().css("display","block").css('color','crimson');
			return false;
		} else if(!join_email) {
			$('#join_email').focus();
			$('#join_email').next().css("display","block").css('color','crimson');
			return false;
		} else if(!join_addr) {
			$('#join_addr').focus();
			$('#join_addr').next().css("display","block").css('color','crimson');
			return false;
		}
		if(id != '') {
			// id가 있으면 회원 수정
			$('#frm_mem').action="${path}/member/update";
		} else {
			// id가 없으면 회원 가입
			$('#frm_mem').action="${path}/member/join";
		}
		$('#frm_mem').submit();
	})
	// 우편번호와 주소 클릭시 우편번호 찾기 클릭
	$('.address').click(function() {
		var zipcode = $('.address').eq(0).val();
		var addr = $('.address').eq(1).val();
		if(zipcode == "" || addr == "") {
			$('.address-btn').click();
		}
	})
	// id 값이 있으면 css변경과 유효성 검사 true로 변경
	if(id != '') {
		$('.member_hidden').remove();
		$('.join-header-text').text('회원정보수정')
		$('#join-join-btn').val("회원수정")
		join_id = true;
		join_ps = true;
		join_rps = true;
		join_name = true;
		join_phone = true;
		join_email = true;
		join_addr = true;
	}
	// 아이디 유효성 체크
    $('#join-id').blur(function() {
		var memid = $.trim($(this).val());
		// memid 값으로 joinValidate의 checkId로 유효성 검사 후 맞는 resultCode 담기
		var checkResult = joinValidate.checkId(memid);
		// checkResult.code에 맞는 메시지 출력
		if(checkResult.code != 0) {
			$(this).next().text(checkResult.desc).css("display","block").css('color','crimson');
		} else {
			// ajax로 ID 중복 체크
			if(ajaxIdCheck(memid)) {
				join_id = true;
				return true;
			}
		}
		join_id = false;
		return false;
	})
	// 비밀번호 유효성 체크
	$('#join-ps').blur(function() {
		var pass = $.trim($(this).val());
		// pass와 값으로 joinValidate의 checkPs로 유효성 검사 후 맞는 resultCode 담기
		var checkResult = joinValidate.checkPs(pass);
		// checkResult.code에 맞는 메시지 출력
		if(checkResult.code != 0) {
			$(this).next().text(checkResult.desc).css("display","block").css('color','crimson');
		} else {
			$('#join-ps').next().text(checkResult.desc).css("display","block").css('color','blue');
			$('#join-rps').next().css("display","none");
			$('#join-rps').focus();
			
			join_ps = true;
			join_rps =false;
			return true;
		}
		join_ps = false;
		return false;
	})
	// 비밀번호 확인 유효성 체크
	$('#join-rps').blur(function() {
		var rpass = $.trim($(this).val());
		var pass = $.trim($('#join-ps').val());
		// rpass와 pass 값으로 joinValidate의 checkRps로 유효성 검사 후 맞는 resultCode 담기
		var checkResult = joinValidate.checkRps(rpass, pass);
		// checkResult.code에 맞는 메시지 출력
		if(checkResult.code != 0) {
			$(this).next().text(checkResult.desc).css("display","block").css('color','crimson');
		} else {
			$('#join-ps').next().text(checkResult.desc).css("display","none");
			$(this).next().text(checkResult.desc).css("display","block").css('color','blue');
			join_rps = true;
			return true;
		}
		join_ps = false;
		join_rps = false;
		return false;
	})
	// 닉네임 유효성 체크
	$('#join-name').blur(function() {
		var name = $.trim($(this).val());
		// name 값으로 joinValidate의 checkName로 유효성 검사 후 맞는 resultCode 담기
		var checkResult = joinValidate.checkName(name);
		// checkResult.code에 맞는 메시지 출력
		if(checkResult.code != 0) {
			$(this).next().text(checkResult.desc).css("display","block").css('color','crimson');
		} else {
			// 닉네임 중복 체크
			if(ajaxNameCheck(name)) {
				join_name = true;
				return true;
			}
		}
		join_name = false;
		return false;
	})
	// 전화번호 유효성 체크
	$('#join-phone').blur(function() {
		var phone = $.trim($(this).val());
		// phone 값으로 joinValidate의 checkPhone로 유효성 검사 후 맞는 resultCode 담기
		var checkResult = joinValidate.checkPhone(phone);
		// checkResult.code에 맞는 메시지 출력
		if(checkResult.code != 0) {
			$(this).next().text(checkResult.desc).css("display","block").css('color','crimson');
		} else {
			$(this).next().text(checkResult.desc).css("display","block").css('color','blue');
			join_phone = true;
			return true;
		}
		join_phone = false;
		return false;
	})
	// 이메일 유효성 체크
	$('#join-email').blur(function() {
		var email = $.trim($(this).val());
		// email 값으로 joinValidate의 checkEmail로 유효성 검사 후 맞는 resultCode 담기
		var checkResult = joinValidate.checkEmail(email);
		state = ajaxEmailOverlapCheck(email);
		// checkResult.code에 맞는 메시지 출력
		if(checkResult.code != 0) {
			$(this).next().text(checkResult.desc).css("display","block").css('color','crimson');
			join_email = false;
		} else if(state) {
			$(this).next().text('이미 사용중인 이메일입니다.').css("display","block").css('color','crimson');
			join_email = false;
		} else{
			$(this).next().text(checkResult.desc).css("display","block").css('color','blue');
			join_email = true;
			return true;
		}
		join_email = false;
		return false;
	})
	// 상세주소 유효성 체크
	$('#sample6_detailAddress').blur(function() {
		var addr = $.trim($(this).val());
		// addr 값으로 joinValidate의 checkAddr로 유효성 검사 후 맞는 resultCode 담기
		var checkResult = joinValidate.checkAddr(addr);
		// checkResult.code에 맞는 메시지 출력
		if(checkResult.code != 0) {
			$(this).next().text(checkResult.desc).css("display","block").css('color','crimson');
		} else {
			$(this).next().text(checkResult.desc).css("display","block").css('color','blue');
			// 주소가 공백이 아닐때
			if($('#sample6_address').val() != "") {
				join_addr = true;
				return true;
			// 주소가 공백일때
			} else {
				$('#sample6_detailAddress').next().text('주소를 입력해주세요.').css('color','crimson');
				join_addr = false;
				return false;
			}
		}
		join_addr = false;
		return false;
	})
	window.onpageshow = function(event){
		if(event.persisted || (window.performance && window.performance.navigation.type == 2)){
			location.reload();
		}
	}
})
</script>
