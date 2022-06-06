WITH recursive expression_name
AS ( SELECT cod_pai.codigo, cod_pai.nome, cod_pai.codigo_pai
FROM classificacao as cod_pai
WHERE cod_pai.codigo_pai IS NULL

UNION ALL

SELECT cod_filho.codigo, cod_filho.nome, cod_filho.codigo_pai
FROM classificacao AS cod_filho

INNER JOIN expression_name AS EL
ON cod_filho.codigo = EL.codigo
WHERE cod_filho.codigo IS NOT NULL )

SELECT * FROM expression_name;