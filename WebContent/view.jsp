﻿<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="checkvalid.jsp" %>
<%@page import="java.util.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.ResultSetMetaData"%>

<%

	response.setCharacterEncoding("UTF-8");
	request.setCharacterEncoding("UTF-8");
	String userID=(String)session.getAttribute("userID");
	String targetID=(String)request.getParameter("userID");
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
		+ request.getServerName() + ":" + request.getServerPort()
		+ path + "/";

	/** 链接数据库参数 **/
	String driverName = "com.mysql.jdbc.Driver"; //驱动名称
	String DBUser = "root"; //mysql用户名
	String DBPasswd = "mysql2016PHY"; //mysql密码
	String DBName = "test"; //数据库名
	String MySQLServer = "127.0.0.1"; //MySQL地址
	String MySQLServerPort = "3306"; //MySQL端口号（默认为3306）

	//数据库完整链接地址
	String connUrl = "jdbc:mysql://"+MySQLServer+":"+MySQLServerPort+"/" + DBName + "?user="
		+ DBUser + "&password=" + DBPasswd ;

	//加载数据库驱动
	Class.forName(driverName).newInstance();

	//链接数据库并保存到 conn 变量中
	Connection conn = DriverManager.getConnection(connUrl);

	//申明～？
	Statement stmt = conn.createStatement();

	//设置字符集
	stmt.executeQuery("SET NAMES UTF8");

	
	//申明～？
	Statement stmt2 = conn.createStatement();

	//设置字符集
	stmt2.executeQuery("SET NAMES UTF8");
	
	//要执行的 sql 查询
	String sql;
	
	
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" type="text/css" href="main.css">
	<title>~*Information*~</title>
  	<script language="JavaScript">  
		function submitStatement(){
			var statement=document.getElementById("statement");
			var strInput = statement.value;
			if (strInput!=""){
				var xmlhttp=null;
				if (window.XMLHttpRequest){
					// code for IE7+, Firefox, Chrome, Opera, Safari
					xmlhttp=new XMLHttpRequest();
				}
				else{
					// code for IE6, IE5
					xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
				}
				if (xmlhttp!=null){
					xmlhttp.onreadystatechange=function(){
						if (xmlhttp.readyState==4 && xmlhttp.status==200){
							window.location.reload();
						}
					}
					strInput="submitStatement.jsp?words="+strInput;
					strInput=encodeURI(strInput);
					strInput=encodeURI(strInput);
					xmlhttp.open("GET",strInput,true);
					xmlhttp.send();
				}
			}else{
				alert("请输入内容！");
			}
		}
		function reply(statementID){
			var statementDoc=document.getElementById(statementID);
			if(statementDoc.style.display=="none"){
				statementDoc.style.display="";
				statementDoc=document.getElementById(statementID+"Button");
				statementDoc.style.display="";
			}
			else{
				statementDoc.style.display="none";
				statementDoc=document.getElementById(statementID+"Button");
				statementDoc.style.display="none";
			}
		}
		function submitReply(statementID){
			var statementDoc=document.getElementById(statementID);
			var strInput = statementDoc.value;
			if (strInput!=""){
				var xmlhttp=null;
				if (window.XMLHttpRequest){
					// code for IE7+, Firefox, Chrome, Opera, Safari
					xmlhttp=new XMLHttpRequest();
				}
				else{
					// code for IE6, IE5
					xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
				}
				if (xmlhttp!=null){
					xmlhttp.onreadystatechange=function(){
						if (xmlhttp.readyState==4 && xmlhttp.status==200){
						
							window.location.reload();
						}
					}
					strInput="submitReply.jsp?words="+strInput+"&statementID="+statementID;
					strInput=encodeURI(strInput);
					strInput=encodeURI(strInput);
					xmlhttp.open("GET",strInput,true);
					xmlhttp.send();
				}
			}else{
				alert("请输入内容！");
			}
		}
  		function secondfriend(){ searchForm.name="secName";frm.action="secondfriend.jsp";frm.submit(); }   
 		function newfriend(){  searchForm.name="searchName";frm.action="search.jsp"; frm.submit(); }

	function reply(statementID){
			var statementDoc=document.getElementById(statementID);
			if(statementDoc.style.display=="none"){
				statementDoc.style.display="";
				statementDoc=document.getElementById(statementID+"Button");
				statementDoc.style.display="";
			}
			else{
				statementDoc.style.display="none";
				statementDoc=document.getElementById(statementID+"Button");
				statementDoc.style.display="none";
			}
		}
		function submitReply(statementID){
			var statementDoc=document.getElementById(statementID);
			var strInput = statementDoc.value;
			if (strInput!=""){
				var xmlhttp=null;
				if (window.XMLHttpRequest){
					// code for IE7+, Firefox, Chrome, Opera, Safari
					xmlhttp=new XMLHttpRequest();
				}
				else{
					// code for IE6, IE5
					xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
				}
				if (xmlhttp!=null){
					xmlhttp.onreadystatechange=function(){
						if (xmlhttp.readyState==4 && xmlhttp.status==200){
						
							window.location.reload();
						}
					}
					xmlhttp.open("GET","submitReply.jsp?words="+strInput+"&statementID="+statementID,true);
					xmlhttp.send();
				}
			}else{
				alert("请输入内容！");
			}
		}
	</script>
