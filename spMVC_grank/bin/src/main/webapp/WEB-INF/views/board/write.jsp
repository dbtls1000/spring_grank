<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/include.jsp"%>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/board-write.css?ver=20191015">
	<%@ include file="../include/header.jsp"%>
	<div class="wrapper">
		<div class="wrapper-header">
			<span class="header-text">게시글 작성</span>
		</div>
		<div class="wrapper-body">
			<div class="title-input">
				<label class="title-label" for="">머리글</label> <select
					class="title-in title-select" name="" id="">
					<option value="">선택하세요</option>
					<option value="">PS4</option>
					<option value="">XBox</option>
					<option value="">SWITCH</option>
					<option value="">PC</option>
				</select>
			</div>
			<div class="title-input">
				<label class="title-label" for="">제목</label> <input
					class="title-in title-title-input" type="text">
			</div>
			<div>
				<textarea name="title-text" id="title-text" class="title-text"
					cols="30" rows="10">스마트에디터 적용할려다가 실패해서 포기</textarea>
				<script type="text/javascript" src="${path}/resources/smarteditor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
				<script type="text/javascript">
					var oEditors = [];
					nhn.husky.EZCreator.createInIFrame({
					 oAppRef: oEditors,
					 elPlaceHolder: "title-text",
					 sSkinURI: "${path}/resources/smarteditor/SmartEditor2Skin.html",
					 fCreator: "createSEditor2"
					});
				</script>
			</div>
			<div class="between title-file">
				<input type="file">
				<div class="btn">
					<a class="a-button a-common">등록</a> <a class="a-button a-common"
						id="cancel-btn">취소</a>
				</div>
			</div>
		</div>
	</div>
<%@ include file="../include/footer.jsp"%>