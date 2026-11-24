INSERT INTO autores (nome) VALUES
('Machado de Assis'),
('Aluísio Azevedo'),
('Graciliano Ramos'),
('João Guimarães Rosa');

INSERT INTO livros (nome, autor_id) VALUES
('Dom Casmurro', 1),
('O Cortiço', 2),
('Memórias Póstumas de Brás Cubas', 1),
('Vidas Secas', 3),
('Grande Sertão: Veredas', 4);

INSERT INTO clientes (nome) VALUES
('Ana Souza'),
('Bruno Lima'),
('Carla Mendes'),
('Diego Ferreira');

INSERT INTO emprestimos (cliente_id, livro_id) VALUES
(1, 1),
(1, 2),
(2, 4);
