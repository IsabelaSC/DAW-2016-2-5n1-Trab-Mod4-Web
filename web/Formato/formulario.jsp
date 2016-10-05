<%-- 
    Document   : formulario
    Created on : 04/10/2016, 21:32:08
    Author     : isabela
--%>

<%@page import="br.edu.ifsul.dao.FormatoDAO"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<jsp:useBean id="formatoDao" scope="session"
             type="FormatoDAO"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Edi��o de Formatos</title>
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
        <h2>Edi��o de Formatos</h2>
        <h2><%=formatoDao.getMensagem()%></h2>.
        <form name="form" id="form" action="ServletFormato" method="POST">
            C�digo: <input type="text" name="id" id="id"
                           value="<%= formatoDao.getObjetoSelecionado().getId() == null
                           ? "" : formatoDao.getObjetoSelecionado().getId() %>"
                           size="6" readonly /><br/>
            Nome:  <input type="text" name="nome" id="nome"
                           value="<%= formatoDao.getObjetoSelecionado().getNome() == null
                           ? "" : formatoDao.getObjetoSelecionado().getNome() %>"
                           size="40" /><br/>                     
            <input type="button" value="Salvar" name="btnSalvar" onclick="doSalvar()"/> 
            <input type="button" value="Cancelar" name="btnCancelar" onclick="doCancelar()"/>
            <input type="hidden" name="acao" id="acao" value=""/>
        </form>
    </body>
</html>
