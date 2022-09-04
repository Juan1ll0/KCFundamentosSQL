/* Creación de un schema para el usuario Juan Ignacio Fernández Díez (jifernandez) */
create schema jifernandez;

/* Creación de modelo */
/* Grupos: Guarda el nombre del grupo de empresas */
create table if not exists jifernandez.grupos (
	grupo_id int not null,
	nombre varchar(50) not null
);

alter table jifernandez.grupos
	add constraint grupos_pk 
	primary key (grupo_id);


/* Combustibles: Tipo de combustible, gasolina, diesel, hibrido...etc */
create table if not exists jifernandez.combustibles (
	combustible_id int not null,
	nombre varchar(50) not null,
	descripcion varchar(1024)
);

alter table jifernandez.combustibles
	add constraint combustibles_pk
	primary key (combustible_id);


/* Colores: Tabla destinada a almacenar los colores disponibles */
create table if not exists jifernandez.colores (
	color_id int not null,
	nombre varchar(50) not null,
	metalizado bool default false
);

alter table jifernandez.colores
	add constraint colores_pk
	primary key (color_id);


/* Aseguradoras: Tabla destinada a almacenar las aseguradoras de vehículos contratadas */
create table if not exists jifernandez.aseguradoras (
	aseguradora_id int not null,
	nombre varchar(50) not null,
	telefono varchar(13) not null,
	direccion varchar(256),
	codigo_postal varchar(5),
	ciudad varchar(32),
	pais varchar(32)
);

alter table jifernandez.aseguradoras
	add constraint aseguradora_pk
	primary key (aseguradora_id);


/* Divisas: Tabla para guardar los tipos de monedas */
create table if not exists jifernandez.divisas (
	divisa_id int not null,
	nombre varchar(50) not null,
	simbolo char(2) not null,
	abreviatura varchar(5) not null
);

alter table jifernandez.divisas
	add constraint divisas_pk
	primary key (divisa_id);


/* Marcas: Tabla destinada al almacenamiento de las marcas. 
 * Foreign keys:
 * 		grupo_id: Referencia al grupo
 */
create table if not exists jifernandez.marcas (
	marca_id int not null,
	grupo_id int not null,
	nombre varchar(50) not null
);

alter table jifernandez.marcas
	add constraint marcas_pk
	primary key (marca_id);

alter table jifernandez.marcas
	add constraint marcas_grupo_fk
	foreign key (grupo_id) references jifernandez.grupos(grupo_id);


/* Modelos: Tabla destinada a guardar los modelos de coches.
 * Foreign keys:
 * 		marca_id: Referencia a una marca.
 * 		combustible_id: Referencia a un combustible
 */
create table if not exists jifernandez.modelos (
	modelo_id int not null,
	marca_id int not null,
	combustible_id int not null,
	nombre varchar(50) not null,
	potencia int not null
);

alter table jifernandez.modelos
	add constraint modelos_pk
	primary key (modelo_id);

alter table jifernandez.modelos
	add constraint modelos_marca_fk
	foreign key (marca_id) references jifernandez.marcas (marca_id);

alter table jifernandez.modelos
	add constraint modelos_combustible_fk
	foreign key (combustible_id) references jifernandez.combustibles (combustible_id);


/* Coches: Tabla destinada a guardar los coches disponibles
 * Foreign keys:
 * 		marca_id: Referencia a una marca
 * 		modelo_id: Referencia a un modelo
 * 		color_id: Referencia a un color
 * 		aseguradora_id: Referencia a una aseguradora
 */
create table if not exists jifernandez.coches (
	matricula varchar(8) not null,
	modelo_id int not null,
	color_id int not null,
	aseguradora_id int not null,
	kilometros int not null,
	poliza varchar(50) not null,
	fecha_compra date
);

alter table jifernandez.coches
	add constraint coches_pk
	primary key (matricula);

alter table jifernandez.coches
	add constraint coches_modelo_fk
	foreign key (modelo_id) references jifernandez.modelos (modelo_id);

alter table jifernandez.coches
	add constraint coches_colores_fk
	foreign key (color_id) references jifernandez.colores (color_id);

alter table jifernandez.coches
	add constraint coches_aseguradora_fk
	foreign key (aseguradora_id) references jifernandez.aseguradoras (aseguradora_id);


/* Revisiones: Tabla para guardar el historico de revisiones
 * Primary key:
 * 		matricula_id + fecha: Compuesta para guardar el histórico de revisiones
 * Foreign keys:
 * 		matricula_id: Refrencia a coches
 * 		divisa_id: refrencia a divisas
 */
create table if not exists jifernandez.revisiones(
	matricula varchar(8) not null,
	fecha date not null,
	divisa_id int not null,	
	importe numeric(4,2) not null,
	kilometros int not null
);

