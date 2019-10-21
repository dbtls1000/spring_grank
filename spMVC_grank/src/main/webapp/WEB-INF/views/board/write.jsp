<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/include.jsp"%>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/board-write.css?ver=20191015">
	<%@ include file="../include/header.jsp"%>
	<c:if test="${sessionScope.userid == null}">
	<script>
		alert("로그인 후 사용해주세요")
		location.href="${path}/";
	</script>
</c:if>
	<div class="wrapper">
		<div class="wrapper-header">
			<span class="header-text">게시글 작성</span>
		</div>
		<div class="wrapper-body">
			<form id="frm_board" method="POST">
				<div class="title-input">
					<label class="title-label" for="">머리글</label> <select
						class="title-in title-select" name="b_platform" id="">
						
						<option value="PS4" <c:if test="${bDto.b_platform == 'PS4'}">selected="selected"</c:if> >PS4</option>
						<option value="XBox" <c:if test="${bDto.b_platform == 'XBox'}">selected="selected"</c:if> >XBox</option>
						<option value="SWITCH" <c:if test="${bDto.b_platform == 'SWITCH'}">selected="selected"</c:if> >SWITCH</option>
						<option value="PC" <c:if test="${bDto.b_platform == 'PC'}">selected="selected"</c:if> >PC</option>
					</select>
				</div>
				<div class="title-input">
					<label class="title-label" for="">제목</label> <input
						class="title-in title-title-input" name="b_title" type="text" value="${bDto.b_title}">
				</div>
				<div>
					<textarea id="title-text" class="title-text" cols="30" rows="10" name="b_content">${bDto.b_content }</textarea>
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
			var flag = '${flag}'
			
			if(flag == 'answer'){
				$('#frm_board').action = '${path}/board/write'	
			}else{
				$('#frm_board').action = '${path}/board/answer'
			}
			$('#frm_board').submit()
			
		})
		$(document).ready(function(){
			var bno = '${bDto.bno}'
			var flag = '${flag}'
			
			if(flag == 'answer'){
				$("#board-write-btn").text("등록")
				$(".header-text").text("답변 작성")
			}else{
				if(bno==''){
					
				} else{
					$("#board-write-btn").text("수정")
					$(".header-text").text("게시글 수정")
					var str = "";
					str += "<input type='hidden' name='bno' value='"+bno+"'>";
					$("#frm_board").append(str);
				}
			}
			
		})			
	})
	
</script>