<%-- 
    Document   : index
    Created on : 12/03/2020, 09:39:22
    Author     : Rodrigo
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.lang.String"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        
        <%
             List<String> nomes = (List) application.getAttribute("nomes");
             String acao = request.getParameter("acao");
        
        if("editar".equals(acao)){
         String index = request.getParameter("index");
         String nome = nomes.get(Integer.parseInt(index));

        %>
        
            <form method="POST">
                <input type="hidden" name="index" value="<%=index%>">
                <input type="hidden" name="acao" value="editar">
                <label for="nome">Nome</label>
                <input type="text" name="nome" value="<%=nome%>"/>
                <button type="submit">Salvar</button>
            </form>
       <%} else {%>
        <form method="POST">
            
             <input type="hidden" name="acao" value="salvar"></input> 
            <label for="nome">Nome</label>
           
            <input type="text" name="nome"></input> 
            <button type="submit">Salvar!</button>
        </form>
        <%}%>
        <%
            
            
            
            
           if(nomes==null){
               nomes = new ArrayList<>();
           }
            
           
           String metodo = request.getMethod();
           
                if(metodo.equals("POST") && acao.equals("salvar")){
                    String nome = request.getParameter("nome");
                    nomes.add(nome);
                    application.setAttribute("nomes", nomes);
                }
            
         if(metodo.equals("POST") && acao.equals("remover") ){
             
             String index = request.getParameter("index");
             nomes.remove(Integer.parseInt(index));
             
             application.setAttribute("nomes", nomes);
             
         
         }
         
                if(metodo.equals("POST") && acao.equals("editar")) {
                    String index = request.getParameter("index");
                    String nome = request.getParameter("nome");
                    nomes.remove(Integer.parseInt(index));
                    nomes.add(Integer.parseInt(index), nome);
                    application.setAttribute("nomes", nomes);
                    response.sendRedirect(request.getContextPath() + "/");
                }
         
            

            %>
        
        <table>
        <thead>
            <th>Nome<th>
            <th>Ações</th>
        </thead>
        
        <tbody>
            
          <%
          
          for (int i = 0; i < nomes.size(); i++) {
          %>
           <tr>
               <td>
                   <%=nomes.get(i)%>
               </td>
               <td>
                   <form method="POST">
                        <input type="hidden" name="acao" value="remover">
                        <input type="hidden" name="index" value="<%=i%>">
                         <td><button type="submit">Remover</button></td>
                   </form>
                </td>  
                
                 <td>
                   <form method="GET">
                        <input type="hidden" name="acao" value="editar">
                        <input type="hidden" name="index" value="<%=i%>">
                         <td><button type="submit">Editar</button></td>
                   </form>
                </td>  
           </tr>    
          <%
              }
          %>  
        </tbody>  
    </table>
    </body>
</html>
