<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "bbs.BbsDAO" %> <!-- 클래스를 그대로 가져온다 -->
<%@ page import = "bbs.Bbs" %> <!-- 클래스를 그대로 가져온다 -->
<%@ page import = "java.io.PrintWriter" %> <!-- 자바 스크립트를 작성하기 위해 사용 -->
<% request.setCharacterEncoding("UTF-8");%> <!-- 건너오는 모든 데이터를 UTF-8으로 받겠다. -->

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" http-equiv="X-UA-Compatible" content="IE=edge">
    <title>삭제</title>
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
		} else {
			BbsDAO bbsDAO = new BbsDAO(); //DAO 객체를 만들고 생성자 호출
			int result = bbsDAO.delete(bbsID);
			
			if(result == -1){ // -1이 반환된다면 오류이다
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글 삭제에 실패했습니다.')"); 
				script.println("history.back()");
				script.println("</script>");
			}
			else { //-1 이상이라면 글수정이 성공한것이다.
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'bbs.jsp'");
				script.println("</script>");
			}
		};	
	
%>

</body>

</html>