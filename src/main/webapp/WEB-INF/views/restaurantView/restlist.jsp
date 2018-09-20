<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>



<sec:authentication property="principal" var="principalBean" />
<div class="section">
	<div class="container">

		<c:if test="${paramMap.search == 'noItem'}">
		<div class="row" id="list">
		<div class="col-md-12">
					<div class="section-title">
			<h2 class="title">  검색 결과가 존재하지 않습니다.</h2>
					</div>
				</div>
		
		</c:if>
		<c:forEach items="${resultMap.resultList}" var="resultData" varStatus="loop">

			<c:if test="${(loop.index)%4 == 0}">
				<!-- row -->
				<div class="row" id="list">
			</c:if>

			<c:if test="${(loop.index)==0}">
				<!-- section title -->
				<div class="col-md-12">
					<div class="section-title">
					<c:choose>
						<c:when test="${paramMap.searchName == '#'}">
						<h2 class="title">  검색 결과 - ${paramMap.searchName} ${paramMap.search}</h2>
						</c:when>
						<c:when test="${paramMap.searchName == '카테고리' }">
						<h2 class="title">  ${paramMap.searchName} 검색 결과 -  ${resultData.CATEGORY_NAME}</h2>
						</c:when>
						<c:otherwise>
						<h2 class="title"> ${paramMap.searchName} 검색 결과 -  ${paramMap.search}</h2>
						</c:otherwise>
					</c:choose>
					</div>
				</div>
				<!-- section title -->
			</c:if>


			<!-- restaurant Single -->
			<div class="col-md-3 col-sm-6 col-xs-6"
				style="width: 292.5px; height: 490px;">
				<div class="product product-single"
					style="width: 292px; height: 477px;">
					<div class="product-thumb">
						<sec:authorize access="isAuthenticated()">

							<a href="<c:url value='/restView/restdetail?RESTAURANT_ID=${resultData.RESTAURANT_ID}&MEMBER_KEY=${principalBean.MEMBER_KEY}'/> ">
						</sec:authorize>

						<button class="main-btn quick-view">
							<i class="fa fa-search-plus"></i>상세 페이지로
						</button>
						<c:choose>
							<c:when test="${resultData.CATEGORY_NAME == '한식'}">
							<img src="<c:url value='/resources/img/KR.jpg' /> " style="width: 280px; height: 200px;" alt=""> </a>
							</c:when>
							<c:when test="${resultData.CATEGORY_NAME == '분식'}">
							<img src="<c:url value='/resources/img/BS.jpeg' /> " style="width: 280px; height: 200px;" alt=""> </a>
							</c:when>
							<c:when test="${resultData.CATEGORY_NAME == '중식'}">
							<img src="<c:url value='/resources/img/CH.jpg' /> " style="width: 280px; height: 200px;" alt=""> </a>
							</c:when>
							<c:when test="${resultData.CATEGORY_NAME == '일식'}">
							<img src="<c:url value='/resources/img/JP.jpg' /> " style="width: 280px; height: 200px;" alt=""> </a>
							</c:when>
							<c:when test="${resultData.CATEGORY_NAME == '치킨'}">
							<img src="<c:url value='/resources/img/CHICK.jpg' /> " style="width: 280px; height: 200px;" alt=""> </a>
							</c:when>
							<c:when test="${resultData.CATEGORY_NAME == '피자'}">
							<img src="<c:url value='/resources/img/pizza.jpg' /> " style="width: 280px; height: 200px;" alt=""> </a>
							</c:when>
							<c:when test="${resultData.CATEGORY_NAME == '도시락'}">
							<img src="<c:url value='/resources/img/dosirack.jpg' /> " style="width: 280px; height: 200px;" alt=""> </a>
							</c:when>
							<c:when test="${resultData.CATEGORY_NAME == '패스트푸드'}">
							<img src="<c:url value='/resources/img/fastfood.jpg' /> " style="width: 280px; height: 200px;" alt=""> </a>
							</c:when>
														
						</c:choose>

					</div>
					<div class="product-body">
						<h3 class="product-price">${resultData.RESTAURANT_NAME}</h3>
						<div class="product-rating">
							${resultData.GRADE}
							<c:forEach var="a" begin="1" end="${resultData.GRADE}" step="1">
								<i class="fa fa-star"></i>
							</c:forEach>
						</div>
						<h2 class="product-name">
							<a href="#" style="display: inline margin-right:100;">${resultData.CATEGORY_NAME}</a>
							<a href="#" style="display: inline padding-right: 0px;"
								class="pull-right">${resultData.RESTAURANT_TEL }</a>
						</h2>

						<p>${resultData.RESTAURANT_ADDR }</p>
						<c:forEach items="${resultData.hashList}" var="hashData"
							varStatus="loopNum">
							<a href="<c:url value='/restView/restlist?search=${hashData.HASH_NAME}&searchWhat=3'/> " style="display: inline; color: gray;">#${hashData.HASH_NAME}
							&nbsp;&nbsp;</a>
						</c:forEach>




						<div class="product-btns"></div>
					</div>
				</div>
			</div>


			<!-- /restaurant Single -->

			<c:choose>
				<c:when test="${(loop.index+1)%4 == 0 }">
	</div>

	</c:when>
	<c:when test="${fn:length(resultList)==(loop.index+1)}">
</div>

</c:when>
</c:choose>

</c:forEach>



</div>
</div>




