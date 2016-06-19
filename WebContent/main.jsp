<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="checkvalid.jsp" %>
<%@page import="java.util.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.ResultSetMetaData"%>

<%

	response.setCharacterEncoding("UTF-8");
	request.setCharacterEncoding("UTF-8");
	String userID=(String)session.getAttribute("userID");
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
		+ request.getServerName() + ":" + request.getServerPort()
		+ path + "/";

	/** 链接数据库参数 **/
	String driverName = "com.mysql.jdbc.Driver"; //驱动名称
	String DBUser = "root"; //mysql用户名
	String DBPasswd = "mysql2016PHY"; //mysql密码
	String DBName = "Test"; //数据库名
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

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<title>我的主页</title>
	<meta http-equiv="content-Type" content="text/html;charset=UTF-8"> 
	<style>
		.input_detail {
			width:500px;
			height: 80px;
			border: 1px solid #ccc;
			border-left-color: #9a9a9a;
			border-top-color: #9a9a9a;
			outline: none;
			word-wrap: break-word;
			font-size: 18px;
			overflow:auto;
		}
		.comment{
			border-style: dashed; 
			border-width: 1px 0px 0px 0px; 
			border-color: "#dbf8cc";
		}
	</style>
	<SCRIPT type="text/javascript">
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
	</SCRIPT>
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
	<div align="center">
	
	</div>
	<hr width="700" align="center"/>
	<div align="center">
	<font size="4">发布新状态：</font>
	<TEXTAREA type="text" id="statement"  rows=4 cols=15 class="input_detail"></TEXTAREA>
	<input style="height: 20; width:50" type="button" value="发布" onClick="submitStatement()"/>
	</div>
	<%
	sql= "SELECT a.userID as userID,userName,statementID,releaseTime,content "
		+				"FROM `Test`.`account` as a, `Test`.`statement` as b "
		+	"where a.userID=b.userID and ("
		+	"(b.userID='"+ userID+"') "
		+	"or b.userID in ( "
		+		"SELECT userID1 from `Test`.`friends` where userID2='"+ userID+"'"
		+	")or b.userID in("
		+		"SELECT userID2 from `Test`.`friends` where userID1='"+ userID+"'"
		+	") "
		+")"
	+"order by releaseTime desc  "
	+"limit 0,10;";
	System.out.println(sql);
	//取得结果
	rs = stmt.executeQuery(sql);
	
	while (rs.next()){
	%>
	<div align="center">
	<hr width="700"/>
	<table bgcolor="">
	<tr height="10">
	<td  width="500"><font size="4" color="black"><a href="view.jsp?userID=<%out.print(rs.getString("userID"));%>"><%out.print(rs.getString("userName"));%></a>:</font>
	</td>
	</tr>
	<tr height="100">
	<td width="500"><font size="4" color="black"><%out.print(rs.getString("content"));%></font>
	</td>
	<td width="110"><font size="3" color="gray"><%out.print(rs.getString("releaseTime"));%></font>
	</td>
	<td width="40"><a href="javascript:reply('<%out.print(rs.getString("statementID"));%>')">回复</a><td>
	</tr>
	<%
	String sql2="SELECT a.userID as userID,userName,commentID,releaseTime,content "
		+				"FROM `Test`.`account` as a, `Test`.`comment` as b "
		+	"where a.userID=b.userID and "
		+	"b.statementID='"+ rs.getString("statementID")+"' "
		+"order by releaseTime "
		+"limit 0,10;";
	System.out.println(sql2);
	ResultSet rs2 = stmt2.executeQuery(sql2);
	while (rs2.next()){
	%>
	<tr height="">
		
	<td class="comment" width="500"><font size="3" color="black"><a href="view.jsp?userID=<%out.print(rs2.getString("userID"));%>"><%out.print(rs2.getString("userName"));%></a>回复:</font><font size="4" color="black"><%out.print(rs2.getString("content"));%></font>
	</td>
	<td  class="comment" width="110"><font size="3" color="gray"><%out.print(rs2.getString("releaseTime"));%></font>
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
	<input type="button" style="display:none;" id="<%out.print(rs.getString("statementID"));%>Button" value="确定" onClick="submitReply('<%out.print(rs.getString("statementID"));%>')"/>
	</div>
	</div>
	<%
	}
	%>
<script type="text/javascript">
setInterval(function(){
	window.location.reload();
},30000);

</script>    
</body>
</html>
<%

		/** 关闭连接 **/
		conn.close();
		stmt.close();
		rs.close();
%>