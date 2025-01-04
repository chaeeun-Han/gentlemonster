<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<style>
.search {
  top: 0;
  left: 0;
  width: 100%;
  height: 500px;
  background-color: rgba(0, 0, 0, 0);
  z-index: 1000;
  transition: opacity 0.3s ease, visibility 0.3s ease, transform 0.3s ease;
}
.search-content {
  position: absolute;
  top: 0;
  left: 50%;
  transform: translateX(-50%);
  background-color: white;
  padding: 20px;
  border-radius: 5px;
  width: 100%;
  transition: transform 0.3s ease;
}
.title {
	font-size: 13px;
	font-weight: bold;
	margin-bottom: 30px;
}
a {
	text-decoration: none;
	color: black;
}
ul {
	list-style: none;
	padding-left: 0px;
}
.collection-item {
	width: 25%;
	margin-bottom: 15px;
	text-align: center;
	font-size: 11px;
}
.collection-item-name {
	font-weight: bold;
}

.collection-item-image > img{
	border-radius: 50%;
    width: 63px;
    height: 63px;
    border: 1px solid transparent;
	transition: border-color 0.6s ease;
}
.collection-item-image > img:hover {
	border-color: black;
}
.hot-keyword-item {
    padding-right: 10px;
    padding-bottom: 10px;
    font-size: 14px;
    font-weight: bold;
}
.search-popup-left {
    min-width: 200px;
}
.search-popup-right {
	width: 365px;	
}

</style>

</head>
<body>
<div class="search">
<div class="search-content">
	<div class="search-top d-flex justify-content-between"> 
		<div class="navbar navbar-light mx-auto" style="width:600px;">
		  <form class="inputform container" action="/shop/search">
		    <div class="input-group">
		      <input type="text" name="term" class="form-control inputvalue" placeholder="검색어를 입력하세요" aria-label="Username" aria-describedby="basic-addon1">
		    </div>
		  </form>
		</div>
		<div>
		  <button type="button" class="close m-3" style="border: none; background-color: white;">
			<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-x-circle-fill" viewBox="0 0 16 16">
		  		<path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0M5.354 4.646a.5.5 0 1 0-.708.708L7.293 8l-2.647 2.646a.5.5 0 0 0 .708.708L8 8.707l2.646 2.647a.5.5 0 0 0 .708-.708L8.707 8l2.647-2.646a.5.5 0 0 0-.708-.708L8 7.293z"></path>
			</svg>
		  </button>
		</div>
	</div>
	
	<div class="search-popup d-flex justify-content-center gap-5 pt-5">
		<div class="search-popup-left">
			<div class="title" style="color: #acacac;">
			인기검색어
			</div>
			<div class="hot-keyword">
				<ul class="hot-keyword-list">
					<c:forEach var="trend" items="${trendList}">
						<li class="hot-keyword-item">
							<a href="/shop/item?id=${trend.getProductId()}">${trend.getProductName()}</a>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>
		<div class="search-popup-right">
			<div class="title" style="color: #acacac;">
			다양한 컬렉션을 만나보세요
			</div>
			<div class="d-flex flex-column">
				<ul class="collection-list d-inline-flex justify-content-center">
					<li class="collection-item">
						<a href="/shop?bigCategoryId=1&smallCategoryId=view-all">
						<div class="collection-item-image">
							<img src="https://www-prd-kr.gentlemonster.com/media/catalog/category/view_all_3.jpg">
						</div>
						<div class="collection-item-name">선글라스</div>
						</a>
					</li>
					<li class="collection-item">
						<a href="/shop?bigCategoryId=2&smallCategoryId=view-all">
						<div class="collection-item-image">
							<img src="https://www-prd-kr.gentlemonster.com/media/catalog/category/1-glasses-viewall.jpg">
						</div>
						<div class="collection-item-name">안경</div>
						</a>
					</li>
					<li class="collection-item">
						<a href="/shop?bigCategoryId=1&smallCategoryId=3">
						<div class="collection-item-image">
							<img src="https://www-prd-kr.gentlemonster.com/media/catalog/category/file_1_1.jpg">
						</div>
						<div class="collection-item-name">베스트셀러</div>
						</a>
					</li>
					<li class="collection-item">
						<a href="/shop?bigCategoryId=2&smallCategoryId=4">
						<div class="collection-item-image">
							<img src="https://www-prd-kr.gentlemonster.com/media/catalog/category/5-glasses-bluelight.jpg">
						</div>
						<div class="collection-item-name">블루라이트 차단</div>
						</a>
					</li>
				</ul>
				<ul class="collection-list d-inline-flex justify-content-center">
					<li class="collection-item">
						<a href="/shop?bigCategoryId=2&smallCategoryId=1">
						<div class="collection-item-image">
							<img src="https://www-prd-kr.gentlemonster.com/media/catalog/category/gm_navigation_1_6.jpg">
						</div>
						<div class="collection-item-name">2024 Optical</div>
						</a>
					</li>
					<li class="collection-item">
						<a href="/shop?bigCategoryId=1&smallCategoryId=1">
						<div class="collection-item-image">
							<img src="https://www-prd-kr.gentlemonster.com/media/catalog/category/gm-category-sun-2023_1.jpg">
						</div>
						<div class="collection-item-name">2024 컬렉션</div>
						</a>
					</li>
					<li class="collection-item">
						<a href="/shop?bigCategoryId=1&smallCategoryId=8">
						<div class="collection-item-image">
							<img src="https://www-prd-kr.gentlemonster.com/media/catalog/category/cateye.jpg">
						</div>
						<div class="collection-item-name">캣아이 프레임</div>
						</a>
					</li>
					<li class="collection-item">
						<a href="/shop?bigCategoryId=1&smallCategoryId=10">
						<div class="collection-item-image">
							<img src="https://www-prd-kr.gentlemonster.com/media/catalog/category/gm-category-sun-oval.jpg">
						</div>
						<div class="collection-item-name">원형 프레임</div>
						</a>
					</li>
				</ul>
			</div>
		</div>
		
	</div>
</div>
</div>

<script type="text/javascript">
const closeBtn = document.querySelector('.close');
closeBtn.onclick = function() {
	parent.closeModal();
}

const form = document.querySelector('.inputform');
form.addEventListener("submit", (event) => {
	event.preventDefault();
	
	parent.closeModal();

	const inputvalue = document.querySelector('.inputvalue').value;
	
	parent.window.location.href = '/shop/search?term=' + inputvalue;
});

const links = document.querySelectorAll('li.collection-item a');
links.forEach(link => {
	link.addEventListener('click', (event) => {
		event.preventDefault();
		parent.closeModal();
		parent.window.location.href = link.href; 
	});
});

const links2 = document.querySelectorAll('li.hot-keyword-item a');
links2.forEach(link => {
	link.addEventListener('click', (event) => {
		event.preventDefault();
		parent.closeModal();
		parent.window.location.href = link.href; 
	});
});
</script>

</body>
</html>