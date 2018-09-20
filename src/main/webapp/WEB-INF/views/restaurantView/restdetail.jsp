<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<style>
.star-input>.input, .star-input>.input>label:hover, .star-input>.input>input:focus+label,
	.star-input>.input>input:checked+label {
	display: inline-block;
	vertical-align: middle;
	background: url("<c:url value='/resources/img/grade_img.png'/> ")
		no-repeat;
}

.star-input {
	display: inline-block;
	white-space: nowrap;
	width: 225px;
	height: 40px;
	padding: 25px;
	line-height: 30px;
}

.star-input>.input {
	display: inline-block;
	width: 150px;
	background-size: 150px;
	height: 28px;
	white-space: nowrap;
	overflow: hidden;
	position: relative;
}

.star-input>.input>input {
	position: absolute;
	width: 1px;
	height: 1px;
	opacity: 0;
}

star-input>.input.focus {
	outline: 1px dotted #ddd;
}

.star-input>.input>label {
	width: 30px;
	height: 0;
	padding: 28px 0 0 0;
	overflow: hidden;
	float: left;
	cursor: pointer;
	position: absolute;
	top: 0;
	left: 0;
}

.star-input>.input>label:hover, .star-input>.input>input:focus+label,
	.star-input>.input>input:checked+label {
	background-size: 150px;
	background-position: 0 bottom;
}

.star-input>.input>label:hover ~label{
	background-image: none;
}

.star-input>.input>label[for="p1"] {
	width: 30px;
	z-index: 5;
}

.star-input>.input>label[for="p2"] {
	width: 60px;
	z-index: 4;
}

.star-input>.input>label[for="p3"] {
	width: 90px;
	z-index: 3;
}

.star-input>.input>label[for="p4"] {
	width: 120px;
	z-index: 2;
}

.star-input>.input>label[for="p5"] {
	width: 150px;
	z-index: 1;
}

.star-input>output {
	display: inline-block;
	width: 60px;
	font-size: 18px;
	text-align: right;
	vertical-align: middle;
}
</style>


<script>


fn_star = function() {
	
	var sendData = JSON.stringify({
								  'MEMBER_KEY':$("#member").attr('value')
								, 'RESTAURANT_ID':$("#restaurant").attr('value')
								, 'STAR-POINT':$("#getStar").text()
								, 'updateCheck':$("#updateCheck").attr('value') 
								});

	$.ajax({					//jqeury ajax
		url : "<c:url value='/StarPoint'/> ",
		type : 'post',
		data:sendData,
		dataType : "json",
		contentType : "application/json; charset=UTF-8",
		success:function(result) {
			console.log('success');
			console.log(JSON.stringify(result.data));
			console.log(result.data);
			if(result.data == 1){
				alert('별점을 등록했습니다!');
				$('#gradeTitle').text('제 점수는요?');
				$('.star-btn').text('별점 수정');
				$("#updateCheck").attr('value', 'update');
				
			}else{
				alert('다시 시도해주세요');
			}
		}
		
	});
	
}

fn_marking = function() {
	var sendData = JSON.stringify({
		  							'MEMBER_KEY':$("#member").attr('value')
								  , 'RESTAURANT_ID':$("#restaurant").attr('value')
								  , 'markingCheck' : $('#markingCheck').attr('value')
								});
	
	$.ajax({
		url : "<c:url value='/Marking'/> ",
		type:'post',
		data: sendData,
		dataType:'json',
		contentType:"application/json; charset=UTF-8",
		success:function(result){
			if(result.data == 1){
				if($('#markingCheck').attr('value') == 'insert'){
					alert('즐겨찾기에 추가하셨습니다!');
					$("#markingCheck").attr('value', 'delete');
					$("#makringIcon").attr('class', 'glyphicon glyphicon-ok');
				}else{
					alert('즐겨찾기에서 제외하셨습니다');
					$("#markingCheck").attr('value', 'insert');
					$("#makringIcon").attr('class', 'fa fa-heart');
					
				}

			}
			
			
		}
	});
	
}

fn_delete_comment = function(board_id){
	var msg = confirm('댓글을 삭제하시겠습니까?');
	if(msg == true){
		
		$.ajax({
			url : "<c:url value='/DeleteComment'/> ",
			data:{'BOARD_ID' : board_id},
			dataType : 'json',
			contentType:"application/json; charset=UTF-8",
			success:function(result){
				alert('삭제하셨습니다.');
				$('#boardId'+board_id).remove();
			}
			
		});
		
		
	}else{
		return false;
	}
}

