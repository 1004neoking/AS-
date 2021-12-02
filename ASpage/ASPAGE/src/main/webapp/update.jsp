<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "bbs.Bbs" %> <!-- 클래스를 그대로 가져온다 -->
<%@ page import = "bbs.BbsDAO" %> <!-- 클래스를 그대로 가져온다 -->
<%@ page import = "java.io.PrintWriter" %> <!-- 자바 스크립트를 작성하기 위해 사용 -->
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
	<%	
// 로그인을 했는지 확인하는 구문
		String userID = null;
		if(session.getAttribute("userID") != null){ //만약 세션값이 null이 아니라면 
			userID = (String) session.getAttribute("userID"); //스트링으로 형변환을 한다
			// userID 변수에 세션값을 String으로 변환해서 넣어둔다
		}if(userID == null){
			PrintWriter script = response.getWriter(); //
			script.println("<script>");
			script.println("alert('로그인을 하세요')"); //알림이 나온다
			script.println("location.href = 'login.jsp'");//로그인 페이지로
			script.println("</script>");
		}
//bbsID가 들어오지 않았다면 유효하지않은 글이다
		int bbsID = 0;
		if(request.getParameter("bbsID") != null){ 
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}//파라미터로 넘어온 bbsID가 null이 아니라면 bbsID에 그 값을 넣어준다
//로그인이 되어있는지 확인한다.
		if(bbsID == 0){//bbsID가 없다면
			PrintWriter script = response.getWriter(); //
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다')"); //알림이 나온다
			script.println("location.href = 'bbs.jsp'");//게시판 메인으로 이동
			script.println("</script>");
		} 
//작성한 글이 작성한 사람 본인인지 확인한다. 현재 넘어온 bbsID 값과 세션값을 비교한다
		Bbs bbs = new BbsDAO().getBbs(bbsID); //글 내용을 불러오는 함수
		if(!userID.equals(bbs.getUserID())){ // !(느낌표)는 부정연산자이다 최종 결과를 반대로 바꾼다
			//세션의 userID가 bbs.getUserID(bbsID)와 동일하지 않다면
			PrintWriter script = response.getWriter(); //
			script.println("<script>");
			script.println("alert('권한이 없습니다')"); //알림이 나온다
			script.println("location.href = 'bbs.jsp'");//게시판 메인으로 이동
			script.println("</script>");
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
                        <a class="nav-link" href="#">고객의소리</a>
                    </li>
                </ul>
                
             
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
           
               
            </div>
        </div>
    </nav>

	<!-- 글쓰기 본문 -->
	<div class ="container" style = "padding-top:90px;">
	<form method="post" action="updateAction.jsp?bbsID<%= bbsID %>">//bbsID를 보낸다
			<div class="card shadow mb-4">
					<nav class="navbar navbar-light bg-light">
						<div class="container  justify-content-center">
							<a class="navbar-brand" style="text-align: center;">게시판 글 수정</a>
						</div>				
					</nav>
				<div = "row">
					<table class = "table table-striped" style = "text-align: center;">
						<tbody>
							<tr>
								<td><input type="text" class = "form-control" placeholder="글 제목" name="bbsTitle" maxlength="50" value= "<%= bbs.getBbsTitle() %>"></td>
							</tr>
							<tr>
								<td><textarea class = "form-control" placeholder="글 내용" name="bbsContent" maxlength="2048" style="height: 350px;"><%= bbs.getBbsContent() %></textarea></td>
								
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<input type="submit" class="btn btn-primary " value="글수정" style="float: right;">
		</form>
	</div>

</body>
</html>