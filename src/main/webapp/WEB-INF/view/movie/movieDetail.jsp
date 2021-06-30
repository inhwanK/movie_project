<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
	<link rel="icon" href="data:;base64,iVBORw0KGgo=">	<!-- 파비콘 오류 메세지 해결 -->
	<meta charset="UTF-8">
	<title>영화 상세정보</title>
	<c:set var="contextPath" value="<%=request.getContextPath() %>" />
	<link rel="stylesheet" href="${contextPath}/resources/css/movie/movieDetail.css">
	<link rel="stylesheet" href="${contextPath}/resources/css/movie/star/fontawesome-stars.css">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> 	<!-- 이 js가 다른 js보다 낮으면 에러 뜸 -->
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.0/css/all.min.css" rel="stylesheet">
	<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css">
    <script>
    	window.jQuery || document.write('<script src="${contextPath}/resources/js/star/vendor/jquery-1.11.2.min.js"><\/script>')
    </script>	
    <script src="${contextPath}/resources/js/star/jquery.barrating.min.js"></script>	
	<script>
		$(function() {
			/* 주요정보 등 탭 클릭시 */
			$(".btn li").click(function(e) {
				e.preventDefault();
				$(this).addClass("active");
				$(this).siblings().removeClass("active");
	
				$(".tab-cont-wrap > div").removeClass("active");
				$(".tab-cont-wrap > div").eq($(this).index()).addClass("active");
			});
			
		   /* 취소 버튼 누를시  */
		   $("#cancel").click(function () {
		        $("#contxt").val('');	        
		        $(".br-widget a").removeClass();	               
		        $(".br-widget a:first-child").addClass("br-selected br-current");	               
		        $(".br-current-rating").text("1");	         
		        $(".br-widget").unbind('mouseleave');
		   });
		   
		   /* 한줄평쓰기 버튼 누를시 */
		   $(document).ready( function() {
			   $(".comment-write > span").click(function(){
					$(".write-content").slideToggle().toggleClass("active");  
			     });
		   });
		   
		   /* 별점 테마 */
		   $('#example-fontawesome').barrating({ 
   				theme: 'fontawesome-stars' 
  			});
		   
		   /* 엔터 쳤을때 버튼 누른것과 동일한 이벤트 */
			$("#contxt").on("keyup", function(key) {
		        if (key.keyCode == 13) {
		        	$('#writeBtn').click();
		        	return false;	// 검색 버튼을 눌렀을 경우에 해당 버튼이 활성화 (다른 의도하지 않은 동작 방지)
		        }
		    });
		   
		});
	</script>
	<script type="text/javascript">
		$(function(){
			/* ajax - 박스오피스 데이터만 예매버튼 활성화 */
			var contextPath = "${contextPath}";
			var no = "${movNo}";
			
			$.ajax({
				type:"GET",
				url: contextPath + "/api/movies/boxOffice/" + no,
				contentType: "application/json; charset=utf-8",
				success: function(json){
					var btn = "";
						btn += "<button type='button' id='reserve' class='btn reserve' title='영화 예매하기'>예매</button>";
					$(".screen-type").append(btn);			
				},
				error : function(request, status, error){
					$('#comming').show();
					console.log("error > ");
				}	
			});
		});
	</script>
	<script>
		$(function(){
			function getFormatDate(date){
				var subDateArray = date.substr(0,10).split('-');
				return newDateForm = subDateArray[0] + "." + subDateArray[1] + "." + subDateArray[2];
			}
			
			var contextPath = "${contextPath}";
					
			var movNo = "${movNo}";
			$.get(contextPath+"/api/movies/" + movNo,
				function(json) {	
					var bg = "";
					var title = "";
					var avgStar = "";
					var poster = "";
					var sCont = "";
					
						/* 영화 뒷 배경 */
						bg += "<div class='bg-img' style='background-image:url("
								+ "${contextPath}/resources/images/movie/movie-detail/bg-" + json.movPoster + ");'>";
						bg += "</div>"; 
						
						/* 실시간 평점 (영화 평균 평점) <-- 트랜젝션 사용 */ 
						avgStar += json.movAvgstar;
						
						/* 영화 제목 */			
						title += "<p class='title'>" + json.movTitle + "</p>";
						// title += "<p class='title-eng'>" + 'Cruella' + "</p>";		// 영어 제목 컬럼 미지정
						
						/* 영화 포스터 */
						poster += "<p class='movie-grade age-" + json.movGrade + "'></p>";	
						poster += "<img alt='" + json.movTitle + "'src="
							+ "'${contextPath}/resources/images/movie/box-office/" + json.movPoster + "'/>";			
						
						// 주요정보 탭					
						/* 영화 줄거리 */
						sCont += "<div class='movie-summary'>";
						sCont += "<div class='txt'>" + json.movDetail + "</div>";
						sCont += "</div><br><hr>";
						
						/* 영화 정보 */
						sCont += "<div class='movie-info'>";
						sCont += "<p class='p-type'></p>";		
						sCont += "<div class='line'>";						
						sCont += "<p>감독&nbsp;: " + json.movDirector + "</p>";						
						sCont += "<p>장르&nbsp;: " + json.movGenre + "/" + json.movRuntime + "분</p>";						
						sCont += "<p>등급&nbsp;: " + json.movGrade + "세이상관람가</p>";						
						sCont += "<p>개봉일&nbsp;: " + getFormatDate(json.movOpendate) + "</p>";											
						sCont += "</div>";
						sCont += "<p>출연진&nbsp;: " + json.movActor + "</p>";
						sCont += "</div>";
						
					$(".movie-detail-page .movie-bg").append(bg);
					$(".number em").append(avgStar);
					$(".movie-detail-cont").append(title);
					$(".poster .wrap").append(poster);
					$(".movie-info-list").append(sCont);
			});
			
			/* 상영타입 (전부 2d로 넣어놓음) */
			var cinNo = "1";
			$.get(contextPath + "/api/cinemas/" + cinNo,
				function(json){
					var cinType = "";
						cinType += "상영타입 : " + json.cinType + "(자막)";
					$(".movie-info .p-type").append(cinType);
				});
		
			/* // 주요정보 탭 */
			
			/* 실관람평  탭 */
			var movNo = "${movNo}";
			$.get(contextPath+"/api/comments/movie/" + movNo,
				function(json) {
					var dataLength = json.length;
					if (dataLength >= 1) {
						var sCont = "";				
						var size = "";	
							size += dataLength
							
						for (i = 0; i < dataLength; i++) {							
							sCont += "<li>";
							// comment-list
							sCont += "<div class='comment-list'>";
							// prof
							sCont += "<div class='prof'>";						
							sCont += "<img src='${contextPath}/resources/images/movie/movie-detail/bg-profile.png'>";
							sCont += "<p class='user-id'>" + json[i].comUser + "</p>";
							sCont += "<div class='divNo' style ='display:none'>" + json[i].comNo + "</div>"
							sCont += "</div>";
							// // prof
							
							// textarea
							sCont += "<div class='textarea'>";
							sCont += "<h3>한줄평</h3>";
							sCont += "<h3>" + json[i].comStar + "</h3>";
							sCont += "<p>" + json[i].comContent + "</p>";							
							sCont += "</div>";
							// // textarea
							
							// btn-util
							sCont += "<div class='btn-util'>";
							sCont += "<button id='modify'>수정</button>";
							sCont += "<button id='remove'>삭제</button>";					
							sCont += "</div>";
							// // btn-util
							
							sCont += "</div>";
							// // comment-list
							sCont += "<h5>" + json[i].comDate + "</h5>";
							sCont += "</li>";
						}
						$("#comment-count .font-gblue").append(size);
						$(".movie-comment ul").append(sCont);
					}
								
				});
			
			/* ajax */
			$('#writeBtn').on("click", function(e){
				var movNo = "${movNo}";
				var user = $('#user').val();
				var content = $('#contxt').val();
				var newComment = { movNo: movNo, 
									comUser : $('#user').val(), 
									comContent: $('#contxt').val(),
									comStar : $('.com-star').val()
								};
				
				if (confirm("등록 하시겠습니까?")){
		 			$.ajax({
						url 		: contextPath + "/api/comments/",
						type 		: "POST",
						contentType : "application/json; charset=utf-8",
						datatype 	: "json",
						cache 		: false,
						data 		: JSON.stringify(newComment),
						beforeSend  : function(xhr) {			// success로 넘어가기 전에 조건 만족시 success로 넘어가지 않고 beforeSend에서 멈춤
					        if (user == "") {			// 한줄평 유저 (user)에 값이 없을시 success로 넘어가지 않고 로그인으로 이동
					            xhr.abort();
					        	alert("권한이 없습니다. 로그인 해주세요.");
					            window.location.href = contextPath + "/login";
					        }else if (content == "") {	// 한줄평 내용이 없을때
					        	xhr.abort();
					        	alert("내용을 입력해주세요!");
					        }
					    },
						success 	: function(res) {
							if(user != ""){			// 유저가 있으면 등록후 새로고침
								alert(newComment.comUser + "님의 한줄평이 등록되었습니다.");
								location.reload();
							}
						},
						error : function(request, status, error){
							alert("code:" + request.status+"\n" + "message:" + request.responseText+"\n" + "error:" + error);
							location.reload();
						}
					}); 
				} else {
					return false;
				}
			});
			
			/* 수정 버튼 누를시 팝업 */
			$(document).ready(function(){
				$(this).on('click', '[id=modify]', function(){
					var pa = $(this).parent().parent();
					var ch = pa.children().children();
					var comNo = ch.eq(2).text();
					// alert(comNo);	
				    
					/* 팝업 중앙에 띄우기 */
				    function PopupCenter(url, title, w, h) {  
				        var dualScreenLeft = window.screenLeft != undefined ? window.screenLeft : screen.left;  
				        var dualScreenTop = window.screenTop != undefined ? window.screenTop : screen.top;  
				                  
				        width = window.innerWidth ? window.innerWidth : document.documentElement.clientWidth ? document.documentElement.clientWidth : screen.width;  
				        height = window.innerHeight ? window.innerHeight : document.documentElement.clientHeight ? document.documentElement.clientHeight : screen.height;  
				                  
				        var left = ((width / 2) - (w / 2)) + dualScreenLeft;  
				        var top = ((height / 2) - (h / 2)) + dualScreenTop;  
				        var newWindow = window.open(url, title, 'scrollbars=yes, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);  
				      
				        if (window.focus) {  
				            newWindow.focus();  
				        }  
				    } 				    
				    PopupCenter(contextPath + "/updateComment?comNo=" + comNo,'popup','550','400'); 
				});
			});
			
			/* 한줄평 삭제 */
			$(document).on('click', '[id=remove]', function(){
				var pa = $(this).parent().parent();
				var ch = pa.children().children();
				var comNo = ch.eq(2).text();
				
				if (confirm("삭제하시겠습니까?")){
					$.ajax({
						url: contextPath + "/api/comments/" + comNo,
						type: 'DELETE',
						success: function(res) {
							alert(comNo + "번 한줄평 삭제 완료");
							location.reload();
						},
						error: function(request, status, error) {
							alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
							location.reload();
						}
					});
				} else {
					return false;
				}			
			});
			/* // 실관람평 탭 */
			
			// 예매버튼 클릭시 영화 번호를 reserve 페이지에 전달
			$(document).on('click', '[id=reserve]', function(e){
				var movNo = ${movNo};
				
				window.location.href = contextPath + "/reserve?no=" + movNo;
			});
		});
	</script>
</head>
<body>
	
	<%@include file="/WEB-INF/view/header.jsp"%>

	<section>
		<!-- container -->
		<div class="container">
			<!-- contents -->
			<div class="contents">

				<!-- movie-detail-page -->
				<div class="movie-detail-page">
				<div class="movie-bg"></div>
					<%-- <div class="bg-img" style="background-image: url('${contextPath}/resources/images/movie/movie-detail/bg-Cruella.jpg');"></div> --%>
					<div class="bg-mask"></div>
					<!-- movie-detail-cont -->
					<div class="movie-detail-cont">
						
						<!-- info -->
						<div class="info">
							<div class="score">
								<p class="title">평균 별점</p>
								<div class="number">
									<p title="평균 별점 " class="before">
										<em></em>
										<span>점</span>
									</p>
								</div>
							</div>
	
							<div class="rate">
								<p class="title">예매율</p>
								<p class="cont">
									<em>2</em>위 (14.1&#37;)
								</p>
							</div>
	
							<div class="audience">
								<p class="title">누적관객수</p>
								<p class="cont">
									<em>664,320</em> 명
								</p>
							</div>
						</div>
						<!--// info -->
						
						<div class="poster">
							<div class="wrap">
							</div>
						</div>
						<div class="screen-type">
							<button type='button' id='comming' class='btn comming' style="display: none;">상영예정</button>
						</div>
					</div>
				<!--// movie-detail-cont -->
				</div>
				<!-- movie-detail-page -->
				
				<!-- contentData -->
				<div id="contentData">
					<!-- inner-wrap -->
					<div class="inner-wrap">
	    				<div class="tab-list">
		    				<ul class="btn">
		    					<li class="active">
		    						<a href="#" title="주요정보 탭으로 이동">주요정보</a>
		    					</li>
		    					<li>
		    						<a href="#" title="실관람평 탭으로 이동">실관람평</a>
		    					</li>
		    					<li>
		    						<a href="#" title="예고편/스틸컷 탭으로 이동">예고편/스틸컷</a>
		    					</li>
		    				</ul>
		    			</div>
		    			
		    			<!-- tab-cont-wrap -->
		    			<div class="tab-cont-wrap">
			    			<!-- movie-info-list -->
			    			<div class="movie-info-list active">    			
			    			 </div>
			    			 <!-- //movie-info-list -->
			    			 
			    			 <!-- movie-comment-list -->
			    			 <div class="movie-comment-list">
								<h2>영화 한줄평 내역</h2>
								<div id="comment-count">
									<b>전체 <span class="font-gblue"></span> 건</b>						
								</div>
								<div class="comment-write">
									<span title="한줄평쓰기">한줄평쓰기</span>
									<div class="write-content">
										<form:form>
											<div class="form-txt">									
												<table>
													<tr>
														<td>
															<input type="text" id="user" value="테스트 이메일" readonly/>
															<div class="title"><h4>한줄평</h4></div>
														</td>
													</tr>
													<tr>
														<td>
															<input type="text" id="contxt" class="form-control" maxlength="40" placeholder="한줄평을 적어주세요 (40자 이내)" autocomplete="off"/>
															<select id="example-fontawesome" class="com-star" name="rating">
																<option value="1">1</option>
																<option value="2">2</option>
																<option value="3">3</option>
																<option value="4">4</option>
																<option value="5">5</option>
															</select>
														</td>
													</tr>											
												</table>
											</div>
											<input id="writeBtn" type="button" value="쓰기"/> 
											<input id="cancel" type="button" class="cancelBtn" value="취소"/> 
										</form:form>
									</div>
								</div>
								
								<div class="movie-comment">
									<ul>
									</ul>
								</div>
								
			    			 </div>
			    			 <!-- // movie-comment-list -->
			    			 
		    			 </div>
		    			 <!-- // tab-cont-wrap -->
		    		</div>
		    		<!-- // inner-wrap -->					
				</div>
				<!-- // contentData -->
			</div>
			<!-- // contents -->
		</div>
		<!-- // container -->
	</section>

	<%@include file="/WEB-INF/view/footer.jsp"%>
</body>
</html>