fn_update_comment = function(board_id, member_id, board_comment){
	
	var commentHtml = "";
	commentHtml += "<td class='text-center'><input name='MEMBER_ID' type='hidden' class='form-control' value='"+member_id+"'/>"+member_id+"</td>"
				+ "<td class='details'><textarea name='BOARD_COMMENT' id='commentArea"+board_id+"' class='form-control' placeholder='"+board_comment+"'></textarea></td>"
				+ "<td class='price text-center'><small>Now</small>"
				+ "<td class='text-right'><button type='button' class='btn btn-default btn-sm updateOk' id='updateOk"+board_id+"' onclick=fn_update_ok('"+board_id+"','"+member_id+"')>등록</button></td>";
	
	$('#boardId'+board_id).html(commentHtml);

}

fn_update_ok = function(board_id, member_id){
	
	

	var commentHtml = "";
	var board_comment = $('#commentArea'+board_id).val();
	var sendData = JSON.stringify({
			'BOARD_ID' : board_id
		   ,'BOARD_COMMENT' : board_comment
		});
	
	
	$.ajax({
		url : "<c:url value='/UpdateComment' /> ",
		data : sendData,
		type : 'post',
		dataType : 'json',
		contentType : "application/json; charset=UTF-8",
		success : function(result){
			console.log('댓글 수정 완료');
			console.log(result.data);
			var updatedDay = (result.data)['UPDATE_DATE'];
			 commentHtml += "<td class='text-center'><b>"+member_id+"</b></td>"
							  + "<td class='details text-left'>" + board_comment + "</td>"
							  + "<td class='price text-center'><small>"+updatedDay+"</small></td>"
							  + "<td class='text-right'>"
							  + "<button type='button' class='btn btn-default btn-sm' onclick=fn_update_comment('"+board_id+"','"+member_id+"','"+board_comment+"')>"
							  + "<span>수정</span>"
							  + "</button>"
							  + "&nbsp;"
							  + "<button type='button' class='btn btn-default btn-sm' onclick='fn_delete_comment("+board_id+")'>"
							  + "<span>삭제</span>"
							  + "</button>"
							  + "</td>";
							  
			$('#boardId'+board_id).html(commentHtml);
			alert('댓글 수정 완료');
			
		}
	});
	
	
	
}

fn_menu_description = function(menu_price, menu_desc, menu_name){
	var descHtml = "";
	menu_price = addComma(menu_price)
	descHtml += "<label for='shipping-1'>"+menu_name+"        ("+menu_price+" 원)</label>"
			 + "<p>"+menu_desc+"</p>";

	$('#description').html(descHtml);
	
}


function addComma(num) {
	  var regexp = /\B(?=(\d{3})+(?!\d))/g;
	  return num.toString().replace(regexp, ',');
}


$(function(){
	
	$('.star-btn').click(function(){
		fn_star();
	});
	
	$('#bookmarking').click(function(){
		fn_marking();
	});
	
});

</script>




