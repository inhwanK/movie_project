<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="<%=request.getContextPath() %>" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>메인화면</title>
	<link rel="stylesheet" href="${contextPath}/resources/css/main.css">
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.0/css/all.min.css" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
	<script>
		/* 검색 엔터키 입력시 영화페이지 검색으로 들어감 */
		function searchMovie() {
			var contextPath = "${contextPath}";
			var movTitle = $("#search-box input[type=text]").val();
				  
			if (movTitle != '') {	// 검색 텍스트가 있으면 영화 페이지로 가서 검색 됨
				window.location.href = contextPath + "/searchMovieList?movTitle=" + movTitle;
			}else if (movTitle == '') {		// 검색 텍스트가 없을시 경고 창 띄움(Alert창 디자인 sweetalert2)
				Swal.fire({						
				    icon: 'warning',
				    title: '검색할 영화명을 입력해주세요.'
			    }).then((result) => { 
					if (result.isConfirmed) { 
					} 
				});
			}
		}
	</script>
</head>
<body>
	<header>
		<c:if test = "${member == null }">
		<a href="${contextPath}/main"> <img id="header_ci" alt="브랜드 로고" src="${contextPath}/resources/images/ci_bw.png"></a>
		</c:if>
		<c:if test = "${member != null }">
		<a href="${contextPath}/main"> <img id="header_ci2" alt="브랜드 로고" src="${contextPath}/resources/images/ci_bw.png"></a>
		</c:if>
		
		<div>
		<!-- 관리자가 로그인하지 않은 상태 -->
		<c:if test = "${admin == null }">
			<!-- 로그인 하지 않은 상태 -->
        	<c:if test = "${member == null }">
				<a href="${contextPath}/login">로그인</a> <a href="${contextPath}/join">회원가입</a>
				<a href="${contextPath}/reserve">바로예매</a>
			</c:if>
			
			<!-- 로그인한 상태 -->
        	<c:if test="${ member != null }">
            	<div class="login_success_area">
            		<span>안녕하세요. ${member.memName} 회원님!</span>
            		<a href="${contextPath}/main.do">로그아웃</a>
            		<a href="${contextPath}/reserve">바로예매</a>
            	</div>
        	</c:if>
   		</c:if>
   		<!-- 관리자가 로그인하지 않은 상태 -->
		<c:if test = "${admin != null }">
			<div class="admin_success_area">
            	<span>안녕하세요. ${admin.admId} 회원님!</span>
            	<a href="${contextPath}/main.do">로그아웃</a>
            	<a href="${contextPath}/movieManager">관리페이지</a>
            </div>
		</c:if>
		</div>
	</header>
	<nav>
		<ul>
			<li class="nav"><a href="${contextPath}/movielist">영화</a></li>
			<li class="nav"><a href="${contextPath}/reserve">예매</a></li>
			<li class="nav"><a href="${contextPath}/theaterlist">극장</a></li>
			<li class="nav"><a href="${contextPath}/noticelist">고객센터</a></li>
			<li id="mypagebtn"><a href="${contextPath}/mypage"><i class="far fa-user"></i></a></li>
		</ul>
	</nav>
	
	<section>
	<div id="slide">
		<ul>
			<li></li>
			<li></li>
			<li></li>
			<li></li>
		</ul>
	</div>
	
	<div class="contentsBox">
			<div class="boxoffice">
				<h1>BOX OFFICE</h1>
			</div>
			
			<div class="main-movie-list">
				<ul>
					<li>
						<img src="https://img.megabox.co.kr/SharedImg/2021/05/12/J7vthd2FWEXswHD67dL2rQrMW4uhJQUF_420.jpg">
						<div class="reserve-boxoffice">
								<a href="#">예매</a>
						</div>
					</li>
					<li>
						<img src="https://img.megabox.co.kr/SharedImg/2021/04/20/Pg9xMYRfMNouXwkqG2PeOGGqyUaQ9skl_420.jpg">
						<div class="reserve-boxoffice">
								<a href="#">예매</a>
						</div>
					</li>
					<li>
						<img src="https://img.megabox.co.kr/SharedImg/2021/05/24/OPZRLPUEwlEliCfy6Li4gfhUFCJ52AE1_420.jpg">
						<div class="reserve-boxoffice">
								<a href="#">예매</a>
						</div>
					</li>
				</ul>
			</div>
			
			<div class="search">
				<ul>
					<li id="search-box">
						<input type="text" placeholder="영화제목" style="color:white" onkeyup="if(window.event.keyCode==13){searchMovie()}"/>
					</li>
					<li><i class="far fa-calendar-alt"></i><a href="#"><h2>상영시간표</h2></a></li>
					<li><i class="fas fa-film"></i><a href="${contextPath}/movielist"><h2>박스오피스</h2></a></li>
					<li><i class="fas fa-ticket-alt"></i><a href="${contextPath}/reserve"><h2>바로예매</h2></a></li>
				</ul>
			</div>
		</div>
	
	
	</section>
	
	<footer>
		<div id="content">
			<img id="footer_ci" alt="브랜드 로고" src="${contextPath}/resources/images/ci_bw.png">
			<div id="textarea">
				<p>COPYRIGHT © BoxMovie, Inc. All rights reserved</p>
				<p>대구광역시 서구 서대구로 7길2 (내당동 245-4번지 2층) ARS 053-555-1333</p>
			</div>
		</div>
	</footer>
	
	
</body>
</html>