alter table jifernandez.revisiones
	add constraint revisiones_pk
	primary key (matricula, fecha);

alter table jifernandez.revisiones
	add constraint revisiones_divisa_fk
	foreign key (divisa_id) references jifernandez.divisas (divisa_id);


/* Carga de datos */
/* Grupos */
insert into jifernandez.grupos (grupo_id, nombre) values(1, 'PSA');
insert into jifernandez.grupos (grupo_id, nombre) values(2, 'FCA');
insert into jifernandez.grupos (grupo_id, nombre) values(3, 'Volkswagen');
insert into jifernandez.grupos (grupo_id, nombre) values(4, 'Toyota Motor Corporation');
insert into jifernandez.grupos (grupo_id, nombre) values(5, 'Alianza Renault-Nissan-Mitsubishi');
insert into jifernandez.grupos (grupo_id, nombre) values(6, 'General Motors');
insert into jifernandez.grupos (grupo_id, nombre) values(7, 'Geely');
insert into jifernandez.grupos (grupo_id, nombre) values(8, 'BMW');
insert into jifernandez.grupos (grupo_id, nombre) values(9, 'Tata');
insert into jifernandez.grupos (grupo_id, nombre) values(10, 'Hyundai Motor Company');
insert into jifernandez.grupos (grupo_id, nombre) values(11, 'Ford');
insert into jifernandez.grupos (grupo_id, nombre) values(12, 'Daimler');
insert into jifernandez.grupos (grupo_id, nombre) values(13, 'Honda');
insert into jifernandez.grupos (grupo_id, nombre) values(14, 'Tesla Inc');
insert into jifernandez.grupos (grupo_id, nombre) values(15, 'Mahindra');
insert into jifernandez.grupos (grupo_id, nombre) values(16, 'Ferrari');
insert into jifernandez.grupos (grupo_id, nombre) values(17, 'Subaru');
insert into jifernandez.grupos (grupo_id, nombre) values(18, 'Mazda');
	

/* Marcas */
/* PSA */
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(1, 1, 'Citroen');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(2, 1, 'DS');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(3, 1, 'Opel');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(4, 1, 'Peugeot');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(5, 1, 'Vauxhall');

/* FCA */
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(6, 2, 'Abarth');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(7, 2, 'Alfa Romeo');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(8, 2, 'Chrysler');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(9, 2, 'Dodge');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(10, 2, 'Fiat');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(11, 2, 'Jeep');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(12, 2, 'Lancia');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(13, 2, 'Maserati');

/* Volkswagen */
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(14, 3, 'Audi');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(15, 3, 'Bentley');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(16, 3, 'Buggati');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(17, 3, 'Lamborghini');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(18, 3, 'Porche');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(19, 3, 'Seat');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(20, 3, 'Cupra');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(21, 3, 'Skoda');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(22, 3, 'Volkswagen');

/* Toyota */
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(23, 4, 'Daihatsu');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(24, 4, 'Denso');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(25, 4, 'Hino');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(26, 4, 'Lexus');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(27, 4, 'Toyota');

/* Renault */
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(28, 5, 'Alpine');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(29, 5, 'Dacia');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(30, 5, 'Datsun');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(31, 5, 'Infiniti');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(32, 5, 'Lada');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(33, 5, 'Mitsubishi');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(34, 5, 'Nissan');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(35, 5, 'Renault');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(36, 5, 'Samsung');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(37, 5, 'Venuncia');

/* Genral motors */
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(38, 6, 'Baohuin');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(39, 6, 'Buick');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(40, 6, 'Cadillac');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(41, 6, 'Chevrolet');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(42, 6, 'Holden');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(43, 6, 'Wuling Motors');

/* Geely */
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(44, 7, 'Geely');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(45, 7, 'London Taxi C.');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(46, 7, 'Lotus');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(47, 7, 'Lynk&Co');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(48, 7, 'Proton');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(49, 7, 'Volvo');


/* BMW */
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(50, 8, 'BMW');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(51, 8, 'Mini');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(52, 8, 'Rolls-Royce');

/* Tata */
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(53, 9, 'Jaguar');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(54, 9, 'Land Rover');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(55, 9, 'Tata Motors');

/* Hyunday */
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(56, 10, 'Hyundai');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(57, 10, 'Genesis');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(58, 10, 'Kia');

/* Ford */
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(59, 11, 'Ford');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(60, 11, 'Lincoln M.');

/* Daimler */
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(61, 12, 'Mercedes-Benz');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(62, 12, 'Smart');

/* Hondar */
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(63, 13, 'Honda');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(64, 13, 'Acura');

/* Tesla */
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(65, 14, 'Tesla');

/* Mahindra */
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(66, 15, 'SsangYong');
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(67, 15, 'Pininfarina');

