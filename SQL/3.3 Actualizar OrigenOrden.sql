UPDATE staging.OrdenCotizacion
SET OrigenOrden = CASE
					WHEN IDCotizacion IS NOT NULL THEN 'Aseguradora'
					WHEN ID_Cliente IS NOT NULL THEN 'Cliente registrado'
					ELSE 'Cliente no registrado'
					END
WHERE OrigenOrden IS NULL


UPDATE staging.OrdenCotizacion
SET TotalCotizacion = (
	SELECT OC.CantidadCotizacion * P.Precio 
		FROM staging.OrdenCotizacion OC
			INNER JOIN Dimension.Partes P ON (OC.ID_Parte_Cotizacion = P.ID_Parte)
)
WHERE IDCotizacion IS NOT NULL