<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
<%@ page import="java.sql.*" %>

<%
	request.setCharacterEncoding("gbk");

	int id = Integer.parseInt(request.getParameter("id"));
	int rootid = Integer.parseInt(request.getParameter("rootid"));
	String title = request.getParameter("title");
	String cont = request.getParameter("cont");
	
	//吧换行正确显示
	cont = cont.replace("\n", "<br>"); 
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/bbs", "root", "666666");
	
	conn.setAutoCommit(false);
	
	String sql = "insert into article values(null, ?, ?, ?, ?, now(), 0)";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	Statement stmt = conn.createStatement();
	
	pstmt.setInt(1, id);
	pstmt.setInt(2, rootid);
	pstmt.setString(3, title);
	pstmt.setString(4, cont);
	
	pstmt.executeUpdate();
	
	stmt.executeUpdate("update article set isleaf = 1 where id = " + id);
	
	conn.commit();
	conn.setAutoCommit(true);
	
	stmt.close();
	pstmt.close();
	conn.close();
	
	response.sendRedirect("showArticleTree.jsp");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>Insert title here</title>
</head>
<body>
	<font color="red" size="22">OK!	</font>
</body>
</html>