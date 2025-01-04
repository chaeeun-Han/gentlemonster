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
#search-modal {
   visibility: hidden;
   display: flex;
   justify-content: center;
   align-items: center;
   position: fixed;
   z-index: 1000;
   left: 0;
   top: 0;
   width: 100%;
   height: 70%;
   background-color: rgba(255, 255, 255, 0.7);
}
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
  color: black; 
  text-decoration: none; 
  margin-right: 10px; 
}
#cartButton {
    background-color: transparent;  
    border: none;  
    padding: 0;  
    cursor: pointer;  
    outline: none;  
}

#cartButton svg {
    vertical-align: middle;  /* 아이콘 수평 정렬 */
}

</style>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
  <header class="p-3">
    <div class="container-fluid">
      <div
        class="d-flex flex-wrap align-items-center justify-content-between">
        <a href="/shop?bigCategoryId=1&smallCategoryId=view-all">
          <img alt="Logo" src="/images/Logo.png" width="250">
      </a>


        <ul class="nav justify-content-center">
          <li><a href="/shop?bigCategoryId=1&smallCategoryId=view-all" class="nav-link px-2 link-body-emphasis">선글라스</a></li>
          <li><a href="/shop?bigCategoryId=2&smallCategoryId=view-all" class="nav-link px-2 link-body-emphasis">안경</a></li>
          <li><a href="/styles" class="nav-link px-2 link-body-emphasis">스타일</a></li>
        </ul>

        <div class="d-flex align-items-center">
          <form class="me-3" role="search">
            <input type="search" class="custom-search" onClick="openModal()"
              placeholder="검색어를 입력하세요" aria-label="Search">
          </form>
        <div id="search-modal">
         <div class="modal-content">
            <iframe id="modal-iframe"
               style="width: 100%; height: 500px; border: none;">
            </iframe>
         </div>
        </div>
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
          <button id="cartButton" class="btn" onclick="openHeaderCartModal()" class="open">
             <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-bag" viewBox="0 0 16 16">
               <path d="M8 1a2.5 2.5 0 0 1 2.5 2.5V4h-5v-.5A2.5 2.5 0 0 1 8 1m3.5 3v-.5a3.5 3.5 0 1 0-7 0V4H1v10a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V4zM2 5h12v9a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1z"/>
             </svg>
             <!-- 장바구니 배지 -->
             <span class='badge' id='lblCartCount'> ${cart_count} </span>
        </button>
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
 <script>
 // 검색 모달
 function openModal() {
     const iframe = document.querySelector("#modal-iframe");
     iframe.src = "/shop/search";
     document.querySelector("#search-modal").style.visibility = "visible";
 }
 
 function closeModal() {
     document.querySelector("#search-modal").style.visibility = "hidden";
     document.querySelector("#modal-iframe").src = "";
 }
 
 window.onclick = function(event) {
     const modal = document.querySelector("#search-modal");
     if (event.target === modal) {
        closeModal();
     }
 }
 </script>
 
 <!-- 장바구니 모달 -->
    <div id="header-cart-modal">
       <div class="header-cart-modal-content">
       <!-- 외부 modal 불러오는 곳 -->
       
       </div>
    </div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
      <script>
         // 모달 열기
          function openHeaderCartModal() {
            // 모달이 로드된 후에 load() 호출
            $('.header-cart-modal-content').load("/shop/cart", function () {
               calculateTotal();
               initializeEvents();
            });
             document.querySelector("#header-cart-modal").style.visibility = "visible";
             document.querySelector(".header-cart-modal-content").style.transform = "translateX(0)";
             document.querySelector("#header-cart-modal").style.opacity = "1";
         }       
           //이벤트 초기화
          function initializeEvents() {

              // 수량 증가
              document.querySelectorAll('.increase').forEach(button => {
                  button.onclick = function () {
                      let quantityElement = this.closest('.item').querySelector('.quantity');
                      let currentQuantity = parseInt(quantityElement.textContent, 10);
                      quantityElement.textContent = currentQuantity + 1;
                      calculateTotal();
                  };
              });

              // 수량 감소
              document.querySelectorAll('.decrease').forEach(button => {
                  button.onclick = function () {
                      let quantityElement = this.closest('.item').querySelector('.quantity');
                      let currentQuantity = parseInt(quantityElement.textContent, 10);
                      if (currentQuantity > 1) {
                          quantityElement.textContent = currentQuantity - 1;
                          calculateTotal();
                      }
                  };
              });

              // 삭제 버튼
              document.querySelectorAll('.item-delete').forEach(button => {
                  button.onclick = function () {
                      let cartId = this.dataset.cartid;
                      let targetElement = document.getElementById('delete-btn'); 
                     targetElement.dataset.cartid = cartId;
                      
                  };
              });
              
              console.log("이벤트 초기화 완료.");
          }
         // 모달 닫기
         function closeCartModal() {
            document.querySelector("#header-cart-modal").style.visibility = "hidden";
            window.updateCart();
         }
         // 모달 외부 클릭 시 닫기
         window.onclick = function(event) {
            const modal = document.querySelector("#header-cart-modal");
            if (event.target === modal) {
            	closeCartModal();
            }
         }
      </script>
      
   <!-- 삭제 버튼 클릭시 modal 띄우기 -->   
   <div class="modal" id="delete-modal" tabindex="-1" aria-labelledby="delete-modal" aria-hidden="true">
      <div class="modal-dialog" role="document">
         <div class="modal-content rounded-4 shadow">
            <div class="modal-body p-4 text-center">
              <h5>삭제하시겠습니까?</h5>
              <p class="mb-0">장바구니에서 해당 상품을 삭제 시 복구되지 않습니다.</p>
            </div>
            <div class="modal-footer flex-nowrap p-0">
              <button type="button" id="delete-btn"  data-bs-dismiss="modal" data-cartid="" onclick="deleteItem()" class="btn btn-lg btn-link fs-6 text-decoration-none col-6 m-0 rounded-0 border-right"><strong>삭제</strong></button>
              <button type="button" id="close-delete" data-bs-dismiss="modal" aria-level="Close" class="btn btn-lg btn-link fs-6 text-decoration-none col-6 m-0 rounded-0">취소</button>
            </div>
          </div>
       </div> 
    </div>
    <script>
       //아이템 삭제
       function deleteItem() {
          let getElement = document.getElementById("delete-btn");
          let cartId = getElement.dataset.cartid;
          console.log('cartid : ' + cartId);

          const params = new URLSearchParams();
          params.append('cartid', cartId);
          
          if (!cartId) {
             console.warn('cartId is null');
             return;
          }
          fetch('/shop/cart?action=DELETE', {
             method: 'POST',
             headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
             },
             body: params
           })
           .then(response => {
               if (!response.ok) {
                   console.warn('Item delete may have failed.');
               } else {
                  openHeaderCartModal();
               }
           })
           .catch(error => {
               console.error('Error deleting cart:', error);
           });
       }
    </script>      
</body>
</html>