<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <!--HTML5-->
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>메인페이지</title>

    <!--폰트 참조-->
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">
    <link href="/css/sb-admin-2.css" rel="stylesheet">
    <!--부트스트랩 참조-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

    <style>
      a { text-decoration:none }
      a { color: black};
    </style>

</head>

<body>
	<%	// 로그인을 했는지 확인하는 구문
		String userID = null;
		if(session.getAttribute("userID") != null){ //만약 세션값이 null이 아니라면 
			userID = (String) session.getAttribute("userID"); //스트링으로 형변환을 한다
			// userID 변수에 세션값을 String으로 변환해서 넣어둔다	
		}
	%>
	
    <!-- 네비게이션 바 -->
    <nav class="navbar navbar-expand-lg fixed-top navbar-light bg-light">
        <div class="container">
            <a class="navbar-brand" href="main.jsp">AS 서비스</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">

                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="self.jsp">스스로해결</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="guide.jsp">요금안내</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">서비스예약</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="bbs.jsp">고객의소리</a>
                    </li>
                </ul>
                
                
                <%
                	if(userID == null) { 
                	//만약 userID가 null이라면 로그인이 안되어있는 것이다. 로그인,회원가입을 드랍다운으로 표시함
                %>
                <div class="collapse navbar-collapse justify-content-end">
                  <li class="nav dropdown">
                    <a style="color: black;" class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                      접속하기
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                      <li><a class="dropdown-item" href="login.jsp">로그인</a></li>
                      <li><a class="dropdown-item" href="register.jsp">회원가입</a></li>
                    </ul>
                  </li>
                </div>
                
                <%
                	}else { //null이 아니라면 로그인이 되어있는 것이다. 드랍다운으로 로그아웃을 표시
                %>
                <div class="collapse navbar-collapse justify-content-end">
                  <li class="nav dropdown">
                    <a style="color: black;" class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                      회원관리
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                      <li><a class="dropdown-item" href="logoutAction.jsp">로그아웃</a></li>
                    </ul>
                  </li>
                </div>
                <%
                	}
                %>
               
            </div>
        </div>
    </nav>
    
    <!--캐로셀 (중앙의 사진) -->
    <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
        <div class="container">
        <div class="carousel-indicators">
          <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
          <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
          <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
        </div>
        <div class="carousel-inner">
          <div class="carousel-item active">
            <img src="img\MAIN3.jpg" class="d-block w-100" alt="...">
          </div>
          <div class="carousel-item">
            <img src="img/MAIN2.jpg" class="d-block w-100" alt="...">
          </div>
          <div class="carousel-item">
            <img src="img/MAIN1.jpg" class="d-block w-100" alt="...">
          </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
          <span class="carousel-control-prev-icon" aria-hidden="true"></span>
          <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
          <span class="carousel-control-next-icon" aria-hidden="true"></span>
          <span class="visually-hidden">Next</span>
        </button>
      </div>
    </div><br>
    
    <div class="container">
      <div class="row row-cols-1 row-cols-md-3 g-4">
        <div class="col">
          <div class="card">
            <img src="img/006.jpg" class="card-img-top" alt="...">
            <div class="card-body">
              <h5 class="card-title">제품자가진단</h5>
              <a href="self.jsp" class="card-text">등록된 생활가전 제품의 진단 결과를 간편하게 확인해 보세요.</a>

            </div>
          </div>
        </div>
        <div class="col">
          <div class="card">
            <img src="img/002.png" class="card-img-top" alt="...">
            <div class="card-body">
              <h5 class="card-title">동영상</h5>
              <a href="https://www.youtube.com" class="card-text" target="_blank">동영상 가이드를 활용하여 제품에 대한 궁금증을 해결할 수 있습니다.</a>
            </div>
          </div>
        </div>
        <div class="col">
          <div class="card">
            <img src="img/003.png" class="card-img-top" alt="...">
            <div class="card-body">
              <h5 class="card-title">다운로드 자료실</h5>
              <a href="#" class="card-text">제품관련 유용한 자료를 다운받을 수 있습니다.</a>
            </div>
          </div>
        </div>
      </div>
    </div><br><br>

    <h1 style="text-align: center;">주요 서비스 안내</h1><br>
    <div class="container">
      <div class="row row-cols-1 row-cols-md-3 g-4">
        <div class="col">
          <div class="card">
            <img src="img/005.jpg" class="card-img-top" alt="...">
            <div class="card-body">
              <h5 class="card-title">출장서비스 예약</h5>
              <a href="#" class="card-text">원하시는 곳으로 엔지니어가 방문하여 제품을 점검해 드립니다.</a>

            </div>
          </div>
        </div>
        <div class="col">
          <div class="card">
            <img src="img/004.jpg" class="card-img-top" alt="...">
            <div class="card-body">
              <h5 class="card-title">센터 찾기</h5>
              <a href="#" class="card-text">우리동네에 있는 센터 정보를 조회할 수 있습니다.</a>
            </div>
          </div>
        </div>
        <div class="col">
          <div class="card">
            <img src="img/006.jpg" class="card-img-top" alt="...">
            <div class="card-body">
              <h5 class="card-title">이메일 상담</h5>
              <a href="#" class="card-text">제품에 대한 궁금한 내용을 이메일로 답변해 드립니다.</a>
            </div>
          </div>
        </div>
        
      </div>
    </div><br>
    

    <h1 style="text-align: center;">공지사항</h1><br>
    <div class="container" style="padding-bottom: 70px;">
      <div class="row row-cols-1 row-cols-md-3 g-4">
        <div class="col">
          <div class="card">
            <div class="card-body">
              <h5 class="card-title">마포점 휴점 안내</h5>
              <p class="card-text">마포점이 리뉴얼 공사로 인해 휴점합니다.<br>2021-11-08</p>
            </div>
          </div>
        </div>
        <div class="col">
          <div class="card">
            <div class="card-body">
              <h5 class="card-title">홍대점 휴점 안내</h5>
              <p class="card-text">홍대점이 리뉴얼 공사로 인해 휴점합니다.<br>2021-11-08</p>
            </div>
          </div>
        </div>
        <div class="col">
          <div class="card">
            <div class="card-body">
              <h5 class="card-title">평택점 폐점 안내</h5>
              <p class="card-text">평택점이 폐점하게 되었습니다. <br>2021-11-08</p>
            </div>
          </div>
        </div>
      </div>
    </div>

  
</body>
</html>