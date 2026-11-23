CREATE TABLE public.autores (
	id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	nome VARCHAR(255) NOT NULL,
	criado_em TIMESTAMPTZ NOT NULL DEFAULT now(),
	atualizado_em TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE public.livros (
	id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	nome VARCHAR(255) NOT NULL,
	status VARCHAR(20) NOT NULL DEFAULT 'disponivel',
	autor_id INT NOT NULL,
	criado_em TIMESTAMPTZ NOT NULL DEFAULT now(),
	atualizado_em TIMESTAMPTZ NOT NULL DEFAULT now(),

	CONSTRAINT ck_livros_status
		CHECK (status IN ('disponivel', 'emprestado', 'danificado', 'perdido')),
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
	data_devolucao DATE NOT NULL DEFAULT (current_date + INTERVAL '7 days')::DATE,
	devolvido_em TIMESTAMPTZ,
	criado_em TIMESTAMPTZ NOT NULL DEFAULT now(),
	atualizado_em TIMESTAMPTZ NOT NULL DEFAULT now(),

	CONSTRAINT fk_emprestimos_livros
		FOREIGN KEY (livro_id) REFERENCES livros(id) ON DELETE RESTRICT,
	CONSTRAINT fk_emprestimos_clientes
		FOREIGN KEY (cliente_id) REFERENCES clientes(id) ON DELETE RESTRICT
);

CREATE INDEX idx_emprestimos_livros ON public.emprestimos (livro_id);

CREATE INDEX idx_emprestimos_clientes ON public.emprestimos (cliente_id);

CREATE FUNCTION registrar_data_de_atualizacao() RETURNS TRIGGER
LANGUAGE plpgsql AS $$
BEGIN
  NEW.atualizado_em = now();
  RETURN NEW;
END;
$$;

CREATE TRIGGER tg_autores_registrar_atualizado_em
BEFORE UPDATE ON autores
FOR EACH ROW
EXECUTE FUNCTION registrar_data_de_atualizacao();

CREATE TRIGGER tg_livros_registrar_atualizado_em
BEFORE UPDATE ON livros
FOR EACH ROW
EXECUTE FUNCTION registrar_data_de_atualizacao();

CREATE TRIGGER tg_clientes_registrar_atualizado_em
BEFORE UPDATE ON clientes
FOR EACH ROW
EXECUTE FUNCTION registrar_data_de_atualizacao();

CREATE TRIGGER tg_emprestimos_registrar_atualizado_em
BEFORE UPDATE ON emprestimos
FOR EACH ROW
EXECUTE FUNCTION registrar_data_de_atualizacao();
