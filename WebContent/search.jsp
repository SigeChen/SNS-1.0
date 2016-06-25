<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="checkvalid.jsp" %>
<%@page import="java.util.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.ResultSetMetaData"%>

<%

	response.setCharacterEncoding("UTF-8");
	request.setCharacterEncoding("UTF-8");
	
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

	//要执行的 sql 查询
	
	String userID=(String)session.getAttribute("userID");
	
	String searchName=(String)request.getParameter("searchName");
	System.out.println(searchName);
	String sql=null;
	ResultSet rs=null;
	
%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" type="text/css" href="main.css">
	<title>~*New Friends*~</title>
	<script type="text/javascript">
		function addFriend(userID){
			if (userID!=""){
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
							//window.location.href="search.jsp?searchName=<%out.print(searchName);%>";
							var s=document.getElementById(userID);
							s.innerHTML="Completed";
						}
					}
					xmlhttp.open("GET","add.jsp?friendID="+userID,true);
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
	<a href="main.jsp" class="text1"  style="color:#FFFFFF;text-decoration:none;">My Homepage </a>

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
   
	<%
	if (searchName!=null){
		
		sql= "SELECT * FROM `test`.`account` "
			+"where userName like '%"+searchName+"%' "
			+"and userID !='"+userID+"' "
			+"and userID not in ( "
			+"select userID2 from `test`.`friends` where userID1='"+userID+"'"
			+") and userID not in ( "
			+"select userID1 from `test`.`friends` where userID2='"+userID+"'"
			+" );";
		
		//取得结果
		System.out.println(sql);
		rs = stmt.executeQuery(sql);
		while (rs.next()){
		%>
		<div class="list box-shadow" >
			<span style="font-family:GOTHICB;color:#FFFFFF;position: relative;left:40px;top:15px;font-size:120%;"><a href="view.jsp?userID=<%out.print(rs.getString("userID"));%>" style="color:#222222;text-decoration:none;"><%out.print(rs.getString("userName"));%></a>&nbsp&nbsp&nbsp<%if(rs.getString("sex")=="女") out.print("Female"); else out.print("Male");%>&nbsp&nbsp&nbsp<%out.print(rs.getString("birthMonth"));%>&nbsp/&nbsp<%out.print(rs.getString("birthYear"));%></span>

			<span id="<%out.print(rs.getString("userID"));%>"><input class="button1" style="position:relative;left:50px;top:12px;" type="button" value="Add" onClick="addFriend('<%out.print(rs.getString("userID"));%>')" /></span>
		</div>
		<%
		}
	}
	%>
</body>
</html>
<%

		/** 关闭连接 **/
		conn.close();
		stmt.close();
		rs.close();
%>