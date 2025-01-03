<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Top Navigation Bar</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
<style>
.custom-search {
  border: 1px solid black; /* 검은 테두리 */
  border-radius: 28px; /* 둥글게 처리 */
  padding: 0.8rem; /* 내부 여백 */
  outline: none; /* 포커스 시 외곽선 제거 */
  font-size: 11pt;
  width: 200px;
  height: 40px;
}

.custom-search:focus {
  border-color: black; /* 포커스 시 테두리 색상 유지 */
  box-shadow: 0 0 5px rgba(0, 0, 0, 0.5); /* 포커스 시 약간의 그림자 효과 */
}

.badge {
  padding-left: 9px;
  padding-right: 9px;
  -webkit-border-radius: 9px;
  -moz-border-radius: 9px;
  border-radius: 9px;
}

#lblCartCount {
  font-size: 12px;
  color: black;
  padding: 0 5px;
  vertical-align: top;
  margin-left: -5px;
}

/* 로그인 스타일 */
a.login-link {
  color: black; /* 글씨색 검정 */
  text-decoration: none; /* 밑줄 제거 */
  margin-right: 10px; /* SVG와 간격 추가 */
}
</style>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
  <header class="p-3">
    <div class="container-fluid">
      <div
        class="d-flex flex-wrap align-items-center justify-content-between">
        <img alt="#" src="/images/Logo.png" width="250">

        <ul class="nav justify-content-center">
          <li><a href="/shop?bigCategoryId=1&smallCategoryId=view-all" class="nav-link px-2 link-body-emphasis">선글라스</a></li>
          <li><a href="/shop?bigCategoryId=2&smallCategoryId=view-all" class="nav-link px-2 link-body-emphasis">안경</a></li>
          <li><a href="/styles" class="nav-link px-2 link-body-emphasis">스타일</a></li>
        </ul>

        <div class="d-flex align-items-center">
          <form class="me-3" role="search">
            <input type="search" class="custom-search"
              placeholder="검색어를 입력하세요" aria-label="Search">
          </form>
          <!-- 로그인 링크 -->
          <form id="logoutForm" action="/member/logout" method="post" style="display: none;"></form>
          <c:choose>
		    <c:when test="${empty userid}">
		        <a href="#" data-bs-toggle="modal" data-bs-target="#loginModal" class="m-2 text-decoration-none text-reset">로그인</a>
		    </c:when>
		    <c:otherwise>
		        <a href="#" class="m-2 text-decoration-none text-reset" onclick="document.getElementById('logoutForm').submit(); return false;">로그아웃</a>
		    </c:otherwise>
		  </c:choose>
          <!-- 회원가입 링크 -->
          <a href="/member/join" class="m-2 text-decoration-none text-reset">${empty userid ? "회원가입" : ""}</a>
          <!-- 구매 내역 링크 -->
          <c:choose>
		    <c:when test="${empty userid}">
		        <a href="#" data-bs-toggle="modal" data-bs-target="#alertModal" class="m-2 text-decoration-none text-reset">구매내역</a>
		    </c:when>
		    <c:otherwise>
		        <a href="/shop/purchase-list" class="m-2 me-3 text-decoration-none text-reset">구매내역</a>
		    </c:otherwise>
		  </c:choose>
          <!-- 쇼핑백 아이콘 -->
          <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-bag" viewBox="0 0 16 16">
            <path d="M8 1a2.5 2.5 0 0 1 2.5 2.5V4h-5v-.5A2.5 2.5 0 0 1 8 1m3.5 3v-.5a3.5 3.5 0 1 0-7 0V4H1v10a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V4zM2 5h12v9a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1z"/>
          </svg>
          <!-- 장바구니 배지 -->
          <span class='badge' id='lblCartCount'> ${cart_count} </span>
        </div>
        
		<div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
		    <div class="modal-dialog" style="min-height: auto;" role="document">
		        <div class="modal-content rounded-5 shadow" style="height: auto; max-height: 400px;">
		            <div class="modal-header p-5 pb-4 border-bottom-0">
		                <h2 class="fw-bold mb-0">로그인</h2>
		                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		            </div>
		            <div class="modal-body p-5 pt-0">
		                <form action="/member/login" method="post">
		                    <div class="form-floating mb-3">
		                        <input type="text" class="form-control rounded-4" name="userid", id="floatingInput" placeholder="아이디">
		                        <label for="floatingInput">아이디</label>
		                    </div>
		                    <div class="form-floating mb-3">
		                        <input type="password" class="form-control rounded-4" name="password" id="floatingPassword" placeholder="비밀번호">
		                        <label for="floatingPassword">비밀번호</label>
		                    </div>
		                    <button class="w-100 mb-2 btn btn-lg rounded-4 btn-primary" type="submit">로그인</button>
		                </form>
		            </div>
		        </div>
		    </div>
		</div>
		
		<div class="modal fade" id="alertModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">로그인이 필요합니다.</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
		        	구매 내역을 확인하시려면 로그인해주세요.
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">확인</button>
		      </div>
		    </div>
		  </div>
		</div>
    </div>
  </header>
</body>


</html>