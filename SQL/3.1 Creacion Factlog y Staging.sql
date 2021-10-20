USE [RepuestosWebDWH]
GO

--Creamos tabla para log de fact batches
CREATE TABLE FactLog
(
	ID_Batch UNIQUEIDENTIFIER DEFAULT(NEWID()),
	FechaEjecucion DATETIME DEFAULT(GETDATE()),
	NuevosRegistros INT,
	CONSTRAINT [PK_FactLog] PRIMARY KEY
	(
		ID_Batch
	)
)
GO

--Agregamos FK
ALTER TABLE Hecho.OrdenCotizacion ADD CONSTRAINT [FK_IDBatch] FOREIGN KEY (ID_Batch) 
REFERENCES Factlog(ID_Batch)
go


create schema [staging]
go

DROP TABLE IF EXISTS [staging].[OrdenCotizacion]
GO

CREATE TABLE [staging].[OrdenCotizacion](
 ID_Orden [UDT_PK]
,ID_Cliente [UDT_PK]
,ID_Ciudad [UDT_PK]
,[IDCotizacion] [UDT_PK]
,[ID_StatusOrden] [UDT_PK]
,ID_DetalleOrden [UDT_PK]	
,ID_Descuento [UDT_PK]	
,[NumLinea] [UDT_PK]
,[VehiculoID] [UDT_PK]
,[ID_Parte] [UDT_PK_VARCHAR]
,[IDAseguradora] [UDT_PK]
,[IDPlantaReparacion] [UDT_PK]
,[IDPartner] [UDT_VarcharTiny]
,[IDClientePlantaReparacion] [UDT_VarcharTiny]
,[IDRecotizacion] [UDT_VarcharCorto]
,Total_Orden [UDT_Decimal12.2]
,Fecha_Orden [UDT_DateTime] --SCD Tipo 0
,NumeroOrden [UDT_VarcharTiny]
,[status] [UDT_VarcharTiny] 
,[TipoDocumento] [UDT_VarcharTiny] 
,[FechaCreacionCotizacion] [UDT_DateTime]  --SCD Tipo 0
,[ProcesadoPor] [UDT_VarcharTiny] 
,[AseguradoraSubsidiaria] [UDT_VarcharCorto] 
,[NumeroReclamo] [UDT_VarcharTiny] 
,[OrdenRealizada] [UDT_Bit] 
,[CotizacionRealizada] [UDT_Bit] 
,[CotizacionDuplicada] [UDT_Bit] 
,[procurementFolderID] [UDT_VarcharTiny] 
,[DireccionEntrega1] [UDT_VarcharTiny]
,[DireccionEntrega2] [UDT_VarcharTiny]
,[MarcadoEntrega] [UDT_Bit]
,[CodigoPostal_Cotizacion]  [UDT_VarcharTiny]
,[LeidoPorPlantaReparacion] [UDT_Bit]
,[LeidoPorPlantaReparacionFecha] [UDT_DateTime]
,[CotizacionReabierta] [UDT_Bit] --SCD Tipo 2
,[EsAseguradora] [UDT_Bit] --SCD Tipo 0
,[CodigoVerificacion] [UDT_VarcharTiny] --SCD Tipo 0
,[FechaCreacionRegistro_Cotizacion] [UDT_DateTime] --SCD Tipo 0
,[PartnerConfirmado] [UDT_Bit] 
,[WrittenBy] [UDT_VarcharCorto]
,[SeguroValidado] [UDT_Bit] 
,[FechaCaptura] [UDT_DateTime] --SCD Tipo 0
,[IDOrden] INT --SCD Tipo 0
,[Ruta] [UDT_VarcharLargo]
,[FechaLimiteRuta] [UDT_DateTime]
,[OETipoParte] [UDT_VarcharTiny]
,[AltPartNum] [UDT_VarcharTiny]
,[AltTipoParte] [UDT_VarcharTiny]
,[ciecaTipoParte] [UDT_VarcharTiny]
,[Cantidad] INT    --SCD Tipo 2
,[PrecioListaOnRO] [UDT_VarcharTiny]
,[PrecioNetoOnRO] [UDT_VarcharTiny]
,[NecesitadoParaFecha] [UDT_DateTime]  --SCD Tipo 2
,[OrigenOrden] [UDT_VarcharTiny] 
) ON [PRIMARY]
GO

