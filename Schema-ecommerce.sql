-- criação do banco de dados
create database ecommerce;
use ecommerce;

-- criar tabela cliente
create table clients(
		idClient int auto_increment primary key,
        Complete_Name varchar(50),
        CPF char(11) not null,
        identification enum('PF', 'PJ') not null,
        Address varchar(255),
        constraint unique_cpf_client unique (CPF)
);

alter table clients auto_increment=1;
-- desc clients;

-- criar tabela produto
create table product(
		idProduct int auto_increment primary key,
        Pname varchar(255) not null,
        category varchar(30) not null,
        Pdescription varchar(255),
        avaliation float default 0
);

alter table product auto_increment=1;
-- desc product;

-- para ser continuado no desafio: termine de implementar a tabela e crie a conexão com as tabelas necessárias
-- além disso, reflita essa modificação no diagrama de esquema relacional
-- criar constraints relacionadas ao pagamento

create table payments(
	idclient int,
    idPayment int,
    typePayment enum('Boleto','Cartão de crédito') default 'Boleto',
    limitAvailable float,
    primary key(idClient, idPayment),
    constraint fk_payments_client foreign key (idclient) references clients(idClient)
			on update cascade
);

-- desc payments;

-- criar tabela pedido
-- drop table orders;

create table orders(
	idOrder int auto_increment primary key,
    idOrderClient int,
    idPayment int,
    orderStatus enum('Cancelado','Confirmado','Em processamento') default 'Em processamento',
    orderDescription varchar(255),
    order_value float not null,
    sendValue float default 0,
	constraint fk_orders_payment foreign key (idOrderClient, idPayment) references payments(idClient, idPayment)
			on update cascade
);

-- desc orders;

-- criar tabela estoque
create table productStorage(
	idProdStorage int auto_increment primary key,
    storageLocation varchar(255),
    quantity int default 0
);
alter table productStorage auto_increment=1;


-- criar tabela entrega
create table Delivery(
	idDelivery int primary key,
    Order_id int,
    Order_client_id int,
    Delivery_status ENUM("Em processamento", "Pedido recebido", "Em rota", "Entregue") default 'Em processamento',
    Delivery_adress varchar(255) not null,
    Delivery_forecast varchar(10) not null,
	constraint fk_Delivery_Order_id foreign key (Order_id) references Orders(idOrder)
			on update cascade,
	constraint fk_Delivery_Order_client_id foreign key (Order_client_id) references clients(idClient)
			on update cascade
);

alter table Delivery auto_increment=1;
-- desc Delivery;

-- criar tabela fornecedor
create table supplier(
	idSupplier int auto_increment primary key,
    SocialName varchar(255) not null,
    CNPJ char(15) not null,
    contact char(11) not null,
    constraint unique_supplier unique (CNPJ)
);
alter table supplier auto_increment=1;
-- desc supplier;

-- tabelas de relacionamentos M:N

create table productOrder(
	idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum('Disponível', 'Sem estoque') default 'Disponível',
    primary key (idPOproduct, idPOorder),
    constraint fk_productorder_product foreign key (idPOproduct) references product(idProduct),
    constraint fk_productorder_order foreign key (idPOorder) references orders(idOrder)

);

create table storageLocation(
	idLproduct int,
    idLstorage int,
    location varchar(255) not null,
    primary key (idLproduct, idLstorage),
    constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
    constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProdStorage)
);

create table productSupplier(
	idPsSupplier int,
    idPsProduct int,
    quantity int not null,
    primary key (idPsSupplier, idPsProduct),
    constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
    constraint fk_product_supplier_prodcut foreign key (idPsProduct) references product(idProduct)
);

-- desc productSupplier;

show tables;

show databases;
use information_schema;
show tables;
desc referential_constraints;
select * from referential_constraints where constraint_schema = 'ecommerce';