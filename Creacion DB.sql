CREATE DATABASE IF NOT EXISTS la_musleria;

USE la_musleria;

CREATE TABLE IF NOT EXISTS establecimiento (
nombre_establecimiento VARCHAR (20) NOT NULL PRIMARY KEY,
direccion_establecimiento VARCHAR(100) NOT NULL,
contacto_establecimiento VARCHAR(100) NOT NULL,
concepto_establecimiento VARCHAR(150) NOT NULL,
imagen_establecimiento VARCHAR(100) DEFAULT 'imagen-generica.jpg'
);

CREATE TABLE IF NOT EXISTS personal (
id_personal INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
nombre_personal VARCHAR (50) NOT NULL,
contacto_personal VARCHAR (100) NOT NULL,
puesto_personal VARCHAR(20) NOT NULL,
sueldo_personal INT NOT NULL,
antiguedad_personal TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP()
);

CREATE TABLE IF NOT EXISTS proveedor (
id_proveedor INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
nombre_proveedor VARCHAR (50) NOT NULL,
contacto_proveedor VARCHAR (150) NOT NULL,
tipo_de_pago_proveedor INT NOT NULL,
producto_proveedor VARCHAR (50) NOT NULL
);

CREATE TABLE IF NOT EXISTS factura(
id_factura INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
total_factura INT NOT NULL,
rfc_factura VARCHAR (15) NOT NULL,
fecha_factura TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP()
);

CREATE TABLE IF NOT EXISTS venta(
id_venta INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
platillo_venta VARCHAR (15) NOT NULL,
cantidad_venta  INT NOT NULL,
sub_total_venta INT NOT NULL
);

CREATE TABLE IF NOT EXISTS stock(
id_stock INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
cantidad_stock  INT NOT NULL
);

CREATE TABLE IF NOT EXISTS inventario(
id_inventario INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
cantidad_inventario  INT NOT NULL
);

CREATE TABLE IF NOT EXISTS menu(
id_menu INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
platillo_menu VARCHAR(20) NOT NULL,
costo_menu INT NOT NULL,
promocion_menu VARCHAR(50) NOT NULL,
ganacia_menu INT NOT NULL
);

CREATE TABLE IF NOT EXISTS ingredientes(
id_ingredientes INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
platillo_ingredientes VARCHAR(20) NOT NULL,
nombre_ingredientes VARCHAR(25) NOT NULL,
cantidad_ingredientes VARCHAR(20) NOT NULL,
proveedor_ingredientes VARCHAR(25) NOT NULL,
costo_proveedor_ingredientes INT NOT NULL
);

CREATE TABLE IF NOT EXISTS nuevo_cliente(
id_nuevo_cliente INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nombre_nuevo_cliente VARCHAR(40) NOT NULL,
plato_ordenado_nuevo_cliente VARCHAR(40) NOT NULL,
correo_nuevo_cliente VARCHAR(40) NOT NULL
);

CREATE TABLE IF NOT EXISTS frecuente_cliente (
id_frecuente_cliente  INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nombre_frecuente_cliente  VARCHAR(40) NOT NULL,
plato_ordenado_frecuente_cliente  VARCHAR(40) NOT NULL,
correo_frecuente_cliente  VARCHAR(40) NOT NULL,
registro_visitas_frecuente_cliente  INT NOT NULL 
);

CREATE TABLE IF NOT EXISTS club_frecuente_cliente(
id_club_frecuente_cliente INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nombre_club_frecuente_cliente VARCHAR(40) NOT NULL,
plato_ordenado_club_frecuente_cliente VARCHAR(40) NOT NULL,
correo_club_frecuente_cliente VARCHAR(40) NOT NULL,
registro_visitas_club_frecuente_cliente INT NOT NULL,
beneficio_club_frecuente_cliente VARCHAR(40) NOT NULL
);

