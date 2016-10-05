<%-- 
    Document   : listar
    Created on :  05/09/2016, 20:35:45
    Author     : isabela
--%>

<%@page import="br.edu.ifsul.modelo.Autor"%>
<%@page import="br.edu.ifsul.dao.AutorDAO"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<jsp:useBean id="autorDao" scope="session"
             type="AutorDAO"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Listagem de autors</title>.
    </head>
    <body>
        <a href="../index.html">Inicio</a>
        <h2>Autors</h2>
        <h2><%=autorDao.getMensagem()%></h2>
        <a href="ServletAutor?acao=incluir">Incluir</a>
        <table border="1">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>Bibliografia</th>
                    <th>Alterar</th>
                    <th>Excluir</th>
                </tr>
            </thead>
            <tbody>
                <%
                  for(Autor e :autorDao.getLista() )  {
                %>  
                <tr>
                    <td><%=e.getId()%></td>
                    <td><%=e.getNome()%></td>
                    <td><%=e.getBibliografia()%></td>
                    <td><a href="ServletAutor?acao=alterar&id=<%=e.getId()%>">Alterar</a></td>
                    <td><a href="ServletAutor?acao=excluir&id=<%=e.getId()%>">Excluir</a></td>
                </tr>
                <%
                    }
                %>    
                    
            </tbody>
        </table>
    </body>
</html>
