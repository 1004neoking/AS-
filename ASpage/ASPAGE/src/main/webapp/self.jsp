<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="user.User" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!--HTML5-->
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>고객의 소리</title>

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
	
	<body style="padding-bottom: 70px;">
    <%	// 로그인을 했는지 확인하는 구문
		String userID = null;
		if(session.getAttribute("userID") != null){ //만약 세션값이 null이 아니라면 
			userID = (String) session.getAttribute("userID"); //스트링으로 형변환을 한다
			// userID 변수에 세션값을 String으로 변환해서 넣어둔다	
		}
		int pageNumber = 1; // 현재 게시판은 1페이지 (기본페이지)
		if(request.getParameter("pageNumber") != null){//파라미터로 페이지넘버가 넘어왔다면
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}//페이지 넘버에 해당 파라미터를 넣어준다 (정수형으로 바꿔서)
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


	<div class = "container" style = "padding-top :90px;">
		<div class="card shadow mb-4">
		    <nav class="navbar navbar-light bg-light">
		        <div class="container-fluid">
		          <a class="navbar-brand">스스로 해결</a>
		          <form class="d-flex">
		            <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
		            <button class="btn btn-outline-success" type="submit">Search</button>
		          </form>
		        </div>
		      </nav>
		    <div class="card-body">
		        <div class="table-responsive">
		            <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0" style="text-align: center;">
		                
		                <thead>
		                    <tr>
		                        <th>제목</th>
		                        <th>작성자</th>
		                        <th>작성일</th>	           
		                    </tr>
		                </thead>
		                <tfoot>
		                    <tr>
		                        <th>제목</th>
		                        <th>작성자</th>
		                        <th>작성일</th>
		                    </tr>
		                </tfoot>
		                <tbody>
		                	<%
		                		BbsDAO bbsDAO = new BbsDAO();
		                		ArrayList<Bbs> list = bbsDAO.getselfList(pageNumber);//기본 1으로 설정해뒀다
		                		for(int i = 0; i < list.size(); i++){		                		               		
		                	%>
		                		<tr>
			                        <td><a href ="view.jsp?bbsID=<%=list.get(i).getBbsID()%>"><%=list.get(i).getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replace("\n", "<br>") %></a></td>
			                        <td><%=list.get(i).getUserID()%></td>
			                        <td><%=list.get(i).getBbsDate().substring(0, 11) + list.get(i).getBbsDate().substring(11, 13) + "시" + list.get(i).getBbsDate().substring(14, 16) + "분"%></td>       
		                    	</tr>
		                	
		                	<%
		                		}
		                	%>
		                
		                </tbody>
		            </table>
		            <%
		            	if(pageNumber != 1){ //페이지넘버가 1이아니라면 다 2페이지 이상이기 때문에 이전페이지로 가는 버튼을 만들어준다
		            %>	
		            	<a href= "bbs.jsp?pageNumber=<%= pageNumber - 1%>" class = "btn btn-success btn-arrow-left">이전</a>
		         	<%
		            	} if(bbsDAO.nextPage(pageNumber + 1)) { //페이지넘버에 +1을 해줘서 다음페이지가 존재하는지 확인하고 다음페이지로 가는 버튼을 만들어준다
		         	%>
		         		<a href= "bbs.jsp?pageNumber=<%= pageNumber + 1%>" class = "btn btn-success btn-arrow-left">다음</a>
		         	<%
		            	} 
		         	%>
	           	 		<a href="write.jsp" class="btn btn-primary" style = "float:right;">글쓰기</a>
		        	
	              
	        	</div>
	        </div>
    </div>
</div>



</body>
</html>