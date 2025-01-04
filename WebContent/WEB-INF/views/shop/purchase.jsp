<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://kit.fontawesome.com/cf6e255851.js"
	crossorigin="anonymous"></script>
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">

<!-- custom css -->
<link rel="stylesheet" type="text/css" href="/css/cart.css">

<!-- Bootstrap JS, Popper.js -->
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>
<title>Insert title here</title>
<style>
hr {
	margin: 30px 0px;
}

.container {
	display: flex;
	width: 30%;
	margin: 50px auto;
	gap: 80px;
}

.delivery-info {
	flex: 3;
}

.order-info {
	flex: 3;
}

.title {
	font-weight: bold;
	font-size: 20px;
	margin-top: 30px;
	margin-bottom: 60px;
}

.option {
	margin-top: 30px;
}

.option-title {
	font-size: 14px;
	font-weight: bold;
	margin-bottom: 5px;
}

.option-input {
	width: 100%;
	height: 40px;
	margin-top: 5px;
	padding: 0px 10px;
	border: 1px solid black;
}

.buttons {
	display: flex;
	justify-content: space-between;
}

.exit {
	cursor: pointer;
	background-color: white;
	color: black;
	border: 1px solid black;
	width: 45%;
	height: 40px;
}

.purchase-btn {
	cursor: pointer;
	background-color: black;
	color: white;
	border: 0px;
	width: 46%;
	height: 40px;
}

.selected-btn {
	width: 100%;
}
</style>
</head>
<body>
    <jsp:include page="/header.jsp"></jsp:include>
	<div class="container">
		<div class="delivery-info">
			<p class="title">배송 정보</p>
			<form action="/shop/purchase" method="POST" accept-charset="UTF-8">
				<c:forEach var="product" items="${products}">
				    <input type="hidden" name="productId" value="${product.productId}">
				    <input type="hidden" name="productName" value="${product.productName}">
				    <input type="hidden" name="productCount" value="${product.productCount}">
				    <input type="hidden" name="price" value="${product.price}">
				    <input type="hidden" name="imgUrl" value="${product.imgUrl}">
				</c:forEach>
				<div class="option">
					<p class="option-title">성</p>
					<input class="option-input" type="text" name="first"
						placeholder="성을 적어 주세요." required="required">
				</div>
				<div class="option">
					<p class="option-title">이름</p>
					<input class="option-input" type="text" name="last"
						placeholder="이름을 적어 주세요." required="required">
				</div>
				<div class="option">
					<p class="option-title">전화번호</p>
					<input class="option-input" type="text" name="phone"
						placeholder="전화번호를 적어 주세요." required="required">
				</div>
				<div class="option">
					<p class="option-title">주소</p>
					<input class="option-input" type="text" name="address" value="${address}"
						placeholder="배송지의 주소를 적어 주세요." required="required">
				</div>
				<hr>
				<div class="buttons">
					<button type="button" class="exit" onclick="window.location.href='/styles'">취소</button>
					<button type="button" class="purchase-btn" data-bs-toggle="modal" data-bs-target="#purchaseModal">결제하기</button>
				</div>

				<div class="modal fade" id="purchaseModal" tabindex="-1"
					aria-labelledby="purchaseModalLabel" aria-hidden="true">
					<div class="modal-dialog" role="document">
						<div class="modal-content rounded-4 shadow">
							<div class="modal-body p-4 text-center">
								<h5 class="mb-0">구매가 완료되었습니다. 감사합니다!</h5>
							</div>
							<div class="modal-footer p-0 justify-content-center">
								<button type="submit"
									class="selected-btn btn btn-lg btn-link fs-6 text-decoration-none m-0 rounded-0"
									data-bs-dismiss="modal">
									<strong>확인</strong>
								</button>
							</div>
			
						</div>
					</div>
				</div>


			</form>
		</div>

		<div class="order-info">
		    <p class="title">주문 내용</p>
		    <div class="item-list">
   				<c:forEach var="product" items="${products}">
		            <div class="item" data-cartid="1">
		                <button class="item-detail">
		                    <img class="item-image" alt="장바구니 상품 이미지 URL" src="${product.imgUrl}">
		                </button>
		                <div class="item-info">
		                    <p class="item-name">${product.productName}</p>
		                    <p class="item-price">${product.price}원</p>
		                    <div class="item-quantity">
		                        <span class="quantity">${product.productCount}</span>
		                    </div>
		                </div>
		            </div>
		        </c:forEach>
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
		    </div>
		</div>
	</div>


</body>
<script src="/js/cart.js" defer></script> 
<script>
    function submitForm() {
        // form 요청 보내기
        document.querySelector('form').submit();
    }
</script>
</html>
