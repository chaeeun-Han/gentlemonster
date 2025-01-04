<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/css/productList.css">
</head>
<body>
	<jsp:include page="/header.jsp"></jsp:include>
			<div class="mx-4">
			<p id="title" class="fw-bold">"${term}" (${size})</p>
		</div>
		<div class="mx-4">
			<div class="row">
				<c:forEach var="search" items="${searchList}">
					<div class="col-custom mb-4">
						<div class="card">
							<a class="text-decoration-none text-reset" href="/shop/item?id=${search.getProductId()}">
								<img src="${search.getMainImageUrl()}" class="card-img-top"
									alt="${search.getProductName()}">
								<div class="card-body text-center">
									<h5 class="card-title">${search.getProductName()}</h5>
									<p class="card-text">
									<c:choose>
										<c:when test="${search.getProductCount() == 0}">
										품절
										</c:when>
										<c:otherwise>
										${search.getPrice() }
										</c:otherwise>
									</c:choose>
										</p>
								</div>
							</a>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
</body>
</html>