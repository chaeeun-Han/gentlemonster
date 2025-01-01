<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%!
	int totalPrice;
	int shippingFee;
	Long id = 123L;
	LocalDate date = LocalDate.now();
	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	 String formatedNow = date.format(formatter);

	public class PurchaseDto {
		private String name;
		private int price;
		private int count;
		private String url;
		
		public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public int getPrice() {
            return price;
        }

        public void setPrice(int price) {
            this.price = price;
        }

        public int getCount() {
            return count;
        }

        public void setCount(int count) {
            this.count = count;
        }

        public String getUrl() {
            return url;
        }

        public void setUrl(String url) {
            this.url = url;
        }
	}
%>
<%
	List<PurchaseDto> purchases = new ArrayList<PurchaseDto>();
	
	for (int i = 0; i < 2; i++) {
		PurchaseDto dto = new PurchaseDto();
		dto.setName("다다 01");
		dto.setPrice(340000);
		dto.setCount(1);
		dto.setUrl("https://www-prd-kr.gentlemonster.com/media/catalog/product/cache/6c6f229b8a7ab97f51028776641e27d1/1/1/11001_OJO_GC9_2.jpg");
		purchases.add(dto);
		totalPrice += dto.getPrice();
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Purchase History</title>
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
	
	#information {
		font-size: 15px;
		margin-left: 30px;
		color: #555555;
	}
	
</style>

</head>
<body>
	<jsp:include page="/header.jsp"></jsp:include>
	<div class="container">
		<div class="text_container">
			<p class="title">주문내용</p>
			<p class="text"><fmt:formatNumber value="${totalPrice}" pattern="#,###"/>원</p>
		</div>
		<div class="text_container">
			<p class="text">상품</p>
			<p class="text">가격</p>
		</div>
		<c:forEach var="product" items="${products}">
		<div class="item">
			<div class="item_left">
				<img class="item_img" src="${product.getImgUrl()}"/>
				<div class="item_text">
					<p class="bold_text">${product.getProductName()}</p>
					<p class="text">수량: ${product.getProductCount()}</p>
				</div>
			</div>
			<div class="item_right">
				<p class="text"><fmt:formatNumber value="${product.getPrice()}" pattern="#,###"/>원</p>
			</div>
		</div>
		</c:forEach>
		<hr style="border: solid 1.5px;"/>
		<div class="text_container">
			<p class="text">상품합계</p>
			<p class="text"><fmt:formatNumber value="${totalProductPrice}" pattern="#,###"/>원</p>
		</div>
		<div class="text_container" style="margin-top:-10px;">
			<p class="text">배송비</p>
			<p class="text"><fmt:formatNumber value="${shippingFee}" pattern="#,###"/>원</p>
		</div>
		<hr style="border: solid 1.5px; margin-top:-1px;"/>
		<div class="text_container">
			<p class="text">총합계(수량:${totalCount})</p>
			<p class="text"><fmt:formatNumber value="${totalPrice}" pattern="#,###"/>원</p>
		</div>
		<div class="item_left" style="margin-top:30px;">
			<p class="text">주문번호</p>
			<p id="information">${purchaseId}</p>
		</div>
		<div class="item_left" style="padding-bottom:30px;">
			<p class="text">주문일</p>
			<p id="information">${purchaseTime}</p>
		</div>
	</div>
</body>
</html>