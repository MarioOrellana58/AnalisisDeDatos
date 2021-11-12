USE master
GO


DECLARE @EliminarDB BIT = 1;
--Eliminar BDD si ya existe y si @EliminarDB = 1
if (((select COUNT(1) from sys.databases where name = 'RepuestosWebDWH')>0) AND (@EliminarDB = 1))
begin
	EXEC msdb.dbo.sp_delete_database_backuphistory @database_name = N'RepuestosWebDWH'
	
	
	use [master];
	ALTER DATABASE [RepuestosWebDWH] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE;
		
	DROP DATABASE [RepuestosWebDWH]
	print 'RepuestosWebDWH ha sido eliminada'
end
GO

CREATE DATABASE RepuestosWebDWH
GO

USE RepuestosWebDWH
GO


--Schemas para separar objetos
	CREATE SCHEMA Hecho
	GO

	CREATE SCHEMA Dimension
	GO

--------------------------------------------------------------------------------------------
-------------------------------MODELADO CONCEPTUAL------------------------------------------
--------------------------------------------------------------------------------------------
--Tablas Dimensiones

	CREATE TABLE Dimension.Partes
	(
		SK_Parte INT PRIMARY KEY IDENTITY
	)
	GO

	CREATE TABLE Dimension.Geografia
	(
		SK_Geografia INT PRIMARY KEY IDENTITY
	)
	GO

	CREATE TABLE Dimension.Clientes
	(
		SK_Cliente INT PRIMARY KEY IDENTITY
	)
	GO
	
	CREATE TABLE Dimension.Vehiculo
	(
		SK_Vehiculo INT PRIMARY KEY IDENTITY
	)
	GO
	
	CREATE TABLE Dimension.Aseguradoras
	(
		SK_Aseguradora INT PRIMARY KEY IDENTITY
	)
	GO
	
	CREATE TABLE Dimension.PlantaReparacion
	(
		SK_PlantaReparacion INT PRIMARY KEY IDENTITY
	)
	GO
	
	CREATE TABLE Dimension.StatusOrden
	(
		SK_StatusOrden INT PRIMARY KEY IDENTITY
	)
	GO
	
	CREATE TABLE Dimension.Descuento
	(
		SK_Descuento INT PRIMARY KEY IDENTITY
	)
	GO
	
	CREATE TABLE Dimension.Fecha
	(
		DateKey INT PRIMARY KEY
	)
	GO


--Tablas Fact

	CREATE TABLE Hecho.OrdenCotizacion
	(
		SK_OrdenCotizacion INT PRIMARY KEY IDENTITY,
		SK_Parte INT REFERENCES Dimension.Partes(SK_Parte),
		SK_Geografia INT REFERENCES Dimension.Geografia(SK_Geografia),
		SK_Cliente INT REFERENCES Dimension.Clientes(SK_Cliente),
		SK_Vehiculo INT REFERENCES Dimension.Vehiculo(SK_Vehiculo),
		SK_Descuento INT REFERENCES Dimension.Descuento(SK_Descuento),
		SK_Aseguradora INT REFERENCES Dimension.Aseguradoras(SK_Aseguradora),
		SK_PlantaReparacion INT REFERENCES Dimension.PlantaReparacion(SK_PlantaReparacion),
		SK_StatusOrden INT REFERENCES Dimension.StatusOrden(SK_StatusOrden),
		DateKey INT REFERENCES Dimension.Fecha(DateKey)
	)

