<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html;charset=UTF-8"%>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link type="text/css" rel="stylesheet" href="jdeveloper.css" />
    <title>login</title>
  </head>
  <body>
  <h3 align="left"> AnyCo Corporation: HR Application</h3>
  <h3 align="left">
      Application Login form
    </h3><form method="POST" action="login_action.jsp"> <!-- sending the data via the post and the action is behind the login_action.jsp -->
      <table cellspacing="2" cellpadding="3" border="1">
        <tr>
          <td width="17%">User_ID</td>
          <td width="83%">
            <input type="text" name="userid"/>
          </td>
        </tr><tr>
          <td width="17%">Password</td>
          <td width="83%">
            <input type="password" name="password"/>
          </td>
        </tr><tr>
          <td width="17%">Host</td>
          <td width="83%">
            <input type="text" name="host"/>
          </td>
        </tr>
      </table>
      <input type="submit" name="submit" value="Login"/>
    </form><h3 align="left"/>
    
     <%String loginerrormsg = null;
    loginerrormsg = (String) session.getAttribute("loginerrormsg");
    if (loginerrormsg != null) {
%>
 <h4>
      <%=loginerrormsg%>
</h4>
  <%
}
%>
  </body>
</html>