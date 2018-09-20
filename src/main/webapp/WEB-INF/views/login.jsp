<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

    <!-- login  -->
	<h2 class="col-sm-12" style="text-align: center; margin-bottom:40px;">log in</h2>
	<form class="form-signin" role="form" action="<c:url value='/j_spring_security_check' />" method="POST">
	  <div class="form-group">
	    <label for="inputID" class="col-sm-2 control-label">ID</label>
	    <div class="col-sm-9">
	      <input type="text" name="id" class="form-control" id="inputID" placeholder="Your ID">
	      <p class="col-sm-1"></p>
	    </div>
	  </div>
	  <div class="form-group">
	    <label for="inputPassword" class="col-sm-2 control-label">Password</label>
	    <div class="col-sm-9">
	      <input type="password" name="password" class="form-control" id="inputPassword" placeholder="Password">
	      <p class="col-sm-1"></p>
		  <p class="col-sm-2"></p>
		  <p class="col-sm-10" style="padding-left: 0px;color:red;">   				
   				<c:choose>
				    <c:when test="${paramMap.fail eq 'true'}">
				        Login Fail
				    </c:when>
				    <c:otherwise>
				    </c:otherwise>
				</c:choose>
				
			</p>
	    </div>
	  </div>
	  <div class="form-group">
	    <div class="col-sm-offset-2 col-sm-10">
	      <button type="submit" class="primary-btn" style="margin-left: 340px;">log in</button>
	    </div>
	  </div>
	</form>
