<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Join</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<style>
	* {
	      margin: 0px;
	      padding: 0px;
	  }
	        
	.container {
		text-align: center;
		padding-top: 50px;
		height: 300px;
		width: 60% !important;
		max-width: 600px !important;
	}
	
	h2.title {
		font-size: 30px;
		font-weight: 600;
		margin-top: 50px;
		margin-bottom: 50px;
	}
</style>
</head>
<body>
<form action="/member/join" method="post">
	<div class="container">
		<h2 class="title">회원가입</h2>
		<div class="form-floating mb-3">
	        <input type="text" class="form-control rounded-4" name="userid" id="floatingInput" placeholder="아이디">
	        <label for="floatingInput">아이디</label>
	    </div>
	    <div class="form-floating mb-3">
	        <input type="password" class="form-control rounded-4" name="password" id="floatingPassword" placeholder="비밀번호">
	        <label for="floatingPassword">비밀번호</label>
	    </div>
	    <div class="form-floating mb-3">
	        <input type="password" class="form-control rounded-4" name="passwordCheck" id="floatingPasswordCheck" placeholder="비밀번호">
	        <label for="floatingPassword">비밀번호 확인</label>
	    </div>
	    <div class="form-floating mb-3">
	        <input type="date" class="form-control rounded-4" name="birthday" id="floatingBirth" placeholder="비밀번호">
	        <label for="floatingPassword">생년월일</label>
	    </div>
	    <div class="form-floating mb-3">
	        <input type="email" class="form-control rounded-4" name="email" id="floatingEmail" placeholder="비밀번호">
	        <label for="floatingPassword">이메일</label>
	    </div>
	    <div class="form-floating mb-3">
	        <input type="text" class="form-control rounded-4" name="address" id="floatingAddress" placeholder="비밀번호">
	        <label for="floatingPassword">기본배송지</label>
	    </div>
	    <button class="w-100 mb-2 btn btn-lg rounded-4 btn-primary" type="submit">회원가입</button>
	</div>
</form>
</body>
</html>