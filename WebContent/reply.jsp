<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
<%@ page import="java.sql.*" %>

<%
	int id = Integer.parseInt(request.getParameter("id"));
	int rootid = Integer.parseInt(request.getParameter("rootid"));
%>

<script>
	function check() {
		if (document.reply.title.value.trim() == "") {
			alert("please input the title!")
			document.reply.title.focus();
			return false;
		}
		
		if (document.reply.cont.value.trim() == "") {
			alert("please input the cont!")
			document.reply.cont.focus();
			return false;
		}
		
		return true;
	}
</script>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>Insert title here</title>
</head>
<body>

	<form name="reply" action="replyOk.jsp" method="post" onsubmit="return check();">
		<input type="hidden" name="id" value="<%= id %>">
		<input type="hidden" name="rootid" value="<%= rootid %>">
		
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
					<input type="submit" value="�ύ" />
				</td>
			</tr>
		</table>
	</form>
</body>
</html>