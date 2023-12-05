<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="security"%>
<!-- ======= Hero Section ======= -->
<style>
/* ---------- Container for the orbiting circles animation ---------- */
#circle-orbit-container {
  position: relative;
  top: -28px;
  left: 25px;
  height: 600px;
  width: 300px;
}

/* ---------- Inner orbit - This is the circles closest to the central point ---------- */
#inner-orbit {
  position: absolute;
  top: 75px;
  left: 75px;
  width: 150px;
  height: 150px;
  border: 3px #fff9ea solid;
  border-radius: 100%;
  -webkit-animation: spin-right 10s linear infinite;
  animation: spin-right 10s linear infinite;
}

/* ---------- Repeating styles for the inner orbiting circles ---------- */
.inner-orbit-cirlces {
  position: absolute;
  top: 62px;
  left: -6px;
  height: 10px;
  width: 10px;
  border-radius: 100%;
  background-color: #9F98E6;
}

/* ---------- Middle orbit - This is the circles second closest to the central point ---------- */
#middle-orbit {
  position: absolute;
  top: 35px;
  left: 35px;
  width: 656px;
  height: 656px;
  border: 1px #fff9ea solid;
  border-radius: 100%;
  -webkit-animation: spin-right 15s linear infinite;
  animation: spin-right 15s linear infinite;
}

/* ---------- Repeating styles for the inner orbiting circles ---------- */
.middle-orbit-cirlces {
  position: absolute;
  top: 188px;
  left: 17px;
  height: 20px;
  width: 20px;
  border-radius: 100%;
  background-color: #e2ebf1;
}

/* ---------- Outer orbit - This is the circles furthest away from the central point ---------- */
#outer-orbit {
  position: absolute;
  width: 856px;
  height: 856px;
  border: 3px #fff9ea solid;
  border-radius: 100%;
  -webkit-animation: spin-right 20s linear infinite;
  animation: spin-right 20s linear infinite;
  bottom: -190px;
  left: -72px;
}

/* ---------- Repeating styles for the outer orbiting circles ---------- */
.outer-orbit-cirlces {
  position: absolute;
  top: 96px;
  left: 125px;
  height: 30px;
  width: 30px;
  border-radius: 100%;
  background-color: #A7C4D4;
}

/* ---------- Animation ---------- */
@-webkit-keyframes spin-right {
  100% {
    -webkit-transform: rotate(360deg);
    -moz-transform: rotate(360deg);
    -ms-transform: rotate(360deg);
    -o-transform: rotate(360deg);
    transform: rotate(360deg);
  }
}

.imageArea {
	-webkit-text-size-adjust: 100%;
    --color333: #333;
    --color555: #555;
    --color777: #777;
    --color999: #999;
    --mainColor: #623ad6;
    --errorColor: #f96464;
    --ongolingColor: #00b19c;
    --holdColor: #514474;
    --whiteColor: #fff;
    --fontBold: bold;
    --fontMedium: normal;
    --bgGray: #faf9f9;
    --bgEee: #eee;
    font-family: "Noto Sans KR",Roboto,"Malgun Gothic","맑은 고딕",helvetica,"Apple SD Gothic Neo",sans-serif,"Apple Color Emoji","Twemoji Country Flags";
    color: #333;
    font-size: 100%;
    vertical-align: baseline;
    display: inline-block;
    position: absolute;
    border-radius: 20px;
    background: url(/resources/images/main/mainImg2.png) no-repeat;
    box-shadow: -80px 80px 80px rgba(0,0,0,.25);
    animation: img-fade-left 3s forwards;
    left: 90px;
    width: 810px;
    height: 510px;
    top: unset;
    bottom: -16px;
}

@keyframes img-fade-in {
    0% {
        opacity: 0;
    }
    100% {
        opacity: 1;
    }
}
@keyframes rotate-img-main{
    100% {
        transform: rotate(360deg);
    }
}
@keyframes rotate-img-sub{
    100% {
        transform: rotate(-360deg);
    }
}
@keyframes img-fade-left {
    0% {
        opacity: 0;
        transform: translate(100%, 0);
    }
    80% {
        opacity: 1;
        transform: translate(-5%, 0);
    }
    100% {
        opacity: 1;
        transform: translateZ(0);
    }
}
@keyframes img-fade-left-small {
    0% {
        opacity: 0;
        transform: translate(100%, 0);
    }
    100% {
        opacity: 1;
        transform: translateZ(0);
    }
}
.bigCircle {
	-webkit-text-size-adjust: 100%;
    --color333: #333;
    --color555: #555;
    --color777: #777;
    --color999: #999;
    --mainColor: #623ad6;
    --errorColor: #f96464;
    --ongolingColor: #00b19c;
    --holdColor: #514474;
    --whiteColor: #fff;
    --fontBold: bold;
    --fontMedium: normal;
    --bgGray: #faf9f9;
    --bgEee: #eee;
    font-family: "Noto Sans KR",Roboto,"Malgun Gothic","맑은 고딕",helvetica,"Apple SD Gothic Neo",sans-serif,"Apple Color Emoji","Twemoji Country Flags";
    color: #333;
    line-height: 1;
    letter-spacing: -.02em;
    box-sizing: border-box;
    font-size: 100%;
    vertical-align: baseline;
    background: 0 0;
    position: absolute;
    opacity: 0;
    animation: img-fade-in 3s forwards;
    animation-delay: 1s;
    top: -70px;
    left: -70px;

}