/* Ferrari */
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(68, 16, 'Ferrari');

/* Subaru */
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(69, 17, 'Subaru');

/* Mazda */
insert into jifernandez.marcas(marca_id, grupo_id, nombre) values(70, 18, 'Mazda');


/* Combustibles */
insert into jifernandez.combustibles(combustible_id, nombre, descripcion) values(1, 'Gasolina 95', 'Gasolina de 95 octanos. Derivado del petroleo');
insert into jifernandez.combustibles(combustible_id, nombre, descripcion) values(2, 'Gasolina 98', 'Gasolina de 98 octanos. Derivado del petroleo');
insert into jifernandez.combustibles(combustible_id, nombre, descripcion) values(3, 'Diésel', 'Diesel. Derivado del petroleo');
insert into jifernandez.combustibles(combustible_id, nombre, descripcion) values(4, 'Eléctrico', 'Utiliza la energía electrica almacenada en baterias');
insert into jifernandez.combustibles(combustible_id, nombre, descripcion) values(5, 'Híbrido', 'Utilizan gasolina y tienen un motor eléctrico.');
insert into jifernandez.combustibles(combustible_id, nombre, descripcion) values(6, 'Híbrido enchufable', 'Utilizan gasolina y tienen un motor eléctrico que se puede cargar a través de un enchufe');
insert into jifernandez.combustibles(combustible_id, nombre, descripcion) values(7, 'GLP', 'Utilizan gas licuado');
insert into jifernandez.combustibles(combustible_id, nombre, descripcion) values(8, 'GNC', 'Utilizan gas natural.');
insert into jifernandez.combustibles(combustible_id, nombre, descripcion) values(9, 'Hidrógeno', 'Utilizan una pila de hidrógeno.');

/* Colores */
insert into jifernandez.colores(color_id, nombre, metalizado) values (1, 'Rojo', false);
insert into jifernandez.colores(color_id, nombre, metalizado) values (2, 'Rojo', true);
insert into jifernandez.colores(color_id, nombre, metalizado) values (3, 'Azúl', false);
insert into jifernandez.colores(color_id, nombre, metalizado) values (4, 'Azúl oscuro', true);
insert into jifernandez.colores(color_id, nombre, metalizado) values (5, 'Verde', false);
insert into jifernandez.colores(color_id, nombre, metalizado) values (6, 'Verde Oliva', true);
insert into jifernandez.colores(color_id, nombre, metalizado) values (7, 'Amarillo', false);
insert into jifernandez.colores(color_id, nombre, metalizado) values (8, 'Blanco', false);
insert into jifernandez.colores(color_id, nombre, metalizado) values (9, 'Blanco perla', true);
insert into jifernandez.colores(color_id, nombre, metalizado) values (10, 'Negro', false);
insert into jifernandez.colores(color_id, nombre, metalizado) values (11, 'Negro mate', false);
insert into jifernandez.colores(color_id, nombre, metalizado) values (12, 'Negro', true);
insert into jifernandez.colores(color_id, nombre, metalizado) values (13, 'Rosa', false);
insert into jifernandez.colores(color_id, nombre, metalizado) values (14, 'Morado', true);
insert into jifernandez.colores(color_id, nombre, metalizado) values (15, 'Gris', false);
insert into jifernandez.colores(color_id, nombre, metalizado) values (16, 'Gris platino', true);
insert into jifernandez.colores(color_id, nombre, metalizado) values (17, 'Beige', false);
insert into jifernandez.colores(color_id, nombre, metalizado) values (18, 'Plata', true);
insert into jifernandez.colores(color_id, nombre, metalizado) values (19, 'Dorado', true);

/* Aseguradoras */
insert into jifernandez.aseguradoras (aseguradora_id, nombre, telefono, direccion, codigo_postal, ciudad, pais)
	values(1, 'Allianz', '917862215', 'Calle Alcalá, 79, 1º', '28093', 'Madrid', 'España');
insert into jifernandez.aseguradoras (aseguradora_id, nombre, telefono, direccion, codigo_postal, ciudad, pais)
	values(2, 'Axa', '919208712', 'Calle Fuencarral, 9', '28071', 'Madrid', 'España');
insert into jifernandez.aseguradoras (aseguradora_id, nombre, telefono, direccion, codigo_postal, ciudad, pais)
	values(3, 'Balumba', '913319090', 'Paseo de la Castellana, 190, 5º', '28063', 'Madrid', 'España');
insert into jifernandez.aseguradoras (aseguradora_id, nombre, telefono, direccion, codigo_postal, ciudad, pais)
	values(4, 'Generali', '927888890', 'Avenida la Diagonal , 380, 2º', '08090', 'Barcelona', 'España');
