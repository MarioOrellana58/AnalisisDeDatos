-- indice sobre Cotizacion
CREATE INDEX [IndiceCotizacion] ON Cotizacion ( [IDCotizacion] ) INCLUDE ( 
	   [status]
      ,[TipoDocumento]
      ,[FechaCreacion]
      ,[ProcesadoPor]
      ,[IDAseguradora]
      ,[AseguradoraSubsidiaria]
      ,[NumeroReclamo]
      ,[IDPlantaReparacion]
      ,[OrdenRealizada]
      ,[CotizacionRealizada]
      ,[CotizacionDuplicada]
      ,[procurementFolderID]
      ,[DireccionEntrega1]
      ,[DireccionEntrega2]
      ,[MarcadoEntrega]
      ,[IDPartner]
      ,[CodigoPostal]
      ,[LeidoPorPlantaReparacion]
      ,[LeidoPorPlantaReparacionFecha]
      ,[CotizacionReabierta]
      ,[EsAseguradora]
      ,[CodigoVerificacion]
      ,[IDClientePlantaReparacion]
      ,[FechaCreacionRegistro]
      ,[IDRecotizacion]
      ,[PartnerConfirmado]
      ,[WrittenBy]
      ,[SeguroValidado]
      ,[FechaCaptura]
      ,[IDOrden]
      ,[Ruta]
      ,[FechaLimiteRuta])

UPDATE STATISTICS Cotizacion WITH FULLSCAN


-- indice sobre CotizacionDetalle
CREATE INDEX [IndiceCotizacionDetalle] ON CotizacionDetalle ( [IDCotizacion] ) INCLUDE ( 
       [NumLinea]
      ,[ID_Parte]
      ,[OETipoParte]
      ,[AltPartNum]
      ,[AltTipoParte]
      ,[ciecaTipoParte]
      ,[Cantidad]
      ,[PrecioListaOnRO]
      ,[PrecioNetoOnRO]
      ,[NecesitadoParaFecha]
      ,[VehiculoID])

UPDATE STATISTICS CotizacionDetalle WITH FULLSCAN


-- indice sobre Orden
CREATE INDEX [IndiceOrden] ON Orden ( [ID_Orden] ) INCLUDE ( 
	   [ID_Cliente]
      ,[ID_Ciudad]
      ,[ID_StatusOrden]
      ,[Total_Orden]
      ,[Fecha_Orden]
      ,[NumeroOrden] )

UPDATE STATISTICS Orden WITH FULLSCAN


-- indice sobre Detalle_orden
CREATE INDEX [IndiceDetalle_orden] ON Detalle_orden ( [ID_DetalleOrden] ) INCLUDE ( 
	   [ID_Orden]
      ,[ID_Parte]
      ,[ID_Descuento]
      ,[Cantidad]
      ,[VehiculoID] )

UPDATE STATISTICS Detalle_orden WITH FULLSCAN

