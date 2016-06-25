<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@include file="checkvalid.jsp" %>
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
	String DBName = "test"; //数据库名
	String MySQLServer = "127.0.0.1"; //MySQL地址
	String MySQLServerPort = "3306"; //MySQL端口号（默认为3306）

	//数据库完整链接地址
	String connUrl = "jdbc:mysql://"+MySQLServer+":"+MySQLServerPort+"/" + DBName + "?user="
		+ DBUser + "&password=" + DBPasswd ;

	//加载数据库驱动
	Class.forName(driverName).newInstance();
	Connection conn = DriverManager.getConnection(connUrl);
	Statement stmt = conn.createStatement();

	//设置字符集
	stmt.executeQuery("SET NAMES UTF8");
	Statement stmt2 = conn.createStatement();
	stmt2.executeQuery("SET NAMES UTF8");

	//要执行的 sql 查询语句
	String sql;

	//执行结果
	ResultSet rs1,rs2;

%>


<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" type="text/css" href="main.css">
	<title>~*WELCOME*~</title>
	<script type="text/javascript">
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

		function secondfriend(){
			searchForm.name="secName";
			frm.action="secondfriend.jsp";frm.submit();
		}   

		function newfriend(){
			searchForm.name="searchName";
			frm.action="search.jsp"; frm.submit();
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
		rs1 = stmt.executeQuery(sql);
		if (rs1.next()){
			out.println(rs1.getString("UserName"));
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

	<div class="inputblock box-shadow">
		<span class="text2" style="position:relative;left:15px;top:-70px;"">Say something: </span>
		<textarea type="text" id="statement"  rows=7 cols=50 class="input_detail"></textarea>
		<input class="button1" style="position:relative;left:70px;top:10px;" type="button" value="Submit" onClick="submitStatement()"/>
	</div>
	<%
	sql = "SELECT a.userID as userID,userName,statementID,releaseTime,content "
		+				"FROM `test`.`account` as a, `test`.`statement` as b "
		+	"where a.userID=b.userID and ("
		+	"(b.userID='"+ userID+"') "
		+	"or b.userID in ( "
		+		"SELECT userID1 from `test`.`friends` where userID2='"+ userID+"'"
		+	")or b.userID in("
		+		"SELECT userID2 from `test`.`friends` where userID1='"+ userID+"'"
		+	") "
		+")"
		+"order by releaseTime desc "
		+"limit 0,10;";
	System.out.println(sql);
	rs1 = stmt.executeQuery(sql);
	
	while (rs1.next()){
	%>
		<div align="center">
		<hr width="800" color="#ffffff"/>
		<table bgcolor="">
			<tr>
				<td  width="500"><a style="font-family:GOTHICB;color:#FFFFFF;text-decoration:none;" href="view.jsp?userID=<%out.print(rs1.getString("userID"));%>" ><%out.print(rs1.getString("userName"));%>:</a></td>
			</tr>
			<tr height="100">
				<td width="600"><span style="font-family:GOTHIC;color:#FFFFFF;"><%out.print(rs1.getString("content"));%></span></td>
				<td width="110"><span style="font-family:GOTHIC;color:#aaaaaa;"><%out.print(rs1.getString("releaseTime"));%></span></td>
				<td width="40"><input class="button2" type="button" value="Reply" onClick="reply('<%out.print(rs1.getString("statementID"));%>')"/><td>
			</tr>
			<%
			sql="SELECT a.userID as userID,userName,commentID,releaseTime,content "
				+				"FROM `test`.`account` as a, `test`.`comment` as b "
				+	"where a.userID=b.userID and "
				+	"b.statementID='"+ rs1.getString("statementID")+"' "
				+"order by releaseTime "
				+"limit 0,10;";
				System.out.println(sql);
				rs2 = stmt2.executeQuery(sql);
			while (rs2.next()){
			%>
				<tr height="">
		
					<td class="comment" width="500"><a href="view.jsp?userID=<%out.print(rs2.getString("userID"));%>" style="font-family:GOTHICB;color:#FFFFFF;text-decoration:none;"><%out.print(rs2.getString("userName"));%></a><span style="font-family:GOTHIC;color:#aaaaaa;"> reply: </span><span style="font-family:GOTHIC;color:#FFFFFF;"><%out.print(rs2.getString("content"));%></span>
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
			<input style="display:none; height:25;width:500" id="<%out.print(rs1.getString("statementID"));%>" value=""/>
			<input class="button2" type="button" style="display:none;" id="<%out.print(rs1.getString("statementID"));%>Button" value="Submit" onClick="submitReply('<%out.print(rs1.getString("statementID"));%>')"/>
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
		rs1.close();
%>