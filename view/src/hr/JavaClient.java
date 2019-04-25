package hr;
import java.sql.ResultSet;

public class JavaClient {
    public static void main(String args[])throws Exception{
        DataHandler datahandler = new DataHandler();
        ResultSet rset = datahandler.getEmployeesByName("King");
        while (rset.next()) {
        System.out.println(rset.getInt(1) + " " +
        rset.getString(2) + " " +
        rset.getString(3) + " " +
        rset.getString(4));
        }
    }
}