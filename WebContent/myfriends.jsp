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
	
	String sql=null;
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<title>我的好友</title>
	<meta http-equiv="content-Type" content="text/html;charset=UTF-8"> 
	 <link href="http://libs.baidu.com/bootstrap/3.0.3/css/bootstrap.min.css" rel="stylesheet">
   <script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
   <script src="http://libs.baidu.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
   <script language="JavaScript">  
   function secondfriend(){ searchForm.name="secName";frm.action="secondfriend.jsp";frm.submit(); }   
   function newfriend(){  searchForm.name="searchName";frm.action="search.jsp"; frm.submit(); }
    	   </script>

</head>

<body  align="center" style="width:700" bgcolor="#dbf8cc">
<nav class="navbar navbar-default">
  <div class="container-fluid">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="main.jsp">SNS-1.0</a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
        <li class="active"><a href="main.jsp">我的主页 <span class="sr-only">(current)</span></a></li>
        <li><a href="myfriends.jsp">我的好友</a></li>
      
   
      </ul>
   
       <form  class="navbar-form navbar-left"  name="frm"  action="" method="post">
         <div class="form-group">
    	<input id="searchForm" type="text" class="form-control" placeholder="寻找"/>
    	     </div>
    	      <input type="submit"  class="btn btn-default" value="新好友" onClick="newfriend()" />
    	     <input type="submit"  class="btn btn-default" value="二度人脉" onClick="secondfriend()"/>
    	     		
    </form>
        
	   </ul>
      <ul class="nav navbar-nav navbar-right">
      
       <li style="width:400"> <a href="main.jsp"><%
	sql= "SELECT * FROM `Test`.`account` where userID='"+userID+"' LIMIT 15";
	System.out.println(sql);

	//取得结果
	ResultSet rs = stmt.executeQuery(sql);
	if (rs.next()){
		out.println(rs.getString("UserName"));
	}%></a> </li>
	  <li><a href="logout.jsp">退出登录</a></li>
      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>
	<hr  style="width:700" />
	<%
	
		
		sql= "select * from test.account "+
				" where userID in( "+
				" select userID1 from test.friends "+
				" where userID2='" + userID + "')" + 
				" or  userID  in( " +
				" select userID2 from test.friends " + 
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