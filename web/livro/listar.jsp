<%-- 
    Document   : listar
    Created on : 05/10/2016, 20:35:16
    Author     : isabela
--%>

<%@page import="br.edu.ifsul.modelo.Livro"%>
<%@page import="br.edu.ifsul.dao.LivroDAO"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<jsp:useBean id="livroDao" scope="session"
             type="LivroDAO"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Listagem de livros</title>
    </head>
    <body>
        <a href="../index.html">Início</a>
        <h2>Livros</h2>
        <h2><%=livroDao.getMensagem()%></h2>
        <a href="ServletLivro?acao=incluir">Incluir</a>
        <table border="1">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Titulo</th>
                    <th>Idioma</th>                    
                    <th>Alterar</th>
                    <th>Excluir</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    for(Livro l : livroDao.getLista()){  // inicio do laço de repetição                  
                %>
                <tr>
                    <td><%=l.getIsbn()%></td>
                    <td><%=l.getTitulo()%></td>
                    <td><%=l.getIdioma().getNome()%></td>
                    <td><a href="ServletLivro?acao=alterar&id=<%=l.getIsbn()%>">Alterar</a></td>
                    <td><a href="ServletLivro?acao=excluir&id=<%=l.getIsbn()%>">Excluir</a></td>
                </tr>
                <%
                    } // fim do laço de repetição
                %>
            </tbody>
        </table>
    </body>
</html>
