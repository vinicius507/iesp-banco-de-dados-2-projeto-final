INSERT INTO autores (nome) VALUES
('Machado de Assis'),
('Aluísio Azevedo'),
('Graciliano Ramos'),
('João Guimarães Rosa'),
('Clarice Lispector'),
('Jorge Amado'),
('José de Alencar'),
('Rachel de Queiroz'),
('Erico Verissimo'),
('Lima Barreto'),
('Monteiro Lobato'),
('Carlos Drummond de Andrade'),
('Cecília Meireles'),
('Manuel Bandeira'),
('Mário de Andrade'),
('Oswald de Andrade'),
('Euclides da Cunha'),
('Raul Pompeia'),
('Lygia Fagundes Telles'),
('Ariano Suassuna'),
('Conceição Evaristo'),
('Carolina Maria de Jesus'),
('Chico Buarque'),
('Milton Hatoum'),
('Itamar Vieira Junior'),
('Fernando Sabino'),
('Rubem Fonseca'),
('Bernardo Guimarães'),
('Joaquim Manuel de Macedo'),
('Manuel Antônio de Almeida');

INSERT INTO livros (nome, autor_id)
SELECT
	v.livro,
	a.id
FROM (
	VALUES
	('Dom Casmurro', 'Machado de Assis'),
	('Memórias Póstumas de Brás Cubas', 'Machado de Assis'),
	('Quincas Borba', 'Machado de Assis'),
	('O Alienista', 'Machado de Assis'),
	('Helena', 'Machado de Assis'),
	('Esaú e Jacó', 'Machado de Assis'),
	('O Cortiço', 'Aluísio Azevedo'),
	('O Mulato', 'Aluísio Azevedo'),
	('Casa de Pensão', 'Aluísio Azevedo'),
	('Vidas Secas', 'Graciliano Ramos'),
	('São Bernardo', 'Graciliano Ramos'),
	('Angústia', 'Graciliano Ramos'),
	('Memórias do Cárcere', 'Graciliano Ramos'),
	('Grande Sertão: Veredas', 'João Guimarães Rosa'),
	('Sagarana', 'João Guimarães Rosa'),
	('Primeiras Estórias', 'João Guimarães Rosa'),
	('A Hora da Estrela', 'Clarice Lispector'),
	('A Paixão Segundo G.H.', 'Clarice Lispector'),
	('Perto do Coração Selvagem', 'Clarice Lispector'),
	('Laços de Família', 'Clarice Lispector'),
	('Capitães da Areia', 'Jorge Amado'),
	('Gabriela, Cravo e Canela', 'Jorge Amado'),
	('Dona Flor e Seus Dois Maridos', 'Jorge Amado'),
	('Tieta do Agreste', 'Jorge Amado'),
	('Mar Morto', 'Jorge Amado'),
	('Iracema', 'José de Alencar'),
	('O Guarani', 'José de Alencar'),
	('Senhora', 'José de Alencar'),
	('Lucíola', 'José de Alencar'),
	('O Quinze', 'Rachel de Queiroz'),
	('Memorial de Maria Moura', 'Rachel de Queiroz'),
	('As Três Marias', 'Rachel de Queiroz'),
	('O Tempo e o Vento', 'Erico Verissimo'),
	('Incidente em Antares', 'Erico Verissimo'),
	('Olhai os Lírios do Campo', 'Erico Verissimo'),
	('Triste Fim de Policarpo Quaresma', 'Lima Barreto'),
	('Clara dos Anjos', 'Lima Barreto'),
	('Recordações do Escrivão Isaías Caminha', 'Lima Barreto'),
	('Reinações de Narizinho', 'Monteiro Lobato'),
	('Urupês', 'Monteiro Lobato'),
	('O Picapau Amarelo', 'Monteiro Lobato'),
	('Sentimento do Mundo', 'Carlos Drummond de Andrade'),
	('A Rosa do Povo', 'Carlos Drummond de Andrade'),
	('Claro Enigma', 'Carlos Drummond de Andrade'),
	('Romanceiro da Inconfidência', 'Cecília Meireles'),
	('Ou Isto ou Aquilo', 'Cecília Meireles'),
	('Viagem', 'Cecília Meireles'),
	('Libertinagem', 'Manuel Bandeira'),
	('Estrela da Vida Inteira', 'Manuel Bandeira'),
	('Macunaíma', 'Mário de Andrade'),
	('Pauliceia Desvairada', 'Mário de Andrade'),
	('Amar, Verbo Intransitivo', 'Mário de Andrade'),
	('Memórias Sentimentais de João Miramar', 'Oswald de Andrade'),
	('Serafim Ponte Grande', 'Oswald de Andrade'),
	('Os Sertões', 'Euclides da Cunha'),
	('O Ateneu', 'Raul Pompeia'),
	('As Meninas', 'Lygia Fagundes Telles'),
	('Ciranda de Pedra', 'Lygia Fagundes Telles'),
	('Antes do Baile Verde', 'Lygia Fagundes Telles'),
	('Auto da Compadecida', 'Ariano Suassuna'),
	('A Pedra do Reino', 'Ariano Suassuna'),
	('Ponciá Vicêncio', 'Conceição Evaristo'),
	('Olhos d''Água', 'Conceição Evaristo'),
	('Becos da Memória', 'Conceição Evaristo'),
	('Quarto de Despejo', 'Carolina Maria de Jesus'),
	('Budapeste', 'Chico Buarque'),
	('Estorvo', 'Chico Buarque'),
	('Leite Derramado', 'Chico Buarque'),
	('Dois Irmãos', 'Milton Hatoum'),
	('Relato de um Certo Oriente', 'Milton Hatoum'),
	('Cinzas do Norte', 'Milton Hatoum'),
	('Torto Arado', 'Itamar Vieira Junior'),
	('O Encontro Marcado', 'Fernando Sabino'),
	('O Grande Mentecapto', 'Fernando Sabino'),
	('Feliz Ano Novo', 'Rubem Fonseca'),
	('Agosto', 'Rubem Fonseca'),
	('A Grande Arte', 'Rubem Fonseca'),
	('A Escrava Isaura', 'Bernardo Guimarães'),
	('A Moreninha', 'Joaquim Manuel de Macedo'),
	('Memórias de um Sargento de Milícias', 'Manuel Antônio de Almeida')
) AS v (livro, autor)
JOIN autores AS a ON a.nome = v.autor;

