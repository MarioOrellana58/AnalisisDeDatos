USE [RepuestosWebDWH]
GO

DECLARE @myid uniqueidentifier = NEWID();  
SELECT CONVERT(CHAR(255), @myid) AS 'char'; 

INSERT INTO [Dimension].[Vehiculo]
           ([VehiculoID]
           ,[VIN_Patron]
           ,[Anio]
           ,[Marca]
           ,[Modelo]
           ,[SubModelo]
           ,[Estilo]
           ,[FechaCreacionSource]
           ,[FechaCreacion]
           ,[UsuarioCreacion]
           ,[FechaModificacion]
           ,[UsuarioModificacion]
           ,[ID_Batch]
           ,[ID_SourceSystem])
SELECT [VehiculoID]
      ,[VIN_Patron]
      ,[Anio]
      ,[Marca]
      ,[Modelo]
      ,[SubModelo]
      ,[Estilo]
      ,[FechaCreacion] AS [FechaCreacionSource]
	  --Columnas Auditoria
	  ,GETDATE() AS FechaCreacion
	  ,CAST(SUSER_NAME() AS nvarchar(100)) AS UsuarioCreacion
	  ,GETDATE() AS FechaModificacion
	  ,CAST(SUSER_NAME() AS nvarchar(100)) AS UsuarioModificacion
	  ,@myid
	  ,'AISUHET9Q8A4BHNVGA0S49'
  FROM [RepuestosWeb].[dbo].[Vehiculo]
GO


