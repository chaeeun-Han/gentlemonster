<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
				<div style="height: 150px">사진 넣는 구간</div><br>
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
					<button
						style="width: 150px; height: 30px; font-size: 10px; border-radius: 20px;">
						장바구니 담기</button>
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
</body>

</html>