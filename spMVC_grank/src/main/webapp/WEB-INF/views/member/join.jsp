<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/include.jsp" %>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/join.css?ver=2019101701">
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
	                    <input autocomplete="off" class="join-input" id="join-id" type="text" name="userid" required="">
	                </div>
                </div>
                <div class="member_hidden">
	                <div class="join-label">
	                    <span>비밀번호</span>
	                </div>
	                <div class="input-field">
	                    <input class="join-input" type="password" name="passwd" required="">
	                </div>
                </div>
                <div class="member_hidden">
	                <div class="join-label">
	                    <span>비밀번호확인</span>
	                </div>
	                <div class="input-field">
	                    <input class="join-input" type="password" name="" required="">
	                </div>
                </div>
                <div class="join-label">
                    <span>닉네임</span>
                </div>
                <div class="input-field">
                    <input autocomplete="off" class="join-input" type="text" name="name" required="" value="${mDto.name}">
                </div>
                <div class="join-label">
                    <span>전화번호</span>
                </div>
                <div class="input-field">
                    <input autocomplete="off" class="join-input" type="text" name="phone" required=""  value="${mDto.phone}">
                </div>
                <div class="join-label">
                    <span>이메일</span>
                </div>
                <div class="input-field">
                    <input autocomplete="off" class="join-input" type="text" name="email" required="" value="${mDto.email}">
                </div>
                <div class="join-address">
                    <input class="address-btn" type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
                </div>
                <input class="address" type="text" name="zipcode" readonly="readonly" id="sample6_postcode" placeholder="우편번호" value="${mDto.zipcode}">
                <input class="address" type="text" name="addr1" readonly="readonly" id="sample6_address" placeholder="주소" value="${mDto.addr1}">
                <div class="join-label">
                    <span>상세주소</span>
                </div>
                <div class="input-field">
                    <input autocomplete="off" class="join-input" name="addr2" type="text" id="sample6_detailAddress" value="${mDto.addr2}">
                </div>
                <input type="hidden" id="sample6_extraAddress" placeholder="참고항목">
                <input id="join-join-btn" type="button" value="회원가입">
            </form>
        </div>
    </div>
<%@ include file="../include/footer.jsp" %>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="${path}/resources/js/daumpost.js"></script>
<script>
$(function() {
	$('.join-input').focus(function(){
        $(this).parent().css('border','1px solid #00b894')
    })
    $('.join-input').blur(function(){
        $(this).parent().css('border','solid 1px #dadada')
    })
	
    var id = '${sessionScope.userid}';
	$('#join-join-btn').click(function() {
		if(id != '') {
			$('#frm_mem').action="${path}/member/update";
		} else {
			$('#frm_mem').action="${path}/member/join";
		}
		$('#frm_mem').submit();
	})
	
	$('.address').click(function() {
		var zipcode = $('.address').eq(0).val();
		var addr = $('.address').eq(1).val();
		if(zipcode == "" || addr == "") {
			$('.address-btn').click();
		}
	})
	if(id != '') {
		$('.member_hidden').remove();
		$('.join-header-text').text('회원정보수정')
		$('#join-join-btn').val("회원수정")
	}
})

</script>