<!-- section -->
<sec:authentication property="principal" var="principalBean" />
<c:set var="gradePoint" value="0"/>
<c:set var="checkGrade" value="false"/>
<div class="section">
	<!-- container -->
	<div class="container">
		<!-- row -->
		<div class="row">

			<!--  Product Details -->
			<div class="product product-details clearfix">
				<div class="col-md-6">
					<div>
						<div class="product-view">
													<c:choose>
							<c:when test="${restInfo.CATEGORY_NAME == '한식'}">
							<img src="<c:url value='/resources/img/KR.jpg' /> " style="height:450px;" alt=""> </a>
							</c:when>
							<c:when test="${restInfo.CATEGORY_NAME == '분식'}">
							<img src="<c:url value='/resources/img/BS.jpeg' /> " style="height:450px;" alt=""> </a>
							</c:when>
							<c:when test="${restInfo.CATEGORY_NAME == '중식'}">
							<img src="<c:url value='/resources/img/CH.jpg' /> " style="height:450px;" alt=""> </a>
							</c:when>
							<c:when test="${restInfo.CATEGORY_NAME == '일식'}">
							<img src="<c:url value='/resources/img/JP.jpg' /> " style="height:450px;" alt=""> </a>
							</c:when>
							<c:when test="${restInfo.CATEGORY_NAME == '치킨'}">
							<img src="<c:url value='/resources/img/CHICK.jpg' /> " style="height:450px;" alt=""> </a>
							</c:when>
							<c:when test="${restInfo.CATEGORY_NAME == '피자'}">
							<img src="<c:url value='/resources/img/pizza.jpg' /> " style="height:450px;" alt=""> </a>
							</c:when>
							<c:when test="${restInfo.CATEGORY_NAME == '도시락'}">
							<img src="<c:url value='/resources/img/dosirack.jpg' /> " style="height:450px;" alt=""> </a>
							</c:when>
							<c:when test="${restInfo.CATEGORY_NAME == '패스트푸드'}">
							<img src="<c:url value='/resources/img/fastfood.jpg' /> " style="height:450px;" alt=""> </a>
							</c:when>
														
						</c:choose>
						</div>
					</div>
				</div>
				<div class="col-md-6">
					<div class="product-body">
						<div class="product-label">
							<span>${restInfo.CATEGORY_NAME }</span>
							
							
							<div class="pull-right">
								<button class="main-btn icon-btn" id="bookmarking">
									<c:if test="${markingCheck == '0' }">
									<i class="fa fa-heart" id="makringIcon"></i>
									<input type="hidden" id="markingCheck" value="insert" />
									</c:if>
									<c:if test="${markingCheck == '1' }">
									<i class="glyphicon glyphicon-ok" id="makringIcon"></i>
									<input type="hidden" id="markingCheck" value="delete" />
									</c:if>
								</button>
							</div>	
						
							
							
						</div>
						<h2 class="product-name">${restInfo.RESTAURANT_NAME }</h2>
						<div>
							<div class="product-rating">
							<c:forEach var="a" begin="1" end="${restInfo.GRADE}" step="1">
   							<i class="fa fa-star"></i> 
  							 </c:forEach>

							</div>
							<a href="#">${restInfo.GRADE} 점 </a>
						</div>
						<p>
							<strong>주소</strong><br> 
							${restInfo.RESTAURANT_ADDR }
						</p>
						<br>
						<p>
							<strong>연락처</strong><br> 
							${restInfo.RESTAURANT_TEL}
						</p>
						<br>
						<c:if test="${fn:length(hashList) > 0}">
						<p>	
							
							<strong>해시태그</strong> 
							<br>
							 <c:forEach items="${hashList}" var="hashData" varStatus="loopNum">
							 <a href="<c:url value='/restView/restlist?search=${hashData.HASH_NAME}&searchWhat=3'/> " style="display:inline; color:gray;">#${hashData.HASH_NAME} &nbsp;&nbsp;</a>
							 </c:forEach>
							
							
						</p>
						<br>
						 </c:if>
						<p>
							<strong>업체 상세</strong><br> 
							${restInfo.RESTAURANT_DESCRIPTION}
						</p>
						
						<br>

						
						
						<div class="payments-methods">
						<div class="section-title">
						
						<sec:authorize access="isAuthenticated()">
						<c:choose>
						<c:when test="${gradeCheck == '0'}">
						
							<h4 class="title" id="gradeTitle">제 점수는요?</h4>
						</c:when>

						<c:otherwise>

						<h4 class="title" id="gradeTitle">제 점수는요?</h4>
						
						</c:otherwise>
						</c:choose>
						</sec:authorize>
						
						
						</div>
						<form name="star-point" id="star-point" method="post">
						<span class="star-input"> <span class="input">
						<c:if test="${gradeCheck == '1' }">
						
						 <c:forEach var="a" begin="1" end="5" step="1">
						 	<c:choose>
						 	<c:when test="${gradeInfo.GRADE == a}">
						 	<input type="radio" name="star-input" value="${a}" id="p${a}" checked/> <label for="p${a}">${a}</label>
						 	</c:when>
						 	<c:otherwise>
						 	<input type="radio" name="star-input" value="${a}" id="p${a}"/> <label for="p${a}">${a}</label>
						 	</c:otherwise>
						 	</c:choose>
						 </c:forEach>
						 </c:if>
						 <c:if test="${gradeCheck=='0'}">
						 <input type="radio" name="star-input" value="1" id="p1" /> <label
										for="p1">1</label> <input type="radio" name="star-input"
										value="2" id="p2" /> <label for="p2">2</label> <input
										type="radio" name="star-input" value="3" id="p3" /> <label
										for="p3">3</label> <input type="radio" name="star-input"
										value="4" id="p4" /> <label for="p4">4</label> <input
										type="radio" name="star-input" value="5" id="p5" /> <label
										for="p5">5</label>
						 </c:if>
						
										<sec:authorize access="isAuthenticated()">
										<input type="hidden" id="member" name="MEMBER_KEY" value="${principalBean.MEMBER_KEY}"/>
										<input type="hidden" id="restaurant" name="RESTAURANT_ID" value="${resultMap.RESTAURANT_ID}"/>
										</sec:authorize>
									
						</span>
						<output for="star-input"><b id="getStar">${gradeInfo.GRADE}</b>점</output>
						<c:choose>
						<c:when test="${gradeCheck == '0'}">
						<input id="updateCheck" type="hidden" value="insert"/>
						</c:when>
						<c:otherwise>
						<input id="updateCheck" type="hidden" value="update"/>
						</c:otherwise>
						</c:choose>
						</span>
						</form>
						<script src="<c:url value='/resources/js/star.js' /> "></script>
					</div>
					
					<div class="pull-right">
						<c:choose>
						<c:when test="${gradeCheck == '0' }">
						<button class="star-btn primary-btn" type="button" >별점 주기</button>
						</c:when>
						<c:otherwise>
						<button class="star-btn primary-btn" type="button" >별점 수정</button>
						</c:otherwise>
						</c:choose>
					</div>
					</div>
				</div>
				
				

					
					
				 <div class="col-md-12">
					<div class="product-tab">
						<ul class="tab-nav">
							<li class="active"><a data-toggle="tab" href="#tab1">메뉴 확인</a></li>
						</ul>
						<div class="tab-content">
							<div id="tab1" class="tab-pane fade in active">
								<p><b>메뉴명을 클릭해서 가격과 상세 설명을 확인하실 수 있습니다.</b></p>
							</div>
						</div>
					</div>
				</div>
			</div>






			
				<div class="col-md-6">
					<div class="billing-details">


						<div class="section-title">
							<h4 class="title">메뉴 리스트</h4>
						</div>
						<c:forEach items="${menuList}" var="resultData" varStatus="loop">
						<div class="form-group text-center">
							<strong><a href="#menuDescription" onclick="fn_menu_description('${resultData.MENU_PRICE}', '${resultData.MENU_DESCRIPTION}', '${resultData.MENU_NAME}')">${resultData.MENU_NAME}</a></strong>
						</div>
						</c:forEach>
					</div>
				</div>

				<div class="col-md-6">
					<div class="shiping-methods">
						<div class="section-title">
							<h4 class="title" id="menuDescription">메뉴 설명</h4>
						</div>
						<div class="input-checkbox" id="description">
							
							
							<div class="caption">
							
							</div>
						</div>

					</div>
		</div> 
		

		<!-- Comment & Grade -->
		<div class="col-md-12">
			<div class="order-summary clearfix">
				<div class="section-title">
					<h3 class="title">리뷰</h3>
				</div>
				<table class="shopping-cart-table table">
					<thead>
						<tr>
							<th class="text-center" style="width: 150px;">사용자</th>
							<th class="text-center" style="width: 700px;">댓글</th>
							<th class="text-center" style="width: 100px;">등록일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${resultMap.commentList}" var="resultData" varStatus="loop">
							<tr id="boardId${resultData.BOARD_ID}">
								<td class="text-center"><b>${resultData.MEMBER_ID}</b></td>
								<td class="details text-left">${resultData.BOARD_COMMENT}</td>

								<td class="price text-center"><small>${resultData.UPDATE_DATE}</small></td>
								<sec:authorize access="isAuthenticated()">
								<c:if test="${resultData.MEMBER_ID eq  principalBean.username}">
 									<td class="text-right">
									<button type="button" class="btn btn-default btn-sm" onclick="fn_update_comment('${resultData.BOARD_ID}','${resultData.MEMBER_ID}', '${resultData.BOARD_COMMENT }') ">
  									<span id="update${loop.index}">수정</span>
									</button> 
									<button type="button" class="btn btn-default btn-sm" onclick="fn_delete_comment('${resultData.BOARD_ID }')">
  									<span id="delete${loop.index}">삭제</span>
									</button> 
									</td> 
								</c:if>
								</sec:authorize>
							</tr>
						</c:forEach>

						<!-- 댓글 및 평점 입력 form -->
						<tr>

							<form id="commentForm"
								action="<c:url value='/review/insertReview' /> " method="post">
								<sec:authorize access="isAuthenticated()">
									<input id="member_key" name="MEMBER_KEY" type="hidden"
										class="form-control"
										value="<c:url value='${principalBean.MEMBER_KEY}'/>" />
									<input id="inputRestID" name="RESTAURANT_ID" type="hidden"
										class="form-control" value="${resultMap.RESTAURANT_ID}" />
									<td class="thumb text-center"><input id="inputID"
										name="MEMBER_ID" type="hidden" class="form-control"
										value="${principalBean.username}" />${principalBean.username}</td>
									<td class="details"><textarea id="inputContent"
											name="BOARD_COMMENT" class="form-control"
											placeholder="input contents"></textarea></td>
									<td class="price text-center"><small>Now</small></td>

									
								</sec:authorize>
						</tr>
					</tbody>
				</table>
				<div class="pull-right">
					<input class="primary-btn" type="submit" value="리뷰 등록" />
				</div>
				</form>

			</div>

		</div>

	</div>
	<!-- /row -->
</div>
<!-- /container -->
</div>
<!-- /section -->
