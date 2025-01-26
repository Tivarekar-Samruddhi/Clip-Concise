<%@ page import="summarizer.YoutubeURLParser" %>
<%@ page import="summarizer.StoreSummary" %>
<%! String username,userid,video_id,summary,video_title,video_link;%>
<%	
	//Checking if user has a valid session or not , if not then the user is redirected to the login page.
	if(session!=null && session.getAttribute("username")!=null){
		userid = (String)session.getAttribute("uid");
		username = (String)session.getAttribute("username");
	}
	else
		response.sendRedirect("login.jsp");
%>

<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8" />
		<link rel="stylesheet" href="styling\home.css" />
		<meta
			name="viewport"
			content="width=device-width, initial-scale=1.0"
		/>
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
		<title>ClipConcise</title>
	</head>
	<body>
		<div class="navbar">
			<div class="navbar-left">
				<div class="logo-container">
                    <img src="Landing-Page\finallogo.png" alt="logo" class="logo">
                </div>
				<div class="nav-items title">ClipConcise</div>
			</div>
			<div class="navbar-right">
				<div class="nav-items">
					<a class="redirects" href="history.jsp">History</a>
				</div>
				<div class="nav-items">
					<a class="redirects" href="logout">Logout</a>
				</div>
			</div>
		</div>
		<div class="main">
			<div class="search">
				<form action="" method="post">
					<input style="text-align:center;"
						type="text"
						name="video_link"
						class="search-bar"
						id="search-bar"
						placeholder="Paste youtube video link"
						required
					/>
						<input type="hidden" name="title" id="title">
						<input type="hidden" name="videoid" id="videoid">
					<button type="submit" class="search-button" name="submit" id="search-button">
						Summarize
					</button>
				</form>
			</div>
		</div>
		
		<div id="main_container">
        		<%
            		if (request.getParameter("submit") != null){
                		video_id = request.getParameter("videoid");
				%>
					<div id="summary_container">
    				<p id="summary_para">
				<%
                		if(session.getAttribute("prev_video")==null || !	((String)session.getAttribute("prev_video")).equals(video_id))
                		{
                    		summary = YoutubeURLParser.processVideoId(video_id);
                    		if(summary != null ){
                        		session.setAttribute("prev_video",video_id);
								video_title = request.getParameter("title");
								video_link = request.getParameter("video_link");
        		%>
        				<h1 class="output-title">Title : <a target="_blank" href="<%= video_link%>"><%= video_title%></a></h1>
        		<%
				summary = summary.replaceAll("\\*\\*", "<strong>");

					// Replace *text* with <li>text</li>
					summary = summary.replaceAll("\\*(.*?)\\*", "<li>$1</li>");
			
					// Replace \n with <br>
					summary = summary.replaceAll("\n", "<br>");
                        out.println(summary);
                        session.setAttribute("prev_summary",summary);
                        StoreSummary.save((String)session.getAttribute("uid"),video_title,video_link,summary);
                    }
                    else{
                        out.println("Error generating summary");
                    }
            }
            else{
            %>
                <h1 class="output-title">Title : <a target="_blank" href="<%= video_link%>"><%= video_title%></a></h1>
            <%  
                summary = (String) session.getAttribute("prev_summary");
                out.println(summary);
            }
        %>
    </p>
</div>
<% }%>
<div class="footer"></div>
<script src="link_validator.js"></script>
</body>
</html>