--Metadata

	EXEC sys.sp_addextendedproperty 
     @name = N'Desnormalizacion', 
     @value = N'La dimension Partes provee una vista desnormalizada de las tablas origen Partes, Linea y Categoria, dejando todo en una �nica dimensi�n para un modelo estrella', 
     @level0type = N'SCHEMA', 
     @level0name = N'Dimension', 
     @level1type = N'TABLE', 
     @level1name = N'Partes';
	GO

	EXEC sys.sp_addextendedproperty 
     @name = N'Desnormalizacion', 
     @value = N'La dimension Geografia provee una vista desnormalizada de las tablas origen Pa�s, Region y Ciudad en una sola dimensi�n para un modelo estrella', 
     @level0type = N'SCHEMA', 
     @level0name = N'Dimension', 
     @level1type = N'TABLE', 
     @level1name = N'Geografia';
	GO

	EXEC sys.sp_addextendedproperty 
     @name = N'Desnormalizacion', 
     @value = N'La dimension Clientes posee toda la informaci�n de la tabla de origen Clientes', 
     @level0type = N'SCHEMA', 
     @level0name = N'Dimension', 
     @level1type = N'TABLE', 
     @level1name = N'Clientes';
	GO

	EXEC sys.sp_addextendedproperty 
     @name = N'Desnormalizacion', 
     @value = N'La dimension Vehiculo posee toda la informaci�n de la tabla de origen Vehiculo', 
     @level0type = N'SCHEMA', 
     @level0name = N'Dimension', 
     @level1type = N'TABLE', 
     @level1name = N'Vehiculo';
	GO

	EXEC sys.sp_addextendedproperty 
     @name = N'Desnormalizacion', 
     @value = N'La dimension Descuento posee toda la informaci�n de la tabla de origen Descuento', 
     @level0type = N'SCHEMA', 
     @level0name = N'Dimension', 
     @level1type = N'TABLE', 
     @level1name = N'Descuento';
	GO

	EXEC sys.sp_addextendedproperty 
     @name = N'Desnormalizacion', 
     @value = N'La dimension StatusOrden posee toda la informaci�n de la tabla de origen StatusOrden', 
     @level0type = N'SCHEMA', 
     @level0name = N'Dimension', 
     @level1type = N'TABLE', 
     @level1name = N'StatusOrden';
	GO

	EXEC sys.sp_addextendedproperty 
     @name = N'Desnormalizacion', 
     @value = N'La dimension Aseguradoras posee toda la informaci�n de la tabla de origen Aseguradoras', 
     @level0type = N'SCHEMA', 
     @level0name = N'Dimension', 
     @level1type = N'TABLE', 
     @level1name = N'Aseguradoras';
	GO

	EXEC sys.sp_addextendedproperty 
     @name = N'Desnormalizacion', 
     @value = N'La dimension PlantaReparaci�n posee toda la informaci�n de la tabla de origen PlantaReparaci�n', 
     @level0type = N'SCHEMA', 
     @level0name = N'Dimension', 
     @level1type = N'TABLE', 
     @level1name = N'PlantaReparacion';
	GO

	EXEC sys.sp_addextendedproperty 
     @name = N'Desnormalizacion', 
     @value = N'La dimension fecha es generada de forma automatica y no tiene datos origen, se puede regenerar enviando un rango de fechas al stored procedure USP_FillDimDate', 
     @level0type = N'SCHEMA', 
     @level0name = N'Dimension', 
     @level1type = N'TABLE', 
     @level1name = N'Fecha';
	GO

	EXEC sys.sp_addextendedproperty 
     @name = N'Desnormalizacion', 
     @value = N'La tabla de hechos es una union proveniente de las tablas de Orden, Detalle_Orden, Cotizaci�n y Cotizaci�nDetalle', 
     @level0type = N'SCHEMA', 
     @level0name = N'Hecho', 
     @level1type = N'TABLE', 
     @level1name = N'OrdenCotizacion';
	GO

--------------------------------------------------------------------------------------------
---------------------------------MODELADO LOGICO--------------------------------------------
--------------------------------------------------------------------------------------------
--Transformaci�n en modelo l�gico (mas detalles)

