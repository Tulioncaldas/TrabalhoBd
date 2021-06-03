CREATE database ATIVIDADE4;

delimiter $$
create trigger tri_vendas_ai
after insert on comivenda
for each row
begin
	## declaração de variáveis:	
    close busca_itens;
    
    SET vtotal_item = NEW.n_valoivenda * NEW.n_qtdeivenda;
    
	UPDATE comvenda SET n_totavenda = valor_total_dos_itens - valor_total_do_item
	WHERE n_numero_de_vendas = new.n_numero_de_vendas;
end$$
delimiter ;clare valor_total_dos_itens float(10,2) DEFAULT 0;
	declare valor_total_do_item float(10,2) DEFAULT 0;
	declare total_item float(10,2);
    DECLARE qtd_item INT DEFAULT 0;
    DECLARE fimloop INT DEFAULT 0;
    
	## cursor para buscar os itens já registrados da venda
	declare busca_itens cursor for
		select n_valoivenda, n_qtdeivenda
		from comivenda
		where n_numero_de_vendas = new.n_numero_de_vendas;
    
	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET fimloop = 1;
    
	## abro o cursor
	open busca_itens;
		## declaro e inicio o loop
		itens : loop
            
			IF fimloop = 1 THEN
				LEAVE itens;
			END IF;
        
			fetch busca_itens into total_item, qtd_item;
			
			## somo o valor total dos itens (produtos)
			SET valor_total_do_item = total_item * qtd_item;
			set valor_total_dos_itens = valor_total_dos_itens + valor_total_do_item;
            
		end loop itens;
CLOSE busca_itens;
    SET valor_total_do_item = NEW.n_valoivenda * NEW.n_qtdeivenda;
	UPDATE comvenda SET n_totavenda = valor_total_dos_itens - valor_total_do_item
	WHERE n_numero_de_vendas = NEW.n_numero_de_vendas;
END$$
DELIMITER ;
