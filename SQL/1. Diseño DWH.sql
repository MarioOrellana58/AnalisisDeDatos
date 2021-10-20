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

--Enteros
 --User Defined Type _ Surrogate Key
	--Tipo para SK entero: Surrogate Key
	CREATE TYPE [UDT_SK] FROM INT
	GO

	--Tipo para PK INT
	CREATE TYPE [UDT_PK] FROM INT

	--Tipo para PK varchar
	CREATE TYPE [UDT_PK_VARCHAR] FROM VARCHAR(100)
	GO

--Cadenas
	--Tipo para cadenas medianas
	CREATE TYPE [UDT_VarcharLargo] FROM VARCHAR(600)
	GO

	--Tipo para cadenas medianas
	CREATE TYPE [UDT_VarcharMediano] FROM VARCHAR(300)
	GO

	--Tipo para cadenas cortas
	CREATE TYPE [UDT_VarcharCorto] FROM VARCHAR(100)
	GO

	--Tipo para cadenas m�s cortas
	CREATE TYPE [UDT_VarcharTiny] FROM VARCHAR(50)
	GO

	--Tipo para cadenas cortas
	CREATE TYPE [UDT_UnCaracter] FROM CHAR(1)
	GO

--Decimal

	--Tipo Decimal 2,2
	CREATE TYPE [UDT_Decimal2.2] FROM DECIMAL(2,2)
	GO

	--Tipo Decimal 12,2
	CREATE TYPE [UDT_Decimal12.2] FROM DECIMAL(12,2)
	GO

--Fechas
	CREATE TYPE [UDT_DateTime] FROM DATETIME
	GO

