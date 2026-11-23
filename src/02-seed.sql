INSERT INTO livros (nome) VALUES
('Dom Casmuro'),
('O Cortiço'),
('Memórias Póstumas de Brás Cubas'),
('Vidas Secas'),
('Grande Sertão: Veredas');


INSERT INTO clientes (nome) VALUES
('Ana Souza'),
('Bruno Lima'),
('Carla Mendes'),
('Diego Ferreira');

INSERT INTO emprestimos (cliente_id, livro_id) VALUES
(1, 1),
(1, 2),
(2, 4);
