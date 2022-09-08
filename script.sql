DROP DATABASE IF EXISTS iNova; 

CREATE DATABASE iNova;

USE iNova;

CREATE TABLE Endereco (
idEndereco INT NOT NULL AUTO_INCREMENT,
cep INT NOT NULL,
logradouro VARCHAR(50) NOT NULL,
numero INT NOT NULL,
estado VARCHAR(45) NOT NULL,
cidade VARCHAR(45) NOT NULL,
bairro VARCHAR(45) NOT NULL,
PRIMARY KEY (idEndereco),
UNIQUE INDEX idEndereco_UNIQUE (idEndereco ASC) VISIBLE
);

CREATE TABLE Pessoa (
idPessoa INT NOT NULL AUTO_INCREMENT,
nome VARCHAR(45) NOT NULL,
telefone INT NOT NULL,
cpf_pessoa INT NOT NULL,
Endereco_idEndereco INT NOT NULL,
PRIMARY KEY (idPessoa, Endereco_idEndereco),
UNIQUE INDEX idPessoa_UNIQUE (idPessoa ASC) VISIBLE,
UNIQUE INDEX telefone_pessoa_UNIQUE (telefone ASC) VISIBLE,
UNIQUE INDEX cpf_pessoa_UNIQUE (cpf_pessoa ASC) VISIBLE,
INDEX fk_Pessoa_Endereco1_idx (Endereco_idEndereco ASC) VISIBLE,
CONSTRAINT fk_Pessoa_Endereco1 FOREIGN KEY (Endereco_idEndereco) REFERENCES Endereco (idEndereco) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE Email (
idEmail INT NOT NULL AUTO_INCREMENT,
Plataforma VARCHAR(45) NOT NULL,
Pessoa_idPessoa INT NOT NULL,
PRIMARY KEY (idEmail, Pessoa_idPessoa),
UNIQUE INDEX idEmail_UNIQUE (idEmail ASC) VISIBLE,
INDEX fk_Email_Pessoa1_idx (Pessoa_idPessoa ASC) VISIBLE,
CONSTRAINT fk_Email_Pessoa1 FOREIGN KEY (Pessoa_idPessoa) REFERENCES Pessoa (idPessoa) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE  Dono (
idDono INT NOT NULL AUTO_INCREMENT,
cod_licenca INT NOT NULL,
Pessoa_idPessoa INT NOT NULL,
Pessoa_Endereco_idEndereco INT NOT NULL,
PRIMARY KEY (idDono, Pessoa_idPessoa, Pessoa_Endereco_idEndereco),
UNIQUE INDEX cod_licenca_UNIQUE (cod_licenca ASC) VISIBLE
);

CREATE TABLE Pessoa_Dono (
idPessoa_Dono INT NOT NULL AUTO_INCREMENT,
Dono_idDono INT NOT NULL,
Dono_Pessoa_idPessoa INT NOT NULL,
Dono_Pessoa_Endereco_idEndereco INT NOT NULL,
Pessoa_idPessoa INT NOT NULL,
Pessoa_Endereco_idEndereco INT NOT NULL,
PRIMARY KEY (idPessoa_Dono, Dono_idDono, Dono_Pessoa_idPessoa, Dono_Pessoa_Endereco_idEndereco, Pessoa_idPessoa, Pessoa_Endereco_idEndereco),
UNIQUE INDEX idPessoa_Dono_UNIQUE (idPessoa_Dono ASC) VISIBLE,
INDEX fk_Pessoa_Dono_Dono1_idx (Dono_idDono ASC, Dono_Pessoa_idPessoa ASC, Dono_Pessoa_Endereco_idEndereco ASC) VISIBLE,
INDEX fk_Pessoa_Dono_Pessoa1_idx (Pessoa_idPessoa ASC, Pessoa_Endereco_idEndereco ASC) VISIBLE,
CONSTRAINT fk_Pessoa_Dono_Dono1 FOREIGN KEY (Dono_idDono , Dono_Pessoa_idPessoa , Dono_Pessoa_Endereco_idEndereco) REFERENCES Dono (idDono , Pessoa_idPessoa , Pessoa_Endereco_idEndereco)
ON DELETE NO ACTION ON UPDATE NO ACTION,
CONSTRAINT fk_Pessoa_Dono_Pessoa1 FOREIGN KEY (Pessoa_idPessoa , Pessoa_Endereco_idEndereco) REFERENCES Pessoa (idPessoa , Endereco_idEndereco) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE Cliente (
idCliente INT NOT NULL AUTO_INCREMENT,
Pessoa_idPessoa INT NOT NULL,
Pessoa_Endereco_idEndereco INT NOT NULL,
PRIMARY KEY (idCliente, Pessoa_idPessoa, Pessoa_Endereco_idEndereco),
UNIQUE INDEX idCliente_UNIQUE (idCliente ASC) VISIBLE,
INDEX fk_Cliente_Pessoa1_idx (Pessoa_idPessoa ASC, Pessoa_Endereco_idEndereco ASC) VISIBLE,
CONSTRAINT fk_Cliente_Pessoa1 FOREIGN KEY (Pessoa_idPessoa , Pessoa_Endereco_idEndereco) REFERENCES Pessoa (idPessoa , Endereco_idEndereco) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE Funcionario (
idFuncionario INT NOT NULL AUTO_INCREMENT,
funcao VARCHAR(45) NOT NULL,
pin_acesso INT NOT NULL,
Pessoa_idPessoa INT NOT NULL,
PRIMARY KEY (idFuncionario, Pessoa_idPessoa),
UNIQUE INDEX idFuncionario_UNIQUE (idFuncionario ASC) VISIBLE,
INDEX fk_Funcionario_Pessoa1_idx (Pessoa_idPessoa ASC) VISIBLE,
CONSTRAINT fk_Funcionario_Pessoa1 FOREIGN KEY (Pessoa_idPessoa) REFERENCES Pessoa (idPessoa) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE Empresa (
idEmpresa INT NOT NULL AUTO_INCREMENT,
nome_fantasia VARCHAR(50) NOT NULL,
razao_social VARCHAR(45) NOT NULL,
slogan VARCHAR(45) NULL,
contato INT NOT NULL,
cnpj INT NOT NULL,
Endereco_idEndereco INT NOT NULL,
PRIMARY KEY (idEmpresa, Endereco_idEndereco),
UNIQUE INDEX cnpj_UNIQUE (cnpj ASC) VISIBLE,
INDEX fk_Empresa_Endereco1_idx (Endereco_idEndereco ASC) VISIBLE,
CONSTRAINT fk_Empresa_Endereco1 FOREIGN KEY (Endereco_idEndereco) REFERENCES Endereco (idEndereco) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE Empresa_Dono (
idEmpresa_Dono INT NOT NULL AUTO_INCREMENT,
Dono_idDono INT NOT NULL,
Dono_Pessoa_idPessoa INT NOT NULL,
Dono_Pessoa_Endereco_idEndereco INT NOT NULL,
Empresa_idEmpresa INT NOT NULL,
Empresa_Endereco_idEndereco INT NOT NULL,
PRIMARY KEY (idEmpresa_Dono, Dono_idDono, Dono_Pessoa_idPessoa, Dono_Pessoa_Endereco_idEndereco, Empresa_idEmpresa, Empresa_Endereco_idEndereco),
UNIQUE INDEX idEmpresa_Dono_UNIQUE (idEmpresa_Dono ASC) VISIBLE,
INDEX fk_Empresa_Dono_Dono1_idx (Dono_idDono ASC, Dono_Pessoa_idPessoa ASC, Dono_Pessoa_Endereco_idEndereco ASC) VISIBLE,
INDEX fk_Empresa_Dono_Empresa1_idx (Empresa_idEmpresa ASC, Empresa_Endereco_idEndereco ASC) VISIBLE,
CONSTRAINT fk_Empresa_Dono_Dono1 FOREIGN KEY (Dono_idDono , Dono_Pessoa_idPessoa , Dono_Pessoa_Endereco_idEndereco) REFERENCES Dono (idDono , Pessoa_idPessoa , Pessoa_Endereco_idEndereco)
ON DELETE NO ACTION ON UPDATE NO ACTION,
CONSTRAINT fk_Empresa_Dono_Empresa1 FOREIGN KEY (Empresa_idEmpresa , Empresa_Endereco_idEndereco) REFERENCES Empresa (idEmpresa , Endereco_idEndereco) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE Categoria (
idCategoria INT NOT NULL,
nome_categoria VARCHAR(50) NOT NULL,
ordenacao INT NOT NULL AUTO_INCREMENT,
descricao VARCHAR(45) NULL,
PRIMARY KEY (idCategoria),
UNIQUE INDEX idCategoria_UNIQUE (idCategoria ASC) VISIBLE,
UNIQUE INDEX nome_categoria_UNIQUE (nome_categoria ASC) VISIBLE,
UNIQUE INDEX ordenacao_UNIQUE (ordenacao ASC) VISIBLE
);

CREATE TABLE Estoque (
idEstoque INT NOT NULL,
quant_min INT NOT NULL,
quant_max INT NOT NULL,
quant_atual INT NOT NULL,
PRIMARY KEY (idEstoque)
);

CREATE TABLE Compra (
idCompra INT NOT NULL AUTO_INCREMENT,
preco_compra FLOAT NOT NULL,
fornecedor VARCHAR(45) NULL,
data_compra DATE NOT NULL,
quantidade INT NOT NULL,
valor_total FLOAT NOT NULL,
Produto_idProduto INT NOT NULL,
Produto_Categoria_idCategoria INT NOT NULL,
Produto_Estoque_idEstoque INT NOT NULL,
PRIMARY KEY (idCompra, Produto_idProduto, Produto_Categoria_idCategoria, Produto_Estoque_idEstoque),
UNIQUE INDEX idCompra_UNIQUE (idCompra ASC) VISIBLE,
INDEX fk_Compra_Produto1_idx (Produto_idProduto ASC, Produto_Categoria_idCategoria ASC, Produto_Estoque_idEstoque ASC) VISIBLE,
CONSTRAINT fk_Compra_Produto1 FOREIGN KEY (Produto_idProduto , Produto_Categoria_idCategoria , Produto_Estoque_idEstoque) REFERENCES Produto (idProduto, Categoria_idCategoria , Estoque_idEstoque)
ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE Produto (
idProduto INT NOT NULL AUTO_INCREMENT,
nome_produto VARCHAR(45) NOT NULL,
detalhes VARCHAR(100) NULL,
tipo VARCHAR(45) NOT NULL,
unidade_medida VARCHAR(45) NOT NULL,
preco_venda FLOAT NOT NULL,
setor_preparo VARCHAR(45) NULL,
preco_custo FLOAT NULL,
Categoria_idCategoria INT NOT NULL,
Estoque_idEstoque INT NOT NULL,
PRIMARY KEY (idProduto, Categoria_idCategoria, Estoque_idEstoque),
UNIQUE INDEX idProduto_UNIQUE (idProduto ASC) VISIBLE,
UNIQUE INDEX nome_produto_UNIQUE (nome_produto ASC) VISIBLE,
INDEX fk_Produto_Categoria1_idx (Categoria_idCategoria ASC) VISIBLE,
INDEX fk_Produto_Estoque1_idx (Estoque_idEstoque ASC) VISIBLE,
CONSTRAINT fk_Produto_Categoria1 FOREIGN KEY (Categoria_idCategoria) REFERENCES Categoria (idCategoria) ON DELETE NO ACTION ON UPDATE NO ACTION,
CONSTRAINT fk_Produto_Estoque1 FOREIGN KEY (Estoque_idEstoque) REFERENCES Estoque (idEstoque) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE Taxa (
idTaxa INT NOT NULL AUTO_INCREMENT,
tipo_taxa VARCHAR(45) NOT NULL,
valor_porcentagem INT NOT NULL,
periodo TIME NULL,
PRIMARY KEY (idTaxa),
UNIQUE INDEX idTaxa_UNIQUE (idTaxa ASC) VISIBLE
);

CREATE TABLE Venda (
idVenda INT NOT NULL AUTO_INCREMENT,
data_venda DATE NOT NULL,
valor_taxa INT NOT NULL,
valor_produtos INT NOT NULL,
total_taxa INT NOT NULL,
Cliente_idCliente INT NOT NULL,
Cliente_Pessoa_Endereco_idEndereco INT NOT NULL,
Funcionario_idFuncionario INT NOT NULL,
Taxa_idTaxa INT NOT NULL,
PRIMARY KEY (idVenda, Cliente_idCliente, Cliente_Pessoa_Endereco_idEndereco, Funcionario_idFuncionario, Taxa_idTaxa),
UNIQUE INDEX idVenda_UNIQUE (idVenda ASC) VISIBLE,
INDEX fk_Venda_Cliente1_idx (Cliente_idCliente ASC, Cliente_Pessoa_Endereco_idEndereco ASC) VISIBLE,
INDEX fk_Venda_Funcionario1_idx (Funcionario_idFuncionario ASC) VISIBLE,
INDEX fk_Venda_Taxa1_idx (Taxa_idTaxa ASC) VISIBLE,
CONSTRAINT fk_Venda_Cliente1 FOREIGN KEY (Cliente_idCliente , Cliente_Pessoa_Endereco_idEndereco) REFERENCES Cliente (idCliente , Pessoa_Endereco_idEndereco) ON DELETE NO ACTION ON UPDATE NO ACTION,
CONSTRAINT fk_Venda_Funcionario1 FOREIGN KEY (Funcionario_idFuncionario) REFERENCES Funcionario (idFuncionario) ON DELETE NO ACTION ON UPDATE NO ACTION,
CONSTRAINT fk_Venda_Taxa1 FOREIGN KEY (Taxa_idTaxa) REFERENCES Taxa (idTaxa) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE Venda_has_Produto (
Venda_idVenda INT NOT NULL,
Venda_Cliente_idCliente INT NOT NULL,
Venda_Cliente_Pessoa_Endereco_idEndereco INT NOT NULL,
Venda_Funcionario_idFuncionario INT NOT NULL,
Venda_Taxa_idTaxa INT NOT NULL,
Produto_idProduto INT NOT NULL,
Produto_Categoria_idCategoria INT NOT NULL,
Produto_Estoque_idEstoque INT NOT NULL,
PRIMARY KEY (Venda_idVenda, Venda_Cliente_idCliente, Venda_Cliente_Pessoa_Endereco_idEndereco, Venda_Funcionario_idFuncionario, Venda_Taxa_idTaxa,
Produto_idProduto, Produto_Categoria_idCategoria, Produto_Estoque_idEstoque),
INDEX fk_Venda_has_Produto_Produto1_idx (Produto_idProduto ASC, Produto_Categoria_idCategoria ASC, Produto_Estoque_idEstoque ASC) VISIBLE,
INDEX fk_Venda_has_Produto_Venda1_idx (Venda_idVenda ASC, Venda_Cliente_idCliente ASC, Venda_Cliente_Pessoa_Endereco_idEndereco ASC, Venda_Funcionario_idFuncionario ASC, Venda_Taxa_idTaxa ASC) VISIBLE,
CONSTRAINT fk_Venda_has_Produto_Venda1 FOREIGN KEY (Venda_idVenda, Venda_Cliente_idCliente, Venda_Cliente_Pessoa_Endereco_idEndereco, Venda_Funcionario_idFuncionario , Venda_Taxa_idTaxa)
REFERENCES Venda (idVenda, Cliente_idCliente, Cliente_Pessoa_Endereco_idEndereco, Funcionario_idFuncionario, Taxa_idTaxa) ON DELETE NO ACTION ON UPDATE NO ACTION,
CONSTRAINT fk_Venda_has_Produto_Produto1 FOREIGN KEY (Produto_idProduto, Produto_Categoria_idCategoria, Produto_Estoque_idEstoque)
REFERENCES Produto (idProduto, Categoria_idCategoria, Estoque_idEstoque) ON DELETE NO ACTION ON UPDATE NO ACTION
);