insert into jifernandez.aseguradoras (aseguradora_id, nombre, telefono, direccion, codigo_postal, ciudad, pais)
	values(5, 'Fiatc Seguros', '910909090', 'Gran vía, 23, 1º', '28883', 'Madrid', 'España');
insert into jifernandez.aseguradoras (aseguradora_id, nombre, telefono, direccion, codigo_postal, ciudad, pais)
	values(6, 'Direct Seguros', '934090401', 'Calle Alcalá, 290', '28091', 'Madrid', 'España');
insert into jifernandez.aseguradoras (aseguradora_id, nombre, telefono, direccion, codigo_postal, ciudad, pais)
	values(7, 'Catalana Occidente Seguros', '924001010', 'Sagrada Familia, 20', '08003', 'Barcelona', 'España');
insert into jifernandez.aseguradoras (aseguradora_id, nombre, telefono, direccion, codigo_postal, ciudad, pais)
	values(8, 'Génesis', '940101010', 'Calle Madrid, 40, 3º-A', '52090', 'Toledo', 'España');
insert into jifernandez.aseguradoras (aseguradora_id, nombre, telefono, direccion, codigo_postal, ciudad, pais)
	values(9, 'Línea Directa', '910202020', 'Calle Bravo Murillo, 190, 5º', '28040', 'Madrid', 'España');
insert into jifernandez.aseguradoras (aseguradora_id, nombre, telefono, direccion, codigo_postal, ciudad, pais)
	values(10, 'Mapfre', '913787878', 'Calle Alcalá, 40', '28040', 'Madrid', 'España');
insert into jifernandez.aseguradoras (aseguradora_id, nombre, telefono, direccion, codigo_postal, ciudad, pais)
	values(11, 'MMT Seguros', '920555566', 'Avenida Madrid, 79, 1º', '08020', 'Barcelona', 'España');
insert into jifernandez.aseguradoras (aseguradora_id, nombre, telefono, direccion, codigo_postal, ciudad, pais)
	values(12, 'Pelayo', '914040404', 'Sor Angela de la Cruz, 30', '28052', 'Madrid', 'España');
insert into jifernandez.aseguradoras (aseguradora_id, nombre, telefono, direccion, codigo_postal, ciudad, pais)
	values(13, 'Mutua Madrileña', '910303050', 'Paseo de la Castellana, 10', '28193', 'Madrid', 'España');
insert into jifernandez.aseguradoras (aseguradora_id, nombre, telefono, direccion, codigo_postal, ciudad, pais)
	values(14, 'Qualitas Auto', '920010190', 'Avenida Diagonal, 200', '08018', 'Barcelona', 'España');
insert into jifernandez.aseguradoras (aseguradora_id, nombre, telefono, direccion, codigo_postal, ciudad, pais)
	values(15, 'Racc', '918800000', 'Calle Mayor, 90, 6º', '28003', 'Madrid', 'España');
insert into jifernandez.aseguradoras (aseguradora_id, nombre, telefono, direccion, codigo_postal, ciudad, pais)
	values(16, 'Reale Seguros', '923409010', 'La Rambla, 40', '08991', 'Barcelona', 'España');
insert into jifernandez.aseguradoras (aseguradora_id, nombre, telefono, direccion, codigo_postal, ciudad, pais)
	values(17, 'Verti', '920307090', 'Paseo de Gracia, 90, 1º', '08090', 'Barcelona', 'España');
insert into jifernandez.aseguradoras (aseguradora_id, nombre, telefono, direccion, codigo_postal, ciudad, pais)
	values(18, 'Seguros Bilbao', '945001020', 'Gran vía, 80', '48001', 'Bilbao', 'España');
insert into jifernandez.aseguradoras (aseguradora_id, nombre, telefono, direccion, codigo_postal, ciudad, pais)
	values(19, 'Zurich', '910367891', 'Glorieta de Bilbao, 7', '28004', 'Madrid', 'España');
insert into jifernandez.aseguradoras (aseguradora_id, nombre, telefono, direccion, codigo_postal, ciudad, pais)
	values(20, 'Liberti Seguros', '919999990', 'Plaza Cibeles, 2', '28010', 'Madrid', 'España');

/* Divisas */
insert into jifernandez.divisas (divisa_id, nombre, simbolo, abreviatura) values(1, 'Dolar estadounidense', '$', 'USD');
insert into jifernandez.divisas (divisa_id, nombre, simbolo, abreviatura) values(2, 'Euro', '€', 'EUR');
insert into jifernandez.divisas (divisa_id, nombre, simbolo, abreviatura) values(3, 'Yen Japones', '¥', 'JPY');
insert into jifernandez.divisas (divisa_id, nombre, simbolo, abreviatura) values(4, 'Libra esterlina', '£', 'GBP');
insert into jifernandez.divisas (divisa_id, nombre, simbolo, abreviatura) values(5, 'Dolar Australiano', '$', 'AUD');
insert into jifernandez.divisas (divisa_id, nombre, simbolo, abreviatura) values(6, 'Dolar Canadiense', '$', 'CAD');
insert into jifernandez.divisas (divisa_id, nombre, simbolo, abreviatura) values(7, 'Franco Suizo', 'Fr', 'CHF');
insert into jifernandez.divisas (divisa_id, nombre, simbolo, abreviatura) values(8, 'El renminbi chino', '¥', 'CNH');