--Hechos
	ALTER TABLE Hecho.OrdenCotizacion ADD ID_Orden [int] --
	ALTER TABLE Hecho.OrdenCotizacion ADD ID_Cliente [int] --
	ALTER TABLE Hecho.OrdenCotizacion ADD ID_Ciudad [int] --
	ALTER TABLE Hecho.OrdenCotizacion ADD [IDCotizacion] [int] --
	ALTER TABLE Hecho.OrdenCotizacion ADD [ID_StatusOrden] [int] --
	ALTER TABLE Hecho.OrdenCotizacion ADD ID_DetalleOrden [int] --	
	ALTER TABLE Hecho.OrdenCotizacion ADD ID_Descuento [int] --		
    ALTER TABLE Hecho.OrdenCotizacion ADD [NumLinea] [varchar](50) --
    ALTER TABLE Hecho.OrdenCotizacion ADD [VehiculoID_Cotizacion] [int] --
    ALTER TABLE Hecho.OrdenCotizacion ADD [VehiculoID_Orden] [int] --
    ALTER TABLE Hecho.OrdenCotizacion ADD [ID_Parte_Cotizacion] [varchar](50) --
    ALTER TABLE Hecho.OrdenCotizacion ADD [ID_Parte_Orden] [varchar](50) --
    ALTER TABLE Hecho.OrdenCotizacion ADD [IDAseguradora] [int] --
	ALTER TABLE Hecho.OrdenCotizacion ADD [IDPlantaReparacion] [varchar](50) --
	
	ALTER TABLE Hecho.OrdenCotizacion ADD [IDPartner] [varchar](50) --
	ALTER TABLE Hecho.OrdenCotizacion ADD [IDClientePlantaReparacion] [varchar](50) --
	ALTER TABLE Hecho.OrdenCotizacion ADD [IDRecotizacion] [varchar](100) --
	
	ALTER TABLE Hecho.OrdenCotizacion ADD Total_Orden [decimal](12, 2) --
	ALTER TABLE Hecho.OrdenCotizacion ADD Fecha_Orden [datetime] --
	ALTER TABLE Hecho.OrdenCotizacion ADD NumeroOrden [varchar](20) --
    ALTER TABLE Hecho.OrdenCotizacion ADD [CantidadOrden] [int] --  

	ALTER TABLE Hecho.OrdenCotizacion ADD [status] [varchar](50) -- 
	ALTER TABLE Hecho.OrdenCotizacion ADD [TipoDocumento] [varchar](50) -- 
	ALTER TABLE Hecho.OrdenCotizacion ADD [FechaCreacionCotizacion] [datetime] --
	ALTER TABLE Hecho.OrdenCotizacion ADD [ProcesadoPor] [varchar](50) --  
	ALTER TABLE Hecho.OrdenCotizacion ADD [AseguradoraSubsidiaria] [varchar](80) -- 
	ALTER TABLE Hecho.OrdenCotizacion ADD [NumeroReclamo] [varchar](50) -- 
	ALTER TABLE Hecho.OrdenCotizacion ADD [OrdenRealizada] [bit] -- 
	ALTER TABLE Hecho.OrdenCotizacion ADD [CotizacionRealizada] [bit] -- 
	ALTER TABLE Hecho.OrdenCotizacion ADD [CotizacionDuplicada] [bit] -- 
	ALTER TABLE Hecho.OrdenCotizacion ADD [procurementFolderID] [varchar](50) -- 
	ALTER TABLE Hecho.OrdenCotizacion ADD [DireccionEntrega1] [varchar](50) --
	ALTER TABLE Hecho.OrdenCotizacion ADD [DireccionEntrega2] [varchar](50) --
	ALTER TABLE Hecho.OrdenCotizacion ADD [MarcadoEntrega] [bit] --
	ALTER TABLE Hecho.OrdenCotizacion ADD [CodigoPostal_Cotizacion]  [varchar](10) --
	ALTER TABLE Hecho.OrdenCotizacion ADD [LeidoPorPlantaReparacion] [bit] --
	ALTER TABLE Hecho.OrdenCotizacion ADD [LeidoPorPlantaReparacionFecha] [datetime] --
	ALTER TABLE Hecho.OrdenCotizacion ADD [CotizacionReabierta] [bit] -- 
	ALTER TABLE Hecho.OrdenCotizacion ADD [EsAseguradora] [bit] --
	ALTER TABLE Hecho.OrdenCotizacion ADD [CodigoVerificacion] [varchar](50) -- 
	ALTER TABLE Hecho.OrdenCotizacion ADD [FechaCreacionRegistro_Cotizacion] [datetime] -- 
	ALTER TABLE Hecho.OrdenCotizacion ADD [PartnerConfirmado] [bit] -- 
	ALTER TABLE Hecho.OrdenCotizacion ADD [WrittenBy] [varchar](80) --
	ALTER TABLE Hecho.OrdenCotizacion ADD [SeguroValidado] [bit] -- 
	ALTER TABLE Hecho.OrdenCotizacion ADD [FechaCaptura] [datetime] -- 
	ALTER TABLE Hecho.OrdenCotizacion ADD [Ruta] [varchar](500)
	ALTER TABLE Hecho.OrdenCotizacion ADD [FechaLimiteRuta] [datetime]

	ALTER TABLE Hecho.OrdenCotizacion ADD [OETipoParte] [varchar](10) --
    ALTER TABLE Hecho.OrdenCotizacion ADD [AltPartNum]  [varchar](45) --
    ALTER TABLE Hecho.OrdenCotizacion ADD [AltTipoParte] [varchar](45) --
    ALTER TABLE Hecho.OrdenCotizacion ADD [ciecaTipoParte] [varchar](45) --
	ALTER TABLE Hecho.OrdenCotizacion ADD [CantidadCotizacion] [int]  --
	ALTER TABLE Hecho.OrdenCotizacion ADD [TotalCotizacion] [decimal](24, 2) --VER TIPO DE DATO porque es calculada
    ALTER TABLE Hecho.OrdenCotizacion ADD [PrecioListaOnRO] [varchar](10) --
    ALTER TABLE Hecho.OrdenCotizacion ADD [PrecioNetoOnRO] [varchar](10) --
    ALTER TABLE Hecho.OrdenCotizacion ADD [NecesitadoParaFecha] [datetime] --

	ALTER TABLE Hecho.OrdenCotizacion ADD [OrigenOrden] [varchar](50)--Se llena con ETL
	--Columnas Auditoria
	ALTER TABLE Hecho.OrdenCotizacion ADD FechaCreacion DATETIME NULL DEFAULT(GETDATE())
	ALTER TABLE Hecho.OrdenCotizacion ADD UsuarioCreacion NVARCHAR(100) NULL DEFAULT(SUSER_NAME())
	ALTER TABLE Hecho.OrdenCotizacion ADD FechaModificacion DATETIME NULL
	ALTER TABLE Hecho.OrdenCotizacion ADD UsuarioModificacion NVARCHAR(100) NULL
	--Columnas Linaje
	ALTER TABLE Hecho.OrdenCotizacion ADD ID_Batch UNIQUEIDENTIFIER NULL
	ALTER TABLE Hecho.OrdenCotizacion ADD ID_SourceSystem VARCHAR(50)	

