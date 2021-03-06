<%-- 
    Document   : listar
    Created on :  05/09/2016, 20:35:45
    Author     : isabela
--%>

<%@page import="br.edu.ifsul.modelo.Formato"%>
<%@page import="br.edu.ifsul.dao.FormatoDAO"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<jsp:useBean id="formatoDao" scope="session"
             type="FormatoDAO"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Listagem de formatos</title>.
    </head>
    <body>
        <a href="../index.html">Inicio</a>
        <h2>Formatos</h2>
        <h2><%=formatoDao.getMensagem()%></h2>
        <a href="ServletFormato?acao=incluir">Incluir</a>
        <table border="1">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>Alterar</th>
                    <th>Excluir</th>
                </tr>
            </thead>
            <tbody>
                <%
                  for(Formato e :formatoDao.getLista() )  {
                %>  
                <tr>
                    <td><%=e.getId()%></td>
                    <td><%=e.getNome()%></td>
                    <td><a href="ServletFormato?acao=alterar&id=<%=e.getId()%>">Alterar</a></td>
                    <td><a href="ServletFormato?acao=excluir&id=<%=e.getId()%>">Excluir</a></td>
                </tr>
                <%
                    }
                %>    
                    
            </tbody>
        </table>
    </body>
</html>
