CREATE TABLE public.autores (
	id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	nome VARCHAR(255) NOT NULL,
	criado_em TIMESTAMPTZ NOT NULL DEFAULT now(),
	atualizado_em TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE public.livros (
	id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	nome VARCHAR(255) NOT NULL,
	autor_id INT NOT NULL,
	criado_em TIMESTAMPTZ NOT NULL DEFAULT now(),
	atualizado_em TIMESTAMPTZ NOT NULL DEFAULT now(),

	CONSTRAINT fk_livros_autores
		FOREIGN KEY (autor_id) REFERENCES autores(id) ON DELETE RESTRICT
);

CREATE INDEX idx_livros_autores ON public.livros (autor_id);

CREATE TABLE public.clientes (
	id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	nome VARCHAR(255) NOT NULL,
	criado_em TIMESTAMPTZ NOT NULL DEFAULT now(),
	atualizado_em TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE public.emprestimos (
	id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	livro_id INT NOT NULL,
	cliente_id INT NOT NULL,
	devolver_ate DATE NOT NULL DEFAULT (current_date + INTERVAL '7 days')::DATE,
	devolvido_em TIMESTAMPTZ,
	criado_em TIMESTAMPTZ NOT NULL DEFAULT now(),
	atualizado_em TIMESTAMPTZ NOT NULL DEFAULT now(),

	CONSTRAINT fk_emprestimos_livros
		FOREIGN KEY (livro_id) REFERENCES livros(id) ON DELETE RESTRICT,
	CONSTRAINT fk_emprestimos_clientes
		FOREIGN KEY (cliente_id) REFERENCES clientes(id) ON DELETE RESTRICT,
	CONSTRAINT ck_emprestimos_devolvido_em
		CHECK (devolvido_em IS NULL OR devolvido_em >= criado_em)
);

CREATE INDEX idx_emprestimos_livros ON public.emprestimos (livro_id);

CREATE INDEX idx_emprestimos_clientes ON public.emprestimos (cliente_id);

CREATE UNIQUE INDEX uq_emprestimos_livro_aberto
ON public.emprestimos (livro_id) WHERE devolvido_em IS NULL;

CREATE VIEW public.vw_livros_situacao AS
SELECT
	l.id															AS livro_id,
	l.nome															AS livro_nome,
	a.nome															AS autor_nome,
	CASE WHEN e.id IS NULL THEN 'disponivel' ELSE 'emprestado' END	AS situacao,
	e.id															AS emprestimo_id,
	c.nome															AS cliente_nome,
	e.devolver_ate
FROM livros l
JOIN autores a ON a.id = l.autor_id
LEFT JOIN emprestimos e ON e.livro_id = l.id AND e.devolvido_em IS NULL
LEFT JOIN clientes c ON c.id = e.cliente_id;

CREATE FUNCTION fn_registrar_atualizado_em() RETURNS TRIGGER
LANGUAGE plpgsql AS $$
BEGIN
  NEW.atualizado_em = now();
  RETURN NEW;
END;
$$;

CREATE TRIGGER tg_autores_registrar_atualizado_em
BEFORE UPDATE ON autores
FOR EACH ROW
EXECUTE FUNCTION fn_registrar_atualizado_em();

CREATE TRIGGER tg_livros_registrar_atualizado_em
BEFORE UPDATE ON livros
FOR EACH ROW
EXECUTE FUNCTION fn_registrar_atualizado_em();

CREATE TRIGGER tg_clientes_registrar_atualizado_em
BEFORE UPDATE ON clientes
FOR EACH ROW
EXECUTE FUNCTION fn_registrar_atualizado_em();

CREATE TRIGGER tg_emprestimos_registrar_atualizado_em
BEFORE UPDATE ON emprestimos
FOR EACH ROW
EXECUTE FUNCTION fn_registrar_atualizado_em();
