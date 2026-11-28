-- Empréstimos e taxa de atraso por ano e mês, com subtotais (ROLLUP).
SELECT
	d.ano,
	d.mes,
	sum(f.qtd_emprestimos)	AS emprestimos,
	sum(f.qtd_atrasados)	AS atrasados,
	round(sum(f.qtd_atrasados)::NUMERIC / sum(f.qtd_emprestimos) * 100, 1)
		AS taxa_atraso_pct
FROM dw.fato_emprestimos AS f
JOIN dw.dim_data AS d ON d.data = f.data_emprestimo
GROUP BY rollup (d.ano, d.mes)
ORDER BY d.ano, d.mes;

-- Empréstimos por autor e ano em todas as combinações (CUBE).
SELECT
	l.autor_nome,
	d.ano,
	sum(f.qtd_emprestimos) AS emprestimos
FROM dw.fato_emprestimos AS f
JOIN dw.dim_livro AS l ON l.livro_id = f.livro_id
JOIN dw.dim_data AS d ON d.data = f.data_emprestimo
GROUP BY cube (l.autor_nome, d.ano)
ORDER BY l.autor_nome, d.ano;

-- Mês do empréstimo x mês da devolução (dim_data em dois papéis).
SELECT
	de.ano || '-' || lpad(de.mes::TEXT, 2, '0')	AS mes_emprestimo,
	coalesce(
		dd.ano || '-' || lpad(dd.mes::TEXT, 2, '0'), 'em aberto'
	)											AS mes_devolucao,
	sum(f.qtd_emprestimos)						AS emprestimos
FROM dw.fato_emprestimos AS f
JOIN dw.dim_data AS de ON de.data = f.data_emprestimo
LEFT JOIN dw.dim_data AS dd ON dd.data = f.data_devolucao
GROUP BY mes_emprestimo, mes_devolucao
ORDER BY mes_emprestimo, mes_devolucao;

-- Ranking dos livros mais emprestados.
SELECT
	rank() OVER (ORDER BY sum(f.qtd_emprestimos) DESC)	AS posicao,
	l.livro_nome,
	l.autor_nome,
	sum(f.qtd_emprestimos)								AS emprestimos,
	sum(f.dias_emprestado)								AS dias_emprestado
FROM dw.fato_emprestimos AS f
JOIN dw.dim_livro AS l ON l.livro_id = f.livro_id
GROUP BY l.livro_nome, l.autor_nome
ORDER BY posicao, l.livro_nome;

-- Distribuição por faixa de atraso e médias de dias.
SELECT
	f.faixa_atraso,
	sum(f.qtd_emprestimos)			AS emprestimos,
	round(avg(f.dias_emprestado) FILTER (
		WHERE f.qtd_devolvidos = 1
	), 1)							AS media_dias_emprestado,
	round(avg(f.dias_atraso), 1)	AS media_dias_atraso
FROM dw.fato_emprestimos AS f
GROUP BY f.faixa_atraso
ORDER BY emprestimos DESC;

-- Autores mais populares em 2025.
SELECT
	rank() OVER (ORDER BY sum(f.qtd_emprestimos) DESC)	AS posicao,
	l.autor_nome,
	sum(f.qtd_emprestimos)								AS emprestimos,
	count(DISTINCT f.cliente_id)						AS leitores_distintos
FROM dw.fato_emprestimos AS f
JOIN dw.dim_livro AS l ON l.livro_id = f.livro_id
JOIN dw.dim_data AS d ON d.data = f.data_emprestimo
WHERE d.data BETWEEN DATE '2025-01-01' AND DATE '2025-12-31'
GROUP BY l.autor_nome
ORDER BY posicao, l.autor_nome;
