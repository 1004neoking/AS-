<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

    <title>회원 가입</title>

    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">
    <link href="/css/sb-admin-2.css" rel="stylesheet">

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
    
    <div class="container"> <!--중앙 정렬-->
        <div class="row justify-content-center" style="padding-top:60px;">

        <div class="card shadow-lg my-5">
            <div class="card-body p-0">
                
                <div class="row">
                    <div class="col-lg-5 d-none d-lg-block bg-register-image" >
                        
                        <img src="img/LOGRE.jpg" style="max-width: 100%; height: auto;" alt="">
                    </div>
                    <div class="col-lg-7">
                        <div class="p-5">
                            <div class="text-center">
                                <h1 class="h4 text-gray-900 mb-4">회원 가입</h1>
                            </div>
                            <form class="user" method="post" action="registerAction.jsp">
                           
                                <div class="form-group row">
                                    <div class="col-sm-6 mb-3 mb-sm-0">
                                        <input type="text" class="form-control form-control-user" id="id"
                                            placeholder="아이디" name="userID"><br>
                                    </div>
                                    <div class="col-sm-6">
                                        <input type="text" class="form-control form-control-user" id="name"
                                            placeholder="이름" name="userName"><br>
                                    </div>
                                   
                                    <!--placeholder == 인풋칸 안에 들어있는 초기글-->
                                    <!--col은 열 sm은 small md는 medium lg는 large-->
                                    <!--row는 가로로 그룹지을 칼럼들의 집합-->
                                </div>
                                <div class="form-group row">
                                    <div class="col-sm-6 mb-3 mb-sm-0"> 
                                        <!--col은 열 sm은 small md는 medium lg는 large-->
                                        <input type="password" class="form-control form-control-user"
                                            id="passwd" placeholder="비밀번호" name="userPW"><br>
                                    </div>
                                    <div class="col-sm-6">
                                        <input type="Birth" class="form-control form-control-user"
                                            id="RepeatPasswd" placeholder="생년월일" name="userBirth"><br>
                                    </div>
                                </div>
                             
                                <div class="form-group">
                                        <input type="phone" class="form-control form-control-user"
                                            id="phone" placeholder="전화번호" name="userPhone"><br>
                                    </div>
                                <div class="form-group">
                                    <input type="email" class="form-control form-control-user" id="userEmail"
                                        placeholder="이메일" name = "userEmail"><br>
                                </div>
                                <div class="form-group">
                                    <input type="text" class="form-control form-control-user" id="userAddr"
                                        placeholder="주소" name = "userAddr"><br>
                                </div>
                                
                                <input type="submit" style="float: right;" class="btn btn-primary btn-user btn-block" value="회원가입">
                               
                                <br>
                                                                
                            </form>
                           
                        </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>

</html>