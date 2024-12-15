create table clientes (
    id serial primary key,
    nome varchar(120),
    cidade varchar(120),
    email varchar(120) unique
)
insert into clientes(nome, cidade, email)
values('Tiago', 'imbituba', 'tiago@email.com'),
    ('João', 'Santos', 'joao@email.com'),
    ('Eduardo', 'Minas', 'eduardo@email.com'),
    (
        'Priscila',
        'RIO DE JANEIRO',
        'priscila@email.com'
    ),
    ('Davi', 'RIO DE JANEIRO', 'Davi@email.com')
select *
from clientes
ALTER TABLE produtos
ALTER COLUMN preco TYPE decimal(10, 3) USING ROUND(preco, 3);
create table produtos(
    id serial primary key,
    nome varchar (120) not null,
    preco decimal(10, 3) not null
)
select *
from produtos
INSERT INTO produtos (nome, preco)
VALUES ('Playstation3', 1500.00),
    ('Playstation PSP', 900.00),
    ('Xbox series X', 5000.00),
    ('Playstation 5', 6500.00),
    ('Nintendo Wii', 2000.00);
create table pedidos (
    id serial primary key,
    cliente_id int references clientes(id),
    data date
)
select *
from pedidos
insert into pedidos(cliente_id, data)
values(1, '2024-12-10'),
    (2, '2024-12-15'),
    (3, '2024-12-14'),
    (4, '2024-12-22'),
    (5, '2024-12-18') create table itens_pedidos(
        id serial primary key,
        pedido_id int references pedidos(id),
        produto_id int references produtos(id),
        quantidade int,
        valor_total decimal(10, 3)
    )
select *
from itens_pedidos
ALTER TABLE itens_pedidos
ALTER COLUMN valor_total TYPE decimal(10, 3) USING ROUND(valor_total, 3);
insert into itens_pedidos (produto_id, pedido_id, quantidade, valor_total)
values (1, 1, 2, 3000),
    (2, 1, 1, 900),
    (3, 2, 2, 10000),
    (4, 3, 1, 6500),
    (5, 4, 2, 4000)
select clientes.id as id_do_clientes,
    clientes.nome,
    clientes.email,
    pedidos.id as id_do_pedido,
    pedidos.data as data_do_pedido
from clientes
    left join pedidos on pedidos.cliente_id = clientes.id
select pedidos.id,
    produtos.nome,
    produtos.preco,
    sum(itens_pedidos.quantidade) as quantidade,
    sum(itens_pedidos.valor_total) as valor_total
from pedidos
    join itens_pedidos on pedidos.id = itens_pedidos.pedido_id
    join produtos on itens_pedidos.produto_id = produtos.id
group by pedidos.id,
    produtos.nome,
    produtos.preco
select pedidos.id,
    sum(itens_pedidos.valor_total)
from pedidos
    join itens_pedidos on pedidos.id = itens_pedidos.pedido_id
group by pedidos.id
select pedidos.id as pedido_id,
    produtos.nome as produto_nome,
    sum(itens_pedidos.valor_total) as total_pedido
from pedidos
    join itens_pedidos on pedidos.id = itens_pedidos.pedido_id
    join produtos on itens_pedidos.produto_id = produtos.id
group by pedidos.id,
    produtos.nome;