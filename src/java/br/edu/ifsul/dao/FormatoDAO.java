package br.edu.ifsul.dao;

import br.edu.ifsul.jpa.EntityManagerUtil;
import br.edu.ifsul.modelo.Formato;
import br.edu.ifsul.util.Util;
import java.io.Serializable;
import java.util.List;
import java.util.Set;
import javax.persistence.EntityManager;
import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import javax.validation.Validator;

public class FormatoDAO implements Serializable {
    
    private Formato objetoSelecionado;// atributo que armazena o objeto que está sendo incluido/editado
    private String mensagem = ""; // atributo que armazena mensagens que serão exibidas ao usuario
    private EntityManager em; // objeto que executa as operações de persistência
    
    public FormatoDAO(){
        em = EntityManagerUtil.getEntityManager(); // inicialização da entityManager
    }
    
    public boolean validaObjeto(Formato obj){
        // criação do objeto que valida os dados da classe FormatoA
        Validator validador = Validation.buildDefaultValidatorFactory().getValidator();
        // armazenando os erros de validação em uma lista
        Set<ConstraintViolation<Formato>> erros = validador.validate(obj);
        if (erros.size() > 0){ // caso caia neste teste o objeto tem erros
            mensagem = ""; // montando a mensagem com os erros para o usuário
            mensagem += "Objeto com erros: <br/>";
            for (ConstraintViolation<Formato> erro : erros){
                mensagem += "Erro: "+erro.getMessage()+"<br/>";
            }
            return false;
        } else {
            return true;
        }
    }
    
    public List<Formato> getLista(){
        /// consultando e retornando um entidade persistente        
        return em.createQuery("from Formato order by nome").getResultList();
    }
    
    public boolean salvar(Formato obj){
        try {
            em.getTransaction().begin();// inicia uma transação
            if (obj.getId() == null){
                em.persist(obj); // objeto novo
            } else {
                em.merge(obj); // objeto sendo alterado
            }
            em.getTransaction().commit(); // finalizando transação
            mensagem = "Objeto persistido com sucesso";
            return true;
        } catch (Exception e){
            if (em.getTransaction().isActive() == false){ // verificando se a transação não esta ativa
                em.getTransaction().begin();
            } 
            em.getTransaction().rollback(); // desfazendo possivel alterações que ocorreram 
            mensagem = "Erro ao persistir objeto: "+Util.getMensagemErro(e);
            return false;
        }
    }
    
    public boolean remover(Formato obj){
        try {
            em.getTransaction().begin();// inicia uma transação
            em.remove(obj); // removendo o objeto
            em.getTransaction().commit(); // finalizando transação
            mensagem = "Objeto removido com sucesso";
            return true;
        } catch (Exception e){
            if (em.getTransaction().isActive() == false){ // verificando se a transação não esta ativa
                em.getTransaction().begin();
            } 
            em.getTransaction().rollback(); // desfazendo possivel alterações que ocorreram 
            mensagem = "Erro ao remover objeto: "+Util.getMensagemErro(e);
            return false;
        }
    } 
    
    public Formato localizar(Integer id){
        return em.find(Formato.class, id);
    }

    public Formato getObjetoSelecionado() {
        return objetoSelecionado;
    }

    public void setObjetoSelecionado(Formato objetoSelecionado) {
        this.objetoSelecionado = objetoSelecionado;
    }

    public String getMensagem() {
        return mensagem;
    }

    public void setMensagem(String mensagem) {
        this.mensagem = mensagem;
    }

    public EntityManager getEm() {
        return em;
    }

    public void setEm(EntityManager em) {
        this.em = em;
    }

}
