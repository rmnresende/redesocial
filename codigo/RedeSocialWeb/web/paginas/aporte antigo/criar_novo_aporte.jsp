<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <title>Cria��o de novo aporte</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        
        
        <style type="text/css">            
            #background {
                width: 500px;
                height: 500px;
                padding: 0px;
                margin: 0px;
                border-width: 2px;
                background-color: #e5e4e2;
            }
            
            #topo {
                font-family: Arial;
                width: 500px;
                height: 50px;
                margin-left: 10px;                 
            }
            
            #hr {
                background-color: #000;
                width: 465px;
                height: 2px;
                margin-top: -20px;
                margin-left: 2px;                              
            }
            
            #conteudo {
                font-family: Arial;
                width: 465px;
                height: 590px;
                margin-top: 10px;
                margin-left: 10px;  
            }
            
            #campo_arquivo{
                width: 73%;
                height:50px;
		padding: 5px;
		border: 1px solid #666;
		margin-top: 5px;
		float: left;
                color: #666;
                background-color: #ffffff;
            }
            #botao_arquivo{
                width:97px;
                height:60px;		
		border: solid #6b6b6b 2px;
		margin-top: 5px;
		float: right;
                margin-left: 10px;
            }
            #output{
                width: 100px;
                height: 100px;
            }
            
            #descricao {
                width: 465px;
                height: 65px;
                margin-top: 65px;
                
            }
            
            .descricao {
                margin: 0px; 
                width: 464px; 
                height: 75px;
                margin-top: 3px;
            }
            #palavra_chave{
                width: 465px;
                height: 60px;
                margin-top: 65px;
            }
                                                       
            label, h1 {
                padding: 5px 3px 0px 0px;                
            }
            
            select {
                width: 468px;
                border-bottom: 300px;
                border-bottom-color: #6b6b6b;
            }
            
            input {
                width: 465px;
                border-bottom: 300px;
                border-bottom-color: #6b6b6b;
            }
            
            #imgfundo {
                background: #0790eb; 
                width:97px; 
                height:60px; 
            }
            
            #btns{                
                width: 250px;
                margin-left: 220px;
            }
            
            .realupload {
                width:97px;
                height:60px; 
                opacity:0.0;    
                -moz-opacity: 0.0;     
                filter: alpha(opacity = 0);
            }
            .fakeupload {
                width:97px;
                height: 60px;
                font-size: 10px;
                
                
            }
            .fakeupload_nome {                
                width: 100%;
                height:40px;
                margin-left: -05px;
                margin-top: -05px;
                border: 1px;
                border-bottom-color: #000;
            }
            p.info { 
                width: 350px;
                border-top: 1px solid #000;              
                margin-top: 0px; 
                margin-left: -5px;
                font-size: 10px;                          
            }
            p.titulo {
                font-size: 15px
            } 
            
            p.obrigatorio {                
                margin-left: -219px;
                font-size: 10px;
            }
            .btnenviar {                
                width: 40%;
                height: 10px;
                color: #ffffff;
                font-size: 20px;
                background: #18ad4a;
                padding: 2px 10px 22px 05px;
                border: solid #313233 3px;                 
                margin-left: 25px;
                float: right;
                
                
            }
            .btncancelar {
                width: 40%;
                height: 10px;
                color: #ffffff;
                font-size: 20px;
                background: #ff0505;
                padding: 2px 10px 22px 05px;
                border: solid #313233 3px; 
               
                float: right;
            }
            
        </style>
        
    </head>
    
    <body> 
        
        
        <div id="background">
            <div id="topo">
                <h1> Cria��o de novo aporte</h1>
                <div id="hr"></div>                
            </div>  

            <div id="conteudo">
                <form action="" method="post">
                    <label> Titulo * </label> <br>
                    <input  size="90" type="text" name="TituloAporte" value="Aporte de Teste"><br> 
                    <br>
                    <label> Categoria * </label><br>
                    <select name="Categoria" >
                        <option value="categoria1"> Categoria 1 </option>
                        <option value="categoria2"> Categoria 2 </option>
                        <option value="categoria3"> Categoria 3 </option>
                    </select>
                    <br>
                    <br>
                    <label> Imagem /video (opcional)</label>
                    <br>

                    <div id="botao_arquivo">


                        <div id="imgfundo" class="fakeupload">                                     
                            <input type="file" class="realupload" name="FileUpload" onchange="this.form.fakeupload.value = this.value; ">
                        </div>


                    </div>

                    <div id="campo_arquivo">                                                            
                         <input name="fakeupload" class="fakeupload_nome"  type="text" readonly>    
                         <br>

                         <p class="info"> descri��o_do_arquivo </p>
                    </div>



                    <div id="descricao">
                        <br>
                        <label> Descri��o (opcional)</label> <br>
                        <textarea placeholder="Digite uma descrição"  class="descricao"></textarea>
                    </div>

                    <div id="palavra_chave">
                       <label> Palvras chaves (opcional) </label> <br>
                    <input  size="90" type="text" name="PalavrasChaves" value=""><br>  
                    </div>

                    <div id="btns">                                                                
                        <input type="submit" class="btnenviar" value="Enviar" /> 
                        <input type="reset" class="btncancelar" value="Cancelar" />
                        <p class="obrigatorio">
                            * Obrigatorio
                        </p>

                    </div>
                </form>    


            </div>    

        </div>          
            
    </body>
        
</html>
