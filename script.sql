DROP DATABASE IF EXISTS iNova; 

CREATE DATABASE iNova;

USE iNova;

CREATE TABLE Endereco (
idEndereco INT PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
cep INT,
logradouro VARCHAR(50) NOT NULL,
numero INT NOT NULL,
estado VARCHAR(45) NOT NULL,
cidade VARCHAR(45) NOT NULL,
bairro VARCHAR(45) NOT NULL
);

CREATE TABLE Pessoa (
idPessoa INT PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
nome VARCHAR(45) NOT NULL,
telefone INT,
cpf_pessoa INT NOT NULL,
Endereco_idEndereco INT NOT NULL,
CONSTRAINT fk_Pessoa_Endereco1 FOREIGN KEY (Endereco_idEndereco) REFERENCES Endereco (idEndereco)
);

CREATE TABLE Email (
idEmail INT PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
plataforma VARCHAR(45) NOT NULL,
Pessoa_idPessoa INT NOT NULL UNIQUE,
CONSTRAINT fk_Email_Pessoa1 FOREIGN KEY (Pessoa_idPessoa) REFERENCES Pessoa (idPessoa) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE  Dono (
idDono INT PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
cod_licenca INT NOT NULL UNIQUE,
Pessoa_idPessoa INT NOT NULL UNIQUE,
Pessoa_Endereco_idEndereco INT NOT NULL
);

CREATE TABLE Cliente (
idCliente INT PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
Pessoa_idPessoa INT NOT NULL,
Pessoa_Endereco_idEndereco INT NOT NULL,
CONSTRAINT fk_Cliente_Pessoa1 FOREIGN KEY (Pessoa_idPessoa) REFERENCES Pessoa (idPessoa)
);

CREATE TABLE Funcionario (
idFuncionario INT PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
funcao VARCHAR(45) NOT NULL,
pin_acesso INT NOT NULL,
Pessoa_idPessoa INT NOT NULL,
CONSTRAINT fk_Funcionario_Pessoa1 FOREIGN KEY (Pessoa_idPessoa) REFERENCES Pessoa (idPessoa)
);

CREATE TABLE Empresa (
idEmpresa INT PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
Dono_idDono INT NOT NULL,
nome_fantasia VARCHAR(50) NOT NULL,
razao_social VARCHAR(45) NOT NULL,
slogan VARCHAR(45) NULL,
contato INT NOT NULL,
cnpj INT NOT NULL,
Endereco_idEndereco INT NOT NULL,
CONSTRAINT fk_Empresa_Endereco1 FOREIGN KEY (Endereco_idEndereco) REFERENCES Endereco (idEndereco),
CONSTRAINT fk_Empresa_Dono1 FOREIGN KEY (Dono_idDono) REFERENCES Dono (idDono)
);

CREATE TABLE Categoria (
idCategoria INT PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
nome_categoria VARCHAR(50) NOT NULL UNIQUE,
ordenacao INT NOT NULL UNIQUE DEFAULT 0,
descricao VARCHAR(45) NULL
);

CREATE TABLE Estoque (
idEstoque INT PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
quant_min INT NOT NULL,
quant_max INT NOT NULL,
quant_atual INT NOT NULL
);

CREATE TABLE Produto (
idProduto INT PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
nome_produto VARCHAR(45) NOT NULL UNIQUE,
detalhes VARCHAR(100) NULL,
tipo VARCHAR(45) NOT NULL,
unidade_medida VARCHAR(45) NOT NULL,
preco_venda FLOAT NOT NULL,
setor_preparo VARCHAR(45) NULL,
preco_custo FLOAT NULL,
Categoria_idCategoria INT NOT NULL,
Estoque_idEstoque INT NOT NULL,
CONSTRAINT fk_Produto_Categoria1 FOREIGN KEY (Categoria_idCategoria) REFERENCES Categoria (idCategoria),
CONSTRAINT fk_Produto_Estoque1 FOREIGN KEY (Estoque_idEstoque) REFERENCES Estoque (idEstoque)
);

CREATE TABLE Compra (
idCompra INT PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
preco_compra FLOAT NOT NULL,
fornecedor VARCHAR(45) NULL,
data_compra DATE NOT NULL,
quantidade INT NOT NULL,
valor_total FLOAT NOT NULL,
Produto_Categoria_idCategoria INT NOT NULL,
Produto_Estoque_idEstoque INT NOT NULL,
Produto_idProduto INT NOT NULL,
CONSTRAINT fk_Compra_Produto1 FOREIGN KEY (Produto_idProduto) REFERENCES Produto (idProduto)
);

CREATE TABLE Taxa (
idTaxa INT PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
tipo_taxa VARCHAR(45) NOT NULL,
valor_porcentagem INT NOT NULL,
periodo TIME NULL
);

CREATE TABLE Venda (
idVenda INT PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
data_venda DATE NOT NULL,
valor_taxa INT NOT NULL,
valor_produtos INT NOT NULL,
total_taxa INT NOT NULL,
Cliente_idCliente INT NOT NULL,
Cliente_Pessoa_Endereco_idEndereco INT NOT NULL,
Funcionario_idFuncionario INT NOT NULL,
Taxa_idTaxa INT NOT NULL,
CONSTRAINT fk_Venda_Cliente1 FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente (idCliente),
CONSTRAINT fk_Venda_Funcionario1 FOREIGN KEY (Funcionario_idFuncionario) REFERENCES Funcionario (idFuncionario),
CONSTRAINT fk_Venda_Taxa1 FOREIGN KEY (Taxa_idTaxa) REFERENCES Taxa (idTaxa)
);

CREATE TABLE Venda_has_Produto (
Venda_idVenda INT PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
Venda_Cliente_idCliente INT NOT NULL,
Venda_Cliente_Pessoa_Endereco_idEndereco INT NOT NULL,
Venda_Funcionario_idFuncionario INT NOT NULL,
Venda_Taxa_idTaxa INT NOT NULL,
Produto_idProduto INT NOT NULL,
Produto_Categoria_idCategoria INT NOT NULL,
Produto_Estoque_idEstoque INT NOT NULL,
CONSTRAINT fk_Venda_has_Produto_Venda1 FOREIGN KEY (Venda_idVenda) REFERENCES Venda (idVenda),
CONSTRAINT fk_Venda_has_Produto_Produto1 FOREIGN KEY (Produto_idProduto) REFERENCES Produto (idProduto)
);

INSERT INTO categoria (nome_categoria, ordenacao, descricao) VALUES ('COMBOS', 1, 'OS MELHORES COMBOS PARA NOITE');
INSERT INTO categoria (nome_categoria, ordenacao, descricao) VALUES ('BEBIDAS', 2, 'BEBIDAS GELADAS E QUENTES');
INSERT INTO categoria (nome_categoria, ordenacao, descricao) VALUES ('PORÇÕES', 3, 'ENTRADAS PARA PEDIDOS');

SELECT idCategoria, nome_categoria, descricao FROM categoria;

INSERT INTO endereco (logradouro, numero, estado, cidade, bairro) VALUES ('R. Engenheiro Beltrão', 2323, 'PARANÁ', 'TAMBOARA', 'CENTRO');
INSERT INTO endereco (logradouro, numero, estado, cidade, bairro) VALUES ('R. Antonio Felipe', 45, 'PARANÁ', 'PARANAVAÍ', 'SÃO JOÃO');
INSERT INTO endereco (logradouro, numero, estado, cidade, bairro) VALUES ('Av. Heitor Furtado', 3568, 'PARANÁ', 'PARANAVAÍ', 'CANADÁ');

SELECT idEndereco, logradouro, numero, cidade FROM endereco;

INSERT INTO pessoa (nome, cpf_pessoa, Endereco_idEndereco) VALUES ('JOAO', 11112345698, 1);
INSERT INTO pessoa (nome, cpf_pessoa, Endereco_idEndereco) VALUES ('SAMARA', 12189412345, 3);
INSERT INTO pessoa (nome, cpf_pessoa, Endereco_idEndereco) VALUES ('ANDERSON', 12154564895, 2);

SELECT idPessoa, nome, Endereco_idEndereco FROM pessoa;

