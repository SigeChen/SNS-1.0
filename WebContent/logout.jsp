<%@page language="java" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.ResultSetMetaData"%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" type="text/css" href="main.css">
	<title>~*WAIT*~</title>
</head>
<body>
<div class ="title"><span class="text1">Welcome</span> </div>
<div class ="waitblock box-shadow">
<%
	int ok=0;
	if(session.getAttribute("login")!=null && session.getAttribute("login").equals("ok")){
		session.setAttribute("login",null);
		session.setAttribute("userID",null);
		ok=1;
	}
	out.println("<p class=\"text3\">Log out...</p>");
	out.println("<p class=\"text3\">Return to <a href=\"login.jsp\">login page</a> after 5s.</p>");
	String content=5+";URL="+"login.jsp";
	response.setHeader("REFRESH",content); 
%>
</div>
</body>
</html>