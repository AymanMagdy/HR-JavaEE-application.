package hr;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import oracle.jdbc.pool.OracleDataSource;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.Connection;
import java.sql.ResultSetMetaData;
import java.sql.ResultSet;

import javax.servlet.http.HttpSession;
import java.sql.SQLException;

import oracle.jdbc.internal.OracleTypes;


public class DataHandler{
    public DataHandler(){
        
    }
    // The vars of the connection declaration
    String jdbcUrl = "jdbc:oracle:thin:@localhost:1521:ORCL";  // the link to the db
    String userid = "hr";  // the user id 
    String password = "hr";  // the uses password..
    Connection conn;         // Establishing the connection
    
     
    // The vars of the getting data
    Statement stmnt ;
    ResultSet rset ;
    String query ;
    String sqlstring;
    
    // Method to connect to the database
    public void getDBConnection() throws SQLException{
        OracleDataSource ds = new OracleDataSource();
        ds.setURL(jdbcUrl);  // setting the url
        conn = ds.getConnection(userid,password);
    }
    
    
    public ResultSet getAllEmployees() throws SQLException {
        
        try{ // trying to exceute the code, if there's any errors and it's not excuted for any reason, it'll catch the error
            getDBConnection();
            // setting the constraints of the statments
            stmnt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
            query = "SELECT * FROM Employees ORDER BY employee_id"; // The query statment
            rset = stmnt.executeQuery(query); // the excuting of the query
        } catch ( SQLException ex ){
            logException(ex);
        }
        return rset;
    }
    
    // this method is working to search about the emp by their names( last and first one ).
    public ResultSet getEmployeesByName(String name) throws SQLException {
        try{
            name = name.toUpperCase(); // changing the case of the entered name by the user.
            getDBConnection(); // calling the method of connecting to the database.
            
            stmnt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
            
            // the query to get the data from the data by the first & last names
            query =
            "SELECT * FROM Employees WHERE UPPER(first_name) LIKE \'%" + name + "%\'" +
            " OR UPPER(last_name) LIKE \'%" + name + "%\' ORDER BY employee_id";
            System.out.println("\nExecuting query: " + query);
            // excuting the query itself
            rset = stmnt.executeQuery(query);
        } catch ( SQLException ex ){
            logException(ex);
        }
        return rset;
    }
    
    // the user authintication
    public boolean authenticateUser(String jdbUrl, String userid, String password, HttpSession session) throws SQLException {
        this.jdbcUrl  = jdbUrl;
        this.userid   = userid;
        this.password = password;
        
        // trying if the user has successefully entered the user_id and password rither right.
        try{
            OracleDataSource ds = new OracleDataSource();
            ds.setURL(jdbcUrl);
            ds.getConnection(userid, password);
            return true;
        }
        
        // catching the exception if the data are worng whether the id or the password
        catch(SQLException ex){
            System.out.println("Invalid user credentials..");
            session.setAttribute("loginerrormsg", "Invalid login. Try again..");
            this.jdbcUrl  = null;
            this.userid   = null;
            this.password = null;
            return false;
        }
    }
    
    // this method is used to eget the data from the database and give to the Employee data class.
    // 1 - Connect to the DB, 2- writing the statment from the conn class, 3- writing the query and then excute it.
    public Employee findEmployeeById(int id) throws SQLException {
        Employee selectedEmp = new Employee();
        try{ // try connecting to the DB then creating the statement, and the query then excute it.
            getDBConnection();
            Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
            query = "SELECT * FROM Employees WHERE employee_id = " + id;
            rset = stmt.executeQuery(query);
            // in this while loop all doing is giving the selected data from the database to the class Employee to start the processing.
            while (rset.next()) {
            selectedEmp.setEmployeeId(new Integer(rset.getInt("employee_id")));
            selectedEmp.setFirstName(rset.getString("first_name"));
            selectedEmp.setLastName(rset.getString("last_name"));
            selectedEmp.setEmail(rset.getString("email"));
            selectedEmp.setPhoneNumber(rset.getString("phone_number"));
            selectedEmp.setHireDate(rset.getDate("hire_date"));
            selectedEmp.setSalary(new Double(rset.getDouble("salary")));
            selectedEmp.setJobId(rset.getString("job_id"));
            }
        } catch ( SQLException ex ){ // if the try statement dind't successed catching the error 
            logException(ex);
        }
        
        return selectedEmp;
    }
    
    
    //The class to start updating the data
    //Takes all the emp data
    public String updateEmployee(int employee_id,
    String first_name,
    String last_name, String email,
    String phone_number, String salary,
    String job_id) throws SQLException {
        
        // creat instance of the emp and assign the emp_data_id to it.
        Employee oldEmployee = findEmployeeById(employee_id);
        getDBConnection();
        Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
        StringBuffer columns = new StringBuffer( 255 );
        
        // checking if the first_name firld isn't null and not equals to the old one, then updating it.
        if ( first_name != null && !first_name.equals(oldEmployee.getFirstName() ) )
        {
        columns.append( "first_name = '" + first_name + "'" );
        }
        
        // doing the same of the previous one with the last_name
        if ( last_name != null && !last_name.equals(oldEmployee.getLastName() ) ) {
        if ( columns.length() > 0 ) {
        columns.append( ", " );
        }
        columns.append( "last_name = '" + last_name + "'" );
        }
        
        // with the email
        if ( email != null && !email.equals(oldEmployee.getEmail()) ) {
        if ( columns.length() > 0 ) {
        columns.append( ", " );
        }
        columns.append( "email = '" + email + "'" );
        }
        
        // with the phone_number
        if ( phone_number != null && !phone_number.equals(oldEmployee.getPhoneNumber()) ) {
        if ( columns.length() > 0 ) {
        columns.append( ", " );
        }
        columns.append( "phone number = '" + phone_number + "'" );
        }
        
        // with the salary
        if ( salary != null && !salary.equals( oldEmployee.getSalary().toString() ) ) {
            if ( columns.length() > 0 ) {
            columns.append( ", " );
            }
            columns.append( "salary = '" + salary + "'" );
            
            // after doing all the needed changes, construct the update query
            // making sure that the column is not null, creating the needed sql statement to update, then excute it.
            if ( columns.length() > 0 )
            {
                String sqlString = "update Employees SET " + columns.toString() + " WHERE employee_id = " + employee_id;
                System.out.println("\nExecuting: " + sqlString);
                stmt.execute(sqlString);
            }
        else
        {
            System.out.println( "Nothing to do to update Employee Id: " +
            employee_id);
        }
        }
        return "success";
    }
    
    
    
