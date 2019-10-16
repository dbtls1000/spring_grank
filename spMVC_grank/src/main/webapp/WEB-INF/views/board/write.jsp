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
			<form id="frm_board" method="POST">
				<div class="title-input">
					<label class="title-label" for="">머리글</label> <select
						class="title-in title-select" name="b_platform" id="">
						<option value="PS4">PS4</option>
						<option value="XBox">XBox</option>
						<option value="SWITCH">SWITCH</option>
						<option value="PC">PC</option>
					</select>
				</div>
				<div class="title-input">
					<label class="title-label" for="">제목</label> <input
						class="title-in title-title-input" name="b_title" type="text">
				</div>
				<div>
					<textarea id="title-text" class="title-text" cols="30" rows="10" name="b_content"></textarea>
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
						<a class="a-button a-common" id="board-write-btn">등록</a> <a class="a-button a-common"
							id="cancel-btn">취소</a>
					</div>
				</div>
			</form>
		</div>
	</div>
<%@ include file="../include/footer.jsp"%>
<script>
	$(function(){
		$('#board-write-btn').click(function(){
			oEditors.getById["title-text"].exec("UPDATE_CONTENTS_FIELD", []);
			var content = $('#title-text').val();
			var regEmpty = /\s/g;
			var text = content.replace(/[<][^>]*[>]/gi,"");
			alert(text)
			
			$('#board-write-btn').action = '${path}/board/write'
			
			$('#frm_board').submit()
			
		})
	})
</script>