  -- Cria as tabelas se não existirem
  CREATE TABLE IF NOT EXISTS t_Jogador(
  id_jogador INTEGER NOT NULL PRIMARY KEY, 
  id_genero INTEGER NOT NULL, 
  id_fase INTEGER NOT NULL, 
  id_puzzle INTEGER NOT NULL,
  id_puzzle_anterior INTEGER NOT NULL,
  fg_carregar INTEGER NOT NULL DEFAULT(0),
  ini_x FLOAT NOT NULL DEFAULT (0),
  ini_y FLOAT NOT NULL DEFAULT (0),
  ds_idioma VARCHAR (10) NOT NULL
);

  CREATE TABLE IF NOT EXISTS t_Decisao(
    id_decisao INTEGER NOT NULL PRIMARY KEY, 
    ds_decisao VARCHAR(30) NOT NULL, 
    id_puzzle INTEGER NOT NULL, 
    ds_var_name VARCHAR(30) NOT NULL, 
    vlr_dec_1 INTEGER NOT NULL, 
    ds_variavel VARCHAR(30),
    ds_texto VARCHAR (30)
);

  CREATE TABLE IF NOT EXISTS t_Entrada_Dados(
    id_entrada INTEGER NOT NULL PRIMARY KEY, 
    vlr_entrada VARCHAR(30) NOT NULL, 
    id_puzzle INTEGER NOT NULL, 
    ds_entrada VARCHAR(30) NOT NULL, 
    ds_var_name VARCHAR(30) NOT NULL, 
    FOREIGN KEY(id_puzzle) REFERENCES t_Puzzle(id_puzzle)
);

  CREATE TABLE IF NOT EXISTS t_Exibicao(
    id_exibicao INTEGER NOT NULL PRIMARY KEY, 
    ds_exibicao VARCHAR(30) NOT NULL, 
    ds_var_name VARCHAR(30) NOT NULL, 
    id_puzzle INTEGER NOT NULL
);

  CREATE TABLE IF NOT EXISTS t_Fase(
    id_fase INTEGER NOT NULL PRIMARY KEY, 
    id_proxima_fase_V VARCHAR(30) NOT NULL, 
    id_proxima_fase_F VARCHAR(30) NOT NULL, 
    vlr_falso VARCHAR(30) NOT NULL,
    ini_x FLOAT NOT NULL DEFAULT (0),
    ini_y FLOAT NOT NULL DEFAULT (0),
    fg_dialogo INTEGER NOT NULL DEFAULT(0)
);

