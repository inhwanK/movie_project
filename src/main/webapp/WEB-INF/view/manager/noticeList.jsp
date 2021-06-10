<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/latest/css/bootstrap.min.css">
<script src="//code.jquery.com/jquery.min.js"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/latest/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="css/sidebar.css">
</head>
<body>
<div id="page-wrapper">
  <!-- 사이드바 -->
  <div id="sidebar-wrapper">
    <ul class="sidebar-nav">
      <li class="sidebar-brand">
        <a href="#">관리자 페이지</a>
      </li>
      <li><a href="${contextPath }/main">HOME</a></li>
      <li><a href="${contextPath }/movieManager">영화 관리</a></li>
      <li><a href="${contextPath }/reserveManager">예매 관리</a></li>
      <li><a href="${contextPath }/showInfoManager">상영시간 관리</a></li>
      <li><a href="${contextPath }/memberManager">회원 관리</a></li>
      <li><a href="${contextPath }/salesManager">매출 조회</a></li>
      <li><a href="${contextPath }/noticeManager">공지사항</a></li>
      <li><a href="${contextPath }/inquiryManager">문의사항</a></li>
    </ul>
  </div>
  <!-- /사이드바 -->

  <!-- 본문 -->
  <div id="page-content-wrapper">
    <div class="container-fluid">
      <h1 class="text-center">공지사항</h1>
      <button class="btn btn-primary">등록</button>
      <table class="table table-hover table-striped text-center" style="border: 1px solid;">
      	<thead>
      		<tr>
      			<th>번호</th>
      			<th>제목</th>
      			<th>등록일</th>
      			<th></th>
      			<th></th>
      		</tr>
      	</thead>
      	<tbody>
      		<tr>
      			<td>1</td>
      			<td>공지1</td>
      			<td>2021-05-30</td>
      			<td><button class="btn btn-primary">수정</button></td>
      			<td><button class="btn btn-primary">삭제</button></td>
      		</tr>
      		<tr>
      			<td>2</td>
      			<td>공지2</td>
      			<td>2021-05-31</td>
      			<td><button class="btn btn-primary">수정</button></td>
      			<td><button class="btn btn-primary">삭제</button></td>
      		</tr>
      		<tr>
      			<td>3</td>
      			<td>공지3</td>
      			<td>2021-06-01</td>
      			<td><button class="btn btn-primary">수정</button></td>
      			<td><button class="btn btn-primary">삭제</button></td>
      		</tr>
      	</tbody>
      </table>
    </div>
  </div>
</div>
</body>
</html>