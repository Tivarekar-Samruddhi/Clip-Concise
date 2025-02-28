<%@ page import="java.io.*, java.sql.*,manager.ConnectionManager" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8" />
		<meta
			name="viewport"
			content="width=device-width, initial-scale=1.0"
		/>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<link rel="stylesheet" href="styling\admin.css" />
		<script>
            function remove(uuid){
                console.log(uuid);
                $.ajax({
                    type: "POST",
                    url: "http://localhost:8080/Clip-Concise/removeServlet",
                    data: { uid: uuid },
                    success: function(flag) {
                        // Display the retrieved summary in the main content area
                        if(flag)
                            alert("User Removed Successfully");
                            refreshContent();
                    }
                });
            }
        </script>
        
		<title>Document</title>
	</head>
	<body>
		<div class="navbar">
			<div class="navbar-left">
				<div class="logo-container">
					<img
						src="Landing-Page\finallogo.png"
						alt="logo"
						class="logo"
					/>
				</div>
				<div class="nav-items title">ClipConcise</div>
			</div>
			<div class="navbar-right">
				<div class="nav-items">
					<a class="redirects" href="logout">Logout</a>
				</div>
			</div>
		</div>

		<div class="container">
        <%
            try (Connection con = ConnectionManager.connect()){
                Class.forName("org.postgresql.Driver");
                PreparedStatement ps = con.prepareStatement("select * from users");
                ResultSet rs = ps.executeQuery();
        %>
        <table class="tab">
            <col width="100">
            <col width="150">   
            <tr class="heading">
                <th> Remove</th>
                <th> UID </th>
                <th> USERNAME </th>
                <th> TITLE </th>
            </tr>
            <%
                while (rs.next()) {
                    int uno = rs.getInt(1);
                    PreparedStatement ps1 = con.prepareStatement("select * from video where uid=?");
                    ps1.setInt(1, uno);
                    ResultSet rs1 = ps1.executeQuery();
            %>
            <tr>
                <td><button onclick="remove('<%= rs.getInt(1)%>')"><svg xmlns="http://www.w3.org/2000/svg" x="0px" y="0px" width="64" height="64" viewBox="0 0 64 64">
                    <path d="M 28.070312 2 C 27.065313 2 26.132219 2.4999375 25.574219 3.3359375 L 22.464844 8 L 11 8 C 9.346 8 8 9.346 8 11 L 8 17 C 8 18.654 9.346 20 11 20 L 11.099609 20 L 14.628906 53.523438 C 14.895906 56.076437 17.034563 58 19.601562 58 L 44.400391 58 C 46.966391 58 49.103094 56.076438 49.371094 53.523438 L 52.900391 20 L 53 20 C 54.654 20 56 18.654 56 17 L 56 11 C 56 9.346 54.654 8 53 8 L 41.535156 8 L 38.425781 3.3359375 C 37.867781 2.4999375 36.934688 2 35.929688 2 L 28.070312 2 z M 28.070312 4 L 35.929688 4 C 36.264688 4 36.575719 4.1673125 36.761719 4.4453125 L 39.132812 8 L 24.867188 8 L 27.238281 4.4453125 C 27.424281 4.1673125 27.735312 4 28.070312 4 z M 11 10 L 21.132812 10 L 42.867188 10 L 53 10 C 53.552 10 54 10.449 54 11 L 54 17 C 54 17.551 53.552 18 53 18 L 52 18 L 12 18 C 11.978 18 11.9595 18.011672 11.9375 18.013672 C 11.9165 18.011672 11.897 18 11.875 18 L 11 18 C 10.448 18 10 17.551 10 17 L 10 11 C 10 10.449 10.448 10 11 10 z M 14 12 C 13.447 12 13 12.448 13 13 L 13 15 C 13 15.552 13.447 16 14 16 C 14.553 16 15 15.552 15 15 L 15 13 C 15 12.448 14.553 12 14 12 z M 19 12 C 18.447 12 18 12.448 18 13 L 18 15 C 18 15.552 18.447 16 19 16 C 19.553 16 20 15.552 20 15 L 20 13 C 20 12.448 19.553 12 19 12 z M 24 12 C 23.447 12 23 12.448 23 13 L 23 15 C 23 15.552 23.447 16 24 16 C 24.553 16 25 15.552 25 15 L 25 13 C 25 12.448 24.553 12 24 12 z M 29 12 C 28.447 12 28 12.448 28 13 L 28 15 C 28 15.552 28.447 16 29 16 C 29.553 16 30 15.552 30 15 L 30 13 C 30 12.448 29.553 12 29 12 z M 35 12 C 34.447 12 34 12.448 34 13 L 34 15 C 34 15.552 34.447 16 35 16 C 35.553 16 36 15.552 36 15 L 36 13 C 36 12.448 35.553 12 35 12 z M 40 12 C 39.447 12 39 12.448 39 13 L 39 15 C 39 15.552 39.447 16 40 16 C 40.553 16 41 15.552 41 15 L 41 13 C 41 12.448 40.553 12 40 12 z M 45 12 C 44.447 12 44 12.448 44 13 L 44 15 C 44 15.552 44.447 16 45 16 C 45.553 16 46 15.552 46 15 L 46 13 C 46 12.448 45.553 12 45 12 z M 50 12 C 49.447 12 49 12.448 49 13 L 49 15 C 49 15.552 49.447 16 50 16 C 50.553 16 51 15.552 51 15 L 51 13 C 51 12.448 50.553 12 50 12 z M 13.109375 20 L 50.890625 20 L 47.382812 53.314453 C 47.221812 54.846453 45.938437 56 44.398438 56 L 19.601562 56 C 18.061563 56 16.778187 54.846453 16.617188 53.314453 L 13.109375 20 z M 21 52 C 20.447 52 20 52.448 20 53 C 20 53.552 20.447 54 21 54 L 35 54 C 35.553 54 36 53.552 36 53 C 36 52.448 35.553 52 35 52 L 21 52 z M 39 52 C 38.447 52 38 52.448 38 53 C 38 53.552 38.447 54 39 54 L 43 54 C 43.553 54 44 53.552 44 53 C 44 52.448 43.553 52 43 52 L 39 52 z"></path>
                </svg></button></td>
                <td><%= rs.getInt(1) %></td>
                <td><%= rs.getString(2) %></td>
            <td>
                    <%
                        while (rs1.next()) {
                    %>
                    <a class="links" href="<%= rs1.getString(4) %>"><%= rs1.getString(3) %></a><br>
                    <%
                        }
                    %>
                </td>
            </tr>
            <%
                }
            } catch(Exception e) {
                e.printStackTrace();
            }
            %>
        </table>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	</body>
</html>
