<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script type="text/javascript">
	$(function() {
		function getFormatDate(date) {
			var subDateArray = date.substr(0, 10).split('-');
			return subDateArray[0] + "." + subDateArray[1] + "."
					+ subDateArray[2];
		} // js 파일로 관리할 필요 있음.

		var contextPath = "${contextPath}";
		var totalNotice = "${totalNotice}";
		var page = Math.ceil(totalNotice / 10);
		var selectPage = "${selectPage}";
		

		$.get(contextPath + "/api/noticelist/"+selectPage,
				function(json) {

					var dataLength = json.length;
					if (dataLength >= 1) {
						var list = "";
						for (i = 0; i < dataLength; i++) {
							list += "<tr>";
							list += "<td>" + json[i].notNo + "</td>";
							list += "<td><a href='${contextPath}/notice?notNo="
									+ json[i].notNo + "'>" + json[i].notTitle
									+ "</a></td>"; //보여주면 안될 것 같은 정보.
							list += "<td>" + getFormatDate(json[i].notDate) + "</td>";
							list += "<tr>"
						}
						$("tbody").append(list);
					}

					var pageBtn = "";

					for (i = 1; i < page + 1; i++) {
						pageBtn += "<a title=" + i
								+ "페이지보기 href=\"noticelist?selectPage=" + i
								+ "\">" + i + "</a>"; // 더 좋은 방법이 있을 거야....
					}
					$("nav.pagination").append(pageBtn);
				});

		// 이벤트 등록
		$("#searchBtn").on("click", function(){
			//var notTitle = $("#searchTxt").val();
			var notTitle = $("#searchTxt").serialize();
			console.log($("#searchTxt").val());
			console.log($("#searchTxt").serialize());
			
			//a = "notTitle="+notTitle;
			// a로 하면 됨..
			console.log(notTitle);
			$.ajax({
				url: contextPath + "/api/noticesearch?"+notTitle,
				type:"post",
				contentType : "application/json; charset=utf-8",
				dataType: "json",
				data : notTitle,
				success : function(json){
					console.log("성공");
					console.log(json);
					
					var dataLength = json.length;
					
					
					
					
					if (dataLength >= 1) {
						var list = "";
						for (i = 0; i < dataLength; i++) {
							list += "<tr>";
							list += "<td>" + json[i].notNo + "</td>";
							list += "<td><a href='${contextPath}/notice?notNo="
									+ json[i].notNo + "'>" + json[i].notTitle
									+ "</a></td>"; //보여주면 안될 것 같은 정보.
							list += "<td>" + getFormatDate(json[i].notDate) + "</td>";
							list += "<tr>"
						}
						$("tbody").empty();
						$("tbody").append(list);
					}
					
					var page = Math.ceil(dataLength / 10);
					console.log(page);
					var pageBtn = "";

					for (i = 1; i < page + 1; i++) {
						pageBtn += "<a title=" + i
								+ "페이지보기 href=\"noticelist?selectPage=" + i
								+ "\">" + i + "</a>"; // 더 좋은 방법이 있을 거야....
					}
					$("nav.pagination").empty();
					$("nav.pagination").append(pageBtn);
				},
				error : function(){
					console.log("error > ");
				}
				
			});
		});
	});
</script>

<link rel="stylesheet" href="${contextPath}/resources/css/notice/noticeList.css">
<link rel="stylesheet" href="${contextPath}/resources/css/notice/newlayout.css">
<title>공지사항</title>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.0/css/all.min.css" rel="stylesheet">
</head>
<body>
	 <header>
		<a href="${contextPath}/main"><img id="header_ci" alt="브랜드 로고"
			src="${contextPath}/resources/images/ci.png"></a>
		<div>
			<a href="${contextPath}/login">로그인</a> <a href="#">회원가입</a> <a
				href="#">바로예매</a>
		</div>

	</header>

	<nav>
		<ul>
			<li class="nav"><a href="${contextPath}/movielist">영화</a></li>
			<li class="nav"><a href="${contextPath}/reserve">예매</a></li>
			<li class="nav"><a href="${contextPath}/theaterlist">극장</a></li>
			<li class="nav"><a href="${contextPath}/inquiry">이벤트</a></li>
			<li class="nav"><a href="${contextPath}/noticelist">고객센터</a></li>
			<li id="mypagebtn"><a href="${contextPath}/mypage"><i
					class="far fa-user"></i></a></li>
		</ul>
	</nav> 

	<section>
		<div>

			<div id="contents">
				<div id="title-wrap">
						<div class="title">
							<a href="noticelist" style="font-weight:900; color: #222;">공지사항</a>
						</div>
						<div class="title">
							<a href="inquiry">1:1 문의</a>
						</div>
				</div>


				<!-- 검색 기능 -->
				<div class="board-list-util">
					<div class="board-search">
						<input type="text" id="searchTxt" title="검색어를 입력해 주세요."
							placeholder="제목을 입력하세요." class="input-text" maxlength="15" name="notTitle">
						<button type="button" id="searchBtn" class="button purple">검색</button>
					</div>
				</div>

				<!-- 여기부터 리스트  -->
				<div class="table-wrap">
					<table class="board-list">
						<colgroup>
							<col style="width: 15%;">
							<col>
							<col style="width: 15%;">
						</colgroup>
						<thead>
							<tr>
								<th scope="col">번호</th>
								<th scope="col">제목</th>
								<th scope="col">등록일</th>
							</tr>
							
						</thead>
						<tbody>
						
						</tbody>
					</table>
				</div>

				<!-- pagination -->
				<nav class="pagination"></nav>

				<!--// pagination -->
			</div>
		</div>
	</section>
	 <footer>
		<div id="content">
			<img id="footer_ci" alt="브랜드 로고"
				src="${contextPath}/resources/images/ci.png">
			<div id="textarea">
				<p>COPYRIGHT © BoxMovie, Inc. All rights reserved</p>
				<p>대구광역시 서구 서대구로 7길2 (내당동 245-4번지 2층) ARS 053-555-1333</p>
			</div>
		</div>
	</footer>

</body>
</html>