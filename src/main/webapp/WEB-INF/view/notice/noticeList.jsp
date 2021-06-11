<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="<%=request.getContextPath() %>" />
<%-- <c:set var="pageNo" value="<%=request.getAttribute("pageNo") %>"/> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script type="text/javascript">
	$(function(){
		function getFormatDate(date){
			var subDateArray = date.substr(0,10).split('-');
			return subDateArray[0] + "." + subDateArray[1] + "." + subDateArray[2]; 
		} // js 파일로 관리할 필요 있음.
		
		var contextPath = "${contextPath}";
		var totalNotice = "${totalNotice}";
		var page = Math.ceil(totalNotice/10);
		var selectPage = "${selectPage}";
		
		$.get(contextPath+"/api/noticelist/"+ selectPage, function(json) {
			
			var dataLength = json.length;
			if(dataLength >= 1){
				var list = "";
				for(i = 0 ; i < dataLength ; i++){
					list += "<tr>";
					list += "<td>" + json[i].notNo + "</td>"; 
					list += "<td><a href='${contextPath}/notice?notNo=" + json[i].notNo + "'>" + json[i].notTitle+  "</a></td>"; //보여주면 안될 것 같은 정보.
					list += "<td>" + getFormatDate(json[i].notDate) + "</td>";
					list += "<tr>"
				}
				$("tbody").append(list);
			};
			
			var pageBtn = "";
			
			for(i = 1; i < page + 1; i++){
					pageBtn += "<a title="+ i +"페이지보기 href=\"javascript:void(0)\" pageNo="+ i + ">" + i + "</a>";
			}
			$("nav.pagination").append(pageBtn);
		});
	});
</script>
<link rel="stylesheet" href="${contextPath}/resources/css/notice/noticeList.css">
<title>Insert title here</title>

</head>
<body>


<div id="notice-wrap">

	<div id="contents">
		<h2 class="tit">공지사항</h2>

		<!-- <div class="tab-block mb30">
			<ul>
				<li class="on tabBtn"><button type="button" class="btn tabBtn"
						data-no="" title="전체공지 보기">전체</button></li>

				<li class="tabBtn"><button type="button" class="btn"
						data-no="81" title="메가박스 공지 보기">메가박스 공지</button></li>

				<li class="tabBtn"><button type="button" class="btn"
						data-no="82" title="지점 공지 보기">지점 공지</button></li>

			</ul>
		</div> -->


<!-- 검색 기능 -->
		  <div class="board-list-util">
			<!-- <p class="result-count">
				<strong>전체 <em class="font-gblue">5,645</em>건
				</strong>
			</p> -->

			<div class="dropdown bootstrap-select mr07 bs3">
				<select id="theater" title="지역 선택" class="mr07" tabindex="-98"><option
						class="bs-title-option" value=""></option>
					<option value="">지역 선택</option>

					<option value="10">서울</option>

					<option value="30">경기</option>

					<option value="35">인천</option>

					<option value="45">대전/충청/세종</option>

					<option value="55">부산/대구/경상</option>

					<option value="65">광주/전라</option>

					<option value="70">강원</option>

					<option value="80">제주</option>

				</select>
				<button type="button"
					class="btn dropdown-toggle btn-default bs-placeholder"
					data-toggle="dropdown" role="button" data-id="theater"
					title="지역 선택">
					<div class="filter-option">
						<div class="filter-option-inner">
							<div class="filter-option-inner-inner">지역 선택</div>
						</div>
					</div>
					<span class="bs-caret"><span class="caret"></span></span>
				</button>
				
				<div class="dropdown-menu open" role="combobox">
					<div class="inner open" role="listbox" aria-expanded="false"
						tabindex="-1">
						<ul class="dropdown-menu inner "></ul>
					</div>
				</div>
			</div>

			<div class="dropdown bootstrap-select disabled mr07 bs3">
				<select id="theater02" title="극장 선택" disabled="disabled"
					class="mr07" tabindex="-98"><option
						class="bs-title-option" value=""></option>
					<option value="">극장 선택</option>

				</select>
				<button type="button"
					class="btn dropdown-toggle disabled btn-default bs-placeholder"
					data-toggle="dropdown" role="button" data-id="theater02"
					tabindex="-1" aria-disabled="true" title="극장 선택">
					<div class="filter-option">
						<div class="filter-option-inner">
							<div class="filter-option-inner-inner">극장 선택</div>
						</div>
					</div>
					<span class="bs-caret"><span class="caret"></span></span>
				</button>
				<div class="dropdown-menu open" role="combobox">
					<div class="inner open" role="listbox" aria-expanded="false"
						tabindex="-1">
						<ul class="dropdown-menu inner "></ul>
					</div>
				</div>
			</div>

			<div class="board-search">
				<input type="text" id="searchTxt" title="검색어를 입력해 주세요."
					placeholder="검색어를 입력해 주세요." class="input-text" value=""
					maxlength="15">
				<button type="button" id="searchBtn" class="btn-search-input">검색</button>
			</div>
		</div>
		
<!-- 여기부터 리스트  -->
		<div class="table-wrap">
			<table class="board-list">
				<caption>번호, 극장, 구분, 제목, 등록일이 들어간 공지사항 전체 리스트</caption>
				<colgroup>
					<col style="width: 72px;">
					<col>
					<col style="width: 116px;">
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
		<nav class="pagination">
			<!-- <strong class="active">1</strong> 
			<a title="2페이지보기" href="javascript:void(0)" pagenum="2">2</a> 
			<a title="3페이지보기" href="javascript:void(0)" pagenum="3">3</a> 
			<a title="10페이지보기" href="javascript:void(0)" pagenum="10">10</a>  
			<a title="이후 10페이지 보기" href="javascript:void(0)" class="control next" pagenum="11">next</a>
			<a title="마지막 페이지 보기" href="javascript:void(0)" class="control last"pagenum="565">last</a> -->
		</nav> 
		
		<!--// pagination -->
	</div>
	</div>
</body>
</html>