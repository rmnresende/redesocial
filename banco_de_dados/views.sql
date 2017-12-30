﻿/* Todos os códigos das views serão adicionados aqui */
/**
 * View para selecionar a quantidade de usuários cadastrados por mês
 * @author Daniel Moreira Cardoso
 */
 
 CREATE VIEW `quantidade_de_usuarios_por_mes` AS
    (SELECT 
        DATE_FORMAT(`usuarios`.`data_cadastro`, '%M') AS `Mês`,
        DATE_FORMAT(`usuarios`.`data_cadastro`, '%y') AS `Ano`,
        COUNT(*) AS `Quantidade de novos usuários`
    FROM
        `usuarios`
    GROUP BY DATE_FORMAT(`usuarios`.`data_cadastro`, '%M-%Y')
    ORDER BY `usuarios`.`data_cadastro`);
	
/**
 * View para selecionar a quantidade de comentários do usuário
 * @author Gusttavo Nunes Gomes
 */
 CREATE VIEW quantidade_de_comentarios_do_usuario AS
	(SELECT
	 	`usuarios`.`nome` AS `Usuário`,
		COUNT(*) AS `Qtde. Comentários`
		
	FROM 
		`usuarios` 
		INNER JOIN `comentarios` ON `comentarios`.`usuario` = `usuarios`.`id`
		
	GROUP BY `usuarios`.`id`
	ORDER BY `Qtde. Comentários`);
    
/**
 * View para selecionar os aportes mais "upados"
 * @author Andrey Silva Ribeiro
 */
 CREATE VIEW aportes_mais_upados AS
	(SELECT
		`postagens`.`curtidas` AS quantidade_ups,
        `aportes`.`titulo`
	FROM 
		(postagens
        INNER JOIN `aportes` ON `postagens`.`id` = `aportes`.`postagem`)
    ORDER BY `postagens`.`curtidas` desc);
    
    
/**
 * View da quantidade de usuários por sexo
 * @author Andrey Silva Ribeiro
 */
 CREATE VIEW quantidade_usuario_sexo AS
 SELECT sexo, count(sexo) AS qtde
 FROM usuarios
 GROUP BY sexo
 ORDER BY sexo desc;
 
/**
 * View para mostrar os aportes mais visualizados
 * @author Jônatas de Souza Rezende
 */
CREATE VIEW aportes_mais_visualizados AS
SELECT ap.id AS id_aporte, titulo AS titulo_do_aporte, post.visualizacoes AS quantidade_de_visualizacoes 
FROM aportes ap
INNER JOIN postagens post ON ap.postagem = post.id
ORDER BY post.visualizacoes DESC;


/**
 * View para mostrar a quantidade de usuários por estado
 * @author Jônatas de Souza Rezende
 */
CREATE VIEW usuarios_por_estado AS
SELECT est.nome AS estado, pai.nome AS pais, COUNT(est.nome) AS qtde
FROM usuarios us
INNER JOIN cidades cid ON us.cidade = cid.id
INNER JOIN estados est ON cid.estado = est.id
INNER JOIN paises pai ON est.pais = pai.id
GROUP BY est.nome, pai.nome
ORDER BY est.nome;

/**
 * View para mostrar a quantidade de vezes que uma palavra-chave foi usada nas postagens
 * @author Thalia Santos de Santana
 */
create view palavra_chave_postagem as
select palavras_chave.descricao as 'palavra_chave', count(palavras_chave.descricao) as 'quantidade' from palavras_chave
inner join postagens_palavras_chave on postagens_palavras_chave.palavra_chave = palavras_chave.id
group by palavras_chave.descricao 
order by palavras_chave.descricao desc;

/**
 * View para mostrar a quantidade de vezes que uma palavra-chave foi usada em aportes
 * @author Thalia Santos de Santana
 */
create view palavra_chave_aporte as
select palavras_chave.descricao as 'palavra_chave', count(palavras_chave.descricao) as 'quantidade' from palavras_chave
inner join postagens_palavras_chave on postagens_palavras_chave.palavra_chave = palavras_chave.id
inner join postagens on postagens_palavras_chave.postagem = postagens.id 
inner join aportes on postagens_palavras_chave.postagem = aportes.postagem
group by palavras_chave.descricao 
order by palavras_chave.descricao desc;

/**
 * View para mostrar a quantidade de comentários em uma postagem
 * @author Davi de Faria
 */
 CREATE VIEW `quantidade_de_comentarios_por_postagem` AS
    (SELECT 
        `p`.`descricao` AS `Postagem`,
        COUNT(*) AS `Quantidade de comentários`
    FROM
        (`postagens` `p`
        LEFT JOIN `comentarios` `c` ON ((`p`.`id` = `c`.`postagem`)))
    GROUP BY `p`.`id`);
    
/**
 * View para mostrar a quantidade de comentários em uma postagem
 * @author Gleyson-Alves
 */
CREATE VIEW multidias_por_album_de_usuario AS
SELECT usuarios.nome as usuario, albuns.nome as album, COUNT(multimidias.id) AS qtde_multimidias
FROM multimidias
INNER JOIN albuns ON multimidias.album = albuns.id
INNER JOIN usuarios ON albuns.usuario = usuarios.id
GROUP BY usuarios.nome, albuns.nome
ORDER BY usuarios.nome;

