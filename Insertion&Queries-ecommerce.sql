-- inserção de dados e queries
use ecommerce;

show tables;
-- idClient, Complete_Name, CPF, identification, Address
insert into clients (Complete_Name, CPF, identification, Address) 
	   values('Maria M Silva', 12346789, 'PF', 'rua silva de prata 29, Carangola - Cidade das flores'),
		     ('Matheus O Pimentel', 987654321, 'PF', 'rua alemeda 289, Centro - Cidade das flores'),
			 ('Ricardo F Silva', 45678913, 'PF', 'avenida alemeda vinha 1009, Centro - Cidade das flores'),
			 ('Julia S França', 789123456, 'PF', 'rua lareijras 861, Centro - Cidade das flores'),
			 ('Roberta G Assis', 98745631, 'PF', 'avenidade koller 19, Centro - Cidade das flores'),
			 ('Isabela M Cruz', 654789123, 'PF', 'rua alemeda das flores 28, Centro - Cidade das flores');
			 
-- idProduct, Pname, category, Pdescription, avaliação
insert into product (Pname, category, Pdescription, avaliation) values
							  ('Fone de ouvido','Eletrônico', 'Preto, sem fio, new generation','4'),
                              ('Barbie Elsa','Brinquedos','15cm, com falas, filme frozen','3'),
                              ('Body Carters','Vestimenta', null,'5'),
                              ('Microfone Vedo - Youtuber','Eletrônico','Ótima captação de áudio','4'),
                              ('Sofá retrátil','Móveis', 'Cor: Marrom, 3 lugares','3'),
                              ('Farinha de arroz','Alimentos', '500g','2'),
                              ('Fire Stick Amazon','Eletrônico','Alexa integrada','3');

insert into payments (idclient, idPayment, typePayment, limitAvailable) values
							(1,11,'Boleto', null),
                            (2,12,'Cartão de crédito',5000),
                            (3,13,'Boleto', null),
                            (4,14,'Cartão de crédito',2500);

insert into orders (idOrderClient, idPayment, orderStatus, orderDescription, order_value, sendValue) values 
							 (1,11,default,'compra via aplicativo',199.99,0),
                             (2,12,default,'compra via aplicativo',50,0),
                             (3,13,'Confirmado',null,49.90,30),
                             (4,14,default,'compra via web site',150,14.99);

insert into productOrder (idPOproduct, idPOorder, poQuantity, poStatus) values
						 (1,1,2,null),
                         (2,2,1,null),
                         (3,4,1,null);

-- storageLocation,quantity
insert into productStorage (storageLocation,quantity) values 
							('Rio de Janeiro',1000),
                            ('Rio de Janeiro',500),
                            ('São Paulo',10),
                            ('São Paulo',100),
                            ('São Paulo',10),
                            ('Brasília',60);

-- idLproduct, idLstorage, location
insert into storageLocation (idLproduct, idLstorage, location) values
						 (1,2,'RJ'),
                         (2,6,'GO');

-- idSupplier, SocialName, CNPJ, contact
insert into supplier (SocialName, CNPJ, contact) values 
							('Almeida e filhos', 123456789123456,'21985474'),
                            ('Eletrônicos Silva',854519649143457,'21985484'),
                            ('Eletrônicos Valma', 934567893934695,'21975474');
                            
-- idPsSupplier, idPsProduct, quantity
insert into productSupplier (idPsSupplier, idPsProduct, quantity) values
						 (1,1,500),
                         (1,2,400),
                         (2,4,633),
                         (3,3,5),
                         (2,5,10);

insert into delivery (idDelivery, Order_id, Order_client_id, Delivery_status, Delivery_adress, Delivery_forecast) values
					(21, 1, 1, 'Em processamento', 'rua silva de prata 29, Carangola - Cidade das flores', '7 dias'),
                    (22, 2, 2, 'Em rota','rua alemeda 289, Centro - Cidade das flores', '10 horas'),
                    (23, 3, 3, 'Entregue','avenida alemeda vinha 1009, Centro - Cidade das flores', '14 dias'),
                    (24, 4, 4, 'Em rota','rua lareijras 861, Centro - Cidade das flores', '9 dias');

-- Queries baseadas no BD criado e povoado

-- Quais e quantos produtos que cada cliente comprou?
select distinct Complete_Name, Pname as Product_name, poQuantity as Quantity 
from product join productOrder on idPOProduct
join orders on idOrder=idPOorder
join clients on idClient = idOrderClient;

-- Qual o tipo de pagamento de cada cliente?
select Complete_Name, typePayment, limitAvailable from clients natural join payments;

-- Quais os fretes, status e tempo de entrega para cada client?
select idClient, sendValue, Delivery_status, Delivery_forecast from clients, Delivery, orders 
		where Order_client_id=idClient and Order_id=idOrder;
        
-- Qual categoria de produto teve mais vendas e qual foi o valor total?
select category, round(SUM(order_value),2) from product, orders, productOrder 
where idProduct= idPOproduct and idOrder=idPOorder;  