.bigCircle>i {
	-webkit-text-size-adjust: 100%;
    --color333: #333;
    --color555: #555;
    --color777: #777;
    --color999: #999;
    --mainColor: #623ad6;
    --errorColor: #f96464;
    --ongolingColor: #00b19c;
    --holdColor: #514474;
    --whiteColor: #fff;
    --fontBold: bold;
    --fontMedium: normal;
    --bgGray: #faf9f9;
    --bgEee: #eee;
    font-family: "Noto Sans KR",Roboto,"Malgun Gothic","맑은 고딕",helvetica,"Apple SD Gothic Neo",sans-serif,"Apple Color Emoji","Twemoji Country Flags";
    color: #333;
    line-height: 1;
    letter-spacing: -.02em;
    box-sizing: border-box;
    font-size: 100%;
    vertical-align: baseline;
    font-style: normal;
    display: inline-block;
    background: url(/resources/images/main/main-obj.png) no-repeat center center/contain;
    animation: rotate-img-sub 10s linear infinite;
    transform-origin: 50% 50%;
    width: 865px;
    height: 865px;

}
.littleCircle {
	position: absolute;
    top: 30px;
    left: 35px;
    opacity: 0;
    animation: img-fade-in 3s forwards;
    animation-delay: 1.0s;
}

.littleCircle>i {
    display: inline-block;
    width: 665px;
    height: 665px;
    background: url(/resources/images/main/sub-obj.svg) no-repeat center center / contain;
    animation: rotate-img-sub 10s linear infinite;
    transform-origin: 50% 50%;
}

.request {
    -webkit-text-size-adjust: 100%;
    --mainColor: #623ad6;
    --errorColor: #f96464;
    --ongolingColor: #00b19c;
    --holdColor: #514474;
    --whiteColor: #fff;
    --fontBold: bold;
    --fontMedium: normal;
    --bgGray: #faf9f9;
    --bgEee: #eee;
    letter-spacing: -.02em;
    box-sizing: border-box;
    vertical-align: baseline;
    background: 0 0;
    display: inline-block;
    position: absolute;
    color: #fff;
    border-radius: 18px;
    font-family: 'DM Sans';
    opacity: 0;
    box-shadow: 13px 14px 22px rgba(0,0,0,.15);
    z-index: 2;
    font-size: 17px;
    line-height: 16px;
    padding: 7px 10px;
    background-color: #27b5f2;
    animation: img-fade-left-small 1s forwards;
    animation-delay: 2.5s;
    margin-left: 3px;
    font-weight: 400;
    top: 301px;
    left: 980px;
    position: absolute;
    width: 97px;
}

.feedback {
    -webkit-text-size-adjust: 100%;
    --mainColor: #623ad6;
    --errorColor: #f96464;
    --ongolingColor: #00b19c;
    --holdColor: #514474;
    --whiteColor: #fff;
    --fontBold: bold;
    --fontMedium: normal;
    --bgGray: #faf9f9;
    --bgEee: #eee;
    letter-spacing: -.02em;
    box-sizing: border-box;
    vertical-align: baseline;
    background: 0 0;
    display: inline-block;
    position: absolute;
    color: #fff;
    border-radius: 18px;
    font-family: 'DM Sans';
    opacity: 0;
    box-shadow: 13px 14px 22px rgba(0,0,0,.15);
    z-index: 2;
    font-size: 17px;
    line-height: 16px;
    padding: 7px 10px;
    background-color: #CFCBC8;
    animation: img-fade-left-small 1s forwards;
    animation-delay: 2.8s;
    margin-left: 3px;
    font-weight: 400;
	bottom: 200px;
    left: 950px;
    position: absolute;
    width: 82px;
}

@font-face {
    font-family: 'GoodNeighbors-Good-Neighbors-Bold';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_11-01@1.0/GoodNeighbors-Good-Neighbors-Bold.woff2') format('woff2');
    font-weight: 700;
    font-style: normal;
}
* {
	 font-family: 'GoodNeighbors-Good-Neighbors-Bold';
}

h1 {
	font-family: 'GoodNeighbors-Good-Neighbors-Bold';
}
</style>

<section id="hero" class="d-flex align-items-center">
	<div class="container">
		<div class="row" style="display: flex;flex-direction: row-reverse;justify-content: flex-end;">
			<div class="col-lg-6 d-flex flex-column justify-content-center pt-4 pt-lg-0 order-2 order-lg-1"
				data-aos="fade-up" data-aos-delay="200">
				<h1>프로젝트 관리 협업툴  <br> 
					BLUE MINE 
				</h1>
				<h2>모든 팀이 블루마인으로 함께 협업해요!</h2>
				<div class="d-flex justify-content-center justify-content-lg-start">
					<a href="${pageContext.request.contextPath }/project/myProject" class="btn-get-started scrollto">무료로 시작하기</a>
				</div>
			</div>
<!-- 			<span class="request">Marketing</span>
			<span class="feedback">Project</span> -->
			<div id="circle-orbit-container">
			  <!-- Circles second closest to the central point -->
			  <span class="bigCircle"><i></i></span>
			  <span class="littleCircle"><i></i></span>
			  <!-- Circles furthest away to the central point -->
			  <span class="imageArea"></span>
			</div>
		</div>
	</div>
</section>