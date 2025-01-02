<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>선글라스 | Gentle Monster</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
<link rel="stylesheet" type="text/css" href="/css/productList.css">
<script src="/js/productList.js"></script>
</head>
<body>
	<jsp:include page="/header.jsp"></jsp:include>
	<div>
		<div class="d-flex justify-content-center">
			<ul class="nav justify-content-center">
				<li class="m-3 hv"><a
					class="d-flex flex-column align-items-center text-center text-decoration-none text-reset"
					href="/shop?bigCategoryId=1&smallCategoryId=view-all" id="item-view-all"> <img class="rounded-circle" alt="#"
						src="https://www-prd-kr.gentlemonster.com/media/catalog/category/view_all_3.jpg"
						width="80px" height="80px"> <span class="mt-2 custom-text">전체보기</span>
				</a></li>
				<li class="m-3 hv"><a
					class="d-flex flex-column align-items-center text-center text-decoration-none text-reset"
					href="/shop?bigCategoryId=1&smallCategoryId=1" id="item-1"> <img class="rounded-circle" alt="#"
						src="https://www-prd-kr.gentlemonster.com/media/catalog/category/2024-Thumbnail.jpg"
						width="80px" height="80px"> <span class="mt-2 custom-text">2024
							컬렉션</span>
				</a></li>
				<li class="m-3 hv"><a
					class="d-flex flex-column align-items-center text-center text-decoration-none text-reset"
					href="/shop?bigCategoryId=1&smallCategoryId=2" id="item-2"> <img class="rounded-circle" alt="#"
						src="https://www-prd-kr.gentlemonster.com/media/catalog/category/bold-Thumbnail.jpg"
						width="80px" height="80px"> <span class="mt-2 custom-text">볼드
							컬렉션</span>
				</a></li>
				<li class="m-3 hv"><a
					class="d-flex flex-column align-items-center text-center text-decoration-none text-reset"
					href="/shop?bigCategoryId=1&smallCategoryId=3" id="item-3"> <img class="rounded-circle" alt="#"
						src="https://www-prd-kr.gentlemonster.com/media/catalog/category/file_1_1.jpg"
						width="80px" height="80px"> <span class="mt-2 custom-text">베스트셀러</span>
				</a></li>
				<li class="m-3 hv"><a
					class="d-flex flex-column align-items-center text-center text-decoration-none text-reset"
					href="/shop?bigCategoryId=1&smallCategoryId=4" id="item-4"> <img class="rounded-circle" alt="#"
						src="https://www-prd-kr.gentlemonster.com/media/catalog/category/SUN_GIFT_Dada_RC6.jpg"
						width="80px" height="80px"> <span class="mt-2 custom-text">선물추천</span>
				</a></li>
				<li class="m-3 hv"><a
					class="d-flex flex-column align-items-center text-center text-decoration-none text-reset"
					href="/shop?bigCategoryId=1&smallCategoryId=5" id="item-5"> <img class="rounded-circle" alt="#"
						src="https://www-prd-kr.gentlemonster.com/media/catalog/category/tinted.jpg"
						width="80px" height="80px"> <span class="mt-2 custom-text">틴트
							렌즈</span>
				</a></li>
				<li class="m-3 hv"><a
					class="d-flex flex-column align-items-center text-center text-decoration-none text-reset"
					href="/shop?bigCategoryId=1&smallCategoryId=6" id="item-6"> <img class="rounded-circle" alt="#"
						src="https://www-prd-kr.gentlemonster.com/media/catalog/category/file_2_1.jpg"
						width="80px" height="80px"> <span class="mt-2 custom-text">사각
							프레임</span>
				</a></li>
				<li class="m-3 hv"><a
					class="d-flex flex-column align-items-center text-center text-decoration-none text-reset"
					href="/shop?bigCategoryId=1&smallCategoryId=7" id="item-7"> <img class="rounded-circle" alt="#"
						src="https://www-prd-kr.gentlemonster.com/media/catalog/category/goggles.jpg"
						width="80px" height="80px"> <span class="mt-2 custom-text">고글형
							프레임</span>
				</a></li>
				<li class="m-3 hv"><a
					class="d-flex flex-column align-items-center text-center text-decoration-none text-reset"
					href="/shop?bigCategoryId=1&smallCategoryId=8" id="item-8"> <img class="rounded-circle" alt="#"
						src="https://www-prd-kr.gentlemonster.com/media/catalog/category/SUN_CATEYE_Terra_Cotta_Y6.jpg"
						width="80px" height="80px"> <span class="mt-2 custom-text">캣아이
							프레임</span>
				</a></li>
				<li class="m-3 hv"><a
					class="d-flex flex-column align-items-center text-center text-decoration-none text-reset"
					href="/shop?bigCategoryId=1&smallCategoryId=9" id="item-9"> <img class="rounded-circle" alt="#"
						src="https://www-prd-kr.gentlemonster.com/media/catalog/category/oval.jpg"
						width="80px" height="80px"> <span class="mt-2 custom-text">타원형
							프레임</span>
				</a></li>
				<li class="m-3 hv"><a
					class="d-flex flex-column align-items-center text-center text-decoration-none text-reset"
					href="/shop?bigCategoryId=1&smallCategoryId=10" id="item-10"> <img class="rounded-circle" alt="#"
						src="https://www-prd-kr.gentlemonster.com/media/catalog/category/SUN_ROUND_Jade_GC10.jpg"
						width="80px" height="80px"> <span class="mt-2 custom-text">원형
							프레임</span>
				</a></li>
			</ul>
		</div>
		<div class="mx-4">
			<p id="title" class="fw-bold">${productList[0].bigCategoryName} / ${productList[0].smallCategoryName}(${productList[0].totalCount})</p>
		</div>
		<div class="mx-4">
			<div class="row">
				<!-- 상품 데이터를 반복 출력 -->
				<c:forEach var="product" items="${productList}">
					<div class="col-custom mb-4">
						<div class="card">
							<a class="text-decoration-none text-reset" href="/shop/item?id=${product.productId}">
								<!-- 이미지 -->
								<img src="${product.imageUrl}" class="card-img-top"
									alt="${product.name}">
								<div class="card-body text-center">
									<!-- 상품명 -->
									<h5 class="card-title">${product.name}</h5>
									<!-- 가격 -->
									<p class="card-text">${product.price}</p>
									<!-- 컬러 옵션 -->
									<p class="text-muted">${product.colorCount}Colors</p>
								</div>
							</a>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</body>
</html>