select 
	m2.nombre as marca, 
	m.nombre as modelo, 
	c2.nombre as color,
	g.nombre as grupo,
	fecha_compra,
	c.matricula as matricula,
	c.kilometros as kilomentros,
	a.nombre as aseguradora,
	c.poliza as poliza
from jifernandez.coches c 
	inner join jifernandez.modelos m on c.modelo_id = m.modelo_id 
	inner join jifernandez.marcas m2 on m.marca_id = m2.marca_id
	inner join jifernandez.grupos g on m2.grupo_id = g.grupo_id
	inner join jifernandez.colores c2 on c.color_id = c2.color_id
	inner join jifernandez.aseguradoras a on c.aseguradora_id = a.aseguradora_id
order by modelo asc, fecha_compra asc;
