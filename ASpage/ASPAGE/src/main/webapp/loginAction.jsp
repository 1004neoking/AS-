<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "user.UserDAO" %> <!-- 클래스를 그대로 가져온다 -->
    <%@ page import = "java.io.PrintWriter" %> <!-- 자바 스크립트를 작성하기 위해 사용 -->
    <% request.setCharacterEncoding("UTF-8");%> <!-- 건너오는 모든 데이터를 UTF-8으로 받겠다. -->
    <jsp:useBean id="user" class="user.User" scope="page"/> 
    <!-- 자바 빈즈를 사용하겠다. scope=page 현재 페이지에서만 빈즈를 사용하겠다 -->
    <jsp:setProperty name="user" property="userID"/> 
    <jsp:setProperty name="user" property="userPW"/>
     <!-- User.java에 있는 BEAN들이 로그인페이지에서 넘겨준 userID,PW ...들을 받아서 가지고있는다 --> 
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" http-equiv="X-UA-Compatible" content="IE=edge">
    <title>로그인 액션</title>
</head>

<body>
	<%
		//로그인이 되어있으면 접속을 막는 구문
		String userID = null;
		if(session.getAttribute("userID") != null){ //세션을 조회해서 조회해서 null이 아니라면 아이디가 있는것이다
			userID = (String) session.getAttribute("userID"); //userID변수에 자신에게 할당된 세션을 넣는다
		}
		if(userID != null){ //userID변수가 null이 아니라면 로그인이 되어있는 것이다. 
			PrintWriter script = response.getWriter(); //
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다')"); //알림이 나온다
			script.println("location.href = 'main.jsp'");//이전 페이지로 돌려보낸다 (로그인페이지)
			script.println("</script>");
		}
		
		UserDAO userDAO = new UserDAO(); //DAO 객체를 만들고 생성자 호출
		int result = userDAO.login(user.getUserID(), user.getUserPW());//로그인페이지에서 입력된 값으로 login을 시도한다.
		//리턴된 값이 -1, 0, 1이 리턴된다.
		if(result == 1){ //1이 리턴된다면 로그인성공 -> 메인페이지로 이동
			session.setAttribute("userID", user.getUserID()); //로그인 성공시 세션부여 세션 아이디,세션에 넣을 값
			PrintWriter script = response.getWriter(); //
			script.println("<script>");
			script.println("location.href = 'main.jsp'"); //새로운 페이지로 이동하는 스크립트문
			script.println("</script>");
		}
		else if(result == 0){ //0이 리턴된다면 로그인 실패 비밀번호가 틀리다
			PrintWriter script = response.getWriter(); //
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.')"); //알림이 나온다
			script.println("history.back()");//이전 페이지로 돌려보낸다 (로그인페이지)
			script.println("</script>");
		}
		else if(result == -1){ //-1이 리턴된다면 아이디가 없다
			PrintWriter script = response.getWriter(); //
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다.')"); //알림이 나온다
			script.println("history.back()");//이전 페이지로 돌려보낸다 (로그인페이지)
			script.println("</script>");
		}
		else if(result == -2){ //-2가 리턴된다면 예외가 발생한것이다.
			PrintWriter script = response.getWriter(); //
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.')"); //알림이 나온다
			script.println("history.back()");//이전 페이지로 돌려보낸다 (로그인페이지)
			script.println("</script>");
		}
	%>
</body>

</html>