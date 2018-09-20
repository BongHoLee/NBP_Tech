<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<script type="text/javascript" src="<c:url value='/resources/js/jquery.min.js'/> "></script>
<script>
fn_marking_list = function() {
	
	$.ajax({
		url : "<c:url value='/MarkingList'/> ",
		type:'get',
		data: {'MEMBER_KEY':$("#USER_KEY").attr('value')},
		dataType:'json',
		contentType:"application/json; charset=UTF-8",
		success:function(result){
			var list = result.data;
			console.log("success!");
			
			var markingList="";
			console.log(JSON.stringify(result.data));
			
			$.each(list, function(i){
				var memberkey = (list[i])['MEMBER_KEY'];
				var restaurant_id = (list[i])['RESTAURANT_ID'];
				var restaurant_addr = (list[i])['RESTAURANT_ADDR'];
				var restaurant_name = (list[i])['RESTAURANT_NAME'];
				var url = "<c:url value='/restView/restdetail?RESTAURANT_ID="+restaurant_id+"&MEMBER_KEY="+memberkey+"' />";
				markingList += '<li><a href ="'+url+'">'+restaurant_name+'/'+restaurant_addr+'</a></li>';  
					
			});
			$("#markList").html(markingList);
			
			
		}
	});
	
}


$(function(){
	$("#makeList").click(function(){
		fn_marking_list();
	});
});
</script>

<!-- HEADER -->

	<header>
	<sec:authentication property="principal" var="principalBean"/>
		<!-- top Header -->
		
		<div id="top-header">
			<div class="container">
				<div class="pull-left">
				<sec:authorize access="isAuthenticated()">
					<span>${principalBean.username }님 환영합니다!</span>
				</sec:authorize>

				</div>

				<div class="pull-right">
					<ul class="header-top-links">					
<%-- 						<sec:authorize access="hasAnyAuthority('MANAGER')">
						<li><a href="<c:url value='/event/list'/> ">EventList</a></li>
						<li><a href="<c:url value='/setting/memberMag'/> ">Member Management</a></li>
						</sec:authorize> --%>
						
					</ul>
				</div>
			</div>
		</div>
		
		<!-- /top Header --

		<!-- header -->
		<div id="header">
			<div class="container">
			<sec:authorize access="isAnonymous()">
				<div class="pull-left" style="margin-left: 37%; height:5%; margin-top : 10%;">
					<!-- Logo -->
					<div class="header-logo">
						<a class="logo" href="<c:url value='/'/> ">
							<img src="<c:url value='/resources/img/logo.png' /> " style="width:300px; height:150px;" alt="">
						</a>
					</div>
					<!-- /Logo -->
			</sec:authorize>	
			<sec:authorize access="isAuthenticated()">
							<div class="pull-left" >
					<!-- Logo -->
					<div class="header-logo">
						<a class="logo" href="<c:url value='/'/> ">
							<img src="<c:url value='/resources/img/logo.png' /> " style="width:270px; height:60px;" alt="">
						</a>
					</div>
			</sec:authorize>
					
					
					<!-- Search -->
					<sec:authorize access="isAuthenticated()">
					<div class="header-search">
					<form method="get" action="<c:url value='/restView/restlist' /> ">
							<input class="input search-input" type="text" name="search" placeholder="무엇을 검색할까요?">
							<select class="input search-categories" name="searchWhat">
								<option value="1">음식점 명</option>
								<option value="2">메뉴</option>
								<option value="3">#</option>
							</select>
							<button class="search-btn" type="submit"><i class="fa fa-search"></i></button>
						</form> 
					</div>
					</sec:authorize>
					<!-- /Search -->
				</div>
				
				<sec:authorize access="isAuthenticated()">
				<div class="pull-right">
				
					<ul class="header-btns">
						<!-- Account -->
						<li class="header-account dropdown default-dropdown">
							<div class="dropdown-toggle" role="button" data-toggle="dropdown" aria-expanded="true">
								<div class="header-btns-icon" style="border:none;">
									
									<i class="fa fa-user-o fa-2x " aria-hidden="true"></i>
								</div>
								
								<sec:authorize access="isAuthenticated()">
								<strong class="text-uppercase">My Account<i class="fa fa-caret-down"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong> 
								</sec:authorize>
								
								
							</div>			
							
							<input type="hidden" id="USER_KEY" value="${principalBean.MEMBER_KEY}" />
							<a href="#" >${principalBean.username}</a>
							<ul class="custom-menu">
								<li><a href="<c:url value='/' />" >
								<li><a href="<c:url value='/logout' />" ><i class="fa fa-user-plus"></i> 로그아웃</a></li>
							</ul>
							

							
							

						</li>
						<!-- /Account -->

						<!-- Cart -->
				<li class="header-cart dropdown default-dropdown" id="makeList" >
							<div class="dropdown-toggle" role="button" data-toggle="dropdown" aria-expanded="true">
							
							<div class="header-btns-icon" style="border:none;" >
									
									<button type="button" class="btn btn-default btn-lg">
  									<span class="fa fa-heart" aria-hidden="true"></span>
									</button>

								</div>
																	
							</div>

							
						
							<ul class="custom-menu listofmark" id="markList">

							</ul>
							

							
							

						</li>
						
						
						

						<!-- /Cart -->

						<!-- Mobile nav toggle-->
						<li class="nav-toggle">
							<button class="nav-toggle-btn main-btn icon-btn"><i class="fa fa-bars"></i></button>
						</li>
						<!-- / Mobile nav toggle -->
					</ul>
					
				</div>
				</sec:authorize>
				
			</div>
			<!-- header -->
		</div>
		<!-- container -->
	</header>
	<!-- /HEADER -->
<form action=" " id="categoryForm">

<sec:authorize access="isAuthenticated()">
<input type="hidden" name="CATEGORY_A_ID" value="hihi">
	<!-- NAVIGATION -->
	<div id="navigation">
		<!-- container -->
		<div class="container">
			<div id="responsive-nav">
				<!-- category nav -->
				<div class="category-nav product-single" style=" margin-top: 0px; margin-bottom: 0px; text-align:center;">
					<span class="category-header"><a href="<c:url value='/' /> " style="color:white">전 체</a></span>
				</div>

				<!-- /category nav -->

				<!-- menu nav -->
				<div class="menu-nav">
					<span class="menu-header">Menu <i class="fa fa-bars"></i></span>
					<ul class="menu-list">
						<li><a href="<c:url value='/restView/restlist?searchWhat=4&search=100'/>">한식</a></li>
						<li><a href="<c:url value='/restView/restlist?searchWhat=4&search=101'/>">중식</a></li>
						<li><a href="<c:url value='/restView/restlist?searchWhat=4&search=102'/>">분식</a></li>
						<li><a href="<c:url value='/restView/restlist?searchWhat=4&search=103'/>">일식</a></li>
						<li><a href="<c:url value='/restView/restlist?searchWhat=4&search=104'/>">치킨</a></li>
						<li><a href="<c:url value='/restView/restlist?searchWhat=4&search=105'/>">피자</a></li>
						<li><a href="<c:url value='/restView/restlist?searchWhat=4&search=106'/>">도시락</a></li>
						<li><a href="<c:url value='/restView/restlist?searchWhat=4&search=107'/>">패스트푸드</a></li>
					</ul>
				</div>
				<!-- menu nav -->
			</div>
		</div>
		<!-- /container -->
	</div>
	</sec:authorize>
	<!-- /NAVIGATION -->
	</form>
	
	

	