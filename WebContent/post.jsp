<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
<%@ page import="java.sql.*" %>

<%
	request.setCharacterEncoding("gbk");

	String action = request.getParameter("action");
	
	if (action != null && action.equals("post")) {
		String title = request.getParameter("title");
		String cont = request.getParameter("cont");
		
		//吧换行正确显示
		cont = cont.replace("\n", "<br>"); 
		
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/bbs", "root", "666666");
		
		
		conn.setAutoCommit(false);
		
		String sql = "insert into article values(null, 0, ?, ?, ?, now(), 0)";
		PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
		Statement stmt = conn.createStatement();
		
		pstmt.setInt(1, -1);
		pstmt.setString(2, title);
		pstmt.setString(3, cont);
		pstmt.executeUpdate();
		
		ResultSet rsKey = pstmt.getGeneratedKeys();
		rsKey.next();
		int key = rsKey.getInt(1);
		rsKey.close();
		
		//注意where前面得加空格
		stmt.executeUpdate("update article set rootid =" + key + " where id =" + key);
		
		conn.commit();
		conn.setAutoCommit(true);
		
		stmt.close();
		pstmt.close();
		conn.close();
		
		response.sendRedirect("showArticleTree.jsp");
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>Insert title here</title>
</head>
<body>

	<form action="post.jsp" method="post">
		<input type="hidden" name="action" value="post">
		
		<table border="1">
			<tr>
				<td>
					<input type="text" name="title" size="60">
				</td>
			</tr>
			<tr>
				<td>
					<textarea cols="60" rows="8" name="cont"></textarea>
				</td>
			</tr>
			<tr>
				<td>
					<input type="submit" value="提交" />
				</td>
			</tr>
		</table>
	</form>
</body>
</html>