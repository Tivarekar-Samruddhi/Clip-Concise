package user_activity;

import manager.ConnectionManager;
import manager.PasswordManager;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class Login_Servlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        HttpSession session = request.getSession();
        Cookie ck = new Cookie("semail", email);
        ck.setPath("/Clip-Concise");

        PreparedStatement pst = null;
        ResultSet rs = null;

        try (Connection con = ConnectionManager.connect()){
            String query = "SELECT * FROM users WHERE email = ?";
            pst = con.prepareStatement(query);
            pst.setString(1, email);
            rs = pst.executeQuery();
            if (rs.next()) {
                ck.setMaxAge(3600);
                response.addCookie(ck);
                if (password.equals(PasswordManager.decrypt(rs.getString(4)))) {
                    con.close();
                    session.setAttribute("username", rs.getString(2));
                    session.setAttribute("uid", rs.getString(1));
                    session.setAttribute("prev_video",null);
                    try {
                        Thread.sleep(2000);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    response.sendRedirect("home.jsp");
                } else {
                    session.setAttribute("statusMessage", "Invalid Password");
                    response.sendRedirect("login.jsp");
                }
            } else {
                ck.setMaxAge(0);
                response.addCookie(ck);
                session.setAttribute("statusMessage", "Invalid Email");
                response.sendRedirect("login.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}