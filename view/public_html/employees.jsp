<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.lang.String"%>

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>employees</title>
    <link type="text/css" rel="stylesheet" href="jdeveloper.css"/>
  </head>
  <body>
    <h2 align="center">
      AnyCo Corporation: HR Application
    </h2><h3>
      Employees Data : 
    </h3><form action="employees.jsp" >
      Filter by Employee name :
      <input type="text" name="insert"/>
      <input type="submit" value="Filter"/>
      <a href="insert.jsp" style="text-decoration:none" >Insert Employee</a>
    </form>
    <table cellspacing="2" cellpadding="3" border="1" width="100%">
      <tr>
        <td width="161">
          <font size="4">
            First Name
          </font></td>
        <td width="161">
          <font size="4">
            Last Name
          </font>
        </td>
        <td width="161">
          <font size="4">
            Email
          </font>
        </td>
        <td width="159">
          <font size="4">
            Job
          </font>
        </td>
        <td width="123">
          <font size="4">
            Phone
          </font>
        </td>
        <td width="108">
          <font size="4">
            salary
          </font></td>
        <td width="91">&nbsp;</td>
      </tr>
      <jsp:useBean id="empsbean" class="hr.DataHandler"/>
      <%ResultSet rset;
          String query = request.getParameter("query");
              if (query != null)
                 rset = empsbean.getEmployeesByName(query);
              else
                 rset = empsbean.getAllEmployees();
      while (rset.next ())
{
out.println("<tr>");
out.println("<td>" +
rset.getString("first_name") + "</td><td> " +
rset.getString("last_name") + "</td><td> " +
rset.getString("email") + "</td><td> " +
rset.getString("job_id") + "</td><td>" +
rset.getString("phone_number") + "</td><td>" +
rset.getDouble("salary") +
"</td><td> <a style='text-decoration : none' href=\"update.jsp?empid=" + rset.getInt(1) +
"\">Edit</a> <a style='text-decoration : none ' href=\"delete_action.jsp?empid=" +
rset.getInt(1) + "\">Delete</a></td>");
out.println("<tr>");
}%>
    </table>
  </body>
</html>