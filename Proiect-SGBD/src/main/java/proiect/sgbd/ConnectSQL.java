package proiect.sgbd;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ConnectSQL {

    private static final String dbURL = "jdbc:oracle:thin:@localhost:1521:xe";
    private static final String username = "student";
    private static final String password ="student";
    private static Connection con = null;

    static{
        try {
            Class.forName ("oracle.jdbc.OracleDriver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }


    private ConnectSQL() {}
    public static Connection getConnection()  {
        if(con==null){
            try {

                con = DriverManager.getConnection( dbURL, username, password );
                System.out.println("Connected to database");
            } catch (SQLException ex) {
                Logger.getLogger(ConnectSQL.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return con;

    }

    private static void createConnection() {
        if ( con == null)
            con = (Connection) new ConnectSQL();

    }
    public static void closeConnection() {
        if (con != null)
            try {
                con.close();
            } catch (SQLException ex) {
                Logger.getLogger(ConnectSQL.class.getName()).log(Level.SEVERE, null, ex);
            }
    }
}
