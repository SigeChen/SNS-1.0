<%@page language="java" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.ResultSetMetaData"%>
<%
	int ok=0;
	request.setCharacterEncoding("UTF-8");
    	response.setCharacterEncoding("UTF-8");
	if(request.getParameter("userID")!=null)
	if(request.getParameter("passwd")!=null)
	if(request.getParameter("userName")!=null)
	if(request.getParameter("sex")!=null)
	if(request.getParameter("birthYear")!=null)
	if(request.getParameter("birthMonth")!=null){
		String userID=request.getParameter("userID");
		String passwd=request.getParameter("passwd");
		String userName= java.net.URLDecoder.decode(request.getParameter("userName"),"UTF-8");//获取请求参数 
		//changed!!
		if(userName.length() == 0)
			ok = 2;
		if(passwd.length() == 0)
			ok = 3;
		if(userID.length() == 0)
			ok = 4;
		if(ok == 0)
		{
		//changed!!
		 
		String sex=request.getParameter("sex");
		String birthYear=request.getParameter("birthYear");
		String birthMonth=request.getParameter("birthMonth");

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
		String sql = "SELECT * FROM `test`.`account` where userID='"+userID+"' LIMIT 1";
		//取得结果
		ResultSet rs = stmt.executeQuery(sql);
		if (!rs.next()){
			sql = "INSERT INTO `test`.`account` VALUES('"+userID+"','"+passwd+"','"+userName+"','"+sex+"',"+birthYear+","+birthMonth+")";
			System.out.println(sql);
			stmt.execute(sql);
			ok=1;
		}
		/** 关闭连接 **/
		conn.close();
		stmt.close();
		rs.close();
	}}
%>

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
if (ok==1){
	out.println("<p class=\"text3\">Completed</p>");
	out.println("<p class=\"text3\">Return to <a href=\"login.jsp\">login page</a> after 5s.</p>");
	String content=5+";URL="+"login.jsp";
	response.setHeader("REFRESH",content); 
}else if (ok == 0){
	out.println("<p class=\"text3\">ID invaild</p>");
	out.println("<p class=\"text3\">Return to <a href=\"register.jsp\">signup</a> after 5s.</p>");
	String content=5+";URL="+"register.jsp";
	response.setHeader("REFRESH",content); 
}
else if (ok == 2 || ok==4){
	out.println("<p class=\"text3\">Name invaild</p>");
	out.println("<p class=\"text3\">Return to <a href=\"register.jsp\">signup</a> after 5s.</p>");
	String content=5+";URL="+"register.jsp";
	response.setHeader("REFRESH",content); 
}
else if (ok == 3){
	out.println("<p class=\"text3\">Password invaild</p>");
	out.println("<p class=\"text3\">Return to <a href=\"register.jsp\">signup</a> after 5s.</p>");
	String content=5+";URL="+"register.jsp";
	response.setHeader("REFRESH",content); 
}
%>
</div>
</body>
</html>