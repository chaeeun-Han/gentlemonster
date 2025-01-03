<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Purchase List</title>
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
	
	.text_container {
		display: flex;
		justify-content: space-between;
		margin-top: 20px;
	}
	
	.title {
		font-size: 16px;
		font-weight: 600;
	}
	
	.text {
		font-size: 15px;
		font-weight: 500;
	}
	
	.bold_text {
		font-size: 15px;
		font-weight: 600;
	}
	
	.item {
		display: flex;
		justify-content: space-between;
		margin-bottom: 20px;
		margin-top: 20px;
	}
	
	.item_left {
		text-align: left;
		display: flex;
	}
	
	.item_right {
		text-align: right;
	}
	
	.item_img {
		width: 150px;
		height: auto;
		aspect-ratio: 2.5 / 3;
		display: flex;
		overflow: hidden;
		justify-content: center;
		border: none;
	}
	
	.item_text {
		flex-direction: column;
		margin-left: 20px;
	}
	
	.history-link {
	  color: black;
	  text-decoration: none;
	  margin-right: 0px;
	}
	
	.custom-hr {
		border: solid 1.5px;
		margin: 30px 0;
		display: block;
	}
</style>

</head>
<body>
	<jsp:include page="/header.jsp"></jsp:include>
	<div class="container">
		<c:forEach var="purchase" items="${purchaseList}" varStatus="status">
			<div class="text_container">
				<p class="title">${purchase.getPurchaseTime()}</p>
				<a href="/shop/purchase-history?id=${purchase.getPurchaseId()}" class="history-link">주문상세 ></a>
			</div>
			<c:forEach var="purchaseHistory" items="${purchase.getPurchaseHistoryDTO()}" varStatus="status2">
				<div class="item">
					<div class="item_left">
						<img class="item_img" src="${purchaseHistory.getImgUrl()}"/>
						<div class="item_text">
							<p class="bold_text">${purchaseHistory.getProductName()}</p>
							<p class="text">수량: ${purchaseHistory.getProductCount()}</p>
						</div>
					</div>
					<div class="item_right">
						<p class="text"><fmt:formatNumber value="${purchaseHistory.getPrice()}" pattern="#,###"/>원</p>
					</div>
				</div>
				<c:if test="${!status2.last}">
					<hr/>
				</c:if>
			</c:forEach>
			<c:if test="${!status.last}">
				<hr class="custom-hr"/>
			</c:if>
			<c:if test="${status.last}">
				<p style="padding-bottom: 30px;">&nbsp;</p>
			</c:if>

		</c:forEach>
	</div>
</body>
</html>