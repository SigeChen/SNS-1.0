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
	String DBPasswd = ""; //mysql密码
	String DBName = "teaching"; //数据库名
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
	
	String sql=null;
	
%>
<html>
<head>
	<title>Search page</title>
	<meta http-equiv="content-Type" content="text/html;charset=UTF-8"> 
	

</head>

<body  align="center" style="width:700" bgcolor="#dbf8cc">
	<div align="center">
	<table>
	<tr>
	<td style="width:400">Hi, <a href="main.jsp"><%
	sql= "SELECT * FROM `teaching`.`account` where userID='"+userID+"' LIMIT 15";
	System.out.println(sql);

	//取得结果
	ResultSet rs = stmt.executeQuery(sql);
	if (rs.next()){
		out.println(rs.getString("UserName"));
	}%></a>
	</td>
	<td style="width:500">
	<form action="search.jsp" method="post">
		<input type="text" name="searchName" maxlength="20" style="width:120"/>
		<input type="submit" value="寻找新好友" />
        <input type="button" value="我的好友" onClick="location.href='myfriends.jsp'"/>
		<input type="button" value="退出登录" onClick="location.href='logout.jsp'" />
	</form>
    <form action="secondfriend.jsp" method="post">
    	<input type="text" name="secName" maxlength="20" style="width:120"/>
    	<input type="submit" value="二度人脉" />
    </form>
	</td>
	</tr>
	</table>
	</div>
	<hr  style="width:700" />
	<%
	
		
		sql= "select * from teaching.account "+
				" where userID in( "+
				" select userID1 from teaching.friends "+
				" where userID2='" + userID + "')" + 
				" or  userID  in( " +
				" select userID2 from teaching.friends " + 
				" where userID1='" + userID +"');";

		//取得结果
		System.out.println(sql);
		rs = stmt.executeQuery(sql);
		while (rs.next()){
		%>
		<div align="center" style="width:700" >
		<li>
		<a href="view.jsp?userID=<%out.print(rs.getString("userID"));%>"><%out.print(rs.getString("userName"));%></a> <%out.print(rs.getString("sex"));%> <%out.print(rs.getString("birthYear"));%>年<%out.print(rs.getString("birthMonth"));%>月
		
		
		
		</li>
		</div>
		<%
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