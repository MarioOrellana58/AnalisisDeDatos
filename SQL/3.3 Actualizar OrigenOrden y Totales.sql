UPDATE staging.OrdenCotizacion
SET OrigenOrden = CASE
					WHEN IDCotizacion IS NOT NULL THEN 'Aseguradora'
					WHEN ID_Cliente IS NOT NULL THEN 'Cliente registrado'
					ELSE 'Invitados'
					END
WHERE OrigenOrden IS NULL


UPDATE staging.OrdenCotizacion
SET TotalCotizacion =  OC.CantidadCotizacion * P.Precio * IIF(C.PorcentajeDescuento IS NOT NULL, 1 - C.PorcentajeDescuento, 1)
		FROM staging.OrdenCotizacion OC
			INNER JOIN Dimension.Partes P ON (OC.ID_Parte_Cotizacion = P.ID_Parte)
			LEFT JOIN Dimension.Descuento C ON (OC.ID_Descuento = C.ID_Descuento)
WHERE IDCotizacion IS NOT NULL


UPDATE staging.OrdenCotizacion
SET Total_Orden =  OC.CantidadOrden * P.Precio * IIF(C.PorcentajeDescuento IS NOT NULL, 1 - C.PorcentajeDescuento, 1)
		FROM staging.OrdenCotizacion OC
			INNER JOIN Dimension.Partes P ON (OC.ID_Parte_Orden = P.ID_Parte)
			LEFT JOIN Dimension.Descuento C ON (OC.ID_Descuento = C.ID_Descuento)
WHERE ID_Orden IS NOT NULL