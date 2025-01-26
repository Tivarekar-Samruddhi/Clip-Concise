package manager;

import java.sql.*;

public class ConnectionManager {
    static Connection con;
    public static Connection connect() {
        try {
            Class.forName("org.postgresql.Driver");
            con = DriverManager.getConnection("jdbc:postgresql://localhost/clipconcise", "root", "root@123");
            } catch (Exception e) {
                e.printStackTrace();
            }
        return con;
    }
}