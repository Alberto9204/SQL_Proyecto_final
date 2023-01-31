USE la_musleria;

INSERT INTO establecimiento (nombre_establecimiento, direccion_establecimiento, contacto_establecimiento, concepto_establecimiento, imagen_establecimiento) VALUES
('La musleria', 'Paseo de Leones no.205 col.cumbres', '811-588-2167', 'Cocina fusion', 'imagen_logo.jpg');

INSERT INTO personal (id_personal, nombre_personal, contacto_personal, puesto_personal, sueldo_personal) VALUES
('1', 'Frida Corona', '8155226699', 'Gerente General', 15000),
('2', 'Alberto Garza', '8155448877', 'Dueño', 20000),
('3', 'Alma Ayala', '8146948877', 'Jefe de cocina', 12000),
('4', 'Abril Ayala', '8155447877', 'Cocinera', 8000),
('5', 'Rolando Guerrero', '8155478877', 'Mesero', 5000),
('6', 'Hugo Alfaro', '8196127877', 'Mesero', 5000);

INSERT INTO proveedor (id_proveedor, nombre_proveedor, contacto_proveedor, tipo_de_pago_proveedor, producto_proveedor) VALUES
(1, 'Los pollos hermanos', '7894561230', 1 , 'Muslos de pollo'),
(2, 'Verdura del Campo', '1236547899', 2, 'verduras'),
(3, 'Desechable Lopes', '6543219877', 1, 'insumos'),
(4, 'Aderezos buffalo', '7893214560', 1 , 'Salsas y condiemntos'),
(5, 'coca-cola', '5487213698', 2, 'refrescos'),
(6, 'Cerveceria Cuauhtemoc ', '1236547899', 1, 'cerveza'),
(7, 'Materias primas Rodriguez', '2486159723', 2, 'Materias primas');

INSERT INTO factura (id_factura, total_factura, rfc_factura) values
(1, 563.85, 'GAAA9204191L3'),
(2, 123.25, 'HGSF870312A72'),
(3, 785.24, 'TENS7511041LU'),
(4, 4521.70, 'YUJN890514ETF'),
(5, 5632.36, 'CVGD0010155HE');

INSERT INTO venta(id_venta, platillo_venta, cantidad_venta, sub_total_venta) VALUES
(1, 'MUSLOS, HAMBURGUESA HIDALGO', '250.26', '230.24'),
(2, 'HAMBURGUESA JOYA, HAMBURGUESA HIDALGO', '260.23', '240.24'),
(3, 'MUSLOS', '120.26', '100.24'),
(4, 'MUSLOS, MUSLOS, HAMBURGUESA CALLEJERA', '420.35', '380.24'),
(5, 'HAMBURGUESA HIDALGO, HAMBURGUESA HIDALGO', '260.26', '245.24'),
(6, 'MUSLOS, HAMBURGUESA JOYA, PAY DE MANAZANA', '385.26', '350.24'),
(7, 'MUSLOS, HAMBURGUESA HIDALGO', '250.26', '230.24');

INSERT INTO inventario (id_inventario, cantidad_inventario) VALUES
(1, 56),
(2, 54),
(3, 32),
(4, 14),
(5, 36),
(6, 85),
(7, 74),
(8, 14),
(9, 60),
(10, 12);

INSERT INTO menu (id_menu, platillo_menu, costo_menu, promocion_menu, ganacia_menu) VALUES
(1, 'MUSLOS', '100', 1, '80'),
(2, 'HAMBURGUESA HIDALGO', '140', 0, '100'),
(3, 'HAMBURGUESA JOYA', '120', 0, '90'),
(4, 'HAMBURGUESA CALLEJERA', '120', 0, '90'),
(5, 'COSTILLAS BBQ', '190', 1, '150'),
(6, 'ESPARAGOS CON TOCINO', '70', 0, '40'),
(7, 'PICAÑA', '165', 0, '135'),
(8, 'PAY DE MANZANA', '65', 0, '45'),
(9, 'CERVEZA', '40', 1, '25'),
(10, 'REFRESCO', '30', 1, '15');

INSERT INTO ingredientes(id_ingredientes, platillo_ingredientes, nombre_ingredientes, cantidad_ingredientes, proveedor_ingredientes, costo_proveedor_ingredientes) VALUES
(1, '1,3', 'MUSLOS', '6pzs', '1', '70KG'),
(2, '2,3,4', 'PAN', '2pzs', '7', '5PZ'),
(3, '2,5', 'COSTILLA', '6pzs', '1', '160KG'),
(4, '1,2,3,4,5,6,7', 'VERDURA', 2, '2', 'NULL'),
(5, '1,2,3,4,5,6', 'SALSAS', 1, '4', '50U'),
(6, '1,2,3,4,5,6,7', 'CARNE', 1, '2', '160KG');

INSERT INTO nuevo_cliente(id_nuevo_cliente, nombre_nuevo_cliente, plato_ordenado_nuevo_cliente, correo_nuevo_cliente) VALUES
(1, 'Ruben Martinez', 'Muslos', 'Ruben_Martinez@gmail.com'),
(2, 'Leo Messi', 'Picaña', 'Leo_Messi@gmail.com'),
(3, 'Javier Hernandez', 'Hamburguesa Hidalgo', 'Javier_Hernandez@gmail.com'),
(4, 'Hugo Sanchez', 'Costillas bbq', 'Hugo_Sanchezz@gmail.com');

INSERT INTO frecuente_cliente(id_frecuente_cliente, nombre_frecuente_cliente, plato_ordenado_frecuente_cliente, correo_frecuente_cliente, registro_visitas_frecuente_cliente) VALUES
(1, 'Miguel Herrera', 'muslos', 'miguel_herrera@gmail.com', 5),
(2, 'chuky Lozano', 'Hamburguesa Hidalgo', 'chuky_Lozano@gmail.com', 7),
(3, 'guillermo ochoa', 'Costillas BBQ', 'guillermo_ochoa@gmail.com', 9);

INSERT INTO club_frecuente_cliente (id_club_frecuente_cliente, nombre_club_frecuente_cliente, plato_ordenado_club_frecuente_cliente, correo_club_frecuente_cliente, registro_visitas_club_frecuente_cliente, beneficio_club_frecuente_cliente) VALUES
(1, 'Fabian Garza', 'Hamburguesa Hidalgo', 'Fabian_Garza@gmail.com', 11, '10%'),
(2, 'Joel Jauregui', 'Muslos', 'Joel_Jauregui@gmail.com', 20, '20%'),
(3, 'Vicente Armando', 'Hamburguesa joya', 'Vicente_Armando@gmail.com', 25, 'Refreso gratis');