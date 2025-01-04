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

.modal-content {
	background-color: #fff;
	padding: 15px;
	width: 630px;
	height: 430px;
	border: none;
	display: flex;
	margin: auto;
}

.modal-left {
	display: flex;
	flex-direction: column;
	width: 50%;
	height: 100%
}

.instargram-id {
	font-size: 12px;
	margin-bottom: 10px;
}

.style-image {
	width: 291px;
	height: 394px;
}

.modal-right {
	display: flex;
	flex-direction: column;
	align-items: center;
	width: 50%;
	height: 430px;
	position: relative;
}

.item-detail {
	margin: 0px;
	padding: 0px;
	cursor: pointer;
	background: none;
	border: none;
}

.item-image {
	width: 177px;
	height: 239px;
	margin-top: 45px;
}

.item-name {
	width: 177px;
	margin-top: 8px;
	font-size: 14px;
}

.item-price {
	width: 177px;
	margin: 3px;
	color: gray;
	font-size: 12px;
}

.buy {
	width: 177px;
	height: 40px;
	background: none;
	margin-top: 20px;
	font-size: 12px;
	border: 0.2px solid black;
	cursor: pointer;
}
</style>
</head>
<body>
	<div class="modal-content">
		<div class="modal-left">
			<p class="instargram-id">${style.instagramId}</p>
			<img class="style-image" alt="스타일 이미지 URL" src="${style.imageUrl}">
		</div>
		<div class="modal-right">
			<button class="item-detail">
				<img class="item-image" alt="상품 이미지 URL" src="${product.imageUrl}">
			</button>
			<p class="item-name">${product.productName}</p>
			<p class="item-price">${product.price}</p>
			<button class="buy" onclick="buyProduct('${product.productId}')">구매하기</button>
		</div>
	</div>
	<script>
	function buyProduct(productId) {
	    window.parent.closeModal(event);
	    window.parent.location.href= `/shop/item?id=${productId}`;
	}
	</script>
</body>
</html>