    // the process of inserting a new Employee
    public String addEmployee(String first_name,
                              String last_name,
                              String email, 
                              String phone_number, 
                              String job_id,
                              int salary)throws SQLException{
        try{
                                  
                                 // Connecting to the DB
                                 getDBConnection();
                                 Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
                                 // the DB query
                                 String sqlString =
                                 "INSERT INTO Employees VALUES (EMPLOYEES_SEQ.nextval, '" +
                                 first_name + "','" +
                                 last_name + "','" +
                                 email + "','" +
                                 phone_number + "'," +
                                 "SYSDATE, '" +
                                 job_id + "', " +
                                 salary + ",.30,100,80)";
                                
                                 System.out.println("\nInserting: " + sqlString);
                                 stmt.execute(sqlString); // The excuting of the query..
                                 return "success";
        } catch ( SQLException ex ){ // if the try statement dind't successed catching the error 
            logException(ex);
            return "Failure";
        } 
                              }
    
    // Adding the Employee by using the PL/SQL 
    public String addEmployeeSP(String first_name,
                                String last_name,
                                String email,
                                String phone_number,
                                String job_id,
                                int salary) throws SQLException {
        try{ // connecting to the database, accessing the file of inserting the new emp by and then set the variables through the Callablestament
            getDBConnection();
            String sqlString = "begin hr.insert_employee(?,?,?,?,?,?); end;";
            CallableStatement callstmt = conn.prepareCall(sqlString);
            callstmt.setString(1, first_name);
            callstmt.setString(2, last_name);
            callstmt.setString(3, email);
            callstmt.setString(4, phone_number);
            callstmt.setString(5, job_id);
            callstmt.setInt(6, salary);
            System.out.println("\nInserting with stored procedure: " +
            sqlString);
            callstmt.execute();
            return "success";
        } catch(SQLException ex) {
            System.out.println("Possible source of error: Make sure you have created the stored procedure");
            logException( ex );
            return "failure";
        }
        
    }
    
    
    // process of delecting..
    public String deleteEmployeeById(int id) throws SQLException {
        
        try{
            getDBConnection();
            Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
            // the query of deleting the Emp from the DB
            String sqlString = "DELETE FROM Employees WHERE employee_id = " + id;
            System.out.println("\nExecuting: " + sqlString);
            stmt.execute(sqlString); // The execution of the query as before..
            return "success";
            
        } catch (SQLException e) {
             e.fillInStackTrace();
             return "failure";
        }
        
    }
    
    
    // The SQLLexception 
    public void logException( SQLException ex )
    {
       while ( ex != null ) {
         ex.printStackTrace();
         ex = ex.getNextException();
    }
    }
    
    // getting the jobs
    public ResultSet getJobs() throws SQLException {
    try {
    getDBConnection();
    String jobquery = "begin ? := get_jobs; end;";
    CallableStatement callStmt = conn.prepareCall(jobquery);
    callStmt.registerOutParameter(1, OracleTypes.CURSOR);
    callStmt.execute();
    rset = (ResultSet)callStmt.getObject(1);
    } catch ( SQLException ex ) {
    logException( ex );
    }
    return rset;
    }
    
    
}