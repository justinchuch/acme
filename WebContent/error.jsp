<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="acme.model.Message" %>
<%
	Message message = null;
	if (request.getSession().getAttribute("message")!=null) {
		message = (Message)request.getSession().getAttribute("message");
		request.getSession().removeAttribute("message");
	}

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>ACME - Error</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
	<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container">

		<div class="page-header">
			<div class="col-md-4 col-md-offset-4">
				<h2>Error Found...</h2>
			</div>
		</div>


		<div class="row">
			<div class="col-md-4 col-md-offset-4">

				<% if(message!=null) { %>
				<div class="alert alert-<%= message.getMsgType() %>"><%= message.getMessage() %></div>
				<% } %>

			</div>
		</div>

	</div>
</body>
</html>