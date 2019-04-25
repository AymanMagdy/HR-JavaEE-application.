<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html;charset=UTF-8"%>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>insert_action</title>
  </head>
  <body>
    <jsp:useBean id="empsbean" class="hr.DataHandler" scope="page"/>
    <%
    // all of the following lines of codes are to get the parameters from the URL
      String useSPFlag = request.getParameter("useSP");
      
      String first_name = request.getParameter("first_name");
      String last_name = request.getParameter("last_name");
      String email = request.getParameter("email");
      String phone_number = request.getParameter("phone_number");
      String job_id = request.getParameter("job_id");
      Integer salary = new Integer(request.getParameter("salary"));
      // if the user selected the SP selecting button
      if ( useSPFlag.equalsIgnoreCase("true"))
       empsbean.addEmployeeSP(first_name, last_name, email, phone_number, job_id, salary.intValue());
       // otherwise use pure JDBC insert
       else
          empsbean.addEmployee(first_name, last_name, email, phone_number, job_id, salary.intValue());
    %>
    <jsp:forward page="/employees.jsp"/>
  
  </body>
</html>