--DimDescuento	
	ALTER TABLE Dimension.Descuento ADD ID_Descuento [int] NOT NULL --
	ALTER TABLE Dimension.Descuento ADD NombreDescuento  [varchar](200) NOT NULL --
	ALTER TABLE Dimension.Descuento ADD PorcentajeDescuento [decimal](2, 2) NOT NULL --
	--Columnas Auditoria
	ALTER TABLE Dimension.Descuento ADD FechaCreacion DATETIME NULL DEFAULT(GETDATE())
	ALTER TABLE Dimension.Descuento ADD UsuarioCreacion NVARCHAR(100) NULL DEFAULT(SUSER_NAME())
	ALTER TABLE Dimension.Descuento ADD FechaModificacion DATETIME NULL
	ALTER TABLE Dimension.Descuento ADD UsuarioModificacion NVARCHAR(100) NULL
	--Columnas Linaje
	ALTER TABLE Dimension.Descuento ADD ID_Batch UNIQUEIDENTIFIER NULL
	ALTER TABLE Dimension.Descuento ADD ID_SourceSystem VARCHAR(50)	

--DimFecha	
	ALTER TABLE Dimension.Fecha ADD [Date] DATE NOT NULL
    ALTER TABLE Dimension.Fecha ADD [Day] TINYINT NOT NULL
	ALTER TABLE Dimension.Fecha ADD [DaySuffix] CHAR(2) NOT NULL
	ALTER TABLE Dimension.Fecha ADD [Weekday] TINYINT NOT NULL
	ALTER TABLE Dimension.Fecha ADD [WeekDayName] VARCHAR(10) NOT NULL
	ALTER TABLE Dimension.Fecha ADD [WeekDayName_Short] CHAR(3) NOT NULL
	ALTER TABLE Dimension.Fecha ADD [WeekDayName_FirstLetter] CHAR(1) NOT NULL
	ALTER TABLE Dimension.Fecha ADD [DOWInMonth] TINYINT NOT NULL
	ALTER TABLE Dimension.Fecha ADD [DayOfYear] SMALLINT NOT NULL
	ALTER TABLE Dimension.Fecha ADD [WeekOfMonth] TINYINT NOT NULL
	ALTER TABLE Dimension.Fecha ADD [WeekOfYear] TINYINT NOT NULL
	ALTER TABLE Dimension.Fecha ADD [Month] TINYINT NOT NULL
	ALTER TABLE Dimension.Fecha ADD [MonthName] VARCHAR(10) NOT NULL
	ALTER TABLE Dimension.Fecha ADD [MonthName_Short] CHAR(3) NOT NULL
	ALTER TABLE Dimension.Fecha ADD [MonthName_FirstLetter] CHAR(1) NOT NULL
	ALTER TABLE Dimension.Fecha ADD [Quarter] TINYINT NOT NULL
	ALTER TABLE Dimension.Fecha ADD [QuarterName] VARCHAR(6) NOT NULL
	ALTER TABLE Dimension.Fecha ADD [Year] INT NOT NULL
	ALTER TABLE Dimension.Fecha ADD [MMYYYY] CHAR(6) NOT NULL
	ALTER TABLE Dimension.Fecha ADD [MonthYear] CHAR(7) NOT NULL
    ALTER TABLE Dimension.Fecha ADD IsWeekend BIT NOT NULL	
  
