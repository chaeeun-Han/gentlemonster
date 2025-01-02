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

#style-modal {
	visibility: hidden;
	display: flex;
	justify-content: center;
	align-items: center;
	position: fixed;
	z-index: 1;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(255, 255, 255, 0.7);
}

.modal-content {
	background-color: #fff;
	padding: 15px;
	width: 630px;
	height: 430px;
	border: none;
	display: flex;
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
	height: 100%;
	position: relative;
}

.close {
	position: absolute;
	right: 0px;
	background: none;
	border: none;
	text-align: right;
	font-size: 14px;
	cursor: pointer;
	background: none;
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
	<div class="modal-left">
		<p class="instargram-id">@${instagramId}</p>
		<img class="style-image" alt="스타일 이미지 URL"
			src="${imageUrl}">
	</div>
	<div class="modal-right">
		<button class="close">
			<i class="fa-solid fa-xmark"></i>
		</button>
		<button class="item-detail">
			<img class="item-image" alt="상품 이미지 URL"
				src="">
		</button>
		<p class="item-name">${productId}</p>
		<p class="item-price">상품 가격</p>
		<button class="buy">구매하기</button>
	</div>
</body>
</html>