CREATE TABLE IF NOT EXISTS t_Looping(
    id_looping INTEGER NOT NULL PRIMARY KEY, 
    ds_looping VARCHAR(30) NOT NULL, 
    id_puzzle INTEGER NOT NULL, 
    vlr_inicial INTEGER NOT NULL, 
    vlr_final INTEGER NOT NULL, 
    vlr_incremento INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS t_Operacao(
    id_operacao INTEGER NOT NULL PRIMARY KEY, 
    ds_operacao VARCHAR(30) NOT NULL, 
    id_puzzle INTEGER NOT NULL, 
    ds_var_name VARCHAR (30) NOT NULL, 
    vlr_op_1 INTEGER NOT NULL, 
    ds_variavel VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS t_Puzzle(
    id_puzzle INTEGER NOT NULL PRIMARY KEY, 
    ds_puzzle VARCHAR(30) NOT NULL, 
    id_fase INTEGER NOT NULL, 
    fg_realizado INTEGER NOT NULL DEFAULT(0), 
    fg_liberado INTEGER NOT NULL DEFAULT(0), 
    ds_resultado VARCHAR(20) NOT NULL, 
    res_num INTEGER NOT NULL DEFAULT(0), 
    fg_transicao INTEGER NOT NULL DEFAULT(0),
    ps_x FLOAT NOT NULL DEFAULT (0),
    ps_y FLOAT NOT NULL DEFAULT (0),      
    img_objeto VARCHAR(100) NOT NULL
);

  INSERT OR REPLACE INTO t_Entrada_Dados VALUES (1,0,2,'Batidas no Coco = 0','batidasNoCoco');
  INSERT OR REPLACE INTO t_Entrada_Dados VALUES (2,1,2,'Batidas no Coco = 1','batidasNoCoco');
  INSERT OR REPLACE INTO t_Entrada_Dados VALUES (3,1,3,'Bater = 1','batidasNoCoco');
  INSERT OR REPLACE INTO t_Entrada_Dados VALUES (4,1,4,'Caminho Escolhido = Direita','escolhido');
  INSERT OR REPLACE INTO t_Entrada_Dados VALUES (5,2,4,'Caminho Escolhido = Esquerda','escolhido');
  INSERT OR REPLACE INTO t_Entrada_Dados VALUES (6,1,5,'Recolher = 1','madeiraRecolhida');
  INSERT OR REPLACE INTO t_Entrada_Dados VALUES (7,1,6,'Pegar = 1','pedraRecolhida');
  INSERT OR REPLACE INTO t_Entrada_Dados VALUES (8,1,7,'Bater Pedra = 0','baterPedra');
  INSERT OR REPLACE INTO t_Entrada_Dados VALUES (9,1,7,'Perder Pedras = 1','perderMadeira');
  INSERT OR REPLACE INTO t_Entrada_Dados VALUES (10,1,8,'Subir = 0','subir');

  INSERT OR REPLACE INTO t_Decisao VALUES (1,'==',4,'escolhido',1,'Caminho Escolhido','direita');

  INSERT OR REPLACE INTO t_Exibicao VALUES (1,'Objeto', 'verificarCoco', 1);
  INSERT OR REPLACE INTO t_Exibicao VALUES (2,'Bater', 'baterObjeto', 1);
  INSERT OR REPLACE INTO t_Exibicao VALUES (3,'Soltar', 'soltarObjeto', 1);
  INSERT OR REPLACE INTO t_Exibicao VALUES (4,'Quebrar', 'quebrarObjeto', 1);
  INSERT OR REPLACE INTO t_Exibicao VALUES (5,'Batidas no Coco', 'batidasNoCoco', 2);
  INSERT OR REPLACE INTO t_Exibicao VALUES (6,'Morder Coco', 'morderCoco', 2);
  INSERT OR REPLACE INTO t_Exibicao VALUES (7,'Bater', 'batidasNoCoco', 3);
  INSERT OR REPLACE INTO t_Exibicao VALUES (8,'"Ir Para Direita"', 'direita', 4);
  INSERT OR REPLACE INTO t_Exibicao VALUES (9,'"Ir Para Esquerda"', 'esquerda', 4);
  INSERT OR REPLACE INTO t_Exibicao VALUES (10,'Recolher', 'madeiraRecolhida', 5);
  INSERT OR REPLACE INTO t_Exibicao VALUES (11,'Pegar', 'pedraRecolhida', 6);
  INSERT OR REPLACE INTO t_Exibicao VALUES (12,'Morder Pedras', 'pedraMordida', 6);
  INSERT OR REPLACE INTO t_Exibicao VALUES (13,'Bater Pedra', 'baterPedra', 7);
  INSERT OR REPLACE INTO t_Exibicao VALUES (14,'Subir', 'subir', 8);

  INSERT INTO t_Fase VALUES (1,3,2,'esquerda',1248,958,'true');
  INSERT INTO t_Fase VALUES (2,3,2,1,2750,1100,'true');
  INSERT INTO t_Fase VALUES (3,0,3,1,250,500,'true');
  
  INSERT OR REPLACE INTO t_Looping VALUES (1,'cont',7,1,4,1);
  INSERT OR REPLACE INTO t_Looping VALUES (2,'cont',8,1,9,1);
  
  INSERT OR REPLACE INTO t_Operacao VALUES (1,'-',3,'batidasNoCoco',1,'Bater = Bater');
  INSERT OR REPLACE INTO t_Operacao VALUES (2,'+',3,'batidasNoCoco',2,'Bater = Bater');
  INSERT OR REPLACE INTO t_Operacao VALUES (3,'+',5,'madeiraRecolhida',2,'Pegar = Pegar');
  INSERT OR REPLACE INTO t_Operacao VALUES (4,'+',5,'madeiraRecolhida',2,'Pegar = Pegar');
  INSERT OR REPLACE INTO t_Operacao VALUES (5,'+',6,'pedraRecolhida',2,'Pegar = Pegar');
  INSERT OR REPLACE INTO t_Operacao VALUES (6,'-',6,'pedraRecolhida',1,'Pegar = Pegar');
  INSERT OR REPLACE INTO t_Operacao VALUES (7,'+',7,'baterPedra',1,'Bater Pedra = Bater Pedra');
  INSERT OR REPLACE INTO t_Operacao VALUES (8,'+',8,'subir',1,'Subir = Subir');

  INSERT INTO t_Puzzle VALUES (1,'desafio01VerificarCoco',1,'false','true','verificarCoco','false','false',0.76,0.48,'coco.png');
  INSERT INTO t_Puzzle VALUES (2,'desafio02BaterCoco',1,'false','false',1,'true','false',0.55,0.67,'coco.png');
  INSERT INTO t_Puzzle VALUES (3,'desafio03QuebrarCoco',1,'false','false',3,'true','false',0.75,0.73,'coco.png');
  INSERT INTO t_Puzzle VALUES (4,'desafio04PlacaDireitaOuEsquerda',1,'false','false','direita','false','true',0.62,0.5,'placa.png');
  INSERT INTO t_Puzzle VALUES (5,'desafio05AcharMadeira',2,'false','false',5,'true','false',0.44,0.27,'lenha.png');
  INSERT INTO t_Puzzle VALUES (6,'desafio06AcharPedras',2,'false','false',2,'true','false',0.45,0.75,'pedraAbrasiva.png');
  INSERT INTO t_Puzzle VALUES (7,'desafio07FazerFogueira',2,'false','false',5,'true','true',0.38,0.5,'cinzas.png');
  INSERT INTO t_Puzzle VALUES (8,'desafio08SubirArvore',3,'false','false',10,'true','true',0.97,0.485,'arvoreGrande.png');

  INSERT INTO t_Jogador VALUES (1, 1, 1, 1, 0, 'false', 1248, 958,'pt-br');

COMMIT;