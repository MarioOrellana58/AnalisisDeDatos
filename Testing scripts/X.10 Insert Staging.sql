USE [RepuestosWebDWH]
GO

INSERT INTO [staging].[OrdenCotizacion]
           ([ID_Orden]
           ,[ID_Cliente]
           ,[ID_Ciudad]
           ,[IDCotizacion]
           ,[ID_StatusOrden]
           ,[ID_DetalleOrden]
           ,[ID_Descuento]
           ,[NumLinea]
           ,[VehiculoID_Cotizacion]
           ,[VehiculoID_Orden]
           ,[ID_Parte_Cotizacion]
           ,[ID_Parte_Orden]
           ,[IDAseguradora]
           ,[IDPlantaReparacion]
           ,[IDPartner]
           ,[IDClientePlantaReparacion]
           ,[IDRecotizacion]
           ,[Total_Orden]
           ,[Fecha_Orden]
           ,[NumeroOrden]
           ,[CantidadOrden]
           ,[status]
           ,[TipoDocumento]
           ,[FechaCreacionCotizacion]
           ,[ProcesadoPor]
           ,[AseguradoraSubsidiaria]
           ,[NumeroReclamo]
           ,[OrdenRealizada]
           ,[CotizacionRealizada]
           ,[CotizacionDuplicada]
           ,[procurementFolderID]
           ,[DireccionEntrega1]
           ,[DireccionEntrega2]
           ,[MarcadoEntrega]
           ,[CodigoPostal_Cotizacion]
           ,[LeidoPorPlantaReparacion]
           ,[LeidoPorPlantaReparacionFecha]
           ,[CotizacionReabierta]
           ,[EsAseguradora]
           ,[CodigoVerificacion]
           ,[FechaCreacionRegistro_Cotizacion]
           ,[PartnerConfirmado]
           ,[WrittenBy]
           ,[SeguroValidado]
           ,[FechaCaptura]
           ,[Ruta]
           ,[FechaLimiteRuta]
           ,[OETipoParte]
           ,[AltPartNum]
           ,[AltTipoParte]
           ,[ciecaTipoParte]
           ,[CantidadCotizacion]
           ,[TotalCotizacion]
           ,[PrecioListaOnRO]
           ,[PrecioNetoOnRO]
           ,[NecesitadoParaFecha]
           ,[OrigenOrden])
SELECT O.[ID_Orden] AS [ID_Orden]
	  ,O.[ID_Cliente] AS [ID_Cliente]
      ,O.[ID_Ciudad] AS [ID_Ciudad]
      ,C.[IDCotizacion] AS [IDCotizacion]
      ,O.[ID_StatusOrden] AS [ID_StatusOrden]
      ,DO.[ID_DetalleOrden] AS [ID_DetalleOrden]
	  ,DO.ID_Descuento AS [ID_Descuento]
	  ,CD.[NumLinea] AS [NumLinea]
      ,CD.[VehiculoID] AS [VehiculoID_Cotizacion]
      ,DO.[VehiculoID] AS [VehiculoID_Orden]
      ,CD.[ID_Parte] AS [ID_Parte_Cotizacion]
      ,DO.[ID_Parte] AS [ID_Parte_Orden]
      ,C.[IDAseguradora] AS [IDAseguradora]
      ,C.[IDPlantaReparacion] AS [IDPlantaReparacion]
      ,C.[IDPartner] AS [IDPartner]
      ,C.[IDClientePlantaReparacion] AS [IDClientePlantaReparacion]
      ,C.[IDRecotizacion] AS [IDRecotizacion]
      ,O.[Total_Orden] AS [Total_Orden]
      ,O.[Fecha_Orden] AS [Fecha_Orden]
      ,O.[NumeroOrden] AS [NumeroOrden]
      ,DO.[Cantidad] AS [CantidadOrden]
	  ,C.[status] AS [status]
      ,C.[TipoDocumento] AS [TipoDocumento]
      ,C.[FechaCreacion] AS [FechaCreacionCotizacion]
      ,C.[ProcesadoPor] AS [ProcesadoPor]
      ,C.[AseguradoraSubsidiaria] AS [AseguradoraSubsidiaria]
      ,C.[NumeroReclamo] AS [NumeroReclamo]
      ,C.[OrdenRealizada] AS [OrdenRealizada]
      ,C.[CotizacionRealizada] AS [CotizacionRealizada]
      ,C.[CotizacionDuplicada] AS [CotizacionDuplicada]
      ,C.[procurementFolderID] AS [procurementFolderID]
	  ,C.[DireccionEntrega1] AS [DireccionEntrega1]
      ,C.[DireccionEntrega2] AS [DireccionEntrega2]
      ,C.[MarcadoEntrega] AS [MarcadoEntrega]
      ,C.[CodigoPostal] AS [CodigoPostal_Cotizacion]
      ,C.[LeidoPorPlantaReparacion] AS [LeidoPorPlantaReparacion]
      ,C.[LeidoPorPlantaReparacionFecha] AS [LeidoPorPlantaReparacionFecha]
      ,C.[CotizacionReabierta] AS [CotizacionReabierta]
      ,C.[EsAseguradora] AS [EsAseguradora]
      ,C.[CodigoVerificacion] AS [CodigoVerificacion]
      ,C.[FechaCreacionRegistro] AS [FechaCreacionRegistro_Cotizacion]
      ,C.[PartnerConfirmado] AS [PartnerConfirmado]
      ,C.[WrittenBy] AS [WrittenBy]
      ,C.[SeguroValidado] AS [SeguroValidado]
      ,C.[FechaCaptura] AS [FechaCaptura]
      ,C.[Ruta] AS [Ruta]
      ,C.[FechaLimiteRuta] AS [FechaLimiteRuta]
      ,CD.[OETipoParte] AS [OETipoParte]
      ,CD.[AltPartNum] AS [AltPartNum]
      ,CD.[AltTipoParte] AS [AltTipoParte]
      ,CD.[ciecaTipoParte] AS [ciecaTipoParte]
      ,CD.[Cantidad] AS [CantidadCotizacion]
	  ,NULL AS [TotalCotizacion]
      ,CD.[PrecioListaOnRO] AS [PrecioListaOnRO]
      ,CD.[PrecioNetoOnRO] AS [PrecioNetoOnRO]
      ,CD.[NecesitadoParaFecha] AS [NecesitadoParaFecha]
	  ,NULL AS [TotalCotizacion]
FROM  RepuestosWeb.DBO.Orden O
	LEFT OUTER JOIN RepuestosWeb.DBO.Detalle_orden DO ON (O.ID_Orden = DO.ID_Orden)
	FULL OUTER JOIN RepuestosWeb.DBO.Cotizacion C ON (O.ID_Orden = C.IDOrden)
	LEFT OUTER JOIN RepuestosWeb.DBO.CotizacionDetalle CD ON (C.IDCotizacion = CD.IDCotizacion)  
GO