/* Modelos */
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(1, 6, 2, 'Abarth 595', 145);
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(2, 7, 2, 'Giulietta', 120);
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(3, 65, 4, 'Model y', 500);
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(4, 14, 3, 'A3', 170);
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(5, 14, 4, 'A1', 110);
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(6, 50, 3, 'Serie 1', 128);
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(7, 40, 2, 'ATS', 276);
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(8, 41, 7, 'Aveo', 76);
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(9, 1, 3, 'Berlingo', 123);
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(10, 20, 2, 'Ibiza', 145);
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(11, 2, 2, '4 Crossback', 145);
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(12, 29, 1, 'Duster', 105);
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(13, 29, 6, 'Lodgy', 145);
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(14, 68, 2, 'F8 Tributo', 720);
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(15, 10, 6, '500', 118);
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(16, 10, 6, '500L', 111);
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(17, 59, 2, 'Mustang', 400);
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(18, 59, 8, 'Fiesta', 95);
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(19, 63, 2, 'Civic', 145);
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(20, 63, 2, 'CR-V', 112);
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(21, 56, 5, 'Kona', 87);
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(22, 56, 3, 'Tucson', 245);
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(23, 11, 3, 'Cherokee', 190);
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(24, 63, 8, 'F-Pace',343 );
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(25, 58, 9, 'EV-6', 235);
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(26, 58, 6, 'Rio', 100);
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(27, 12, 2, 'Delta', 165);
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(28, 12, 5, 'Thema', 185);
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(29, 54, 3, 'Discovery', 245);
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(30, 26, 2, 'ES', 165);
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(31, 66, 3, 'Quanto', 148);
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(32, 70, 2, 'CX-30', 127);
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(33, 61, 2, 'AMG GT', 380);
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(34, 61, 5, 'Clase A', 147);
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(35, 51, 7, 'Cabrio', 124);
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(36, 51, 3, '5 Puertas', 113);
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(37, 33, 3, 'Eclipse Cross', 125);
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(38, 34, 2, 'Ariya', 189);
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(39, 35, 4, 'Zoe', 90);
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(40, 3, 2, 'Ampera', 145);
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(41, 3, 7, 'Astra', 93);
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(42, 19, 6, 'León', 135);
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(43, 19, 1, 'Ibiza', 110);
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(44, 66, 2, 'Korando', 155);
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(45, 21, 5, 'Fabia', 165);
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(46, 62, 4, 'ForFour', 130);
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(47, 17, 2, 'Impreza', 150);
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(48, 65, 4, 'Model 3', 135);
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(49, 27, 4, 'Yaris', 78);
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(50, 49, 2, 'V60', 123);
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(51, 6, 2, 'Toureg', 157);
insert into jifernandez.modelos (modelo_id, marca_id, combustible_id, nombre, potencia) values(52, 6, 2, 'Golf', 117);

/* Coches */
insert into jifernandez.coches (matricula, modelo_id, color_id, aseguradora_id, kilometros, poliza, fecha_compra)
	values('2345DDL', 1, 1, 1, 15870, '44562719PZ', '2022-07-15');
insert into jifernandez.coches (matricula, modelo_id, color_id, aseguradora_id, kilometros, poliza, fecha_compra)
	values('1230BBC', 23, 10, 3, 17890, 'Ad5667PZ34', '2020-09-10');
insert into jifernandez.coches (matricula, modelo_id, color_id, aseguradora_id, kilometros, poliza, fecha_compra)
	values('2312JFG', 30, 2, 4, 1900, '456YTZ2719343', '2020-01-18');
insert into jifernandez.coches (matricula, modelo_id, color_id, aseguradora_id, kilometros, poliza, fecha_compra)
	values('7890KKL', 41, 2, 2, 5670, '5564HDS719PZ', '2021-02-15');
insert into jifernandez.coches (matricula, modelo_id, color_id, aseguradora_id, kilometros, poliza, fecha_compra)
	values('5678FGG', 51, 8, 10, 45342, '8734H79SDI', '2020-05-18');
insert into jifernandez.coches (matricula, modelo_id, color_id, aseguradora_id, kilometros, poliza, fecha_compra)
	values('8901DDL', 52, 12, 11, 12098, '90DSJAYELKO', '2022-06-19');
