<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" type="text/css" href="main.css">
	<title>~*REGISTER*~</title>
</head>
<body>
	<div class ="title"><span class="text1">Welcome</span> </div>
	<form action="registerResponse.jsp" method="post">
	<div class ="registerblock box-shadow">
	<table border="0"  align="center">
		<tbody>
			<tr>
				<td width="160" height="40"><span class="text2">User ID</span> </td>
				<td width="160" ><input type="text" name="userID" maxlength="20" style="width:150"></td>
			</tr>
			<tr>
				<td height="40"><span class="text2">Password</span> </td>
				<td><input type="password" name="passwd" maxlength="20" style="width:150"></td>
			</tr>
			<tr>
				<td height="40"><span class="text2">User Name</span> </td>
				<td><input type="text" name="userName" maxlength="20" style="width:150"></td>
			</tr>
			<tr>
				<td height="40"><span class="text2">Sex</span> </td>
				<td>
				<span class="button2">Male</span><input type="radio" name="sex" checked="selected" value="男" />
				<span class="button2">Female</span><input type="radio" name="sex" value="女" />
				</td>
			</tr>
			<tr>
				<td height="40"><span class="text2">Birth</span></td>
				<td>
				<select onclick="onSelect(this)" name="birthYear">
				<%
					for (int i=1916;i<=2016;i++){
						%><option value=<%=i%>><%=i%></option><%
					}
				%>
				</select>
				<select onclick="onSelect(this)" name="birthMonth">
				<option value="1">Jan</option>
				<option value="2">Feb</option>
				<option value="3">Mar</option>
				<option value="4">Apr</option>
				<option value="5">May</option>
				<option value="6">Jun</option>
				<option value="7">Jul</option>
				<option value="8">Aug</option>
				<option value="9">Sep</option>
				<option value="10">Oct</option>
				<option value="11">Nov</option>
				<option value="12">Dec</option>
				</select>
				</td>
			</tr>
			<tr>
				<td align="left" height="120"><input class="button1" type="submit" value="Submit" /></td>
				<td align="right"><input class="button2" type="button" value="Return" onclick="location.href='login.jsp'"/></td>
			</tr>
		</tbody>
	</div></form>
</body>
</html>