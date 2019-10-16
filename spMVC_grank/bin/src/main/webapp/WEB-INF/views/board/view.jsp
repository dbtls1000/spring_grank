<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/include.jsp"%>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/board-view.css?ver=20191015">
	<%@ include file="../include/header.jsp"%>
	<div class="wrapper">
		<div class="wrapper-header">
			<span class="header-text">상세 게시글</span>
		</div>
		<div id="view_an_btn">
			<a class="a-button a-common">이전글</a> <a class="a-button a-common">다음글</a>
		</div>
		<table class="board-view">
			<colgroup>
				<col width="200" />
				<col width="500" />
			</colgroup>
			<tr class="view_writer">
				<th colspan="2">상세게시글 제목입니다</th>
				<th>우가우가몬</th>
				<th>2019-09-27</th>
			</tr>
			<tr>
				<td class="view_content" colspan="4" style="height: 100px;"><p
						style="text-align: left;">
						내용내용<br>내용내용<br>내용내용<br>내용내용<br>내용내용<br>내용내용<br>내용내용<br>내용내용<br>내용내용<br>내용내용<br>내용내용<br>내용내용<br>내용내용<br>내용내용<br>내용내용<br>내용내용<br>
					</p></td>
			</tr>
		</table>
		<div class="view_button">
			<ul>
				<li><a class="a-button a-common">목록</a></li>
				<li><a class="a-button a-common">답변</a></li>
				<li><a class="a-button a-common">수정</a></li>
				<li><a class="a-button a-delete">삭제</a></li>
			</ul>
		</div>
		<!-- 댓글 -->
		<div class="wrapper-reply" id="commnetlist">
			<div class="wrapper-header"><span class="header-text">댓글</span></div>
			
		</div>
	</div>
	<%@ include file="../include/footer.jsp"%>
