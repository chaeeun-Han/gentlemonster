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
<title>Insert title here</title>
<style>
hr {
	margin: 30px 0px;
}

.container {
	display: flex;
	width: 65%;
	margin: 50px auto;
	gap: 80px;
}

.delivery-info {
	flex: 2;
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
	width: 94%;
	height: 40px;
	margin-top: 5px;
	padding: 0px 10px;
	border: 1px solid black;
}

.button-container {
    display: flex;
    justify-content: center; /* 가로 중앙 정렬 */
    align-items: center; /* 세로 중앙 정렬 */
    gap: 10px; /* 버튼 간 간격 */
    margin-top: 20px; /* 버튼 상단 여백 */
}

.exit {
	cursor: pointer;
	background-color: white;
	color: black;
	border: 1px solid black;
	width: 45%;
	height: 40px;
	background-color: white;
}

.purchase {
	cursor: pointer;
	background-color: black;
	color: white;
	border: 0px;
	width: 46%;
	height: 40px;
	margin-left: 30px;
}
</style>
</head>
<body>
	<div class="container">
		<div class="delivery-info">
			<p class="title">배송 정보</p>
			<form action="" method="post">
				<c:forEach var="product" items="${products}">
				    <input type="hidden" name="productId" value="${product.productId}">
				    <input type="hidden" name="productName" value="${product.productName}">
				    <input type="hidden" name="productCount" value="${product.productCount}">
				    <input type="hidden" name="price" value="${product.price}">
				    <input type="hidden" name="imgUrl" value="${product.imgUrl}">
				</c:forEach>
				<div class="option">
					<p class="option-title">성</p>
					<input class="option-input" type="text" name="first" placeholder="성을 적어 주세요." required="required" ">
				</div>
				<div class="option">
					<p class="option-title">이름</p>
					<input class="option-input" type="text" name="last" placeholder="이름을 적어 주세요." required="required">
				</div>
				<div class="option">
					<p class="option-title">전화번호</p>
					<input class="option-input" type="text" name="phone" placeholder="전화번호를 적어 주세요." required="required">
				</div>
				<div class="option">
					<p class="option-title">주소</p>
					<input class="option-input" type="text" name="address" placeholder="도착지의 주소를 적어 주세요." value="${address}" required="required">
				</div>
				<hr>
				<div class="button-container">
				    <button type="button" class="exit" onclick="history.back();">취소</button>
				    <button type="submit" class="purchase">결제하기</button>
				</div>
			</form>
		</div>
		<div class="order-info">
			<p class="title">주문 내용</p>
			<!-- 주문 내역 가져다가 쓰기 -->
		</div>
	</div>

	<script type="text/javascript">
		
	</script>
</body>
</html>