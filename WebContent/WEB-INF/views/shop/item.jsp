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
<title>${ product.productName }</title>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #f5f5f5;
}

.product-container {
	display: flex;
	/* flex-wrap: wrap; */
	flex-direction: row;
	max-width: 100%;
	max-height: 100%;
	margin: 10px auto;
	background: #fff;
	border: 1px solid #ddd;
	padding: 40px;
}

.product-images {
	display: flex;
	flex-wrap: wrap;
	max-width: 600px;
	justify-content: space-between;
}

.product-images .main-image {
	flex: 0 1 50%;
	box-sizing: border-box;
}

.product-images .main-image img {
	width: 100%;
	margin: 20px;
	max-width: 250px;
	border-radius: 8px;
}

.product-images .sub-images {
	/* flex: 1 0 calc(50% - 5px); */
	flex: 1 0 50%;
	box-sizing: border-box;
}

.product-images .sub-images a img {
	width: 30%;
	margin: 2px;
	border-radius: 4px;
	cursor: pointer;
	border: 1px solid transparent;
	transition: border 0.3s ease;
}

.product-images .sub-images a img:hover{
	border: 2px solid black;
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
        width: 70px;
      }
    </style>
</head>
<body>
	<jsp:include page="/header.jsp"></jsp:include>
	<div class="product-container">
		<div class="product-images">
			<!-- 이미지 리스트를 JSTL로 출력 -->
			<c:forEach var="image" items="${imageList}">
				<div class="main-image">
					<img src="${image.imageUrl}" alt="Main Image" class="main-image">
				</div>
			</c:forEach>
		</div>

		<div></div>
		<div class="product-details">
			<div id="side_right">
				<br> <br> <br>
				<div
					style="width: 150px; font-weight: bold; font-size: 22px; float: left">${product.productName}</div>
				<div style="float: right">${product.price}원</div>
				<br> <br>
				<br>
				<div class="product-images">
					<div class="sub-images">
						<!-- 이미지 리스트를 JSTL로 출력 -->
						<c:forEach var="images" items="${mainImage}" varStatus="status">
							<a href="/shop/item?id=${images.productId}"> <img
								src="${images.imageUrl}" alt="Sub Image ${status.index }">
							</a>
						</c:forEach>
					</div>
				</div>
				<br>
				<div style="height: 200px; text-align: center; font-size:14px">${product.discription}</div>
				<br> <br>
				<div style="text-align: center">
					<c:choose>
						<c:when test="${product.productCount eq 0 }">
							<button
								style="width: 150px; height: 30px; font-size: 10px; background-color: black; border-radius: 20px; color: white;">
								임시 품절 상품입니다.</button>
							<br>
							<br>
						</c:when>
						<c:otherwise>
							<form action="/shop/purchase">
								<button
									style="width: 300px; height: 50px; font-size: 14px; background-color: black; border-radius: 30px; color: white;">
									구매하기</button>
							</form>
							<br>
							<br>
							<form action="/shop/purchase">
								<button
									style="width: 300px; height: 50px; font-size: 14px; border-radius: 30px;">
									장바구니 담기</button>
								<br> <br>
							</form>
						</c:otherwise>

					</c:choose>
				</div>
				<hr style="color: gray">
				<div class="accordion accordion-flush" id="accordionFlushExample">
					<div class="accordion-item">
						<h2 class="accordion-header" id="flush-headingOne">
							<button class="accordion-button collapsed" type="button"
								focus="outline:none" data-bs-toggle="collapse"
								data-bs-target="#flush-collapseOne" aria-expanded="false"
								aria-controls="flush-collapseOne">제품 세부 정보</button>
						</h2>
						<div id="flush-collapseOne" class="accordion-collapse collapse"
							aria-labelledby="flush-headingOne"
							data-bs-parent="#accordionFlushExample">
							<div class="accordion-body" style="font-size: 14px">
								${product.detail}</div>
						</div>
					</div>
				</div>

			</div>
</body>

</html>