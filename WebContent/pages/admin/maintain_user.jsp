<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,acme.dao.UserDAO,acme.dbmodel.User,acme.model.Message,acme.util.*" %>
<%
	// Only admin / SO can access

	User user = null;
	if (request.getSession().getAttribute("user")!=null) {
		user = (User)request.getSession().getAttribute("user");
	} else {
		// redirect to index/login page
		response.sendRedirect(request.getContextPath()+"/logout.jsp");
		return;
	}

	Message message = null;
	if (request.getSession().getAttribute("message")!=null) {
		message = (Message)request.getSession().getAttribute("message");
		request.getSession().removeAttribute("message");
	}

	UserDAO userDao = new UserDAO();
	List<User> ls = userDao.getListWithoutAdmin();

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>ACME Admin - Maintain Users Security Level</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
	<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
</head>
<body>

	<div class="container">

		<div class="page-header">
			<div class="row">
				<div class="col-md-9">
					<h2>Welcome : <%= user.getUsername() %></h2>
				</div>

				<div class="col-md-3">
					<a href="${pageContext.request.contextPath}/logout.jsp" class="btn btn-info" role="button"><span class="glyphicon glyphicon-log-in"></span> Logout</a>
				</div>
			</div>
		</div>


		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}/pages/admin/dashboard.jsp">Home</a></li>
			<li class="active">Maintain Users Security Level</li>
		</ol>


		<div class="row">
			<div class="col-md-4 col-md-offset-4">

				<% if(message!=null) { %>
				<div class="alert alert-<%= message.getMsgType() %>"><%= message.getMessage() %></div>
				<% } %>

			</div>
		</div>


		<form action="${pageContext.request.contextPath}/pages/admin/UserLevelController" method="post" role="form">
		<table class="table table-striped">
		<tr>
			<th class="col-md-2"><label>Id</label></th>
			<th class="col-md-6"><label>Username</label></th>
			<th class="col-md-2"><label>Level</label></th>

			<th class="col-md-2"></th>
		</tr>
		<%
		String[] levelOptions = { "G", "E", "F", "H", "HE", "HF", "FE", "L" };

		for(User userObj : ls) {
			String level = userObj.getLevel();
		%>
		<tr>
			<td><label><%= userObj.getId() %></label></td>
			<td><label><%= userObj.getUsername() %></label></td>
			<td>
				<select class="form-control" name="level_<%= userObj.getId() %>">
					<%--
					<option value="">-</option>
					--%>
					<%
					String selected = "";
					for (int i=0; i<levelOptions.length; i++) {
						if (levelOptions[i].equals(level)) {
							selected = "selected";
						} else {
							selected = "";
						}
						%>
						<option value="<%= levelOptions[i] %>" <%= selected %>><%= levelOptions[i] %></option>
						<%
					}
					%>

				</select>
			</td>

			<td></td>
		</tr>
		<%
		} // END, for
		%>

		<tr>
			<td></td>
			<td></td>
			<td></td>

			<td align="right">
				<input class="btn btn-default" type="submit" name="update" value="Update" />
			</td>
		</tr>
		</table>
		</form>

	</div>

</body>
</html>