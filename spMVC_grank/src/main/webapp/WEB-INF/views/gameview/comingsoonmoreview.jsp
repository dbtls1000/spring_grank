<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fnt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" type="text/css" href="${path}/resources/css/gcard.css?ver=20191112">
<%@ include file="../include/header.jsp"%>
<!-- 출시 예정작 -->
<div class="wrapper">
	<div class="wrapper-header">
		<span class="header-text">출시예정작</span>
	</div>
	<div id="comingsoonmoreviewlist">
	</div>
	<div class="more">
		<a class="comingsoonmerviewlist a-button a-common">More+</a>
	</div>
	<input type="hidden" id="limit-cnt" value="20">
</div>

<script>
	// Ajax로 페이지 생성
	function comingsoonmoreviewlist() {
		$.ajax({
			url : '${path}/game/comingsoonmoreviewlist',
			type : 'GET',
			success : function(page) {
				$('#comingsoonmoreviewlist').html(page);
			},
			error : function() {
				alert('system error!');
			}
		})
	}
	$(document).on('click', '.comingsoonmerviewlist', function() {
		// cnt 값 가져옴
		var cnt = Number($('#limit-cnt').val());
		// cSize 값
		var max = ${cSize};
		cnt += 20;
		// cnt가 csize보다 커지면 cnt = max;  max 일 때 cnt가 size를 초과하면 cnt에 size를 넣어줌
		if(cnt > max){
			cnt = max;
			// 버튼제거
			$('.comingsoonmerviewlist').remove();
		}
		$('#limit-cnt').val(cnt)
		// comingsoonmoreviewlist페이를 만듦
		$.ajax({
			url : '${path}/game/comingsoonmoreviewlist?count='+cnt,
			type : 'GET',
			success : function(page) {
				$('#comingsoonmoreviewlist').html(page);
			},
			error : function() {
				alert('system error!')
			}
		})
	})
	// 페이지가 준비되면 comingsoonmoreviewlist를 뿌려줌
	$(document).ready(function() {
		comingsoonmoreviewlist();
	})
</script>
<%@ include file="../include/footer.jsp"%>