--Bit
	CREATE TYPE [UDT_Bit] FROM BIT
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
		SK_Parte [UDT_SK] PRIMARY KEY IDENTITY
	)
	GO

	CREATE TABLE Dimension.Geografia
	(
		SK_Geografia [UDT_SK] PRIMARY KEY IDENTITY
	)
	GO

	CREATE TABLE Dimension.Clientes
	(
		SK_Cliente [UDT_SK] PRIMARY KEY IDENTITY
	)
	GO
	
	CREATE TABLE Dimension.Vehiculo
	(
		SK_Vehiculo [UDT_SK] PRIMARY KEY IDENTITY
	)
	GO
	
	CREATE TABLE Dimension.Aseguradoras
	(
		SK_Aseguradora [UDT_SK] PRIMARY KEY IDENTITY
	)
	GO
	
	CREATE TABLE Dimension.PlantaReparacion
	(
		SK_PlantaReparacion [UDT_SK] PRIMARY KEY IDENTITY
	)
	GO
	
	CREATE TABLE Dimension.StatusOrden
	(
		SK_StatusOrden [UDT_SK] PRIMARY KEY IDENTITY
	)
	GO
	
	CREATE TABLE Dimension.Descuento
	(
		SK_Descuento [UDT_SK] PRIMARY KEY IDENTITY
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
		SK_OrdenCotizacion [UDT_SK] PRIMARY KEY IDENTITY,
		SK_Parte [UDT_SK] REFERENCES Dimension.Partes(SK_Parte),
		SK_Geografia [UDT_SK] REFERENCES Dimension.Geografia(SK_Geografia),
		SK_Cliente [UDT_SK] REFERENCES Dimension.Clientes(SK_Cliente),
		SK_Vehiculo [UDT_SK] REFERENCES Dimension.Vehiculo(SK_Vehiculo),
		SK_Descuento [UDT_SK] REFERENCES Dimension.Descuento(SK_Descuento),
		SK_Aseguradora [UDT_SK] REFERENCES Dimension.Aseguradoras(SK_Aseguradora),
		SK_PlantaReparacion [UDT_SK] REFERENCES Dimension.PlantaReparacion(SK_PlantaReparacion),
		SK_StatusOrden [UDT_SK] REFERENCES Dimension.StatusOrden(SK_StatusOrden),
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
	ALTER TABLE Hecho.OrdenCotizacion ADD ID_Orden [UDT_PK]
	ALTER TABLE Hecho.OrdenCotizacion ADD ID_Cliente [UDT_PK]
	ALTER TABLE Hecho.OrdenCotizacion ADD ID_Ciudad [UDT_PK]
	ALTER TABLE Hecho.OrdenCotizacion ADD [IDCotizacion] [UDT_PK]
	ALTER TABLE Hecho.OrdenCotizacion ADD [ID_StatusOrden] [UDT_PK]
	ALTER TABLE Hecho.OrdenCotizacion ADD ID_DetalleOrden [UDT_PK]	
	ALTER TABLE Hecho.OrdenCotizacion ADD ID_Descuento [UDT_PK]		
    ALTER TABLE Hecho.OrdenCotizacion ADD [NumLinea] [UDT_PK]
    ALTER TABLE Hecho.OrdenCotizacion ADD [VehiculoID] [UDT_PK]
    ALTER TABLE Hecho.OrdenCotizacion ADD [ID_Parte] [UDT_PK_VARCHAR]
    ALTER TABLE Hecho.OrdenCotizacion ADD [IDAseguradora] [UDT_PK]
	ALTER TABLE Hecho.OrdenCotizacion ADD [IDPlantaReparacion] [UDT_PK]
	
	ALTER TABLE Hecho.OrdenCotizacion ADD [IDPartner] [UDT_VarcharTiny]
	ALTER TABLE Hecho.OrdenCotizacion ADD [IDClientePlantaReparacion] [UDT_VarcharTiny]
	ALTER TABLE Hecho.OrdenCotizacion ADD [IDRecotizacion] [UDT_VarcharCorto]
	
	ALTER TABLE Hecho.OrdenCotizacion ADD Total_Orden [UDT_Decimal12.2]
	ALTER TABLE Hecho.OrdenCotizacion ADD Fecha_Orden [UDT_DateTime]
	ALTER TABLE Hecho.OrdenCotizacion ADD NumeroOrden [UDT_VarcharTiny]

	ALTER TABLE Hecho.OrdenCotizacion ADD [status] [UDT_VarcharTiny] 
	ALTER TABLE Hecho.OrdenCotizacion ADD [TipoDocumento] [UDT_VarcharTiny] 
	ALTER TABLE Hecho.OrdenCotizacion ADD [FechaCreacionCotizacion] [UDT_DateTime]
	ALTER TABLE Hecho.OrdenCotizacion ADD [ProcesadoPor] [UDT_VarcharTiny] 
	ALTER TABLE Hecho.OrdenCotizacion ADD [AseguradoraSubsidiaria] [UDT_VarcharCorto] 
	ALTER TABLE Hecho.OrdenCotizacion ADD [NumeroReclamo] [UDT_VarcharTiny] 
	ALTER TABLE Hecho.OrdenCotizacion ADD [OrdenRealizada] [UDT_Bit] 
	ALTER TABLE Hecho.OrdenCotizacion ADD [CotizacionRealizada] [UDT_Bit] 
	ALTER TABLE Hecho.OrdenCotizacion ADD [CotizacionDuplicada] [UDT_Bit] 
	ALTER TABLE Hecho.OrdenCotizacion ADD [procurementFolderID] [UDT_VarcharTiny] 
	ALTER TABLE Hecho.OrdenCotizacion ADD [DireccionEntrega1] [UDT_VarcharTiny]
	ALTER TABLE Hecho.OrdenCotizacion ADD [DireccionEntrega2] [UDT_VarcharTiny]
	ALTER TABLE Hecho.OrdenCotizacion ADD [MarcadoEntrega] [UDT_Bit]
	ALTER TABLE Hecho.OrdenCotizacion ADD [CodigoPostal_Cotizacion]  [UDT_VarcharTiny]
	ALTER TABLE Hecho.OrdenCotizacion ADD [LeidoPorPlantaReparacion] [UDT_Bit]
	ALTER TABLE Hecho.OrdenCotizacion ADD [LeidoPorPlantaReparacionFecha] [UDT_DateTime]
	ALTER TABLE Hecho.OrdenCotizacion ADD [CotizacionReabierta] [UDT_Bit] 
	ALTER TABLE Hecho.OrdenCotizacion ADD [EsAseguradora] [UDT_Bit]
	ALTER TABLE Hecho.OrdenCotizacion ADD [CodigoVerificacion] [UDT_VarcharTiny] 
	ALTER TABLE Hecho.OrdenCotizacion ADD [FechaCreacionRegistro_Cotizacion] [UDT_DateTime] 
	ALTER TABLE Hecho.OrdenCotizacion ADD [PartnerConfirmado] [UDT_Bit] 
	ALTER TABLE Hecho.OrdenCotizacion ADD [WrittenBy] [UDT_VarcharCorto]
	ALTER TABLE Hecho.OrdenCotizacion ADD [SeguroValidado] [UDT_Bit] 
	ALTER TABLE Hecho.OrdenCotizacion ADD [FechaCaptura] [UDT_DateTime] 
	ALTER TABLE Hecho.OrdenCotizacion ADD [IDOrden] INT 
	ALTER TABLE Hecho.OrdenCotizacion ADD [Ruta] [UDT_VarcharLargo]
	ALTER TABLE Hecho.OrdenCotizacion ADD [FechaLimiteRuta] [UDT_DateTime]

	ALTER TABLE Hecho.OrdenCotizacion ADD [OETipoParte] [UDT_VarcharTiny]
    ALTER TABLE Hecho.OrdenCotizacion ADD [AltPartNum] [UDT_VarcharTiny]
    ALTER TABLE Hecho.OrdenCotizacion ADD [AltTipoParte] [UDT_VarcharTiny]
    ALTER TABLE Hecho.OrdenCotizacion ADD [ciecaTipoParte] [UDT_VarcharTiny]
    ALTER TABLE Hecho.OrdenCotizacion ADD [Cantidad] INT  
    ALTER TABLE Hecho.OrdenCotizacion ADD [PrecioListaOnRO] [UDT_VarcharTiny]
    ALTER TABLE Hecho.OrdenCotizacion ADD [PrecioNetoOnRO] [UDT_VarcharTiny]
    ALTER TABLE Hecho.OrdenCotizacion ADD [NecesitadoParaFecha] [UDT_DateTime] 

	ALTER TABLE Hecho.OrdenCotizacion ADD [OrigenOrden] [UDT_VarcharTiny] 
	--Columnas Auditoria
	ALTER TABLE Hecho.OrdenCotizacion ADD FechaCreacion DATETIME NULL DEFAULT(GETDATE())
	ALTER TABLE Hecho.OrdenCotizacion ADD UsuarioCreacion NVARCHAR(100) NULL DEFAULT(SUSER_NAME())
	ALTER TABLE Hecho.OrdenCotizacion ADD FechaModificacion DATETIME NULL
	ALTER TABLE Hecho.OrdenCotizacion ADD UsuarioModificacion NVARCHAR(100) NULL
	--Columnas Linaje
	ALTER TABLE Hecho.OrdenCotizacion ADD ID_Batch UNIQUEIDENTIFIER NULL
	ALTER TABLE Hecho.OrdenCotizacion ADD ID_SourceSystem VARCHAR(50)	

--DimDescuento	
	ALTER TABLE Dimension.Descuento ADD ID_Descuento [UDT_PK] NOT NULL
	ALTER TABLE Dimension.Descuento ADD NombreDescuento [UDT_VarcharMediano] NOT NULL
	ALTER TABLE Dimension.Descuento ADD PorcentajeDescuento [UDT_Decimal2.2] NOT NULL
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
	ALTER TABLE Dimension.Partes ADD ID_Partes [UDT_PK_VARCHAR]
	ALTER TABLE Dimension.Partes ADD ID_Categoria [UDT_PK]
	ALTER TABLE Dimension.Partes ADD ID_Linea [UDT_PK]
	ALTER TABLE Dimension.Partes ADD NombreParte [UDT_VarcharCorto]
	ALTER TABLE Dimension.Partes ADD Precio [UDT_Decimal12.2]  -- SCD Tipo 2
	ALTER TABLE Dimension.Partes ADD NombreCategoria [UDT_VarcharCorto]
	ALTER TABLE Dimension.Partes ADD NombreLinea [UDT_VarcharCorto]
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
	ALTER TABLE Dimension.Geografia ADD ID_Ciudad [UDT_PK]
	ALTER TABLE Dimension.Geografia ADD ID_Region [UDT_PK]
	ALTER TABLE Dimension.Geografia ADD ID_Pais [UDT_PK]
	ALTER TABLE Dimension.Geografia ADD NombreCiudad [UDT_VarcharCorto]
	ALTER TABLE Dimension.Geografia ADD CodigoPostal [UDT_VarcharTiny]
	ALTER TABLE Dimension.Geografia ADD NombreRegion [UDT_VarcharCorto]
	ALTER TABLE Dimension.Geografia ADD NombrePais [UDT_VarcharCorto]
	--Columnas Auditoria
	ALTER TABLE Dimension.Geografia ADD FechaCreacion DATETIME NOT NULL DEFAULT(GETDATE())
	ALTER TABLE Dimension.Geografia ADD UsuarioCreacion NVARCHAR(100) NOT NULL DEFAULT(SUSER_NAME())
	ALTER TABLE Dimension.Geografia ADD FechaModificacion DATETIME NULL
	ALTER TABLE Dimension.Geografia ADD UsuarioModificacion NVARCHAR(100) NULL
	--Columnas Linaje
	ALTER TABLE Dimension.Geografia ADD ID_Batch UNIQUEIDENTIFIER NULL
	ALTER TABLE Dimension.Geografia ADD ID_SourceSystem VARCHAR(50)


--DimClientes
	ALTER TABLE Dimension.Clientes ADD ID_Cliente [UDT_PK]
	ALTER TABLE Dimension.Clientes ADD NombreCliente [UDT_VarcharMediano] --COMBINA PRIMERO Y SEGUNDO NOMBRE
	ALTER TABLE Dimension.Clientes ADD ApellidoCliente [UDT_VarcharMediano] -- COMBINA PRIMER Y SEGUNDO APELLIDO
	ALTER TABLE Dimension.Clientes ADD Genero [UDT_UnCaracter]
	ALTER TABLE Dimension.Clientes ADD Correo_Electronico [UDT_VarcharCorto]
	ALTER TABLE Dimension.Clientes ADD FechaNacimiento [UDT_DateTime] -- SCD Tipo 0
	--Columnas Auditoria
	ALTER TABLE Dimension.Clientes ADD FechaCreacion DATETIME NOT NULL DEFAULT(GETDATE())
	ALTER TABLE Dimension.Clientes ADD UsuarioCreacion NVARCHAR(100) NOT NULL DEFAULT(SUSER_NAME())
	ALTER TABLE Dimension.Clientes ADD FechaModificacion DATETIME NULL
	ALTER TABLE Dimension.Clientes ADD UsuarioModificacion NVARCHAR(100) NULL
	--Columnas Linaje
	ALTER TABLE Dimension.Clientes ADD ID_Batch UNIQUEIDENTIFIER NULL
	ALTER TABLE Dimension.Clientes ADD ID_SourceSystem VARCHAR(50)

--DimVehiculo
	ALTER TABLE Dimension.Vehiculo ADD [VehiculoID] [UDT_PK]
	ALTER TABLE Dimension.Vehiculo ADD [VIN_Patron] [UDT_VarcharCorto]
	ALTER TABLE Dimension.Vehiculo ADD [Anio] INT 
	ALTER TABLE Dimension.Vehiculo ADD [Marca] [UDT_VarcharCorto]
	ALTER TABLE Dimension.Vehiculo ADD [Modelo] [UDT_VarcharCorto]
	ALTER TABLE Dimension.Vehiculo ADD [SubModelo] [UDT_VarcharCorto]
	ALTER TABLE Dimension.Vehiculo ADD [Estilo] [UDT_VarcharMediano]
	ALTER TABLE Dimension.Vehiculo ADD [FechaCreacionSource] [UDT_DateTime]  -- SCD Tipo 0
	--Columnas Auditoria
	ALTER TABLE Dimension.Vehiculo ADD FechaCreacion DATETIME NOT NULL DEFAULT(GETDATE())
	ALTER TABLE Dimension.Vehiculo ADD UsuarioCreacion NVARCHAR(100) NOT NULL DEFAULT(SUSER_NAME())
	ALTER TABLE Dimension.Vehiculo ADD FechaModificacion DATETIME NULL
	ALTER TABLE Dimension.Vehiculo ADD UsuarioModificacion NVARCHAR(100) NULL
	--Columnas Linaje
	ALTER TABLE Dimension.Vehiculo ADD ID_Batch UNIQUEIDENTIFIER NULL
	ALTER TABLE Dimension.Vehiculo ADD ID_SourceSystem VARCHAR(50)

--DimAseguradoras
    ALTER TABLE Dimension.Aseguradoras ADD [IDAseguradora] [UDT_PK] not null
    ALTER TABLE Dimension.Aseguradoras ADD [NombreAseguradora] [UDT_VarcharCorto] 
    ALTER TABLE Dimension.Aseguradoras ADD [Activa_Aseguradora] [UDT_Bit]
	--Columnas Auditoria
	ALTER TABLE Dimension.Aseguradoras ADD FechaCreacion DATETIME NOT NULL DEFAULT(GETDATE())
	ALTER TABLE Dimension.Aseguradoras ADD UsuarioCreacion NVARCHAR(100) NOT NULL DEFAULT(SUSER_NAME())
	ALTER TABLE Dimension.Aseguradoras ADD FechaModificacion DATETIME NULL
	ALTER TABLE Dimension.Aseguradoras ADD UsuarioModificacion NVARCHAR(100) NULL
	--Columnas Linaje	  
	ALTER TABLE Dimension.Aseguradoras ADD ID_Batch UNIQUEIDENTIFIER NULL
	ALTER TABLE Dimension.Aseguradoras ADD ID_SourceSystem VARCHAR(50)

--DimPlantaReparacion
    ALTER TABLE Dimension.PlantaReparacion ADD [IDPlantaReparacion] [UDT_PK_VARCHAR] not null
    ALTER TABLE Dimension.PlantaReparacion ADD [CompanyNombre] [UDT_VarcharTiny] not null
    ALTER TABLE Dimension.PlantaReparacion ADD [Ciudad] [UDT_VarcharTiny] not null
	ALTER TABLE Dimension.PlantaReparacion ADD [Estado] [UDT_VarcharTiny] not null 
	ALTER TABLE Dimension.PlantaReparacion ADD [CodigoPostal_PlantaReparacion] [UDT_VarcharTiny] not null  
	ALTER TABLE Dimension.PlantaReparacion ADD [Pais] [UDT_VarcharTiny] 
	ALTER TABLE Dimension.PlantaReparacion ADD [AlmacenKeystone] [UDT_VarcharTiny] 
	ALTER TABLE Dimension.PlantaReparacion ADD [LocalizadorCotizacion] [UDT_VarcharTiny] 
	ALTER TABLE Dimension.PlantaReparacion ADD [FechaAgregado] [UDT_DateTime] --SCD Tipo 0
	ALTER TABLE Dimension.PlantaReparacion ADD [ValidacionSeguro] [UDT_Bit]
	ALTER TABLE Dimension.PlantaReparacion ADD [Activo_PlantaReparacion] [UDT_Bit]
	--Columnas Auditoria
	ALTER TABLE Dimension.PlantaReparacion ADD FechaCreacion DATETIME NOT NULL DEFAULT(GETDATE())
	ALTER TABLE Dimension.PlantaReparacion ADD UsuarioCreacion NVARCHAR(100) NOT NULL DEFAULT(SUSER_NAME())
	ALTER TABLE Dimension.PlantaReparacion ADD FechaModificacion DATETIME NULL
	ALTER TABLE Dimension.PlantaReparacion ADD UsuarioModificacion NVARCHAR(100) NULL
	--Columnas Linaje	  
	ALTER TABLE Dimension.PlantaReparacion ADD ID_Batch UNIQUEIDENTIFIER NULL
	ALTER TABLE Dimension.PlantaReparacion ADD ID_SourceSystem VARCHAR(50)


	
--DimStatusOrden
	ALTER TABLE Dimension.StatusOrden ADD ID_StatusOrden [UDT_PK]	not null
	ALTER TABLE Dimension.StatusOrden ADD NombreStatus [UDT_VarcharCorto]	not null
	--Columnas Auditoria
	ALTER TABLE Dimension.StatusOrden ADD FechaCreacion DATETIME NOT NULL DEFAULT(GETDATE())
	ALTER TABLE Dimension.StatusOrden ADD UsuarioCreacion NVARCHAR(100) NOT NULL DEFAULT(SUSER_NAME())
	ALTER TABLE Dimension.StatusOrden ADD FechaModificacion DATETIME NULL
	ALTER TABLE Dimension.StatusOrden ADD UsuarioModificacion NVARCHAR(100) NULL
	--Columnas Linaje	  
	ALTER TABLE Dimension.StatusOrden ADD ID_Batch UNIQUEIDENTIFIER NULL
	ALTER TABLE Dimension.StatusOrden ADD ID_SourceSystem VARCHAR(50)
