package br.edu.ifsul.servlets;

import br.edu.ifsul.dao.AutorDAO;
import br.edu.ifsul.dao.FormatoDAO;
import br.edu.ifsul.dao.LivroDAO;
import br.edu.ifsul.dao.IdiomaDAO;
import br.edu.ifsul.modelo.Autor;
import br.edu.ifsul.modelo.Livro;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Locale;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author isabela
 */
@WebServlet(name = "ServletLivro", urlPatterns = {"/livro/ServletLivro"})
public class ServletLivro extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // capturando o DAO da sessão
        LivroDAO dao = (LivroDAO) request.getSession().getAttribute("livroDao");
        // caso o DAO seja nulo (não existe na sessão) ele deve ser criado
        if (dao == null) {
            dao = new LivroDAO();
        }
        IdiomaDAO daoIdioma = (IdiomaDAO) request.getSession().getAttribute("idiomaDao");
        if (daoIdioma == null) {
            daoIdioma = new IdiomaDAO();
        }
        
        FormatoDAO daoFormato = (FormatoDAO) request.getSession().getAttribute("formatoDao");
        if (daoFormato == null) {
            daoFormato = new FormatoDAO();
        }
  
        AutorDAO daoAutor = (AutorDAO) request.getSession().getAttribute("autorDao");
        if (daoAutor == null) {
            daoAutor = new AutorDAO();
        }        
        
        
        String tela = ""; // armazena a tela que o servlet irá redirecionar após o processamento
        // capturar a operação a ser executada        
        String acao = request.getParameter("acao");
        // conforme a acao que veio da tela será executado um processamento diferente
        if (acao == null) {
            tela = "listar.jsp";
        } else if (acao.equals("incluir")) {
            dao.setObjetoSelecionado(new Livro());
            dao.setMensagem("");
            tela = "formulario.jsp";
        } else if (acao.equals("alterar")) {
            // carregando o objeto do banco pelo id que veio por parametro
            String isbn = String.valueOf(request.getParameter("isbn"));
            //Integer id = Integer.parseInt(request.getParameter("id"));
            dao.setObjetoSelecionado(dao.localizar(isbn));
            dao.setMensagem("");
            tela = "formulario.jsp";
        } else if (acao.equals("excluir")) {
            String isbn = String.valueOf(request.getParameter("isbn"));
            //Integer id = Integer.parseInt(request.getParameter("id"));
            Livro objeto = dao.localizar(isbn);
            if (objeto != null) {
                dao.remover(objeto);
                tela = "listar.jsp";
            }
        } else if (acao.equals("salvar")) {
            Integer id = null;
            try {
                String isbn = String.valueOf(request.getParameter("isbn"));
                //id = Integer.parseInt(request.getParameter("id"));
            } catch (Exception e) {
                e.printStackTrace();
            }
            // atribuindo os dados que vieram na requisição ao objeto selecionado do DAO
            dao.getObjetoSelecionado().setIsbn("isbn");
            dao.getObjetoSelecionado().setTitulo(request.getParameter("titulo"));
            dao.getObjetoSelecionado().setResumo(request.getParameter("resumo"));
            dao.getObjetoSelecionado().setEditora(request.getParameter("editora"));
            dao.getObjetoSelecionado().setDataPublicacao(Calendar.getInstance());
            dao.getObjetoSelecionado().setCodigoBarras(request.getParameter("codigoBarras"));
            dao.getObjetoSelecionado().setNumeroPaginas(Integer.parseInt(request.getParameter("numeroPaginas")));
            dao.getObjetoSelecionado().setAtivo(Boolean.TRUE);//request.getParameter("ativo"));
            dao.getObjetoSelecionado().setDataCadastro(Calendar.getInstance());
            dao.getObjetoSelecionado().setValor(Double.parseDouble(request.getParameter("valor")));

// capturando o id do idioma 
            Integer idIdioma = null;
            try {
                idIdioma = Integer.parseInt(request.getParameter("idIdioma"));
            } catch (Exception e) {
                System.out.println("Erro ao converter o id do idioma");
            }
            dao.getObjetoSelecionado().setIdioma(daoIdioma.localizar(idIdioma));
            // teste se os dados o objeto são validos
            if (dao.validaObjeto(dao.getObjetoSelecionado())) {
                dao.salvar(dao.getObjetoSelecionado()); // se são validos tento salvar
                tela = "listar.jsp";
            } else {
                tela = "formulario.jsp";
            }

// capturando o id do formato             
               Integer idAutor = null;
            try {               
                idAutor = Integer.parseInt(request.getParameter("idAutor"));
            } catch (Exception e) {
                System.out.println("Erro ao converter o id do autor");
            }
            dao.getObjetoSelecionado().setAutorias((List<Autor>) daoAutor.localizar(idAutor));
            //dao.getObjetoSelecionado().setAutor(daoAutor.localizar(idAutor));
            // teste se os dados o objeto são validos
            if (dao.validaObjeto(dao.getObjetoSelecionado())) {
                dao.salvar(dao.getObjetoSelecionado()); // se são validos tento salvar
                tela = "listar.jsp";
            } else {
                tela = "formulario.jsp";
            }         
     
// capturando o id do formato 
            Integer idFormato = null;
            try {
                idFormato = Integer.parseInt(request.getParameter("idFormato"));
            } catch (Exception e) {
                System.out.println("Erro ao converter o id do formato");
            }
            dao.getObjetoSelecionado().setFormato(daoFormato.localizar(idFormato));
            // teste se os dados o objeto são validos
            if (dao.validaObjeto(dao.getObjetoSelecionado())) {
                dao.salvar(dao.getObjetoSelecionado()); // se são validos tento salvar
                tela = "listar.jsp";
            } else {
                tela = "formulario.jsp";
            }
        } else if (acao.equals("cancelar")) {
            dao.setMensagem("");
            tela = "listar.jsp";
        }        

        // atualizar o dao na sessão
        request.getSession().setAttribute("livroDao", dao);
        request.getSession().setAttribute("idiomaDao", daoIdioma);
        // redireciona para a tela
        response.sendRedirect(tela);

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
