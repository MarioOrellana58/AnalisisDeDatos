select marca, sum(oc.CantidadCotizacion * p.Precio) Coti from hecho.OrdenCotizacion oc
inner join Dimension.Vehiculo v on oc.VehiculoID_Cotizacion = v.VehiculoID
inner join Dimension.Partes p on oc.ID_Parte_Cotizacion = p.ID_Parte
group by marca
order by Coti desc 

select marca, sum(oc.CantidadOrden * p.Precio) Orden from hecho.OrdenCotizacion oc
inner join Dimension.Vehiculo v on oc.VehiculoID_Orden = v.VehiculoID
inner join Dimension.Partes p on oc.ID_Parte_Orden = p.ID_Parte
WHERE ID_Orden IS NOT NULL
group by marca
order by Orden desc 

select marca, sum(oc.CantidadOrden * p.Precio) Orden from hecho.OrdenCotizacion oc
inner join Dimension.Vehiculo v on oc.VehiculoID_Orden = v.VehiculoID
inner join Dimension.Partes p on oc.ID_Parte_Orden = p.ID_Parte
group by marca
order by Orden desc 

select marca, sum(oc.Total_Orden) Orden from hecho.OrdenCotizacion oc
inner join Dimension.Vehiculo v on oc.VehiculoID_Orden = v.VehiculoID
inner join Dimension.Partes p on oc.ID_Parte_Orden = p.ID_Parte
group by marca
order by Orden desc 

select sum(oc.Total_Orden) Orden from hecho.OrdenCotizacion oc

UPDATE Hecho.OrdenCotizacion
SET TotalCotizacion =  OC.CantidadCotizacion * P.Precio 
		FROM Hecho.OrdenCotizacion OC
			INNER JOIN Dimension.Partes P ON (OC.ID_Parte_Cotizacion = P.ID_Parte)


select * from Dimension.Geografia oc where SK_Geografia is not null