insert into jifernandez.coches (matricula, modelo_id, color_id, aseguradora_id, kilometros, poliza, fecha_compra)
	values('1981SQL', 34, 7, 1, 1280, 'PR7349ZLS00', '2022-03-09');
insert into jifernandez.coches (matricula, modelo_id, color_id, aseguradora_id, kilometros, poliza, fecha_compra)
	values('4501MNH', 33, 14, 20, 30981, '90SDJ7234810', '2019-11-12');
insert into jifernandez.coches (matricula, modelo_id, color_id, aseguradora_id, kilometros, poliza, fecha_compra)
	values('3200FKJ', 12, 12, 1, 69823, '802378SFDS899', '2018-10-25');
insert into jifernandez.coches (matricula, modelo_id, color_id, aseguradora_id, kilometros, poliza, fecha_compra)
	values('1290DYS', 41, 9, 13, 12899, 'PZ239SD92011', '2021-09-09');
insert into jifernandez.coches (matricula, modelo_id, color_id, aseguradora_id, kilometros, poliza, fecha_compra)
	values('5605HHB', 44, 10, 19, 19450, '920129734JZ7236', '2020-10-12');
insert into jifernandez.coches (matricula, modelo_id, color_id, aseguradora_id, kilometros, poliza, fecha_compra)
	values('8070FFJ', 32, 13, 11, 23000, '21329KSD8972134','2021-08-13');
insert into jifernandez.coches (matricula, modelo_id, color_id, aseguradora_id, kilometros, poliza, fecha_compra)
	values('2022HSK', 21, 12, 2, 3246, '328470FS19856', '2022-06-15');
insert into jifernandez.coches (matricula, modelo_id, color_id, aseguradora_id, kilometros, poliza, fecha_compra)
	values('7093NMS', 22, 4, 4, 67091, 'PSRD723U88239', '2017-06-19');
insert into jifernandez.coches (matricula, modelo_id, color_id, aseguradora_id, kilometros, poliza, fecha_compra)
	values('8050FRT', 1, 8, 8, 120890, '324656DSFSDF', '2014-08-10');
insert into jifernandez.coches (matricula, modelo_id, color_id, aseguradora_id, kilometros, poliza, fecha_compra)
	values('6066JJK', 12, 9, 9, 259821, '324325DSGGS', '2012-03-25');
insert into jifernandez.coches (matricula, modelo_id, color_id, aseguradora_id, kilometros, poliza, fecha_compra)
	values('3020RKL', 17, 15, 16, 117089, 'BX2C24234656W42', '2014-04-29');
insert into jifernandez.coches (matricula, modelo_id, color_id, aseguradora_id, kilometros, poliza, fecha_compra)
	values('1110JST', 19, 11, 2, 189781, '992393476234SDF', '2013-05-06');
insert into jifernandez.coches (matricula, modelo_id, color_id, aseguradora_id, kilometros, poliza, fecha_compra)
	values('2380LMN', 13, 4, 15, 201891, '324787SK', '2012-12-02');
insert into jifernandez.coches (matricula, modelo_id, color_id, aseguradora_id, kilometros, poliza, fecha_compra)
	values('2089FRT', 43, 5, 15, 167891, '43270902437', '2013-09-12');
insert into jifernandez.coches (matricula, modelo_id, color_id, aseguradora_id, kilometros, poliza, fecha_compra)
	values('3090TYR', 32, 10, 12, 95678, '1238902346', '2018-08-10');
insert into jifernandez.coches (matricula, modelo_id, color_id, aseguradora_id, kilometros, poliza, fecha_compra)
	values('1289DDM', 21, 12, 11, 167894, 'ASDHJ213698', '2016-06-18');
insert into jifernandez.coches (matricula, modelo_id, color_id, aseguradora_id, kilometros, poliza, fecha_compra)
	values('3480KLS', 31, 14, 17, 238090, '213489993487', '2014-05-19');
insert into jifernandez.coches (matricula, modelo_id, color_id, aseguradora_id, kilometros, poliza, fecha_compra)
	values('2391LNN', 18, 14, 19, 215671, '2138000DAS', '2013-03-01');
insert into jifernandez.coches (matricula, modelo_id, color_id, aseguradora_id, kilometros, poliza, fecha_compra)
	values('7801GGF', 41, 18, 16, 163001, '2438998091KJFS', '2015-08-27');
insert into jifernandez.coches (matricula, modelo_id, color_id, aseguradora_id, kilometros, poliza, fecha_compra)
	values('7730JJK', 29, 19, 10, 349810, '2134898340', '2008-09-10');
