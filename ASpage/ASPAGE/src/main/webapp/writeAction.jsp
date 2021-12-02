<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "bbs.BbsDAO" %> <!-- 클래스를 그대로 가져온다 -->
    <%@ page import = "java.io.PrintWriter" %> <!-- 자바 스크립트를 작성하기 위해 사용 -->
    <% request.setCharacterEncoding("UTF-8");%> <!-- 건너오는 모든 데이터를 UTF-8으로 받겠다. -->
    
    <jsp:useBean id="bbs" class="bbs.Bbs" scope="page"/> 
    <!-- 자바 빈즈를 사용하겠다. scope=page 현재 페이지에서만 빈즈를 사용하겠다 -->
    <jsp:setProperty name="bbs" property="bbsTitle"/> 
    <jsp:setProperty name="bbs" property="bbsContent"/>
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
		if(userID == null){ //글쓰기는 로그인이 되어있어야한다 null일경우 로그인을 하라고 알린 후 메인페이지로
			PrintWriter script = response.getWriter(); //
			script.println("<script>");
			script.println("alert('로그인을 하세요')"); //알림이 나온다
			script.println("location.href = 'login.jsp'");//로그인 페이지로
			script.println("</script>");
			
		}else {//로그인이 되어있다면?
			
			//글쓰기에 제목,컨텐츠가 전부 적혀있어야 작동되게끔 null인 경우 돌려보낸다
			if(bbs.getBbsTitle() == null || bbs.getBbsContent() == null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안된 사항이 있습니다.')"); //알림이 나온다
				script.println("history.back()");//이전 페이지로 돌려보낸다 (로그인페이지)
				script.println("</script>");
			} else{
				BbsDAO bbsDAO = new BbsDAO(); //DAO 객체를 만들고 생성자 호출
				int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());//자바bean 6개를 모아둔 user로 register 호출
				
				if(result == -1){ // -1이 반환된다면 오류이다
					PrintWriter script = response.getWriter(); //
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다.')"); //알림이 나온다
					script.println("history.back()");//이전 페이지로 돌려보낸다 (로그인페이지)
					script.println("</script>");
				}
				else { //-1 이상이라면 글쓰기가 성공한것이다.
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("history.back()"); //메인페이지로 이동
					script.println("</script>");
				}
			}	
		}
		
	%>
</body>

</html>