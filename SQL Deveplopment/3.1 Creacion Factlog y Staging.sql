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
	[ID_Orden] [int] NULL,
	[ID_Cliente] [int] NULL,
	[ID_Ciudad] [int] NULL,
	[IDCotizacion] [int] NULL,
	[ID_StatusOrden] [int] NULL,
	[ID_DetalleOrden] [int] NULL,
	[ID_Descuento] [int] NULL,
	[NumLinea] [varchar](50) NULL,
    [VehiculoID_Cotizacion] [int] NULL,
    [VehiculoID_Orden] [int] NULL,
    [ID_Parte_Cotizacion] [varchar](50) NULL,
    [ID_Parte_Orden] [varchar](50) NULL,
	[IDAseguradora] [int] NULL,
	[IDPlantaReparacion] [varchar](50) NULL,
	[IDPartner] [varchar](50) NULL,
	[IDClientePlantaReparacion] [varchar](50) NULL,
	[IDRecotizacion] [varchar](100) NULL,
	[Total_Orden] [decimal](12, 2) NULL,
	[Fecha_Orden] [datetime] NULL,
	[NumeroOrden] [varchar](20) NULL,
	[CantidadOrden] [int] NULL,
	[status] [varchar](50) NULL,
	[TipoDocumento] [varchar](50) NULL,
	[FechaCreacionCotizacion] [datetime] NULL,
	[ProcesadoPor] [varchar](50) NULL,
	[AseguradoraSubsidiaria] [varchar](80) NULL,
	[NumeroReclamo] [varchar](50) NULL,
	[OrdenRealizada] [bit] NULL,
	[CotizacionRealizada] [bit] NULL,
	[CotizacionDuplicada] [bit] NULL,
	[procurementFolderID] [varchar](50) NULL,
	[DireccionEntrega1] [varchar](50) NULL,
	[DireccionEntrega2] [varchar](50) NULL,
	[MarcadoEntrega] [bit] NULL,
	[CodigoPostal_Cotizacion] [varchar](10) NULL,
	[LeidoPorPlantaReparacion] [bit] NULL,
	[LeidoPorPlantaReparacionFecha] [datetime] NULL,
	[CotizacionReabierta] [bit] NULL,
	[EsAseguradora] [bit] NULL,
	[CodigoVerificacion] [varchar](50) NULL,
	[FechaCreacionRegistro_Cotizacion] [datetime] NULL,
	[PartnerConfirmado] [bit] NULL,
	[WrittenBy] [varchar](80) NULL,
	[SeguroValidado] [bit] NULL,
	[FechaCaptura] [datetime] NULL,
	[Ruta] [varchar](500) NULL,
	[FechaLimiteRuta] [datetime] NULL,
	[OETipoParte] [varchar](10) NULL,
	[AltPartNum] [varchar](45) NULL,
	[AltTipoParte] [varchar](45) NULL,
	[ciecaTipoParte] [varchar](45) NULL,
	[CantidadCotizacion] [int] NULL,
	[TotalCotizacion] [decimal](24, 2) NULL,
	[PrecioListaOnRO] [varchar](10) NULL,
	[PrecioNetoOnRO] [varchar](10) NULL,
	[NecesitadoParaFecha] [datetime] NULL,
	[OrigenOrden] [varchar](50) NULL
) ON [PRIMARY]
GO

