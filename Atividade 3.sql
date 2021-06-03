/*PROJETO DE BANCO DE DADOS - ATIVIDADE 3*/


USE aula5;

delimiter $$

create Function InserirAluno (cod_curso integer
,data_de_nascimento DATE
,credito_total varchar(30)
,mgp DOUBLE
,nome_do_aluno VARCHAR (60)
,email VARCHAR (30))

returns varchar (60);
BEGIN
Declare novato VARCHAR (60);
SET novato = INSERT INTO aluno(cod_curso
,dat4_de_nascimento 
,credito_total 
,mgp 
,nome_do_aluno 
,email) VALUES ();
RETURN novato;
END$$

SELECT inserirAluno (3,'2002-10-19',100,10,'P','P@gmail.com');