<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title>details</title>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #f5f5f5;
}
.product-container {
	display: flex;
	flex-wrap : wrap;
	max-width: 1200px;
	margin: 10px auto;
	background: #fff;
	border: 1px solid #ddd;
	padding: 40px;
	border-radius: 8px;
}
.product-images {
	display:flex;
	flex-wrap: wrap;
	max-width: 600px;
	justify-content: space-between;
}
.product-images .main-image {
	flex : 0 1 calc(50%- 5px);
	box-sizing: border-box;
	text-align: center;
}
.product-images .main-image img{
	width: 100%;
	margin: 20px;
	max-width: 250px;
	border-radius: 8px;
}
.product-images .sub-images img {
	width: 80px;
	margin: 5px;
	border-radius: 4px;
	cursor: pointer;
}
.product-details {
	flex: 1;
	padding: 20px;
}
.product-details h1 {
	font-size: 24px;
	margin-bottom: 10px;
}
.product-details p {
	margin: 10px 0;
}
.notification-btn {
	padding: 10px 20px;
	background-color: #007bff;
	color: #fff;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}
</style>
<style type="text/css">
div#side_right {
	width: 300px;
	height: 700px;
	float: right;
	background-color: white;
}
</style>
<style type="button">
      div#btn {
        width: 50px;
      }
    </style>
</head>
<body>
	<div class="product-container">
		<div class="product-images">
			<!-- 이미지 리스트를 JSTL로 출력 -->
			<c:forEach var="image" items="${imageList}">
				<div class="main-image">
					<img src="${image.imageUrl}" alt="Main Image" class="main-image">
				</div>
			</c:forEach>
		</div>
		
		<div>
	</div>
	<div class="product-details">
			<div id="side_right">
				<br><br><br>
				<div style="width: 150px; float: left">${product.productName}</div>
				<div style="float: right">${product.price}</div>
				<br><br>
				<br>
				<div style="height: 200px; text-align: center">${product.discription}</div><br><br>
				<div style="text-align: center">
					<c:choose>
					<c:when test="${product.productCount eq null }">
						<button
						style="width: 150px; height: 30px; font-size: 10px; background-color: black; border-radius: 20px; color: white;">
						임시 품절 상품입니다.</button>
					<br> <br>
					</c:when>
					<c:otherwise>
					<button
						style="width: 150px; height: 30px; font-size: 10px; background-color: black; border-radius: 20px; color: white;">
						구매하기</button>
					<br> <br>
					<button id="addBtn" style="width: 150px; height: 30px; font-size: 10px; border-radius: 20px;" data-itemid="${product.productId}" type="button">장바구니 담기</button>
					<br> <br>
					</c:otherwise>				
					</c:choose>
				</div>
				<hr style="color: gray">
				<div style="text-align:left; color:gray">제품 세부 정보</div><br>
				<div style="height: 150px; text-align: left">
					${product.detail}
				</div>
			</div>
		</div>
		
		<!-- modal 띄우기 -->
		<div id="cart-modal">
			<div class="cart-modal-content">
			<!-- 외부 modal 불러오는 곳 -->
			
			</div>
		</div>
		
		<script>
			document.querySelector('#addBtn').addEventListener('click', function() {
		        const itemId = this.dataset.itemid;
		        const params = new URLSearchParams();
		        params.append('itemid', itemId);
		        console.log(itemId);
		        fetch('/shop/cart', {
		            method: 'POST',
		            headers: {
		                'Content-Type': 'application/x-www-form-urlencoded',
		            },
		            body: params
		        }).then(response => {
		            if (!response.ok) {
		                throw new Error('장바구니 추가 실패');
		            }
		            console.log('장바구니 추가 성공');
		            openCartModal();
		        }).catch(error => {
		            console.error('오류:', error);
		        });
		    });
		</script>
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
		<script src="/js/cart.js"></script> 
		<script>
			// 모달 열기
		    function openCartModal() {
		      $('.cart-modal-content').load("/shop/cart", function () {
		    	  calculateTotal();
		    	  initializeEvents();
		      });
		      // const modal = document.getElementById('cart-modal');
		      // modal.classList.add('show');  // show 클래스 추가하여 모달 보이기
	          // modal.querySelector('.cart-modal-content').classList.add('show'); 
	          console.log("열기 버튼 클릭");
	          document.querySelector("#cart-modal").style.visibility = "visible";
	          document.querySelector(".cart-modal-content").style.transform = "translateX(0)";
	          document.querySelector("#cart-modal").style.opacity = "1";
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
		                deleteItem(cartId);
		            };
		        });

		        console.log("이벤트 초기화 완료.");
		    }
		    
			// 모달 닫기
			function closeModal() {
				document.querySelector("#cart-modal").style.visibility = "hidden";
				console.log("닫기 됨");
				window.updateCart();
			}
			// 모달 외부 클릭 시 닫기
			window.onclick = function(event) {
				const modal = document.querySelector("#cart-modal");
				if (event.target === modal) {
					closeModal();
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
		        <button type="button" id="delete-btn" data-cartid="" onclick="add()" class="btn btn-lg btn-link fs-6 text-decoration-none col-6 m-0 rounded-0 border-right"><strong>삭제</strong></button>
		        <button type="button" id="close-delete" data-bs-dismiss="modal" aria-level="Close" class="btn btn-lg btn-link fs-6 text-decoration-none col-6 m-0 rounded-0">취소</button>
		      </div>
		    </div>
	    </div> 
	</div>
</body>

</html>