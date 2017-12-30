<!DOCTYPE html>
<html>
    <head>
        <title>Cadastro de Pa&iacute;ses</title>
        
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        
        <style type="text/css">
            #fundo{
                width: 580px;
                background-color: #eee;
                padding: 20px;
                margin:auto;
                border-radius: 10px;
            }
            
            .botaoSubmit{
                font-family: arial;
                font-weight: bolder;
                color: #fff;
                border: none;
                background-color: #65d85c;
                padding: 10px;
                border-radius: 5px;
            }
            
            .botaoReset{
                font-family: arial;
                font-weight: bolder;
                color: #fff;
                border: none;
                background-color: #ff4c4c;
                padding: 10px;
                border-radius: 5px;
                margin-left: 420px;    
            }
            
            .campo{
                padding: 10px;
                border: none;
                background: #fff;
                border-radius: 5px;
                width: 90%;
                margin-left: 19px;
                margin-top: 10px;
                margin-bottom: 10px;
            }
            
            label{
                font-family: arial;
                font-weight: bolder;
                margin-left: 19px;
            }
            
            h1{
                font-family: arial;
                font-weight: bolder;
                font-size: 24px;
                margin-left: 19px;
            }
            
            hr {
                width: 93%;
            }
        </style>
    </head>
    <body>
        ${mensagem}
            
        ${erro}
        
        <div id="fundo">
            <h1>Cadastro de Pa&iacute;ses</h1>
            <hr />
            
            <form action="PaisControle?operacao=Cadastrar" method="post">
                <input type="hidden" name="id" value="${pais.id}" />
                
                <label for="pais">Pa&iacute;s:</label><br />
                <input name="nome" type="text" value="${pais.nome}"
                       class="campo" id="pais" placeholder="Digite o nome do pa&iacute;s"
                       tabindex="1" />
                <br />
                
                <input tabindex="3" type="reset" class="botaoReset" value="Cancelar" />
                <input tabindex="2" type="submit" class="botaoSubmit" value="Salvar" />
            </form>
        </div>
    </body>
</html>