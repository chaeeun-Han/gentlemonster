<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://kit.fontawesome.com/cf6e255851.js"
	crossorigin="anonymous"></script>
<!-- custom css -->
<link rel="stylesheet" type="text/css" href="/css/cart.css">

<!-- Bootstrap JS, Popper.js -->
<script
   src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script
   src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="modal-top">
		<p class="title">장바구니</p>
		<div class="item-list">
			<c:forEach var="cartItem" items="${cartList}">
				<div class="item" data-cartid="${cartItem.getCartId()}">
					<input type="checkbox" class="checkbox" id="checkbox" checked>
					<button class="item-detail">
						<img class="item-image" alt="장바구니 상품 이미지 URL"
							src="${cartItem.getMainImage()}">
					</button>
					<div class="item-info">
						<p class="item-name">${cartItem.getProductName()}</p>
						<p class="item-price">${cartItem.getPrice()}</p>
						<div class="item-quantity">
							<button class="decrease" onclick="decreaseEvent()">-</button>
							<span class="quantity">${cartItem.getProductCount()}</span>
							<button class="increase" onclick="increaseEvent()">+</button>
						</div>
						<button class="item-delete" data-bs-toggle="modal" data-bs-target="#delete-modal" data-cartid="${cartItem.getCartId()}">삭제</button>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
	<div class="modal-bottom">
		<div class="count-info">
			<p>배송비</p>
			<p>무료</p>
		</div>
		<div class="count-info">
			<p>합계</p>
			<p><span id="totalAmount">0</span>원</p>
		</div>
		<button class="purchase">구매하기</button>
	</div>
	<script src="/js/cart.js"></script> 
</body>
</html>