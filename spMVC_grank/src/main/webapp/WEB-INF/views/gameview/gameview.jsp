<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/include.jsp"%>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/gameview.css?ver=2019102501">
<%@ include file="../include/header.jsp"%>
<style>
</style>
  <div class="wrapper">
        <div class="wrapper-header"><span class="header-text">게임정보</span></div>
        <div class="review-wrapper">
            <div class="review-item">
                <div class="wrapper-header"><span class="header-text">비평가</span></div>
                <div id="c-review">
                </div>
                <div><a id="c_more" class="review a-button a-common">more+</a></div>
               <input type="hidden" id="cview-count" value="5">
            </div>
            <div class="review-item">
                <div class="wrapper-header"><span class="header-text">유저</span></div>
                <div id="u-review">
                </div>
                <div><a id="u_more" class="review a-button a-common">more+</a></div>
            </div> 
            <input type="hidden" id="uview-count" value="5">
        </div>
    </div>
 <script>
 		// creview start
 		function creview(){
 			var game_code = '${gDto.game_code}'
 			var cmax = ${csize};
 			var count = Number($('#cview-count').val());
 			
 			// count이 cmax보다 크면 버튼 제거
 			if(count >= cmax) {
 				$('#c_more').remove();
 			} 
 			$.ajax({ // ajax start
 				url : '${path}/game/creview?game_code='+game_code,
 				type : 'GET',
 				success : function(page){
 					$('#c-review').html(page);
 				},
 				error : function(){
 					alert('System error');
 				}
 			})// ajax end 
 		}// end
 		// ureview start
 		function ureview(){ // function  start
 			var game_code = '${gDto.game_code}'
 			var umax = ${usize};
			var count = Number($('#uview-count').val());
			
			// count값이 umax보다 크면 버튼 제거
			if (count >= umax) {
				$('#u_more').remove();
			}
 			$.ajax({ // ajax start
 				url : '${path}/game/ureview?game_code='+game_code,
 				type : 'GET',
 				success : function(page){
 					$('#u-review').html(page);
 				},
 				error : function(){
 					alert('System error');
 				}
 			})// ajax end
 		}// function end
		
 		// userview more click
 		$(document).on('click', '.review', function(){ // more button function start
 			var ccount = Number($('#cview-count').val());
 			var ucount = Number($('#uview-count').val());
 			var cmax = ${csize};
 			var umax = ${usize};
 			var id = $(this).attr('id');
 			var game_code = '${gDto.game_code}'
			// critic more button
 			if(id == 'c_more'){
 				ccount += 5;
 	 			if(ccount > cmax) {
 	 				ccount = cmax;
 	 				$('#c_more').remove();
 	 			}
 	 			$('#cview-count').val(ccount);
	 		
 	 			$.ajax({ // ajax start
	 				url : '${path}/game/creview?game_code='+game_code+'&count='+ccount,
	 				type : 'GET',
	 				success : function(page){
	 					$('#c-review').html(page);
	 				},
	 				error : function(){
	 					alert('System error');
	 				}
	 			})// ajax end
	 		}
 			
 			// user more button
 			if(id == 'u_more'){
 				ucount += 5;
	 			if(ucount > umax) {
	 				ucount = umax;
	 				$('#u_more').remove();
		 		}
	 				$('#uview-count').val(ucount);
	 			
	 			$.ajax({ // ajax start
	 				url : '${path}/game/ureview?game_code='+game_code+'&count='+ucount,
	 				type : 'GET',
	 				success : function(page){
	 					$('#u-review').html(page);
	 				},
	 				error : function(){
	 					alert('System error');
	 				}
	 			})// ajax end
 			}

 		}) // more button function end
 		
 	
 		// ureview document create
 		$(document).ready(function(){
 			creview();
 			ureview();
 		})
 		
 		
 		
 		
 </script>