<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="hr.Employee"%>

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>edit</title>
    <link type="text/css" rel="stylesheet" href="jdeveloper.css"/>
  </head>
  <body>
  <h2 align="center"> AnyCo Corporation: HR Application </h2>
  <h3 align="left"> Edit Employee Record </h3>
  <jsp:useBean id="empsbean" class="hr.DataHandler" scope="session"/>
  <%
  Integer employee_id = new Integer(request.getParameter("empid"));
  Employee employee = empsbean.findEmployeeById(employee_id.intValue());
  %>
 
 <form action="update_action.jsp" method="POST">
      <table cellspacing="2" cellpadding="3" border="1" width="100%">
        <tr>
          <td width="50%">&nbsp;Name</td>
          <td width="50%">
            <input type="text" name="first_name"
                   value="<%= employee.getFirstName() %>"/>
            <input type="hidden" name="employee_id"
                   value="<%= employee.getEmployeeId() %>"/>
          </td>
        </tr><tr>
          <td width="50%">&nbsp;Last Name</td>
          <td width="50%">
            <input type="text" name="last_name"
                   value="<%= employee.getLastName() %>"/>
          </td>
        </tr><tr>
          <td width="50%">&nbsp;Email</td>
          <td width="50%">
            <input type="text" name="email" value="<%= employee.getEmail() %>"/>
          </td>
        </tr><tr>
          <td width="50%">&nbsp;Phone</td>
          <td width="50%">
            <input type="text" name="phone_number"
                   value="<%= employee.getPhoneNumber() %>"/>
          </td>
        </tr><tr>
          <td width="50%">&nbsp;Job&nbsp;</td>
          <td width="50%">
            <input type="text" name="job" value="<%= employee.getJobId() %>"/>
          </td>
        </tr><tr>
          <td width="50%">&nbsp;Monthly&nbsp;Salary&nbsp;</td>
          <td width="50%">
            <input type="text" name="salary"
                   value="<%= employee.getSalary() %>"/>
          </td>
        </tr>
      </table>
      <input type="submit" name="update" value="Update" />
    </form>
  </body>
</html>