insert into jifernandez.coches (matricula, modelo_id, color_id, aseguradora_id, kilometros, poliza, fecha_compra)
	values('1000JFK', 37, 10, 4, 289023, 'WR1237D9123', '2010-02-03');
insert into jifernandez.coches (matricula, modelo_id, color_id, aseguradora_id, kilometros, poliza, fecha_compra)
	values('9467GHT', 36, 9, 3, 45671, '2132148998394', '2020-04-09');
insert into jifernandez.coches (matricula, modelo_id, color_id, aseguradora_id, kilometros, poliza, fecha_compra)
	values('4301KYK', 14, 6, 2, 67623, '1237JJSDF982', '2021-12-03');
insert into jifernandez.coches (matricula, modelo_id, color_id, aseguradora_id, kilometros, poliza, fecha_compra)
	values('2349JJR', 9, 3, 1, 89125, '12994632090DG', '2018-10-30');
insert into jifernandez.coches (matricula, modelo_id, color_id, aseguradora_id, kilometros, poliza, fecha_compra)
	values('8800DWY', 5, 7, 8, 176312, '23847612300SH', '2016-05-27');
insert into jifernandez.coches (matricula, modelo_id, color_id, aseguradora_id, kilometros, poliza, fecha_compra)
	values('3497LWW', 28, 4, 14, 193781, '213237819823', '2015-04-16');
insert into jifernandez.coches (matricula, modelo_id, color_id, aseguradora_id, kilometros, poliza, fecha_compra)
	values('9377KZW', 32, 2, 13, 89120, '122199543530', '2018-06-25');
insert into jifernandez.coches (matricula, modelo_id, color_id, aseguradora_id, kilometros, poliza, fecha_compra)
	values('7532DZZ', 15, 1, 18, 219278, '21321387888DF', '2014-05-18');
insert into jifernandez.coches (matricula, modelo_id, color_id, aseguradora_id, kilometros, poliza, fecha_compra)
	values('9327ZZL', 26, 19, 19, 76890, '23218890945', '2019-01-31');
insert into jifernandez.coches (matricula, modelo_id, color_id, aseguradora_id, kilometros, poliza, fecha_compra)
	values('9347HFF', 38, 12, 20, 267190, '21312HSDY721348', '2012-10-29');

