USE [RepuestosWebDWH]
GO

DECLARE @myid uniqueidentifier = NEWID();  
SELECT CONVERT(CHAR(255), @myid) AS 'char'; 

INSERT INTO [Dimension].[PlantaReparacion]
           ([IDPlantaReparacion]
           ,[CompanyNombre]
           ,[Ciudad]
           ,[Estado]
           ,[CodigoPostal_PlantaReparacion]
           ,[Pais]
           ,[AlmacenKeystone]
           ,[LocalizadorCotizacion]
           ,[FechaAgregado]
           ,[ValidacionSeguro]
           ,[Activo_PlantaReparacion]
           ,[FechaCreacion]
           ,[UsuarioCreacion]
           ,[FechaModificacion]
           ,[UsuarioModificacion]
           ,[ID_Batch]
           ,[ID_SourceSystem])
SELECT [IDPlantaReparacion]
      ,[CompanyNombre]
      ,[Ciudad]
      ,[Estado]
      ,[CodigoPostal] AS [CodigoPostal_PlantaReparacion]
      ,[Pais]
      ,[AlmacenKeystone]
      ,[LocalizadorCotizacion]
      ,[FechaAgregado]
      ,[ValidacionSeguro]
      ,[Activo] AS [Activo_PlantaReparacion]
	  --Columnas Auditoria
	  ,GETDATE() AS FechaCreacion
	  ,CAST(SUSER_NAME() AS nvarchar(100)) AS UsuarioCreacion
	  ,GETDATE() AS FechaModificacion
	  ,CAST(SUSER_NAME() AS nvarchar(100)) AS UsuarioModificacion
	  ,@myid
	  ,'PAOSJG0AWBGHV88922GE'
  FROM [RepuestosWeb].[dbo].[PlantaReparacion]
GO


