<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html;charset=UTF-8"%>
<!-- importing the java lib in the jsp page be like the following line -->



<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>login_action</title>
  </head>
  <body>
  <%@ page import="java.sql.ResultSet" %>
  <!-- Creating the id-->
<jsp:useBean id="empsbean" class="hr.DataHandler" scope="session"/>

<%

// The parameters to do the user validation.
boolean userIsValid = false;
String userid = request.getParameter("userid");
String password = request.getParameter("password");
String host = request.getParameter("host");
String jdbc  = "jdbc:oracle:thin:@" + host + ":1521:ORCL";
userIsValid = empsbean.authenticateUser(jdbc, userid, password, session);

%>

<!-- if the user has successflly entered all the data as well -->
<% if (userIsValid){ %>
<jsp:forward page="/employees.jsp"/>
<!-- otherwise the user didn't enter the right data will redirect the user to the same web page-->
<% } else { %>
<jsp:forward page="/login.jsp"/>
<% } %>
  </body>
</html>
