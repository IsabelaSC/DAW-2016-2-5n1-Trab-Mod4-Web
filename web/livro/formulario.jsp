<%-- 
    Document   : formulario.jsp
    Created on : 04/10/2016, 22:48:27
    Author     : isabela
--%>

<%@page import="br.edu.ifsul.modelo.Formato"%>
<%@page import="br.edu.ifsul.modelo.Idioma"%>
<%@page import="br.edu.ifsul.dao.IdiomaDAO"%>
<%@page import="br.edu.ifsul.dao.LivroDAO"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<jsp:useBean id="livroDao" scope="session"
             type="LivroDAO"/>
<jsp:useBean id="idiomaDao" scope="session"
             type="IdiomaDAO"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Edição de Livros</title>
        <script>
            function doSalvar(){
                document.getElementById("acao").value = 'salvar';
                document.getElementById("form").submit();
            }
            function doCancelar(){
                document.getElementById("acao").value = 'cancelar';
                document.getElementById("form").submit();
            }            
        </script>                        
    </head>
    <body>
        <h1>Edição de Livros</h1>
        <h2><%=livroDao.getMensagem()%></h2>
        <form name="form" id="form" action="ServletLivro" method="POST">
            Código: <input type="text" name="id"
                           value="<%= livroDao.getObjetoSelecionado().getIsbn()== null
                                   ? "" : livroDao.getObjetoSelecionado().getIsbn()%>" size="6"
                                   readonly />
            <br/>Nome: <input type="text" name="titulo"
                           value="<%= livroDao.getObjetoSelecionado().getTitulo()== null
                                   ? "" : livroDao.getObjetoSelecionado().getTitulo()%>" size="40"/> 
            <br/>Idioma: 
            <select name="idIdioma" id="idIdioma">
                <%
                  for (Idioma e : idiomaDao.getLista())  {
                      String selected = "";
                      if (livroDao.getObjetoSelecionado().getIdioma() != null){
                        if(livroDao.getObjetoSelecionado().getIdioma().getId().equals(e.getId())){
                            selected = "selected";
                        }                  
                      }
                %>    
                    <option value="<%=e.getId()%>" <%=selected%> > <%=e.getNome()%> </option>
                <%
                  }  
                %>         
            <br/>Formato: 
            <select name="idFormato" id="idFormato">
                <%
                  for (Formato f : formatoDao.getLista())  {
                      String selected = "";
                      if (livroDao.getObjetoSelecionado().getFormato()!= null){
                        if(livroDao.getObjetoSelecionado().getFormato().getId().equals(f.getId())){
                            selected = "selected";
                        }                  
                      }
                %>    
                    <option value="<%=f.getId()%>" <%=selected%> > <%=f.getNome()%> </option>
                <%
                  }  
                %>                   
            </select>
            <br/>
            <input type="button" value="Salvar" name="btnSalvar" onclick="doSalvar()"/>
            <input type="button" value="Cancelar" name="btnCancelar" onclick="doCancelar()"/>
            <input type="hidden" name="acao" id="acao" value=""/>
        </form>
    </body>
</html>