--DimPartes
	ALTER TABLE Dimension.Partes ADD ID_Parte [varchar](50) --
	ALTER TABLE Dimension.Partes ADD ID_Categoria [int] --
	ALTER TABLE Dimension.Partes ADD ID_Linea [int] --
	ALTER TABLE Dimension.Partes ADD NombreParte [varchar](100) --
	ALTER TABLE Dimension.Partes ADD Precio [decimal](12, 2)  -- SCD Tipo 2 --
	ALTER TABLE Dimension.Partes ADD NombreCategoria [varchar](100) --
	ALTER TABLE Dimension.Partes ADD NombreLinea [varchar](100) --
	--Columnas SCD Tipo 2
	ALTER TABLE Dimension.Partes ADD [FechaInicioValidez] DATETIME NOT NULL DEFAULT(GETDATE())
	ALTER TABLE Dimension.Partes ADD [FechaFinValidez] DATETIME NULL
	--Columnas Auditoria
	ALTER TABLE Dimension.Partes ADD FechaCreacion DATETIME NOT NULL DEFAULT(GETDATE())
	ALTER TABLE Dimension.Partes ADD UsuarioCreacion NVARCHAR(100) NOT NULL DEFAULT(SUSER_NAME())
	ALTER TABLE Dimension.Partes ADD FechaModificacion DATETIME NULL
	ALTER TABLE Dimension.Partes ADD UsuarioModificacion NVARCHAR(100) NULL
	--Columnas Linaje
	ALTER TABLE Dimension.Partes ADD ID_Batch UNIQUEIDENTIFIER NULL
	ALTER TABLE Dimension.Partes ADD ID_SourceSystem VARCHAR(50)
	
	--DimGeografia
	ALTER TABLE Dimension.Geografia ADD ID_Ciudad [int]
	ALTER TABLE Dimension.Geografia ADD ID_Region [int]
	ALTER TABLE Dimension.Geografia ADD ID_Pais [int]
	ALTER TABLE Dimension.Geografia ADD NombreCiudad [varchar](100)
	ALTER TABLE Dimension.Geografia ADD CodigoPostal [varchar](50)
	ALTER TABLE Dimension.Geografia ADD NombreRegion [varchar](100)
	ALTER TABLE Dimension.Geografia ADD NombrePais [varchar](100)
	--Columnas Auditoria
	ALTER TABLE Dimension.Geografia ADD FechaCreacion DATETIME NOT NULL DEFAULT(GETDATE())
	ALTER TABLE Dimension.Geografia ADD UsuarioCreacion NVARCHAR(100) NOT NULL DEFAULT(SUSER_NAME())
	ALTER TABLE Dimension.Geografia ADD FechaModificacion DATETIME NULL
	ALTER TABLE Dimension.Geografia ADD UsuarioModificacion NVARCHAR(100) NULL
	--Columnas Linaje
	ALTER TABLE Dimension.Geografia ADD ID_Batch UNIQUEIDENTIFIER NULL
	ALTER TABLE Dimension.Geografia ADD ID_SourceSystem VARCHAR(50)


