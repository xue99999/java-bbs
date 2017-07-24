<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
<%@ page import="java.sql.*" %>

<%

	String action = request.getParameter("action");
	
	if (action != null && action.equals("login")) {
		String username = request.getParameter("username");
		String pwd = request.getParameter("pwd");
		
		if (username == null || !username.equals("admin")) {
			out.print("username not correct!   ");
		} else if (pwd == null || !pwd.equals("admin")) {
			out.print("pwd not correct!   ");
		} else {			
			session.setAttribute("admin", "true");
			response.sendRedirect("showArticleTree.jsp");
		}
		
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>Insert title here</title>
</head>
<body>

	<form action="login.jsp" method="post">
		<input type="hidden" name="action" value="login">
		
		<table border="1">
			<tr>
				<td>用户名: </td>
				<td>
					<input type="text" name="username" size="30">
				</td>
			</tr>
			<tr>
				<td>密码: </td>
				<td>
					<input type="text" name="pwd" size="30">
				</td>
			</tr>
		</table>
		
		<br>
		<input type="submit" value="提交" />
	</form>
</body>
</html>