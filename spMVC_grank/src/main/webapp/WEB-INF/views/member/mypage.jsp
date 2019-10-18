<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/include.jsp"%>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/mypage.css?ver=2019101703">
<%@ include file="../include/header.jsp"%>
<div class="wrapper">
	<div class="wrapper-header">
		<span class="header-text">마이 페이지</span>
	</div>
	<div class="member_header">
        <h2>회원 정보</h2>
        <p>${mDto.userid}님의 회원정보입니다. <br>회원정보는 개인정보처리방침에 따라 안전하게 보호되며, 회원님의 명백한 동의 없이 공개 또는 제 3자에게 제공되지 않습니다.</p>
    </div>
	<table class="member_table">
        <tr>
            <th class="member_my">
                <div class="member_thcell"><span>사용자 이름</span></div>
            </th>
            <td class="member_my">
                <div class="member_div">${mDto.name}</div>
            </td>
        </tr>
         <tr>
            <th class="member_my">
                <div class="member_thcell"><span>전화번호</span></div>
            </th>
            <td class="member_my">
                <div>${mDto.phone}</div>
            </td>
        </tr>
        <tr>
            <th class="member_my">
                <div class="member_thcell"><span>주소</span></div>
            </th>
            <td class="member_my">
                <div>${mDto.addr1} ${mDto.addr2}</div>
            </td>
        </tr>
        <tr>
            <th class="member_my member_bottom">
                <div class="member_thcell"><span>이메일</span></div>
            </th>
            <td class="member_my member_bottom">
                <div>${mDto.email}</div>
            </td>
        </tr>
	</table>
	<div class="member_button">
		<a class="a-button a-common" id="member_up">회원수정</a>
		<a class="a-button a-common" id="member_password">비밀번호 변경</a>
		<a class="a-button a-delete" id="member_de">회원 탈퇴</a>
	</div>
</div>
<%@ include file="../include/footer.jsp" %>
<script>
$(function() {
	$('#member_up').click(function() {
		location.href="${path}/member/update"
	})
	$('#member_de').click(function() {
		location.href="${path}/member/member_delete"
	})
	$('#member_password').click(function() {
		location.href="${path}/member/member_password"
	})
})
</script>