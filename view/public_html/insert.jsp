<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html;charset=UTF-8"%>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>insert</title>
    <link type="text/css" rel="stylesheet" href="jdeveloper.css"/>
  </head>
  <body>
  <h2 align="center">
      <%@ page language="java" import="java.sql.ResultSet"%>
      
      AnyCo Corporation: HR Application
    </h2>
    
    <h3 align="left">
    Insert Employee Record
    
    </h3>
     <form action="insert_action.jsp" method="POST">
      <table cellspacing="2" cellpadding="3" border="1" width="100%">
        <tr>
          <td width="50%">First Name </td>
          <td width="50%">
            <input type="text" name="first_name"/>
          </td>
        </tr><tr>
          <td width="50%">Last Name</td>
          <td width="50%">
            <input type="text" name="last_name"/>
          </td>
        </tr><tr>
          <td width="50%">Email
          </td>
          <td width="50%">
            <input type="text" name="email"/>
          </td>
        </tr><tr>
          <td width="50%">Phone</td>
          <td width="50%">
            <input type="text" name="phone_number"/>
          </td>
        </tr><tr>
          <td width="50%">Job</td>
          <td width="50%"><select size="1" name="job_id">
              <option value="HR_REP">
                HR Representative
              </option>
              <option value="PR_REP">
                PR Representative
              </option>
              <option value="MK_MAN">
                Marketing Manger
              </option>
              <option value="SA_MAN">
                Sales Manger
              </option>
              <option value="FI_MAN">
                Finance Manger
              </option>
              <option value="IT_PROG">
                Software Developer
              </option>
              <option value="AD_VIP">
                Vice President
              </option>
              
              <jsp:useBean id="empsbean" class="hr.DataHandler" scope="session"/>
              <%
              ResultSet rset = empsbean.getJobs();
              while (rset.next ())
{
out.println("<option value=" + rset.getString("job_id") + ">" +
rset.getString("job_title") + "</option> " );
}%>
            </select>
          </td>
        </tr><tr>
          <td width="50%">Monthly Salary</td>
          <td width="50%">
            <input type="text" name="salary"/>
          </td>
        </tr>
      </table>
      <p>
        <input type="radio" name="useSP" value="false" checked="checked"/>Use
                                                                          only
                                                                          JDBC
                                                                          to
                                                                          insert
                                                                          a new
                                                                          record
      </p>
      <p>
        <input type="radio" name="useSP" value="true"/>Use stored procedure
                                                       called via JDBC to insert
                                                       a record
      </p>
      <input type="submit" name="add" value="Add Employee"/>
    </form>
  </body>
</html>