<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@page import="java.util.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.ResultSetMetaData"%>

<%
	response.setCharacterEncoding("UTF-8");
	request.setCharacterEncoding("UTF-8");
	if(session.getAttribute("login")!=null && session.getAttribute("login").equals("ok")){
		String content=0+";URL="+"main.jsp";
		response.setHeader("REFRESH",content); 
	}
%>
	

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" type="text/css" href="main.css">
	<title>~*LOGIN*~</title>
</head>
<body>
	<div class ="title"><span class="text1">Welcome</span> </div>
	<form action="loginResponse.jsp" method="post">
		<div class ="loginblock box-shadow">
		<table border="0" align="center">
			<tbody>
			<tr>
				<td width="160" height="80"><span class="text2">User ID</span> </td>
				<td width="160" ><input type="text" name="userID" maxlength="20" style="width:150"></td>
			</tr>
			<tr>
				<td height="40"><span class="text2">Password</span> </td>
				<td><input type="password" name="passwd" maxlength="20" style="width:150"></td>
			</tr>
			<tr>
				<td align="left" height="150"><input class="button1" type="submit" value="Login" /></td>
				<td align="right"><input class="button2" type="button" value="Sign Up " onclick="location.href='register.jsp'"/></td>
			</tr>
			</tbody>
		</table>
		</div>
	</form>
</body>
</html>