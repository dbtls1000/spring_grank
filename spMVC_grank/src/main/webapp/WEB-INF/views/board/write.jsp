<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/include.jsp"%>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/board-write.css?ver=20191030">
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
			<form id="frm_board" method="POST" enctype="multipart/form-data">
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
						class="title-in title-title-input" autocomplete="off" id="b_title" name="b_title" type="text" value="${bDto.b_title}">
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
						 fCreator: "createSEditor2",
						 htParams : {
	                           bUseToolbar : true, // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
	                           bUseVerticalResizer : false, // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
	                           bUseModeChanger : true, // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
	                           bSkipXssFilter : true // client-side xss filter 무시 여부 (true:사용하지 않음 / 그외:사용)
	                           
	                        }
						});
					</script>
				</div>
				<div class="drag-box"><div class="drag-comment">첨부할 파일을 Drag&Drop해주세요.</div></div>
				<div class="uploadedList">
					<c:forEach items="${fList}" var="f">
						<c:choose>
							<c:when test="${f.format_name == 'PNG' || f.format_name == 'JPG' || f.format_name == 'GIF' }">
								<div>
									<div>
										<img width="150px" src="${path}/images/${f.file_name}">
										<span data-fno="${f.fno}" data-src="${f.thumbnail}" style="cursor:pointer;">[삭제]</span>
									</div>
								</div>
							</c:when>
							<c:otherwise>
								<div>
									<div>${f.origin_name}
										<span data-fno="${f.fno}" data-src="${f.file_name}" style="cursor:pointer;">[삭제]</span>
									</div>
								</div>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</div>
				<div class="between title-file">
					<span class="board-write-err">test</span>
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
		var bno = '${bDto.bno}';
		var flag = '${flag}';
		
		if(flag == 'answer'){
			$('.uploadedlist').text('');
			$("#board-write-btn").text("등록");
			$(".header-text").text("답변 작성");
			$('#b_title').attr('readonly','readonly');
		}else{
			if(bno==''){
				
			} else{
				$("#board-write-btn").text("수정");
				$(".header-text").text("게시글 수정");
				var str = "";
				str += "<input type='hidden' name='bno' value='"+bno+"'>";
				$("#frm_board").append(str);
			}
		}
		// 게시글 작성 버튼 클릭시
		$('#board-write-btn').click(function(){
			oEditors.getById["title-text"].exec("UPDATE_CONTENTS_FIELD", []);
			var content = $('#title-text').val();
			var title = $.trim($('#b_title').val());
			var regEmpty = /\s/g;
			var text = content.replace(/[<][^>]*[>]/gi,"");
			var flag = '${flag}'
			if(title == '' || title.length == 0){
				$('.board-write-err').text('제목은 필수 입력 항목입니다.')
									.css('visibility','visible')
									.css('color','crimson')
									.css('font-weight','bold');
				$('#b_title').focus();
				return false;
			}
			if(text == '' || text == null){
				$('.board-write-err').text('내용은 필수 입력 항목입니다.')
									.css('visibility','visible')
									.css('color','crimson')
									.css('font-weight','bold');
				$('#title-text').focus();
				return false;
			}
			// flag값이 answer인지 아닌지에 따라 form의 action변경
			if(flag == 'answer'){
				$('#frm_board').action = '${path}/board/answer'	
			}else{
				$('#frm_board').action = '${path}/board/write'
			}
			$('#frm_board').submit()
			
		})
		/* 첨부파일 이전 방식
		// dragover drop 이벤트는 jquery에 함수가 만들어지지 않은 상태이므로
		// on을 이용해서 이벤트를 핸들링 해야 한다.
		$(".drag-box").on('dragover', function () {
			$(".drag-box span").text("파일을 내려 놓으세요.")
			return false
		})
		// drag-box에 파일을 끌어다 놓은 경우 이벤트
		$('.drag-box').on('drop',function(evt){
			// 웹페이지에 이미지를 드랍하는 경우 전체화면으로 이미지가 출력되는것을 막음
			evt.preventDefault();
			$(".drag-box span").text('파일을 등록하는 중.')
			// drop한 파일들의 정보를 얻기 위한 js클래스
			var files = evt.originalEvent.dataTransfer.files
			// input form과 file을 함께 ajax로 업로드하기 위한 클래스
			var formData = new FormData();
			for(var i = 0; i <files.length; i++){
				var file_name = files[i].name;
				// .jpg .gif .jpeg .png파일이 아닐경우 false
				if(/(\.gif|\.jpg|\.jpeg|\.png)$/i.test(file_name) == false){
					alert("업로드는 *.jpg, *.gif *.jpeg *.png 파일만 가능합니다")
					$(".drag-box span").css("color","crimson")
					$(".drag-box span").text("파일 업로드 실패.")
					return false;
				}
				// formData에 'files'라는 key값으로 담기
				formData.append('files',files[i]);
			}
			// 업로드할 첫번째 파일 1개를 formData객체에 추가
			$.ajax({
				url : "${path}/ajaxfile/fileup",
				method : "POST",
				data:formData, // formData를 보냄
				processData:false,
				contentType:false,
				success:function(result){
					for(var i = 0 ; i < result.length ; i++){
						// UUID값 추출
						var uuid = result[i].file_name.split('_');
						// 원본파일이름 추출
						var origin_name = uuid[uuid.length - 1]
						// 이미지를 업로드하면 그에대한 정보를 보여주는 태그생성
						// 이미지를 미리보기로 보여줄 폼 생성
						var htmls = '';
						htmls += '<div style="display:inline-block;text-align: right;width:150px;">';
						htmls += '<span data-fno="${f.fno}" class="image-delete" style="cursor:pointer;">'
						// form으로 보낼 정보를 input type="hidden"으로 생성해서 담기
						htmls += '<input type="hidden" name="board_files" value="'+ result[i].file_name +'">'
						htmls += '<i class="fas fa-times"></i></span>';
						htmls += '<div><img width="150px" src="${path}/images/'+ result[i].file_name +'">'
						htmls += '</div>';
						htmls += '<div>' + origin_name + '</div>'
						htmls += '<input type=hidden class="image-name" value="'+origin_name+'">'
						htmls += '</div>';
						// 이미지를 담은 태그를 업로드한만큼 생성
						$(".image_box").append(htmls);
					}
				}
			})
			
		})
	})
	// 이미지 삭제 버튼 클릭시
	$(document).on('click','.image-delete',function(){
		// 파일의 PK값 가져오기
		var fno = $(this).attr('data-fno');
		var file_name = $(this).children('input').val();
		// ajax처리 이후 삭제할 태그를 변수에 담기
		var tag = $(this).parent();
		$('.delete-modal').css('display','block');
		$('.delete-comment').text('이미지를 삭제하시겠습니까?');
		$('#confirm-yes').click(function(){
			$.ajax({
				url : "${path}/ajaxfile/delete?fno="+fno+"&file_name=" + file_name,
				method : "GET"
			})
			.done(function(result){
				if(result == "OK"){
					var origin_name = $(tag).children('.image-name').val();
					$('#'+origin_name).remove();
					// done에서 this는 대상이 ajax가 되어서
					// 위에서 선언한 tag라는 변수를 사용한다.
					$(tag).remove()
					$('.delete-modal').css('display','none');
				} else if(result == "FAIL"){
					alert("파일을 삭제할 수 없습니다")
				}
			})
		})
	})
	*/
	//이벤트 설정시에는 jquery의 .on()을 사용한다.
    //드래그 기본 효과를 막음
    $(".drag-box").on("dragenter dragover", function(event){
        //drop영역에 들어가고, 드롭영역에 드래그 되고있을때의 기본 효과를 막음
        event.preventDefault();
    });
    $(".drag-box").on("drop",function(event){
        //drop이 될 때 기본 효과를 막음
        //기본 효과를 막지 않으면 드래그시에 브라우저에서 이미지파일이 열려버림
        event.preventDefault();
        
        //첨부파일 배열
        var files=event.originalEvent.dataTransfer.files;
        var file=files[0]; //첫번째 첨부파일
        var name = file.name
        var size = file.size
        if(size > 104857600){
        	alert('업로드 할 수 있는 파일의 최대 크기는 104MB입니다.')
        } else{
	        //AJAX로 (이미지를 넘길때)폼 전송을 가능케해주는 FormData 객체
	        var formData=new FormData(); 
	        formData.append("file",file); //폼에 file 변수 추가
	        //서버에 파일 업로드(백그라운드에서 실행됨)
	        // contentType: false => multipart/form-data로 처리됨
	        $.ajax({
	            //AjaxUploadController에 post방식으로 넘어감
	            type: "post",
	            url: "${path}/upload/uploadAjax",
	            data: formData,
	            dataType: "text",
	            processData: false,
	            contentType: false,
	            success: function(data,status,req){
	                console.log("data:"+data); //업로드된 파일 이름
	                console.log("status:"+status); //성공,실패 여부
	                console.log("req:"+req.status);//요청코드값
	                var str="";
	                if(checkImageType(data)){ //이미지 파일
						str="<div>";
						str+="<img src='${path}/upload/displayFile?fileName="+data+"'>";
						str+='<input type="hidden" name="board_files" value="'+getImageLink(data)+'">'
	                }else{ //이미지가 아닌 경우
	                    str="<div>"+getOriginalName(data)+"";
						str+='<input type="hidden" name="board_files" value="'+data+'">'
	                }
	                str+="<span style='cursor:pointer' data-src="+data+">[삭제]</span></div>";
	                
	                $(".uploadedList").append(str);
	            }
	        });
        }
    });
  	//첨부파일 삭제 함수
    $(".uploadedList").on("click","span",function(event){
        //현재 클릭한 태그
        var that=$(this);
		//data: "fileName="+$(this).attr("data-src"),        
        $.ajax({
            url: "${path}/upload/deleteFile",
            type: "post",
            data: {
                fileName: $(this).attr("data-src"),fno:$(this).attr("data-fno")
            },
            dataType: "text",
            success: function(result){
                if(result=="deleted"){
                    that.parent("div").remove();
                }
            }
        });
    });
    
    function getOriginalName(fileName){
        if(checkImageType(fileName)){ //이미지 파일이면 skip
            return;
        }
        var idx=fileName.indexOf("_")+1; //uuid를 제외한 파일이름
        return fileName.substr(idx);
    }
    function getImageLink(fileName){
        if(!checkImageType(fileName)){//이미지 파일이 아니면 skip
            return;
        }
        var front=fileName.substr(0,12);//연월일 경로
        var end=fileName.substr(14);// s_ 제거
        return front+end;
    }
    function checkImageType(fileName){
        // '/i': ignore case
        var pattern=/jpg|png|jpeg|gif/i; //정규표현식(대소문자 무시)
        return fileName.match(pattern); //규칙에 맞으면 true
    }
	// delete-modal 아니오버튼 클릭시 이벤트
	$(document).on('click','#confirm-no',function(){
		$('.delete-modal').css('display','none');
	})
})
</script>