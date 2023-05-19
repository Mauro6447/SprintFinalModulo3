-- Se procede a crear el usuario y sus prtivilegios
CREATE USER 'mauro'@'localhost' IDENTIFIED BY 'sprint3';
GRANT ALL PRIVILEGES ON * . * TO 'mauro'@'localhost';
FLUSH PRIVILEGES;
SHOW GRANTS FOR 'mauro'@'localhost'; -- aqui mostramos los privilegios de mauro
create database sprint3 DEFAULT CHARACTER SET utf8mb4;   -- creamos la base de datos del Sprint
use sprint3; -- utilizamos la base de datos Sprint3


-- Creamos la primera tabla, proveedores

CREATE TABLE proveedores(
	id_proveedor varchar(15) not null primary key unique,     
	nombre_representante_legal varchar(50) not null,
	nombre_corporativo varchar(50) not null,
	telefono_de_contacto_1 varchar(15) not null,
	telefono_de_contacto_2 varchar(15) not null,
	nombre_recepcionista varchar(50) not null,
	categoria_de_productos varchar(50) not null,
	email_facturas varchar(50) not null
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
    
    -- Creamos nuestra tabla productos
    
CREATE TABLE productos (
    SKU VARCHAR(20) primary key unique not null,
    nombre VARCHAR(74) not null,
    categoria_de_productos VARCHAR(50) not null,
    stock INT not null,
    precio INT not null,
    color varchar(10) not null
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
  
  
-- Creamos una tabla intermedia entre la relación m:n de productos y proveedores

CREATE TABLE  proveedores_has_productos (
  `proveedores_id_proveedor` VARCHAR(15) NOT NULL,
  `productos_SKU` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`proveedores_id_proveedor`, `productos_SKU`),
  INDEX `fk_proveedores_has_productos_productos1_idx` (`productos_SKU` ASC) VISIBLE,
  INDEX `fk_proveedores_has_productos_proveedores1_idx` (`proveedores_id_proveedor` ASC) VISIBLE,
  CONSTRAINT `fk_proveedores_has_productos_proveedores1`
    FOREIGN KEY (`proveedores_id_proveedor`)
    REFERENCES `sprint3`.`proveedores` (`id_proveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_proveedores_has_productos_productos1`
    FOREIGN KEY (`productos_SKU`)
    REFERENCES `sprint3`.`productos` (`SKU`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;
  
-- Creamos la tabla clientes

CREATE TABLE clientes(
id_cliente varchar(25) unique not null primary key,
nombre varchar(50) not null,
apellido varchar(50) not null,
direccion varchar(70) not null
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Creamos tabla ventas

CREATE TABLE pedidos(
id_pedido int primary key auto_increment,
SKU VARCHAR(20) unique not null, 
id_clientes varchar(25)unique not null, 
valor int not null,
foreign key (SKU) references productos(sku),
foreign key(id_clientes) references clientes(id_cliente)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Ingresasmos los datos a la tabla clientes

INSERT INTO clientes VALUES ('16038575-8','Carolina Del Carmen','Reyes Sanhueza','BORODIN 01491 DEPTO 45, Puente Alto'),
	('15694122-0','Christian Manuel',' Núñez Corrales','CORDILLERA DE LA COSTA 3980, Peñaflor'),
	('16069456-4','Claudio Antonio','Araya Collarte','SANTA RAQUEL 3416 BLOCK10 DPTO12, La Florida'),
	('13864421-9','Cristian Andrés','Caballero Caballero','AV AMERICO VESPUCIO 0940 DEPTO 11, La Granja'),
	('26466659-7','Franklin David','Fuentes Lopez','CALLE IGNACIO ECHEVERRÍA 7203, La Cisterna');
    
-- Ingresamos los datos a la tabla proveedores

INSERT INTO proveedores VALUES (
     '18232782-4','Jeronimo Garcia','Tecnoglobal S.A.',224469535,224469536,'Pamela Diaz','computacion','fluffy@verizon.net'),
	('16468799-6','Estefania Gimenez','Sparta S.A.',2225551624,2225551625,'Alfridexis Vallle','deportes','fraterk@me.com'),
	('26929717-4','Guillermo Perez','Pollack S.A.',552487331,552487332,'Sandra Seura','ropa hombre','animats@mac.com'),
	('17997943-8','Eliana Soriano','Italmod Ltda.',2225564051,2225564052,'Yasna Hidalgo','ropa mujer','tbeck@icloud.com'),
	('16468397-4','Jose Gutierrez','Hisense Corp.',228953263,228953264,'Charles Zheng','linea blanca','mallanmba@yahoo.ca');
    
-- Ingresamos los datos a la tabla productos

INSERT INTO productos VALUES
	('NIKE-AIR-NE-38','Zapatillas de entrenamiento negras modelo Air Force de Nike de la talla 38','deportes',10,35000,'NegrO'),
	('CONV-02-38','Zapatillas Converse blancas talla 38','deportes',15,25000,'Blanco'),
	('673Z3LT#ABM','HP 240 G8 Ci5-1135G7 W11P 8G 256 SSD','computacion',4,750000,'Negro'),
	('9TG18','NBK Gamer 5520 I7-12700H 8GB 512GBSSD W11H RTX3050','computacion',4,1200000,'Carbon'),
	('849119001','Polerón Cuello Redondo Con Capucha Hombre The King''s Polo Club','ropa hombre',50,20000,'Azul'),
	('902960001','Chaqueta Denim Cuello Camisero Hombre Rolly Go','ropa hombre',20,35000,'Beigue'),
	('900575001','Parka Aplicación En Cierres Cuello Alto Capucha Con Sherpa Mujer Geeps','ropa mujer',15,44000,'Negro'),
	('896708001','Blusa Mujer Lesage','ropa mujer',60,10000,'Blanco'),
	('878205001','Refrigerador Side By Side Hisense RC-56WS / No Frost / 428 Litros / A+','linea blanca',15,550000,'Plata'),
	('6Q0N4LA#ABM','HP Zbook Power G9, Ci9-12900H,RTXA1000','computacion',25,20000,'Plata');
    
INSERT INTO pedidos VALUES 
	(1,'NIKE-AIR-NE-38','16038575-8',35000),
	(2,'673Z3LT#ABM','13864421-9',750000),
	(3,'6Q0N4LA#ABM','16069456-4',20000);

    
-- Cuál es la categoría de productos que  más se repite.

select categoria_de_productos, count(*) total
 from productos   
 group by categoria_de_productos
 order by count(*) desc limit 1;
 
 -- La categoria que mas se repite es : computacion
 
 -- Cuáles son los productos con mayor  stock

select nombre, stock from productos
where stock = (select max(stock) from productos);

-- el producto con mayor stock es : Blusa Mujer Lesage, 60 unidades


-- Qué color de producto es más común en nuestra tienda.

select color, count(*) total from productos
group by color
order by count(*) desc limit 1;

-- el color es negro.


-- Cual o cuales son los proveedores con menor stock de productos. 



-- El proveedor con menos productos en stock seria : 18.232.782-4

select * from proveedores where id_proveedor = "18232782-4";

-- Su nombre corporativo seria : Tecnoglobal S.A.


-- Cambien la categoría de productos más popular por ‘Electrónica y computación’.

select nombre, stock, categoria_de_productos from productos where stock = (select max(stock) from productos);

-- El producto con mas stock es : Blusa Mujer Lesage con  60 unidades de la categoria : ropa mujer

-- Procedemos a cambiar de categoria el producto

select * from productos where nombre = 'Blusa Mujer Lesage';
update productos set categoria_de_productos = "Electrónica y computación" where nombre = 'Blusa Mujer Lesage';

-- Se realizo el cambio de categoria para el producto con exito


-- Grupo Sala 7 : Ignacio Ulloa, Mauro Boccardo, Roberto Rivas







                  

