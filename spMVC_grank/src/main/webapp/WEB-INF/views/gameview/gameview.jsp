<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/include.jsp"%>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/mypage.css?ver=2019101703">
<%@ include file="../include/header.jsp"%>
<style>
	   div.wrapper-header {
            background-color: #00b894;
            height: 45px;
            width: 100%;
            color: #fff;
            font-size: 25px;
        }
        .header-text {
            font-size: 25px;
            color: #fff;
            padding-left: 20px;
        }
        .review-wrapper{
            display: flex;
            width: 960px;
            margin: 20px auto;
            justify-content: space-between;
        }
        .review-item{
            display: inline-block;
            width:460px;
            border: 2px solid #00b894;
        }
        .review-content{
            width: 440px;
            margin: 20px auto;
            border-bottom: 1px solid #00b894;
        }
        .game-score{
            width: 20px;
            height: 20px;
            border: 1px solid #00b894;
            border-radius: 5px;
            margin-right: 10px;
            background: #00b894;
        }
</style>
  <div class="wrapper">
        <div class="wrapper-header"><span class="header-text"></span></div>
        <div class="review-wrapper">
            <div class="review-item">
                <div class="wrapper-header"><span class="header-text">${gDto.c_critic}</span></div>
                <!-- 여기에다 Ajax로 집어넣기 -->
                <div id="c-review">
                    <!-- forEach돌리기 -->
                    <div class="review-content">
                        <div style="font-weight: bold;font-size:18px;"><span class="game-score">100</span>The Indie Game Website</div>
                        <div>Disco Elysium blew my mind with its radically simple but deep approach to roleplaying. Its world and characterisation are brought to life by artistry and writing that are nothing short of astounding. Somehow, the stars aligned with absurd ambition, sheer fledgling talent and a decade of pen and paper storytelling in the Elysium universe to create something truly special. Is Disco Elysium the best RPG of all time? I can’t make that call. Is it the best game I’ve played all year? Absolutely.</div>
                    </div>
                </div>
            </div>
            <div class="review-item">
                <div class="wrapper-header"><span class="header-text">유저</span></div>
                <!-- 여기에다 Ajax로 집어넣기 -->
                <div id="u-review">
                    <!-- forEach돌리기 -->
                    <div class="review-content">
                        <div style="font-weight: bold;font-size:18px;"><span class="game-score">10</span>Ubykh</div>
                        <div>A unique Game of a kind, that revolutionize the RPGs with a level of writing rarely achieved elsewhere.
                                True Detective plus Bukowski meets… Expand</div>
                    </div>
                </div>
            </div> 
        </div>
    </div>