/* Revisiones */
insert into jifernandez.revisiones (matricula, fecha, importe, divisa_id, kilometros) values ('7093NMS', '2022-06-19', 50.55, 2, 64217);
insert into jifernandez.revisiones (matricula, fecha, importe, divisa_id, kilometros) values ('8050FRT', '2019-08-10', 45.55, 2, 89762);
insert into jifernandez.revisiones (matricula, fecha, importe, divisa_id, kilometros) values ('8050FRT', '2021-08-07', 49.60, 2, 105394);
insert into jifernandez.revisiones (matricula, fecha, importe, divisa_id, kilometros) values ('6066JJK', '2017-03-25', 48.35, 2, 120345);
insert into jifernandez.revisiones (matricula, fecha, importe, divisa_id, kilometros) values ('6066JJK', '2019-03-19', 49.65, 2, 168012);
insert into jifernandez.revisiones (matricula, fecha, importe, divisa_id, kilometros) values ('6066JJK', '2021-03-21', 49.65, 2, 193032);
insert into jifernandez.revisiones (matricula, fecha, importe, divisa_id, kilometros) values ('6066JJK', '2022-03-25', 49.55, 2, 233780);
insert into jifernandez.revisiones (matricula, fecha, importe, divisa_id, kilometros) values ('3020RKL', '2019-04-28', 60.55, 2, 98290);
insert into jifernandez.revisiones (matricula, fecha, importe, divisa_id, kilometros) values ('3020RKL', '2021-04-27', 61.55, 2, 105617);
insert into jifernandez.revisiones (matricula, fecha, importe, divisa_id, kilometros) values ('1110JST', '2018-05-01', 49.55, 2, 95780);
insert into jifernandez.revisiones (matricula, fecha, importe, divisa_id, kilometros) values ('1110JST', '2020-05-02', 50.90, 2, 153930);
insert into jifernandez.revisiones (matricula, fecha, importe, divisa_id, kilometros) values ('1110JST', '2022-05-03', 52.65, 2, 174278);
insert into jifernandez.revisiones (matricula, fecha, importe, divisa_id, kilometros) values ('2380LMN', '2018-12-02', 49.25, 2, 156012);
insert into jifernandez.revisiones (matricula, fecha, importe, divisa_id, kilometros) values ('2380LMN', '2019-12-01', 50.35, 2, 175902);
insert into jifernandez.revisiones (matricula, fecha, importe, divisa_id, kilometros) values ('2380LMN', '2021-12-03', 51.55, 2, 197818);
insert into jifernandez.revisiones (matricula, fecha, importe, divisa_id, kilometros) values ('2089FRT', '2018-09-11', 45.25, 2, 129843);
insert into jifernandez.revisiones (matricula, fecha, importe, divisa_id, kilometros) values ('2089FRT', '2020-09-12', 48.0, 2, 136903);
insert into jifernandez.revisiones (matricula, fecha, importe, divisa_id, kilometros) values ('2089FRT', '2022-09-10', 50.55, 2, 167404);
insert into jifernandez.revisiones (matricula, fecha, importe, divisa_id, kilometros) values ('1289DDM', '2021-06-17', 51.55, 2, 159233);
insert into jifernandez.revisiones (matricula, fecha, importe, divisa_id, kilometros) values ('3480KLS', '2019-05-19', 49.35, 2, 175890);
insert into jifernandez.revisiones (matricula, fecha, importe, divisa_id, kilometros) values ('3480KLS', '2021-05-17', 51.15, 2, 214789);
insert into jifernandez.revisiones (matricula, fecha, importe, divisa_id, kilometros) values ('2391LNN', '2018-03-01', 48.55, 2, 189233);
insert into jifernandez.revisiones (matricula, fecha, importe, divisa_id, kilometros) values ('2391LNN', '2021-02-28', 52.55, 2, 205681);
insert into jifernandez.revisiones (matricula, fecha, importe, divisa_id, kilometros) values ('7801GGF', '2020-08-27', 55.55, 2, 145672);
insert into jifernandez.revisiones (matricula, fecha, importe, divisa_id, kilometros) values ('7801GGF', '2022-08-25', 60.55, 2, 160923);
insert into jifernandez.revisiones (matricula, fecha, importe, divisa_id, kilometros) values ('7730JJK', '2013-09-10', 40.15, 2, 120921);
insert into jifernandez.revisiones (matricula, fecha, importe, divisa_id, kilometros) values ('7730JJK', '2015-09-09', 42.45, 2, 178932);
insert into jifernandez.revisiones (matricula, fecha, importe, divisa_id, kilometros) values ('7730JJK', '2017-09-06', 47.55, 2, 230911);
insert into jifernandez.revisiones (matricula, fecha, importe, divisa_id, kilometros) values ('7730JJK', '2020-09-09', 48.67, 2, 276021);
insert into jifernandez.revisiones (matricula, fecha, importe, divisa_id, kilometros) values ('7730JJK', '2021-09-10', 48.79, 2, 301892);
insert into jifernandez.revisiones (matricula, fecha, importe, divisa_id, kilometros) values ('7730JJK', '2022-09-08', 54.80, 2, 348901);
insert into jifernandez.revisiones (matricula, fecha, importe, divisa_id, kilometros) values ('1000JFK', '2015-02-03', 51.20, 2, 180690);
insert into jifernandez.revisiones (matricula, fecha, importe, divisa_id, kilometros) values ('1000JFK', '2017-02-02', 52.40, 2, 225372);
insert into jifernandez.revisiones (matricula, fecha, importe, divisa_id, kilometros) values ('1000JFK', '2019-02-01', 53.15, 2, 256901);
insert into jifernandez.revisiones (matricula, fecha, importe, divisa_id, kilometros) values ('1000JFK', '2021-02-03', 58.20, 2, 274012);
insert into jifernandez.revisiones (matricula, fecha, importe, divisa_id, kilometros) values ('8800DWY', '2021-05-27', 58.20, 2, 170452);
insert into jifernandez.revisiones (matricula, fecha, importe, divisa_id, kilometros) values ('3497LWW', '2021-04-15', 53.15, 2, 142891);
insert into jifernandez.revisiones (matricula, fecha, importe, divisa_id, kilometros) values ('3497LWW', '2022-04-13', 55.35, 2, 189008);
insert into jifernandez.revisiones (matricula, fecha, importe, divisa_id, kilometros) values ('7532DZZ', '2021-05-17', 48.20, 2, 183956);
insert into jifernandez.revisiones (matricula, fecha, importe, divisa_id, kilometros) values ('7532DZZ', '2021-05-29', 49.32, 2, 208917);
insert into jifernandez.revisiones (matricula, fecha, importe, divisa_id, kilometros) values ('9347HFF', '2015-10-29', 46.32, 2, 123800);
insert into jifernandez.revisiones (matricula, fecha, importe, divisa_id, kilometros) values ('9347HFF', '2017-10-12', 43.32, 2, 189356);
insert into jifernandez.revisiones (matricula, fecha, importe, divisa_id, kilometros) values ('9347HFF', '2019-10-30', 47.32, 2, 218927);
insert into jifernandez.revisiones (matricula, fecha, importe, divisa_id, kilometros) values ('9347HFF', '2021-10-26', 51.32, 2, 243127);