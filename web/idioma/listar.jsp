<%-- 
    Document   : listar
    Created on :  05/09/2016, 20:35:45
    Author     : isabela
--%>

<%@page import="br.edu.ifsul.modelo.Idioma"%>
<%@page import="br.edu.ifsul.dao.IdiomaDAO"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<jsp:useBean id="idiomaDao" scope="session"
             type="IdiomaDAO"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Listagem de idiomas</title>
    </head>
    <body>
        <a href="../index.html">Inicio</a>
        <h2>Idiomas</h2>
        <h2><%=idiomaDao.getMensagem()%></h2>
        <a href="ServletIdioma?acao=incluir">Incluir</a>
        <table border="1">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>Sigla</th>
                    <th>Alterar</th>
                    <th>Excluir</th>
                </tr>
            </thead>
            <tbody>
                <%
                  for(Idioma e :idiomaDao.getLista() )  {
                %>  
                <tr>
                    <td><%=e.getId()%></td>
                    <td><%=e.getNome()%></td>
                    <td><%=e.getSigla()%></td>
                    <td><a href="ServletIdioma?acao=alterar&id=<%=e.getId()%>">Alterar</a></td>
                    <td><a href="ServletIdioma?acao=excluir&id=<%=e.getId()%>">Excluir</a></td>
                </tr>
                <%
                    }
                %>    
                    
            </tbody>
        </table>
    </body>
</html>
