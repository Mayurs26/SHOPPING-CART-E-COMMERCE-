<%@page import="javax.persistence.EntityTransaction"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.shoppingcart_dto.Admin"%>
<%@page import="com.shoppingcart_dto.Merchant"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="javax.persistence.Persistence"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Reject Merchant</title>
</head>
<body>
	<% 
		String id = request.getParameter("id");
		int id1 = Integer.parseInt(id);
		
		EntityManagerFactory emf = Persistence.createEntityManagerFactory("ankush");
		EntityManager em = emf.createEntityManager();
		EntityTransaction et = em.getTransaction();
		
		Merchant m = em.find(Merchant.class, id1);
		m.setStatus("Inactive");
		
		Admin a = (Admin) session.getAttribute("admin");
	
		m.setAdmin(a);
		List<Merchant>  merchants = new ArrayList(); 
		
		if(a.getMerchants() != null)
		{
			merchants.remove(m);
		}else{
			merchants = new ArrayList();
			merchants.remove(m);
			
		}
		a.setMerchants(merchants);
		
		et.begin();
		em.merge(a);
		em.remove(m);
		et.commit();
		
		emf.close() ;
		em.close() ;
		
		RequestDispatcher rd = request.getRequestDispatcher("Adminoption.jsp");
		rd.forward(request, response);
	%>
</body>
</html>