--DimClientes
	ALTER TABLE Dimension.Clientes ADD ID_Cliente [int]
	--ALTER TABLE Dimension.Clientes ADD NombreCliente [varchar](200) --COMBINA PRIMERO Y SEGUNDO NOMBRE
	--ALTER TABLE Dimension.Clientes ADD ApellidoCliente [varchar](200) -- COMBINA PRIMER Y SEGUNDO APELLIDO
	ALTER TABLE Dimension.Clientes ADD Genero [char](1)
	ALTER TABLE Dimension.Clientes ADD Correo_Electronico [varchar](100)
	ALTER TABLE Dimension.Clientes ADD Direccion [varchar](1000)
	ALTER TABLE Dimension.Clientes ADD FechaNacimiento [datetime] -- SCD Tipo 0
	--Columnas Auditoria
	ALTER TABLE Dimension.Clientes ADD FechaCreacion DATETIME NOT NULL DEFAULT(GETDATE())
	ALTER TABLE Dimension.Clientes ADD UsuarioCreacion NVARCHAR(100) NOT NULL DEFAULT(SUSER_NAME())
	ALTER TABLE Dimension.Clientes ADD FechaModificacion DATETIME NULL
	ALTER TABLE Dimension.Clientes ADD UsuarioModificacion NVARCHAR(100) NULL
	--Columnas Linaje
	ALTER TABLE Dimension.Clientes ADD ID_Batch UNIQUEIDENTIFIER NULL
	ALTER TABLE Dimension.Clientes ADD ID_SourceSystem VARCHAR(50)

--DimVehiculo
	ALTER TABLE Dimension.Vehiculo ADD [VehiculoID] [int]
	ALTER TABLE Dimension.Vehiculo ADD [VIN_Patron] [varchar](10)
	ALTER TABLE Dimension.Vehiculo ADD [Anio] [smallint] 
	ALTER TABLE Dimension.Vehiculo ADD [Marca] [varchar](24)
	ALTER TABLE Dimension.Vehiculo ADD [Modelo] [varchar](32)
	ALTER TABLE Dimension.Vehiculo ADD [SubModelo] [varchar](48)
	ALTER TABLE Dimension.Vehiculo ADD [Estilo] [varchar](128)
	ALTER TABLE Dimension.Vehiculo ADD [FechaCreacionSource] [datetime]  -- SCD Tipo 0
	--Columnas Auditoria
	ALTER TABLE Dimension.Vehiculo ADD FechaCreacion DATETIME NOT NULL DEFAULT(GETDATE())
	ALTER TABLE Dimension.Vehiculo ADD UsuarioCreacion NVARCHAR(100) NOT NULL DEFAULT(SUSER_NAME())
	ALTER TABLE Dimension.Vehiculo ADD FechaModificacion DATETIME NULL
	ALTER TABLE Dimension.Vehiculo ADD UsuarioModificacion NVARCHAR(100) NULL
	--Columnas Linaje
	ALTER TABLE Dimension.Vehiculo ADD ID_Batch UNIQUEIDENTIFIER NULL
	ALTER TABLE Dimension.Vehiculo ADD ID_SourceSystem VARCHAR(50)

