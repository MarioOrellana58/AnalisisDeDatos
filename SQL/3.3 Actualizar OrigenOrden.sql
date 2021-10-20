UPDATE staging.OrdenCotizacion
SET OrigenOrden = CASE
					WHEN IDCotizacion IS NOT NULL THEN 'Aseguradora'
					WHEN ID_Cliente IS NOT NULL THEN 'Cliente registrado'
					ELSE 'Cliente no registrado'
					END
WHERE OrigenOrden IS NULL
