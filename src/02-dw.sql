CREATE SCHEMA dw;

CREATE MATERIALIZED VIEW dw.dim_data AS
SELECT
	g.d::DATE							AS data,
	extract(YEAR FROM g.d)::INT			AS ano,
	extract(MONTH FROM g.d)::INT		AS mes,
	(ARRAY[
		'janeiro', 'fevereiro', 'março', 'abril', 'maio', 'junho',
		'julho', 'agosto', 'setembro', 'outubro', 'novembro', 'dezembro'
	])[extract(MONTH FROM g.d)::INT]	AS mes_nome,
	extract(ISODOW FROM g.d)::INT		AS dia_semana,
	(ARRAY[
		'segunda-feira', 'terça-feira', 'quarta-feira', 'quinta-feira',
		'sexta-feira', 'sábado', 'domingo'
	])[extract(ISODOW FROM g.d)::INT]	AS dia_semana_nome
FROM generate_series(
		DATE '2020-01-01', DATE '2030-12-31', INTERVAL '1 day'
	) AS g (d);

CREATE UNIQUE INDEX uq_dim_data_data ON dw.dim_data (data);

CREATE MATERIALIZED VIEW dw.dim_livro AS
SELECT
	l.id	AS livro_id,
	l.nome	AS livro_nome,
	a.id	AS autor_id,
	a.nome	AS autor_nome
FROM public.livros AS l
JOIN public.autores AS a ON a.id = l.autor_id;

CREATE UNIQUE INDEX uq_dim_livro_livro_id ON dw.dim_livro (livro_id);

CREATE MATERIALIZED VIEW dw.dim_cliente AS
SELECT
	c.id	AS cliente_id,
	c.nome	AS cliente_nome
FROM public.clientes AS c;

CREATE UNIQUE INDEX uq_dim_cliente_cliente_id ON dw.dim_cliente (cliente_id);

CREATE MATERIALIZED VIEW dw.fato_emprestimos AS
WITH
	e AS (
		SELECT
			em.id,
			em.livro_id,
			em.cliente_id,
			em.devolver_ate,
			(em.criado_em AT TIME ZONE 'America/Sao_Paulo')::DATE		AS dt_emp,
			(em.devolvido_em AT TIME ZONE 'America/Sao_Paulo')::DATE	AS dt_dev,
			coalesce(
				(em.devolvido_em AT TIME ZONE 'America/Sao_Paulo')::DATE,
				(now() AT TIME ZONE 'America/Sao_Paulo')::DATE
			)															AS dt_ref
		FROM public.emprestimos AS em
	)

SELECT
	e.id									AS emprestimo_id,
	e.livro_id,
	e.cliente_id,
	e.dt_emp								AS data_emprestimo,
	e.devolver_ate							AS data_prevista,
	e.dt_dev								AS data_devolucao,
	1::SMALLINT								AS qtd_emprestimos,
	(CASE WHEN e.dt_dev IS NULL THEN 0 ELSE 1 END)::SMALLINT
		AS qtd_devolvidos,
	(CASE WHEN e.dt_ref > e.devolver_ate THEN 1 ELSE 0 END)::SMALLINT
		AS qtd_atrasados,
	e.dt_ref - e.dt_emp						AS dias_emprestado,
	greatest(0, e.dt_ref - e.devolver_ate)	AS dias_atraso,
	CASE
		WHEN e.dt_dev IS NULL THEN 'em aberto'
		WHEN e.dt_dev <= e.devolver_ate THEN 'no prazo'
		WHEN e.dt_dev - e.devolver_ate <= 7 THEN '1-7 dias'
		ELSE '>7 dias'
	END										AS faixa_atraso
FROM e;

CREATE UNIQUE INDEX uq_fato_emprestimos_emprestimo_id
ON dw.fato_emprestimos (emprestimo_id);

CREATE INDEX idx_fato_emprestimos_livro ON dw.fato_emprestimos (livro_id);

CREATE INDEX idx_fato_emprestimos_cliente ON dw.fato_emprestimos (cliente_id);

CREATE INDEX idx_fato_emprestimos_data_emprestimo
ON dw.fato_emprestimos (data_emprestimo);

CREATE PROCEDURE dw.pr_carregar_dw()
LANGUAGE plpgsql AS $$
BEGIN
	REFRESH MATERIALIZED VIEW dw.dim_data;
	REFRESH MATERIALIZED VIEW dw.dim_livro;
	REFRESH MATERIALIZED VIEW dw.dim_cliente;
	REFRESH MATERIALIZED VIEW dw.fato_emprestimos;

	ANALYZE dw.fato_emprestimos;
END;
$$;
