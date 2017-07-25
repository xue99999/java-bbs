<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
<%@ page import="java.sql.*" %>

<%
	int pageSize = 3;	

	String strPageNo = request.getParameter("pageNo");
	int pageNo;
	if (strPageNo == null || strPageNo.equals("")) {
		pageNo = 1;
	} else {
		try {
			pageNo = Integer.parseInt(strPageNo.trim());
		} catch(NumberFormatException e) {
			pageNo = 1;
		}
		if (pageNo <= 0) pageNo = 1;
	}


	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/bbs", "root", "666666");
	
	Statement stCount = conn.createStatement();
	ResultSet rsCount = stCount.executeQuery("select count(*) from article where pid = 0");
	rsCount.next();
	int totalCount = rsCount.getInt(1);
	int totalPage = totalCount % pageSize == 0 ? totalCount / pageSize : totalCount / pageSize + 1;
	
	if (pageNo > totalPage) pageNo = 1;	
	
	int startPos = (pageNo - 1) * pageSize;
	
	Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery("select * from article where pid = 0 order by pdate desc limit " + startPos + "," + pageSize);
    
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>Insert title here</title>
</head>
<body>
	<a href='post.jsp'>发表新帖</a>
	<br>
	
	<table border="1">
		<% while(rs.next()) { %>
			<tr>
				<td><%= rs.getString("title") %></td>
			</tr>
		<% 
			}
			rs.close();
			stmt.close();
			conn.close();
		%>
	</table>
	<br>
	共<%= totalPage %>页  &nbsp;&nbsp; 第<%= pageNo %>页 &nbsp;&nbsp;
	<a href="showArticleFlat.jsp?pageNo=<%= pageNo-1 %>">上一页</a>&nbsp;&nbsp;
	<a href="showArticleFlat.jsp?pageNo=<%= pageNo+1 %>">下一页</a>
</body>
</html>