--DimAseguradoras
    ALTER TABLE Dimension.Aseguradoras ADD [IDAseguradora] [int]
    ALTER TABLE Dimension.Aseguradoras ADD [NombreAseguradora] [varchar](80) 
    ALTER TABLE Dimension.Aseguradoras ADD [Activa_Aseguradora] [bit]
	--Columnas Auditoria
	ALTER TABLE Dimension.Aseguradoras ADD FechaCreacion DATETIME NOT NULL DEFAULT(GETDATE())
	ALTER TABLE Dimension.Aseguradoras ADD UsuarioCreacion NVARCHAR(100) NOT NULL DEFAULT(SUSER_NAME())
	ALTER TABLE Dimension.Aseguradoras ADD FechaModificacion DATETIME NULL
	ALTER TABLE Dimension.Aseguradoras ADD UsuarioModificacion NVARCHAR(100) NULL
	--Columnas Linaje	  
	ALTER TABLE Dimension.Aseguradoras ADD ID_Batch UNIQUEIDENTIFIER NULL
	ALTER TABLE Dimension.Aseguradoras ADD ID_SourceSystem VARCHAR(50)

--DimPlantaReparacion
    ALTER TABLE Dimension.PlantaReparacion ADD [IDPlantaReparacion] [varchar](50)
    ALTER TABLE Dimension.PlantaReparacion ADD [CompanyNombre] [varchar](50)
    ALTER TABLE Dimension.PlantaReparacion ADD [Ciudad] [varchar](50)
	ALTER TABLE Dimension.PlantaReparacion ADD [Estado] [varchar](50)
	ALTER TABLE Dimension.PlantaReparacion ADD [CodigoPostal_PlantaReparacion] [varchar](10) 
	ALTER TABLE Dimension.PlantaReparacion ADD [Pais] [varchar](4) 
	ALTER TABLE Dimension.PlantaReparacion ADD [AlmacenKeystone] [varchar](3) 
	ALTER TABLE Dimension.PlantaReparacion ADD [LocalizadorCotizacion] [varchar](4) 
	ALTER TABLE Dimension.PlantaReparacion ADD [FechaAgregado] [datetime] --SCD Tipo 0
	ALTER TABLE Dimension.PlantaReparacion ADD [ValidacionSeguro] [bit]
	ALTER TABLE Dimension.PlantaReparacion ADD [Activo_PlantaReparacion] [bit]
	--Columnas Auditoria
	ALTER TABLE Dimension.PlantaReparacion ADD FechaCreacion DATETIME NOT NULL DEFAULT(GETDATE())
	ALTER TABLE Dimension.PlantaReparacion ADD UsuarioCreacion NVARCHAR(100) NOT NULL DEFAULT(SUSER_NAME())
	ALTER TABLE Dimension.PlantaReparacion ADD FechaModificacion DATETIME NULL
	ALTER TABLE Dimension.PlantaReparacion ADD UsuarioModificacion NVARCHAR(100) NULL
	--Columnas Linaje	  
	ALTER TABLE Dimension.PlantaReparacion ADD ID_Batch UNIQUEIDENTIFIER NULL
	ALTER TABLE Dimension.PlantaReparacion ADD ID_SourceSystem VARCHAR(50)


	
--DimStatusOrden
	ALTER TABLE Dimension.StatusOrden ADD ID_StatusOrden [int]
	ALTER TABLE Dimension.StatusOrden ADD NombreStatus [varchar](100)
	--Columnas Auditoria
	ALTER TABLE Dimension.StatusOrden ADD FechaCreacion DATETIME NOT NULL DEFAULT(GETDATE())
	ALTER TABLE Dimension.StatusOrden ADD UsuarioCreacion NVARCHAR(100) NOT NULL DEFAULT(SUSER_NAME())
	ALTER TABLE Dimension.StatusOrden ADD FechaModificacion DATETIME NULL
	ALTER TABLE Dimension.StatusOrden ADD UsuarioModificacion NVARCHAR(100) NULL
	--Columnas Linaje	  
	ALTER TABLE Dimension.StatusOrden ADD ID_Batch UNIQUEIDENTIFIER NULL
	ALTER TABLE Dimension.StatusOrden ADD ID_SourceSystem VARCHAR(50)