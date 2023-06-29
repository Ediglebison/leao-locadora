-- CreateTable
CREATE TABLE "Login" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "email" TEXT NOT NULL,
    "senha" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Usuario" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "nome" TEXT NOT NULL,
    "cpf" TEXT NOT NULL,
    "contato" TEXT NOT NULL,
    "idEndereco" TEXT NOT NULL,
    "funcao" TEXT NOT NULL,
    "userEmail" TEXT NOT NULL,
    CONSTRAINT "Usuario_userEmail_fkey" FOREIGN KEY ("userEmail") REFERENCES "Login" ("email") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Usuario_idEndereco_fkey" FOREIGN KEY ("idEndereco") REFERENCES "Endereco" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Usuario_funcao_fkey" FOREIGN KEY ("funcao") REFERENCES "Funcao" ("cargo") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Endereco" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "logradouro" TEXT NOT NULL,
    "complemento" TEXT NOT NULL,
    "numero" TEXT NOT NULL,
    "bairro" TEXT NOT NULL,
    "cidade" TEXT NOT NULL,
    "cep" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Funcao" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "cargo" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Cliente" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "nome" TEXT NOT NULL,
    "cpf" TEXT NOT NULL,
    "contato" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "idEndereco" TEXT NOT NULL,
    "numeroCNH" TEXT NOT NULL,
    "categoriaCNH" TEXT NOT NULL,
    "emissaoCNH" DATETIME NOT NULL,
    CONSTRAINT "Cliente_idEndereco_fkey" FOREIGN KEY ("idEndereco") REFERENCES "Endereco" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Carro" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "modelo" TEXT NOT NULL,
    "marca" TEXT NOT NULL,
    "ano" TEXT NOT NULL,
    "placa" TEXT NOT NULL,
    "chassi" TEXT NOT NULL,
    "idTipoCarro" TEXT NOT NULL,
    "idStatus" TEXT NOT NULL,
    CONSTRAINT "Carro_idTipoCarro_fkey" FOREIGN KEY ("idTipoCarro") REFERENCES "TipoCarro" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Carro_idStatus_fkey" FOREIGN KEY ("idStatus") REFERENCES "StatusCarro" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Locacao" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "data" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "idCarro" TEXT NOT NULL,
    "idCliente" TEXT NOT NULL,
    "idUsuario" TEXT NOT NULL,
    "entregar" DATETIME NOT NULL,
    "seguro" BOOLEAN NOT NULL,
    "valor" REAL NOT NULL,
    "idOpPagamento" TEXT NOT NULL,
    CONSTRAINT "Locacao_idCarro_fkey" FOREIGN KEY ("idCarro") REFERENCES "Carro" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Locacao_idCliente_fkey" FOREIGN KEY ("idCliente") REFERENCES "Cliente" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Locacao_idUsuario_fkey" FOREIGN KEY ("idUsuario") REFERENCES "Usuario" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Locacao_idOpPagamento_fkey" FOREIGN KEY ("idOpPagamento") REFERENCES "OpPagamento" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Devolucao" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "data" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "quilomeragem" REAL NOT NULL,
    "idCarro" TEXT NOT NULL,
    "idCliente" TEXT NOT NULL,
    "idUsuario" TEXT NOT NULL,
    "idLocacao" TEXT NOT NULL,
    "idOpPagamento" TEXT NOT NULL,
    CONSTRAINT "Devolucao_idLocacao_fkey" FOREIGN KEY ("idLocacao") REFERENCES "Locacao" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Devolucao_idCarro_fkey" FOREIGN KEY ("idCarro") REFERENCES "Carro" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Devolucao_idCliente_fkey" FOREIGN KEY ("idCliente") REFERENCES "Cliente" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Devolucao_idUsuario_fkey" FOREIGN KEY ("idUsuario") REFERENCES "Usuario" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Devolucao_idOpPagamento_fkey" FOREIGN KEY ("idOpPagamento") REFERENCES "OpPagamento" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "OpPagamento" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "descricao" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Danos" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "descricao" TEXT NOT NULL,
    "pecas" TEXT NOT NULL,
    "valor" REAL NOT NULL,
    "imagem" TEXT NOT NULL,
    "idDevolucao" TEXT NOT NULL,
    CONSTRAINT "Danos_idDevolucao_fkey" FOREIGN KEY ("idDevolucao") REFERENCES "Devolucao" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Taxas" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "tanqueCheio" BOOLEAN NOT NULL,
    "lavado" BOOLEAN NOT NULL,
    "valor" REAL NOT NULL,
    "idDevolucao" TEXT NOT NULL,
    CONSTRAINT "Taxas_idDevolucao_fkey" FOREIGN KEY ("idDevolucao") REFERENCES "Devolucao" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "StatusCarro" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "descricao" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "TipoCarro" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "descricao" TEXT NOT NULL,
    "valor" REAL NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "Login_email_key" ON "Login"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Usuario_cpf_key" ON "Usuario"("cpf");

-- CreateIndex
CREATE UNIQUE INDEX "Usuario_userEmail_key" ON "Usuario"("userEmail");

-- CreateIndex
CREATE UNIQUE INDEX "Funcao_cargo_key" ON "Funcao"("cargo");

-- CreateIndex
CREATE UNIQUE INDEX "Cliente_cpf_key" ON "Cliente"("cpf");

-- CreateIndex
CREATE UNIQUE INDEX "Cliente_email_key" ON "Cliente"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Devolucao_idLocacao_key" ON "Devolucao"("idLocacao");
