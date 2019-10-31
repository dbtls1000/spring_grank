<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/include.jsp"%>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/gameview.css?ver=2019103103">
<%@ include file="../include/header.jsp"%>
  <div class="wrapper">
        <div class="wrapper-header"><span class="header-text">게임정보</span></div>
               <div class="gameinfo-items">
	               <div><img style="width:150px;" src="${gDto.img_src}" alt=""></div>
		               <div class="score-items">
		               	   <div class="game-title">${gDto.game_name}</div>
				               <div class="score">Metascore :&nbsp;
					               <c:choose>
					                   <c:when test="${gDto.m_score <= 70}">
					                   		<c:if test="${gDto.m_score >= 31}">
								               <span class="game-score middle-score">${gDto.m_score}</span>
								            </c:if>	
						               		<c:if test="${gDto.m_score < 31 }">
							               		<span class="game-score low-score">${gDto.m_score}</span>
						               		</c:if>
						               </c:when>
						               <c:otherwise>
						                  <span class="game-score high-score">${gDto.m_score}</span>
						               </c:otherwise>
					               </c:choose>
				               </div>
				               
				               <div class="score">User score :&nbsp;
					               	<c:choose>
						               	<c:when test="${gDto.u_score <= '7' || gDto.u_score == 'tbd'}">
						               		<c:if test="${gDto.u_score >= '3' && gDto.u_score != 'tbd'}">
						               			 <span class="game-score middle-score">${gDto.u_score}</span>
						               		</c:if>
						               		<c:if test="${gDto.u_score < '3'}">
						               			 <span class="game-score low-score">${gDto.u_score}</span>
						               		</c:if>
						               		<c:if test="${gDto.u_score == 'tbd'}">
						               			 <span class="game-score">${gDto.u_score}</span>
						               		</c:if>
						               </c:when>
						               <c:otherwise>
						               		 <span class="game-score high-score">${gDto.u_score}</span>
						               </c:otherwise>
					               </c:choose>
			              	 </div>
                       <div class="rank-item">
  				           <div class="award-wrapper-header"><span class="award-header-text">Awards & Rankings</span></div>
				            <c:forEach items="${rList}" var="r">
				            	<div class="award-content">	
				         				${r}
				          </div>
				            </c:forEach>
        				</div>
		               </div>
           </div>
        <div class="review-wrapper">
            <div class="creview-item">
                <div class="wrapper-header"><span class="header-text">비평가</span></div>
                <div id="c-review">
                </div>
                <div class="div-more"><a id="c_more" class="review a-button a-common">more+</a></div>
               <input type="hidden" id="cview-count" value="5">
            </div>
            <div class="ureview-item">
                <div class="wrapper-header"><span class="header-text">유저</span></div>
                <div id="u-review">
                </div>
                <div class="div-more"><a id="u_more" class="review a-button a-common">more+</a></div>
            </div> 
            <input type="hidden" id="uview-count" value="5">
        </div>
    </div>
 <script>
 		// 1.creview 
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
 		
 		// 2.ureview 
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
		
 		// 3.userview more click
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
	 		}// more button function end
 			
 			// 4.user more button
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
 		
 	
 		// 5.document create
 		$(document).ready(function(){
 			creview();
 			ureview();
 		})
 		
 		
 		
 		
 </script>