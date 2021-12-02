<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" http-equiv="X-UA-Compatible" content="IE=edge">
    <title>로그아웃 액션</title>
</head>

<body>
	<% session.invalidate(); %> <!-- 세션해제 -->
	<script>
	location.href = 'main.jsp'; //메인페이지로 이동
	</script>
</body>
</html>