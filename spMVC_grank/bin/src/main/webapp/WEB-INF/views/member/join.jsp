<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/include.jsp" %>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/join.css?ver=20191014">
<%@ include file="../include/header.jsp" %>
<div style="height: 110px;"></div>
	<form method="POST" id ="frm_mem">
	    <div class="container">
	        <h2>회원가입</h2>
	        <div class="input-field">
	            <input id="join-id" type="text" name="userid" required="">
	            <label for="">아이디</label>
	            <span class="join-err-msg">공백없이 입력해주세요</span>
	            <span></span>
	        </div>
	        <div class="input-field">
	            <input type="text" name="passwd" required="">
	            <label for="">비밀번호</label>
	            <span class="join-err-msg">공백없이 입력해주세요</span>
	            <span></span>
	        </div>
	         <div class="input-field">
	            <input type="text" name="" required="">
	            <label for="">비밀번호 확인</label>
	            <span class="join-err-msg">공백없이 입력해주세요</span>
	            <span></span>
	        </div>
	         <div class="input-field">
	            <input type="text" name="name" required="">
	            <label for="">닉네임</label>
	            <span class="join-err-msg">공백없이 입력해주세요</span>
	            <span></span>
	        </div>
	        <div class="input-field">
	            <input type="text" name="phone" required="">
	            <label for="">전화번호</label>
	            <span class="join-err-msg">공백없이 입력해주세요</span>
	            <span></span>
	        </div>
	        <div class="input-field">
	            <input type="text" name="email" required="">
	            <label for="">이메일</label>
	            <span class="join-err-msg">공백없이 입력해주세요</span>
	            <span></span>
	        </div>
	        <div class="button-address">
	        	<input type="button" id="addr_btn" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
	        </div>
	        <div class="input-address">
	        	<input type="text" class="addr_mem" id="sample6_postcode" name="zipcode" readonly="readonly" required="">
	        	<label>우편번호</label>
	        	<span></span>
	        </div>
	        <div class="input-address">
				<input type="text" class="addr_mem" id="sample6_address" name="addr1" readonly="readonly" required="">
				<label>주소</label>
				<span></span>
			</div>
			<div class="input-address">
				<input type="text" required=""  name="addr2" id="sample6_detailAddress">
				<label>상세주소</label>
				<span></span>
			</div>
				<input type="hidden" id="sample6_extraAddress"  placeholder="참고항목">
	        <input type="submit" value="회원가입" name="" class="btn">
	    </div>
	</form>
<%@ include file="../include/footer.jsp" %>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="${path}/resources/js/daumpost.js"></script>
<script>
$(function() {
	$('.btn').click(function() {
		$('#frm_mem').submit();
	})
	
	$('.addr_mem').click(function() {
		var zipcode = $('.addr_mem').eq(0).val();
		var addr = $('.addr_mem').eq(1).val();
		if(zipcode == "" || addr == "") {
			$('#addr_btn').click();
		}
		
	})
})

</script>