/**
 * View para mostrar a quantidade de cidades por estado
 * @author Adallberto Lucena Moura
 */
CREATE VIEW contador_cidade AS
SELECT e.id as Id_estado, e.nome as estado, p.nome as pais, COUNT(*) as quantidade  FROM estados e JOIN cidades c
ON e.id = c.estado right join paises p on e.pais = p.id
GROUP BY e.nome, p.nome
ORDER BY e.nome, p.nome;

/**
*View para mostrar a quantidade de Postagens por data
* @author Eduardo Oliveira
*/
CREATE VIEW qtde_geral_postagens_por_data AS
SELECT date_format(data, '%Y-%m-%d') AS data_post,
COUNT(*) AS qtde
FROM postagens p
GROUP BY date_format(data, '%Y-%m-%d')
ORDER BY date_format(data, '%Y-%m-%d');

/**
 * View para selecionar a quantidade de usuários cadastrados por cidade
 * @author Igor Justino Rodrigues
 */
create view `quantidade_de_usuarios_por_cidade` as (
	select
		c.id as id_cidade,
		c.nome as cidade, 
		e.id as id_estado, 
		e.nome as estado, 
		p.id as id_pais, 
		p.nome as pais, 
		count(u.nome) as qtde 
	from 
		usuarios u 
			inner join cidades c
				on u.cidade = c.id 
			inner join estados e 
				on c.estado = e.id 
			inner join paises p 
				on e.pais = p.id 
	group by c.nome
);

/**
 * Views para mostrar a quantidade de postagens, aportes e artigos por usuário
 * @author Jônatas de Souza Rezende, Paulo Henrique Araujo
 */

CREATE OR REPLACE VIEW postagens_aportes_por_usuario AS
SELECT 
	usuarios.id AS id_usuario, 
	usuarios.nome AS usuario, 
    COUNT(postagens.id) AS qtde_postagens, 
    COUNT(aportes.postagem) AS qtde_aportes    
FROM usuarios
	LEFT JOIN postagens ON postagens.usuario = usuarios.id
    LEFT JOIN aportes ON aportes.postagem = postagens.id
   	GROUP BY usuarios.id;

CREATE OR REPLACE VIEW postagens_aportes_artigos_por_usuario AS
SELECT 
	id_usuario,
    papu.usuario,
    qtde_postagens,
    qtde_aportes,
	COUNT(autores.usuario) AS qtde_artigos
FROM postagens_aportes_por_usuario papu
	LEFT JOIN autores ON papu.id_usuario = autores.usuario
    GROUP BY id_usuario;    
    

/**
 * View para mostrar a quantidade de publico alvo por idade
 * @author Willian
 */
 
create view publico_alvo as
(SELECT
    count(*) as quantidade, YEAR(FROM_DAYS(TO_DAYS(NOW())-TO_DAYS(data_nascimento))) AS idade
FROM
    usuarios    
    group by idade
    order by quantidade desc);
    
/**
 * View para mostrar a quantidade de estados por pais
 * @author Anny Karoliny Moraes Ribeiro
 */

create view quantidade_de_estados_por_pais as

select
 
	p.nome AS pais, count(p.id) AS 'qtde_estados'

from 
	estados e 

inner join paises p on e.pais = p.id

group by p.id;

/**
 * View para mostrar a quantidade de Usuarios por Pais
 * @author Jonathan Silvestre Sousa
 */
CREATE VIEW `usuarios_por_pais` AS
    SELECT 
        `pai`.`nome` AS `pais`,
        COUNT(`pai`.`nome`) AS `qtde`
    FROM
        (((`usuarios` `us`
        JOIN `cidades` `cid` ON ((`us`.`cidade` = `cid`.`id`)))
        JOIN `estados` `est` ON ((`cid`.`estado` = `est`.`id`)))
        JOIN `paises` `pai` ON ((`est`.`pais` = `pai`.`id`)))
    GROUP BY `pai`.`nome`;
    
   /**
   *View de quantidades de aportes por catgoria
   *@author Brener Gomes de Jesus
   */
   CREATE VIEW `AportesPorQuantidade` AS
   SELECT categorias.descricao, COUNT(*)
   FROM aportes, categorias
   where aportes.categoria = categorias.id
   GROUP BY aportes.categoria;
   
   
 /**
 * View para selecionar a quantidade de relações de usuarios por tipo.
 * @author Fernando Maciel da Silva
 */
create view `usuariosQtdeRelacionamentos` as (

	SELECT u.nome, "Amizade" as tipo, count(*) as Qtde 
	FROM redesocial.relacionamentos r 
    
	inner join	usuarios u on r.usuario_1 = u.id 	
	group by u.nome
	order by u.nome asc
);

/**
 * View da quantidade de postagens de um usuário
 * @author Adallberto Lucena Moura
 */
 
 CREATE OR REPLACE VIEW postagens_por_usuario AS

