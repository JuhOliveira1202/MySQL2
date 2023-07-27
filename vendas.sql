create database vendas;
use vendas;

create table Cliente(
				idcliente int auto_increment primary key,
                nome varchar(50),
                cidade varchar(50),
                codpostal varchar(8),
                cc int);
                
create table Artigo(
				idartigo int auto_increment primary key,
                nome varchar(50),
                preco decimal(18,2),
                categoria varchar(50));
                
create table Venda(
				idvenda int auto_increment primary key,
                cliente int,
                foreign key(cliente) references Cliente(idcliente),
                datav datetime,
                desconto decimal(5,2));
                
create table LinhaVenda(
				venda int,
                foreign key(venda) references Venda(idvenda),
                artigo int,
                foreign key(artigo) references Artigo(idartigo),
                quantidade int);
#alter table LinhaVenda modify column venda int not null;
#alter table LinhaVenda modify column artigo int not null;
#alter table LinhaVenda add primary key(venda,artigo);
		
insert into Cliente(nome, cidade, codpostal,cc) values 
				('Juliana','Vale de Cambra','3730-080','123456789'),
                ('Maria','Oliveira de Azemeis','3730-050','987654321'),
                ('Joaquim','Arouca','3730-789','135792468');
                
select * from Cliente;

insert into Artigo(nome, preco, categoria) values
				('Telemóvel','200.00','SmartPhone'),
                ('Camisa','20.00','Vestuário'),
                ('Calças','30.00','Vestuário');

select * from Artigo;

insert into Venda(cliente, datav, desconto) values 
				('2','2023-02-23','10.00'),
                ('3','2023-01-23','50.00'),
                ('1','2023-02-12','60.00');
select * from Venda;

insert into LinhaVenda(venda, artigo, quantidade) values 
				('5','1','1'),
                ('4','3','2'),
                ('6','2','6');
select * from LinhaVenda;

alter table Cliente add datanasc date; #alterar uma tabela que já existe
update Cliente set datanasc = '2001-02-12' where idcliente = '1'; #vai acrescentar o dado ao id 1

select * from Cliente where cidade = 'Vale de Cambra' and (year(now()) - year(datanasc)) >=18;

select categoria, count(nome) from Artigo group by categoria; #vai agrupar quantos artigos por categoria

select cliente, datav from Venda; #vai mostrar o id do cliente e a data em que comprou 

select nome, datav from Venda, Cliente; #igual ao comando de cima só que em vez de aparecer o id apareve os nomes só que x3

select nome, datav from Venda, Cliente where cliente.idcliente = venda.cliente; #igual ao comando de cima só que aparece unicamente 3x, já não aparece como o anterior

select nome, datav from Venda v, Cliente c where c.idcliente = v.cliente; #exatamento o comando de cima, só que simplificado

select c.nome, datav, a.nome from Venda v, Cliente c, Artigo a, LinhaVenda l where 
			c.idcliente = v.cliente and #mostra apenas o nome do cliente e a data de venda
            l.venda = v.idvenda and #para acrescentar a categoria ao código anterior
			l.artigo = a.idartigo; #resume quem, quando e que artigo, comprou 

select nome from Artigo where nome = 'M%'; #quais os artigos começados por M

select nome, datav from Venda v, Cliente c where  #quais os clientes que compraram hoje
			datav = '2023-02-23' and #ou datav=now()
            c.idcliente = v.cliente; 
            
select nome, datav from Venda v, Cliente c where		#qual o nome do último cliente que fez compras
			c.idcliente = v.cliente order by datav desc 
            limit 1;
            
select nome from Cliente where idcliente NOT IN (select Cliente from Venda); #quais os clientes que nunca compraram nada




