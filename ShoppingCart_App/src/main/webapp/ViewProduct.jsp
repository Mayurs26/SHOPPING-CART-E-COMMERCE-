<!DOCTYPE html>
<%@page import="com.shoppingcart_dto.Product"%>
<%@page import="com.shoppingcart_dto.Merchant"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="com.shoppingcart_dto.Customer"%>
<%@page import="java.util.List"%>
<%@page import="javax.persistence.Query"%>
<%@page import="javax.persistence.EntityTransaction"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="javax.persistence.Persistence"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Product</title>
    <link rel="stylesheet" href="Common_Page.css">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>

</head>
<body>
    <header class="header">
        <nav class="navbar">
             <a href="Home_Page.html">Home</a>
            <a href="About.html">About</a>
            <a href="Contact_Page.jsp">Contact</a>
            <a href="Feedback_Page.jsp">Feedback</a>
        </nav>

        <form action="#" class="search-bar">
            <input type="text" placeholder="search...">
            <button class="submit"><i class='bx bx-search'></i></button>
        </form>
    </header>

    <div class="background"></div>

    <div class="container">
     	<% 
		EntityManagerFactory emf = Persistence.createEntityManagerFactory("ankush");
		EntityManager em = emf.createEntityManager();
		EntityTransaction et = em.getTransaction();
	
		Merchant m = (Merchant) session.getAttribute("merchant");
		
		Query query = em.createQuery("select a from Product a ");
		
		List<Product> products = query.getResultList();
		
		if(products.size() >0){
			
	%>
		<table cellpadding="20" align="center" border="10px">
			<th>ID</th>
			<th>Name</th>
			<th>Category</th>
			<th>Price</th>
			<th>Stock</th>
			
	<%
		for(Product p : products){ %>
		<tr>
			<td><%= p.getId() %></td>
			<td><%= p.getName() %></td>
			<td><%= p.getCategory() %></td>
			<td><%= p.getPrice() %></td>
			<td><%= p.getStock() %></td>
		</tr>
		<%} %>
		</table>
		<%} else{
			PrintWriter pw = response.getWriter();
			pw.write("Product Not Available");
			RequestDispatcher rd = request.getRequestDispatcher("merchantoption.jsp");
			rd.include(request, response);
			response.setContentType("text/html");
		}
			
		%>
    </div>

</body>
</html>