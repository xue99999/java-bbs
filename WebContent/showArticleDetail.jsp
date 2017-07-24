<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
<%@ page import="java.sql.*" %>

<%
	String strId = request.getParameter("id");
	int id = Integer.parseInt(strId);
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/bbs", "root", "666666");
	Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery("select * from article where id = " + id);
        
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>Insert title here</title>
</head>
<body>
<% if (rs.next()) { %>
	<table border="1">
		<tr>
			<td>ID</td>
			<td><%= rs.getInt("id") %></td>
		</tr>
		<tr>
			<td>Title</td>
			<td><%= rs.getString("title") %></td>
		</tr>
		<tr>
			<td>Cont</td>
			<td><%= rs.getString("cont") %></td>
		</tr>
	</table>
	<a href='reply.jsp?id=<%= rs.getInt("id") %>&rootid=<%= rs.getInt("rootid") %>'>
		回复
	</a>
<% } %>
</body>
</html>