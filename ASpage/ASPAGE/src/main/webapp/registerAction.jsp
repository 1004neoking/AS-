<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "user.UserDAO" %> <!-- 클래스를 그대로 가져온다 -->
    <%@ page import = "java.io.PrintWriter" %> <!-- 자바 스크립트를 작성하기 위해 사용 -->
    <% request.setCharacterEncoding("UTF-8");%> <!-- 건너오는 모든 데이터를 UTF-8으로 받겠다. -->
    
    <jsp:useBean id="register" class="user.User" scope="page"/> 
    <!-- 자바 빈즈를 사용하겠다. scope=page 현재 페이지에서만 빈즈를 사용하겠다 -->
    <jsp:setProperty name="register" property="userID"/> 
    <jsp:setProperty name="register" property="userPW"/>
    <jsp:setProperty name="register" property="userName"/>
    <jsp:setProperty name="register" property="userBirth"/>
    <jsp:setProperty name="register" property="userPhone"/>
    <jsp:setProperty name="register" property="userEmail"/>
    <jsp:setProperty name="register" property="userAddr"/>    
    <!-- 이 7개가 위에있는 <jsp:useBean id="user" class="user.User" scope="page"/>   -->
    
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
	
		//회원가입시 입력하지 않은 사항이 있으면 안되니 전부 처리를 해준다. 하나라도 null값이라면 다시 돌려보낸다
		if(register.getUserID() == null || register.getUserPW() == null || register.getUserName() == null || register.getUserBirth() == null ||
		register.getUserPhone() == null || register.getUserEmail() == null || register.getUserAddr() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안된 사항이 있습니다.')"); //알림이 나온다
			script.println("history.back()");//이전 페이지로 돌려보낸다 (로그인페이지)
			script.println("</script>");
		} else{
			UserDAO userDAO = new UserDAO(); //DAO 객체를 만들고 생성자 호출
			int result = userDAO.register(register);//자바bean 6개를 모아둔 user로 register 호출
			
			if(result == -1){ // db안에 pk가 userID밖에 없으니 오류가 난 경우 ID중복이다
				PrintWriter script = response.getWriter(); //
				script.println("<script>");
				script.println("alert('해당 ID가 존재합니다.')"); //알림이 나온다
				script.println("history.back()");//이전 페이지로 돌려보낸다 (로그인페이지)
				script.println("</script>");
			}
			else { //-1 이상이라면 회원가입이 성공한것이다. 로그인을 시키고 메인페이지로 이동
				session.setAttribute("userID", user.getUserID()); //로그인 성공시 세션부여 세션 아이디,세션에 넣을 값
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'main.jsp'"); //메인페이지로 이동
				script.println("</script>");
			}
		};
		
	%>
</body>

</html>