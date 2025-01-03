<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

.purchase {
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
	<div class="container">
		<div class="delivery-info">
			<p class="title">배송 정보</p>
			<form action="/purchase" method="post">
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
					<input class="option-input" type="text" name="address"
						placeholder="배송지의 주소를 적어 주세요." required="required">
				</div>
				<hr>
				<div class="buttons">
					<button type="button" class="exit"
						onclick="window.location.href='/styles'">취소</button>
					<button type="button" class="purchase" data-bs-toggle="modal"
						data-bs-target="#purchaseModal" value="${address}" required="required">결제하기</button>
				</div>
			</form>
		</div>

		<div class="order-info">
			<p class="title">주문 내용</p>
			<!-- 주문 내역 가져다가 쓰기 -->
		</div>
	</div>

	<div class="modal fade" id="purchaseModal" tabindex="-1"
		aria-labelledby="purchaseModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content rounded-4 shadow">
				<div class="modal-body p-4 text-center">
					<h5 class="mb-0">구매가 완료되었습니다. 감사합니다!</h5>
				</div>
				<div class="modal-footer p-0 justify-content-center">
					<button type="button"
						class="selected-btn btn btn-lg btn-link fs-6 text-decoration-none m-0 rounded-0"
						data-bs-dismiss="modal">
						<strong>확인</strong>
					</button>
				</div>

			</div>
		</div>
	</div>


</body>
</html>