CREATE TABLE IF NOT EXISTS cliente(
tipo_de_cliente  INT NOT NULL PRIMARY KEY,
nuevo_cliente INT NOT NULL,
frecuente_cliente INT NOT NULL,
club_frecuente_cliente INT NOT NULL,
FOREIGN KEY (nuevo_cliente)
	REFERENCES nuevo_cliente (id_nuevo_cliente)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
FOREIGN KEY (frecuente_cliente)
	REFERENCES frecuente_cliente  (id_frecuente_cliente)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
FOREIGN KEY (club_frecuente_cliente)
	REFERENCES club_frecuente_cliente (id_club_frecuente_cliente)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- VISTAS--
CREATE OR REPLACE VIEW personal_sin_suledos AS
SELECT id_personal, nombre_personal, puesto_personal 
FROM personal;

CREATE OR REPLACE VIEW provedor_pago_efectivo AS
SELECT id_proveedor, nombre_proveedor, contacto_proveedor, tipo_de_pago_proveedor
FROM proveedor
WHERE tipo_de_pago_proveedor = 1;

CREATE OR REPLACE VIEW platillos_con_mayor_ganancia AS
SELECT platillo_menu, costo_menu, ganacia_menu
FROM menu
WHERE ganacia_menu >= 100;

CREATE OR REPLACE VIEW cliente_con_mas_visitas AS
SELECT nombre_club_frecuente_cliente, registro_visitas_club_frecuente_cliente
FROM club_frecuente_cliente
HAVING max(registro_visitas_club_frecuente_cliente);

CREATE OR REPLACE VIEW facturas_a_deducir AS
SELECT id_factura, total_factura, rfc_factura
FROM factura
WHERE total_factura >= 1000;
# En estas vistas como su nombres los describen es para que los empleados de el negocio puedan ver informacion de la bd sin informacion confidencila o sensible para muchos de ellos;

-- FUNCTIONS --
--  Esta funcion fue para con solo poner el id de los productos arroje que platillo es que se esta ordenando--
USE `la_musleria`;
DROP function IF EXISTS `la_musleria`.`platillo_menu`;
;

DELIMITER $$
USE `la_musleria`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `platillo_menu`(menu_id int) RETURNS varchar(30) CHARSET utf8mb4
    READS SQL DATA
BEGIN
DECLARE nombre VARCHAR(30);
SET nombre = (SELECT platillo_menu FROM menu WHERE id_menu = menu_id);
RETURN nombre;
END$$

DELIMITER ;
;

--  Esta funcion es para obtenr el IVA de la venta iva_menu--

USE `la_musleria`;
DROP function IF EXISTS `la_musleria`.`iva_meu`;
;

DELIMITER $$
USE `la_musleria`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `iva_meu`(monto DECIMAL) RETURNS decimal(9,2)
    DETERMINISTIC
BEGIN

    DECLARE total, iva DECIMAL(9,2);
    
    SET total = 0.00;
    SET iva = 1.15;
    
    SELECT monto * iva INTO total;
    
    RETURN total;

END$$

DELIMITER ;
;

-- STORED PROCEDURES --


USE `la_musleria`;
DROP procedure IF EXISTS `la_musleria`.`insert_new_clientE`;
;

DELIMITER $$
USE `la_musleria`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_new_clientE`(
IN nombre_nuevo_cliente VARCHAR(50),
IN plato_ordenado_nuevo_cliente VARCHAR(30), 
IN correo_nuevo_cliente VARCHAR(50))
BEGIN
INSERT INTO nuevo_cliente(nombre_nuevo_cliente, plato_ordenado_nuevo_cliente, correo_nuevo_cliente) 
VALUES ( 
nombre_nuevo_cliente,
plato_ordenado_nuevo_cliente,
correo_nuevo_cliente);
END$$

DELIMITER ;
;


USE `la_musleria`;
DROP procedure IF EXISTS `la_musleria`.`sp_ordeN`;
;

DELIMITER $$
USE `la_musleria`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ordeN`(IN field VARCHAR(20), IN orden BOOLEAN)
BEGIN
IF orden = TRUE THEN
	SET @mayor = 'ASC';
ELSE 
     SET @mayor = 'DESC';
 END IF;    
 SET @consulta = CONCAT('SELECT * FROM menu ORDER BY',' ',field,' ',@mayor);
 
 PREPARE mi_cons FROM @consulta;
 EXECUTE mi_cons;
 DEALLOCATE PREPARE mi_cons;
END$$

DELIMITER ;
;

USE `la_musleria`;
DROP procedure IF EXISTS `la_musleria`.`sp_ordeN`;
;

DELIMITER $$
USE `la_musleria`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ordeN`(IN field VARCHAR(20), IN orden BOOLEAN)
BEGIN
IF orden = TRUE THEN
	SET @mayor = 'ASC';
ELSE 
     SET @mayor = 'DESC';
 END IF;    
 SET @consulta = CONCAT('SELECT * FROM menu ORDER BY',' ',field,' ',@mayor);
 
 PREPARE mi_cons FROM @consulta;
 EXECUTE mi_cons;
 DEALLOCATE PREPARE mi_cons;
END$$

DELIMITER ;
;

-- En este triger estamos agregando un nuevo proveedor con sus datos de contacto y pues como se solicto se pone el registro de hora usuario y version de esta manera saber cuando se
-- se dio de alta y por quien se dio

CREATE TRIGGER `tr_add_new_proveedor` AFTER INSERT ON `proveedor` FOR EACH ROW BEGIN
	insert into `la_musleria`.`new_proveedor`(id_proveedor, nombre_proveedor, contacto_proveedor, producto_proveedor, usuario, registro, db, version)
    values (new.id_proveedor, new.nombre_proveedor, new.contacto_proveedor, new.producto_proveedor, user(), current_timestamp(), database(), version())
END $$

DELIMITER ;
;
create table new_proveedor(
	id_proveedor int primary key,
    nombre_proveedor varchar(100),
    contacto_proveedor varchar(100),
    producto_proveedor varchar(100),
    usuario varchar(200),
    registro timestamp,
    db varchar (200),
    version varchar (100)
);

insert into proveedor (id_proveedor, 
nombre_proveedor, contacto_proveedor, tipo_de_pago_proveedor, producto_proveedor)
values (152, 'salsas gonzalez', '8225522445', '1', 'salsas');

