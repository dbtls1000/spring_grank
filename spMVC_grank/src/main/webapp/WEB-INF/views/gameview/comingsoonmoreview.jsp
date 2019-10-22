<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fnt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%@ include file="../include/header.jsp"%>
<!-- 출시 예정작 -->
<div class="wrapper">
	<div class="wrapper-header">
		<span class="header-text">출시예정작</span>
	</div>
	<article class="flex-wrapper">
		<c:forEach items="${cList}" var="c">
			<div class="c-cards">
				<a class="c-card" href="#"> <span class="card-header"> <img
						src='${c.c_img}'> <span class="card-title">
							<h3>${c.c_name}</h3>
					</span>
				</span> <span class="card-summary"> ${c.platform} </span> <span
					class="card-meta"> ${c.c_date} </span>
				</a>
			</div>
		</c:forEach>
	</article>
	<div id="comingsoonmoreviewlist"></div>
	<div>
		<a class="comingsoonmerviewlist a-button a-common">more<i class="fas fa-plus"></i></a>
	</div>
	<input type="hidden" id="limit-cnt" value="20">
</div>

<script>
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
		// cnt가 csize보다 커지면 cnt = max;  max 906 일 때 cnt가 906값을 초과하면 cnt에 906을 넣어줌
		if(cnt > max){
			cnt = max;
			// cnt에 max값이 들어가면 버튼제거
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