<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

    <title>글작성</title>

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

	<!-- 글쓰기 본문 -->
	<div class ="container" style = "padding-top:90px;">
	<form method="post" action="writeAction.jsp">
			<div class="card shadow mb-4">
					<nav class="navbar navbar-light bg-light">
						<div class="container  justify-content-center">
							<a class="navbar-brand" style="text-align: center;">고객의 소리</a>
						</div>				
					</nav>
				<div = "row">
					<table class = "table table-striped" style = "text-align: center;">
						<tbody>
							<tr>
								<td><input type="text" class = "form-control" placeholder="글 제목" name="bbsTitle" maxlength="50"></td>
							</tr>
							<tr>
								<td><textarea class = "form-control" placeholder="글 내용" name="bbsContent" maxlength="2048" style="height: 350px;"></textarea></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<input type="submit" class="btn btn-primary " value="글쓰기" style="float: right;">
		</form>
	</div>

</body>
</html>