</head>
<body>
	<div class ="title">
	<span class="text1">Welcome, 
	<a href="main.jsp" style="color:#ec5a52;text-decoration:none;">
	<%
		sql= "SELECT * FROM `test`.`account` where userID='"+userID+"' LIMIT 15";
		System.out.println(sql);
		ResultSet rs = stmt.executeQuery(sql);
		if (rs.next()){
			out.println(rs.getString("UserName"));
	}%></a></span>

		<div style="position:relative;right:10px;top:10px;float:right;">
	    	<form action="secondfriend.jsp" method="post">
	    		<input type="text" name="secName" maxlength="15" style="width:120"/>
	    		<input class="button2" type="submit" value="Network" />
	   	</form></div>
		<div style="position:relative;right:30px;top:10px;float:right;">
		<form action="search.jsp" method="post">
			<input type="text" name="searchName" maxlength="15" style="width:120"/>
			<input class="button2" type="submit" value="New Friends" />
	        		<input class="button2" type="button" value="My Friends" onClick="location.href='myfriends.jsp'"/>
			<input class="button2" type="button" value="Logout" onClick="location.href='logout.jsp'" />
		</form></div>
	</div>


	<div class="list box-shadow" >
	<p ><span style="font-family:GOTHICB;color:#FFFFFF;position: relative;left:10px;top:15px;font-size:120%;">
	<%
	sql= "SELECT * FROM `test`.`account` where userID='"+targetID+"' LIMIT 15";
	System.out.println(sql);

	//取得结果
	String targetName=null;
	rs = stmt.executeQuery(sql);
	if (rs.next()){
		targetName=rs.getString("UserName");
		out.print(targetName+"  ");
		if(rs.getString("sex")=="女")
		out.print("Female ");
		else out.print("Male ");
		out.print(rs.getString("birthMonth")+" / ");
		out.print(rs.getString("birthYear"));
		
	}%>
	</span></p>
	</div>
	<div  style="margin-top:40px;">
	<%
	sql= "SELECT statementID,releaseTime,content "
		+				"FROM `test`.`statement` "
		+	"where userID='"+ targetID+"' "
	+"order by releaseTime desc "
	+"limit 0,10;";
	
	//取得结果
	rs = stmt.executeQuery(sql);
	while (rs.next()){
	%>
	<div align="center">
		<hr width="800" color="#ffffff"/>
		<table bgcolor="">
			<tr>
				<td  width="500"><a style="font-family:GOTHICB;color:#FFFFFF;text-decoration:none;" href="view.jsp?userID=<%out.print(targetID);%>"><%out.print(targetName);%>:</a></td>
			</tr>
			<tr height="100">
				<td width="600"><span style="font-family:GOTHIC;color:#FFFFFF;"><%out.print(rs.getString("content"));%></span></td>
				<td width="110"><span style="font-family:GOTHIC;color:#aaaaaa;"><%out.print(rs.getString("releaseTime"));%></span></td>
				<td width="40"><input class="button2" type="button" value="Reply" onClick="reply('<%out.print(rs.getString("statementID"));%>')"/><td>
			</tr>
			<%
			sql="SELECT a.userID as userID,userName,commentID,releaseTime,content "
				+				"FROM `test`.`account` as a, `test`.`comment` as b "
				+	"where a.userID=b.userID and "
				+	"b.statementID='"+ rs.getString("statementID")+"' "
				+"order by releaseTime "
				+"limit 0,10;";
				System.out.println(sql);
				ResultSet rs2 = stmt2.executeQuery(sql);
			while (rs2.next()){
			%>
				<tr height="">
		
					<td class="comment" width="500"><span style="font-family:GOTHIC;color:#aaaaaa;"><a href="view.jsp?userID=<%out.print(rs2.getString("userID"));%>"  style="color:#ffffff;text-decoration:none;"><%out.print(rs2.getString("userName"));%></a> reply: </span><span style="font-family:GOTHIC;color:#FFFFFF;"><%out.print(rs2.getString("content"));%></span>
					</td>
					<td  class="comment" width="110"><span style="font-family:GOTHIC;color:#aaaaaa;"><%out.print(rs2.getString("releaseTime"));%></span>
					</td>
					<td  class="comment" width="60"><td>
				</tr>
			<%
			}
			rs2.close();
			%>
		</table>
		<div>
			<input style="display:none; height:25;width:500" id="<%out.print(rs.getString("statementID"));%>" value=""/>
			<input class="button2" type="button" style="display:none;" id="<%out.print(rs.getString("statementID"));%>Button" value="Submit" onClick="submitReply('<%out.print(rs.getString("statementID"));%>')"/>
		</div>
		</div>
	</div>
	<%
	}
	%>
	</div>
</body>
</html>
<%

		/** 关闭连接 **/
		conn.close();
		stmt.close();
		rs.close();
%>