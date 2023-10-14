<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<meta charset="UTF-8">
<title>test.jsp</title>
<script>
	function aClick () {
		alert('aaaa');
	}

</script>
</head>
<body>
<%@ include file="../home/topmenu.jsp" %>

<div class="row justify-content-md-center">
	<div class="col col-lg-1"></div>
	
	<div class="col card mb-4 border-light justify-content-md-center">
		<div class="row">
			<div class="card mb-4 border-light">
				<div class="card-header text-center">
						<h3>사진 업로드 게시판 - 목록</h3>
				</div>
			</div>
		</div>
		<div class="row row-cols-1 row-cols-md-4 g-4">
		  <div class="col">
		      <div class="embed-responsive embed-responsive-4by3">
		      	<a class="nav-link" href="#" onclick="aClick()"><img src="./images/cat1.jpg" class="card-img-top embed-responsive-item" alt="..."></a>
		      <div class="card-body">
		        <a class="nav-link" href="#" onclick="aClick()"><h5 class="card-title">Card title</h5></a>
		      </div>
		    </div>
		  </div>
		  <div class="col">
		      <div class="embed-responsive embed-responsive-4by3">
		      <img src="./images/cat.jpg" class="card-img-top embed-responsive-item" alt="...">
		      <div class="card-body">
		        <h5 class="card-title">Card title</h5>
		      </div>
		    </div>
		  </div>
		  <div class="col">
		    <div class="card h-100">
		      <img src="./images/cat2.jpg" class="card-img-top" alt="...">
		      <div class="card-body">
		        <h5 class="card-title">Card title</h5>
		      </div>
		    </div>
		  </div>
		  <div class="col">
		    <div class="card h-100">
		      <img src="./images/dog1.jpg" class="card-img-top" alt="...">
		      <div class="card-body">
		        <h5 class="card-title">Card title</h5>
		      </div>
		    </div>
		  </div>
		  <div class="col">
		    <div class="card h-100">
		      <img src="./images/dog2.jpg" class="card-img-top" alt="...">
		      <div class="card-body">
		        <h5 class="card-title">Card title</h5>
		      </div>
		    </div>
		  </div>
		  <div class="col">
		    <div class="card h-100">
		      <img src="./images/cat4.jpg" class="card-img-top" alt="...">
		      <div class="card-body">
		        <h5 class="card-title">Card title</h5>
		      </div>
		    </div>
		  </div>
		  <div class="col">
		    <div class="card h-100">
		      <img src="./images/cat5.jpg" class="card-img-top" alt="...">
		      <div class="card-body">
		        <h5 class="card-title">Card title</h5>
		      </div>
		    </div>
		  </div>
		</div>
	</div>
	
	<div class="col col-lg-1"></div>
</div>



<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
</body>
</html>