INSERT INTO clientes (nome) VALUES
('Ana Souza'),
('Bruno Lima'),
('Carla Mendes'),
('Diego Ferreira'),
('Eduarda Costa'),
('Felipe Almeida'),
('Gabriela Rocha'),
('Henrique Martins'),
('Isabela Carvalho'),
('João Pereira'),
('Larissa Gomes'),
('Lucas Ribeiro'),
('Mariana Alves'),
('Matheus Barbosa'),
('Natália Dias'),
('Otávio Nunes'),
('Paula Teixeira'),
('Rafael Moreira'),
('Sofia Cardoso'),
('Thiago Andrade'),
('Valentina Freitas'),
('Vinícius Oliveira'),
('Yasmin Santos'),
('Arthur Silva'),
('Beatriz Rodrigues'),
('Caio Fernandes'),
('Débora Lopes'),
('Enzo Vieira'),
('Fernanda Soares'),
('Gustavo Marques'),
('Helena Machado'),
('Igor Ramos'),
('Júlia Nascimento'),
('Leonardo Gonçalves'),
('Manuela Santana'),
('Nicolas Batista'),
('Olívia Campos'),
('Pedro Monteiro'),
('Renata Araújo'),
('Samuel Correia'),
('Tatiane Pinto'),
('Ulisses Farias'),
('Vanessa Duarte'),
('William Cavalcanti'),
('Alice Moura'),
('Bernardo Siqueira'),
('Camila Brito'),
('Daniel Xavier'),
('Elisa Tavares'),
('Fábio Medeiros');

DO $$
DECLARE
	v_livro INT;
	v_clientes INT[];
	v_popularidade DOUBLE PRECISION;
	v_inicio TIMESTAMPTZ;
	v_fim TIMESTAMPTZ;
	v_duracao INTERVAL;
	v_sorteio DOUBLE PRECISION;
	v_intervalo INT;
BEGIN
	PERFORM setseed(0.42);

	SELECT array_agg(id ORDER BY id) INTO v_clientes FROM clientes;

	FOR v_livro IN SELECT id FROM livros ORDER BY id LOOP
		v_popularidade := random();
		v_inicio := TIMESTAMPTZ '2020-01-02 09:00-03'
			+ random() * INTERVAL '60 days';

		WHILE v_inicio < now() LOOP
			v_sorteio := random();
			v_duracao := CASE
				WHEN v_sorteio < 0.75 THEN INTERVAL '1 day' * (2 + random() * 6)
				WHEN v_sorteio < 0.93 THEN INTERVAL '1 day' * (8 + random() * 12)
				ELSE INTERVAL '1 day' * (20 + random() * 40)
			END;

			v_fim := v_inicio + v_duracao;
			IF v_fim > now() THEN
				v_fim := NULL;
			END IF;

			INSERT INTO emprestimos (
				livro_id, cliente_id, criado_em, devolver_ate, devolvido_em
			) VALUES (
				v_livro,
				v_clientes[1 + floor(power(random(), 1.2) * array_length(v_clientes, 1))::INT],
				v_inicio,
				(v_inicio AT TIME ZONE 'America/Sao_Paulo')::DATE + 7,
				v_fim
			);

			EXIT WHEN v_fim IS NULL;

			v_intervalo := floor(random() * (2 + 45 * (1 - v_popularidade)))::INT;
			IF extract(MONTH FROM v_fim) IN (1, 2, 7, 12) THEN
				v_intervalo := v_intervalo * 2;
			END IF;

			v_inicio := v_fim + INTERVAL '1 day' * v_intervalo
				+ random() * INTERVAL '10 hours';
		END LOOP;
	END LOOP;
END;
$$;

CALL dw.pr_carregar_dw();
