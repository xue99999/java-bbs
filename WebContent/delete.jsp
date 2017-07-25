<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<%@ page import="java.sql.*"%>

<%!
	private void del(Connection conn, int id) {
		Statement stmt = null;
		ResultSet rs = null;

		try {
			String sql = "select * from article where pid = " + id;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				del(conn, rs.getInt("id"));
			}
			//吧所有节点删除完之后,吧自己删掉
			stmt.executeUpdate("delete from article where id = " + id);
			

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (stmt != null) {
					stmt.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

	}
%>

<%
	String admin = (String)session.getAttribute("admin");
	
	if (admin == null || !admin.equals("true")) {
		out.print("小贼, 别想删除我数据库!");
		return;
	}
%>

<%
	int id = Integer.parseInt(request.getParameter("id"));
	int pid = Integer.parseInt(request.getParameter("pid"));

	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/bbs", "root", "666666");

	conn.setAutoCommit(false);
	//先删掉当前这个id和他的孩子们
	del(conn, id);
	
	Statement stmt = conn.createStatement();

	ResultSet rs = stmt.executeQuery("select count(*) from article where pid = " + pid);
	rs.next();
	
	int count = rs.getInt(1);
	
	stmt.close();
	rs.close();
	
	if (count <= 0) {
		Statement st = conn.createStatement();
		st.executeUpdate("update article set isleaf = 0 where id = " + pid);
		st.close();
	}
	
	conn.commit();
	conn.setAutoCommit(true);

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
	<font color="red" size="22">OK! </font>
</body>
</html>