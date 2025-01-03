<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Styles</title>

<style>
* {
	margin: 0px;
	padding: 0px;
}

#description {
	font-size: 14px;
	color: #333333;
	margin-bottom: 5px;
	font-weight: 600;
}

#title {
	font-size: 16px;
	color: #333333;
	font-weight: 600;
}

.container {
	margin: 20px;
}

.description_container {
	margin: 30px;
	padding-top: 20px;
}

.title_container {
	text-align: initial;
	margin-top: 50px;
	margin-bottom: 20px;
}

#images {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
	grid-gap: 20px 20px;
}

#image_button {
	width: 100%;
	height: auto;
	aspect-ratio: 2/3;
	display: flex;
	overflow: hidden;
	justify-content: center;
	border: none;
}

#image_button img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

@media ( min-width : 1200px) {
	#images {
		grid-template-columns: repeat(4, minmax(200px, 1fr));
	}
}

@media ( max-width : 1199px) and (min-width: 700px) {
	#images {
		grid-template-columns: repeat(3, minmax(200px, 1fr));
	}
}

@media ( max-width : 699px)and (min-width: 500px) {
	#images {
		grid-template-columns: repeat(2, minmax(200px, 1fr));
	}
}

@media ( max-width : 499px) {
	#images {
		grid-template-columns: repeat(1, minmax(200px, 1fr));
	}
}

#style-modal {
	visibility: hidden;
	display: flex;
	justify-content: center;
	align-items: center;
	position: fixed;
	z-index: 1;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(255, 255, 255, 0.7);
}

.modal-content {
	background-color: #fff;
	padding: 15px;
	width: 630px;
	height: 550px;
	border: none;
	display: flex;
	margin: auto;
	z-index: 2;
}
</style>
</head>
<body>
	<jsp:include page="/header.jsp"></jsp:include>
	<div class="container" align="center">
		<div class="description_container">
			<p id="description">젠틀몬스터와 함께한 다양한 순간을 만나보세요.</p>
			<p id="description">인스타그램에 @gentlemonster을 태그하여 당신의 스타일을 공유해보세요.</p>
		</div>
		<div class="title_container">
			<p id="title">스타일/All(${styles.size()})</p>
		</div>
		<div id="images" style="padding-bottom: 70px;">
			<c:forEach var="style" items="${styles}">
				<button id="image_button"
					onclick="openModal('${style.productId}', '${style.imageUrl}', '${style.instagramId}')">
					<img src="${style.getImageUrl() }" />
				</button>
			</c:forEach>
		</div>
		<div id="style-modal">
			<div class="modal-content">
				<iframe id="modal-iframe"
					style="width: 100%; height: 100%; border: none;"></iframe>
			</div>
		</div>
	</div>
	<script>
		function openModal(productId, imageUrl, instagramId) {
			const iframe = document.querySelector("#modal-iframe");
			iframe.src = "/styles/detail?id=" + encodeURIComponent(productId);
			document.querySelector("#style-modal").style.visibility = "visible";
		}

		function closeModal(event) {
			const modalContent = document.querySelector(".modal-content");
			if (!modalContent.contains(event.target)) {
				document.querySelector("#style-modal").style.visibility = "hidden";
				document.querySelector("#modal-iframe").src = "";
			}
		}

		document.querySelector("#style-modal").addEventListener("click", closeModal);
	</script>
</body>
</html>