SELECT 
	usuarios.id AS id_usuario, 
	usuarios.nome AS usuario, 
    COUNT(postagens.id) AS qtde_postagens
FROM usuarios
	LEFT JOIN postagens ON postagens.usuario = usuarios.id
   	GROUP BY usuarios.id;

/**
 * View do intervalo de idades segundo o painel final (administrativo)
 * @author Salmi Nunes e Willian
 */

CREATE OR REPLACE VIEW `intervalo_idades_com_percentual` AS 
	 select '-18' as intervalo, sum(quantidade) as qtde, (select sum(quantidade))*100/(select sum(quantidade) 
	 from publico_alvo)as  percentual from publico_alvo where idade < 18
	 union
	 select '18 - 24' as intervalo, sum(quantidade) as qtde, (select sum(quantidade))*100/(select sum(quantidade) 
	 from publico_alvo)as  percentual from publico_alvo where idade >= 18 and idade <= 24
	 union
	 select '25 - 34' as intervalo, sum(quantidade) as qtde, (select sum(quantidade))*100/(select sum(quantidade) 
	 from publico_alvo)as  percentual from publico_alvo where idade >= 25 and idade <= 34
	 union
	 select '35 - 44' as intervalo, sum(quantidade) as qtde, (select sum(quantidade))*100/(select sum(quantidade) 
	 from publico_alvo)as  percentual from publico_alvo where idade >= 35 and idade <= 44
	 union
	 select '45 - 54' as intervalo, sum(quantidade) as qtde, (select sum(quantidade))*100/(select sum(quantidade) 
	 from publico_alvo)as  percentual from publico_alvo where idade >= 45 and idade <= 54
	 union
	 select '55 - 64' as intervalo, sum(quantidade) as qtde, (select sum(quantidade))*100/(select sum(quantidade) 
	 from publico_alvo)as  percentual from publico_alvo where idade >= 55 and idade <= 64
	 union
	 select '65+' as intervalo, sum(quantidade) as qtde, (select sum(quantidade))*100/(select sum(quantidade) 
	 from publico_alvo)as  percentual from publico_alvo where idade > 65;
/**
 * View da quantidade de presença por evento
 * @author Willian Wallace de Matteus Silva e Salmi Nunes
 */
 
CREATE OR REPLACE VIEW `percentual_presenca_evento` AS 
(SELECT count(presenca_evento.presenca) as total, 
(select count(presenca_evento.presenca) from presenca_evento where presenca_evento.presenca=1 ) as presentes,
((select count(presenca_evento.presenca) from presenca_evento where presenca_evento.presenca=1 ) / (select count(presenca_evento.presenca)) *100)as percentual
 from presenca_evento);
 
 
/**
 * 3 Views para mostrar a porcentagem de presentes em cada atividade de determinado evento em relacao inscritos/presentes
 * @author Willian Wallace de Matteus Silva e Salmi Nunes
 */ 
 /* ------------------------------------------------------------------------------------------------------------- */
 CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `redesocial`.`contar_inscricao_atividade` AS
    (SELECT 
        `redesocial`.`atividades`.`id` AS `id`,
        `redesocial`.`atividades`.`descricao` AS `descricao`,
        COUNT(0) AS `inscricoes`
    FROM
        (`redesocial`.`presenca_atividade`
        JOIN `redesocial`.`atividades`)
    WHERE
        ((`redesocial`.`presenca_atividade`.`atividade` = `redesocial`.`atividades`.`id`)
            AND (`redesocial`.`atividades`.`evento` = 1))
    GROUP BY `redesocial`.`atividades`.`id`);
	
	
	CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `redesocial`.`contar_presenca_atividade` AS
    (SELECT 
        `redesocial`.`atividades`.`id` AS `id`,
        `redesocial`.`atividades`.`descricao` AS `descricao`,
        COUNT(0) AS `presencas`
    FROM
        (`redesocial`.`presenca_atividade`
        JOIN `redesocial`.`atividades`)
    WHERE
        ((`redesocial`.`presenca_atividade`.`atividade` = `redesocial`.`atividades`.`id`)
            AND (`redesocial`.`presenca_atividade`.`presenca` = 1)
            AND (`redesocial`.`atividades`.`evento` = 1))
    GROUP BY `redesocial`.`atividades`.`id`)
	
	
	CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `redesocial`.`percentual_presenca_atividades` AS
    (SELECT 
        `contar_inscricao_atividade`.`id` AS `id`,
        `contar_inscricao_atividade`.`descricao` AS `descricao`,
        `contar_inscricao_atividade`.`inscricoes` AS `inscricoes`,
        `contar_presenca_atividade`.`presencas` AS `presencas`,
        ((`contar_presenca_atividade`.`presencas` / `contar_inscricao_atividade`.`inscricoes`) * 100) AS `porcentagem_presente`
    FROM
        (`redesocial`.`contar_inscricao_atividade`
        JOIN `redesocial`.`contar_presenca_atividade`)
    WHERE
        (`contar_inscricao_atividade`.`id` = `contar_presenca_atividade`.`id`))
		
/* ------------------------------------------------------------------------------------------------------ */
 
 