<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://kit.fontawesome.com/cf6e255851.js"
	crossorigin="anonymous"></script>
<title>Insert title here</title>
<style>
p {
	margin: 0px;
}

#cart-modal {
	visibility: hidden;
	position: fixed;
	z-index: 1;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.1);
	transition: opacity 0.3s ease, visibility 0.3s ease, transform 0.3s ease;
}

#cart-modal.show {
	visibility: visible;
	opacity: 1;
}

.modal-content {
	background-color: #fff;
	position: fixed;
	right: 0;
	top: 0;
	padding: 20px;
	width: 375px;
	height: 100%;
	border: none;
	display: flex;
	flex-direction: column;
	transform: translateX(100%);
	transition: transform 0.3s ease;
}

#cart-modal.show .modal-content {
	transform: translateX(0);
}

.modal-top {
	display: flex;
	flex-direction: column;
	position: relative;
}

.close {
	position: absolute;
	right: 0px;
	background: none;
	border: none;
	text-align: right;
	font-size: 20px;;
	cursor: pointer;
	background: none;
	padding: 0px;
}

.title {
	font-weight: bold;
}

.item-list {
	margin-top: 10px;
	max-height: 710px;
	overflow-y: auto;
	max-height: 710px;
}

.item-list::-webkit-scrollbar {
	width: 5px;
}

.item-list::-webkit-scrollbar-track {
	background: #f9f9f9;
	border-radius: 10px;
}

.item-list::-webkit-scrollbar-thumb {
	background: #f1f1f1;
	border-radius: 10px;
}

.item-list::-webkit-scrollbar-thumb:hover {
	background: #c7c7c7;
	cursor: pointer;
}

.item {
	display: flex;
	margin: 20px 0px;
	position: relative;
}

.checkbox {
	margin-right: 5px;
	position: absolute;
	top: -5px;
	left: 5px;
	cursor: pointer;
}

.item-detail {
	margin-left: 10px;
	padding: 0px;
	cursor: pointer;
	background: none;
	border: none;
	cursor: pointer;
}

.item-image {
	width: 85px;
	height: 115px;
}

.item-info {
	margin-left: 20px;
	width: calc(100% - 110px);
	display: flex;
	flex-direction: column;
	position: relative;
}

.item-name {
	font-size: 14px;
}

.item-price {
	margin-top: 5px;
	color: gray;
	font-size: 12px;
}

.item-quantity {
	display: flex;
	align-items: center;
	margin-top: auto;
	margin-bottom: 3px;
	border: 0.3px solid black;
	width: 90px;
}

.item-quantity button {
	background: none;
	border: none;
	font-size: 16px;
	width: 30px;
	height: 30px;
	cursor: pointer;
}

.quantity {
	margin: 0 10px;
	font-size: 14px;
}

.item-delete {
	border: none;
	background: none;
	position: absolute;
	right: 0px;
	bottom: 0px;
	text-decoration: underline;
	font-size: 12px;
	color: gray;
	cursor: pointer;
}

.modal-bottom {
	display: flex;
	flex-direction: column;
	margin-top: 25px;
}

.count-info {
	display: flex;
	justify-content: space-between;
	font-size: 14px;
	margin-bottom: 10px;
}

.purchase {
	border: none;
	background-color: black;
	color: white;
	height: 40px;
	margin-top: 20px;
	cursor: pointer;
}
</style>
</head>
<body>
	<button class="open">장바구니 모달(장바구니 추가 클릭 시 / 장바구니 아이콘 클릭 시)</button>
	<div id="cart-modal">
		<div class="modal-content">
			<div class="modal-top">
				<button class="close">
					<i class="fa-solid fa-xmark"></i>
				</button>
				<p class="title">장바구니</p>
				<div class="item-list">
					<div class="item">
						<input type="checkbox" class="checkbox" id="checkbox" checked>
						<button class="item-detail">
							<img class="item-image" alt="장바구니 상품 이미지 URL"
								src="https://www-prd-kr.gentlemonster.com/media/catalog/product/cache/6c6f229b8a7ab97f51028776641e27d1/1/1/11001_LIMITLESS_SPC9_2.jpg">
						</button>
						<div class="item-info">
							<p class="item-name">상품명</p>
							<p class="item-price">가격</p>
							<div class="item-quantity">
								<button class="decrease">-</button>
								<span class="quantity">1</span>
								<button class="increase">+</button>
							</div>
							<button class="item-delete">삭제</button>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-bottom">
				<div class="count-info">
					<p>배송비</p>
					<p>무료</p>
				</div>
				<div class="count-info">
					<p>합계</p>
					<p>원</p>
				</div>
				<button class="purchase">구매하기</button>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		// 수량 관련 버튼 및 수량 표시를 각 아이템에 대해 다르게 처리
	    const decreaseButtons = document.querySelectorAll('.decrease');
	    const increaseButtons = document.querySelectorAll('.increase');
	    const quantityDisplays = document.querySelectorAll('.quantity');
	
	    // 각 버튼에 클릭 이벤트를 추가
	    decreaseButtons.forEach((button, index) => {
	        button.onclick = function() {
	            let currentQuantity = parseInt(quantityDisplays[index].innerText);
	            if (currentQuantity > 1) {
	                quantityDisplays[index].innerText = currentQuantity - 1;
	            }
	        }
	    });
	
	    increaseButtons.forEach((button, index) => {
	        button.onclick = function() {
	            let currentQuantity = parseInt(quantityDisplays[index].innerText);
	            quantityDisplays[index].innerText = currentQuantity + 1;
	        }
	    });
	
	    // 모달 관련 요소
	    const modal = document.querySelector('#cart-modal');
	    const openModalBtn = document.querySelector('.open');
	    const closeModalBtn = document.querySelector('.close');
	
	 	// 모달 열기
	    openModalBtn.onclick = function() {
	        // modal.style.visibility = "visible";
	    	modal.classList.add('show');
	    }
	
	 	// X 버튼으로 모달 닫기
	    closeModalBtn.onclick = function() {
	        // modal.style.visibility = "hidden";
	    	modal.classList.remove('show');
	    }
	
	 	// 모달 외부 클릭으로 모달 닫기
	    window.onclick = function(event) {
	        if (event.target == modal) {
	            // modal.style.visibility = "hidden";
	        	modal.classList.remove('show');
	        }
	    }
    </script>
</body>
</html>