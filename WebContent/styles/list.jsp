<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<%
	List<String> styles = new ArrayList<String>();
	for (int i = 0; i < 146; i++) {
		styles.add("https://web-resource.gentlemonster.com/event/1716253628.jpg");
	}
%>
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
	        
	#description{
		font-size: 14px;
		color: #333333;
		margin-bottom: 5px;
		font-weight: 600;
	}
	
	#title{
		font-size: 16px;
		color: #333333;
		font-weight: 600;
	}
	
	.container{
		margin: 20px;
	}
	
	.description_container{
		margin: 30px;
	}
	
	.title_container{
		text-align: initial;
		margin-top:50px;
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
		aspect-ratio: 2 / 3;
		display: flex;
		overflow: hidden;
		justify-content: center;
		border: none;
	}
	
	#image_button img{
		width:100%;
		height:100%;
		object-fit:cover;
	}
	
	@media (min-width: 1200px) {
		#images {
			grid-template-columns: repeat(4, minmax(200px, 1fr));
		}
	}
	
	@media (max-width: 1199px) and (min-width: 700px){
		#images {
			grid-template-columns: repeat(3, minmax(200px, 1fr));
		}
	}
	
	@media (max-width: 699px)and (min-width: 500px) {
		#images {
			grid-template-columns: repeat(2, minmax(200px, 1fr));
		}
	}
	
	@media (max-width: 499px) {
		#images {
			grid-template-columns: repeat(1, minmax(200px, 1fr));
		}
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
			<p id="title">스타일/All(<%=styles.size()%>)</p>
		</div>
		<div id="images">
			<%
				for(String style: styles){
			%>
			<button id="image_button" onclick="alert('모달')">
				<img src="<%=style%>"/>
			</button>
			<%
				}
			%>
		</div>
	</div>
</body>
</html>

