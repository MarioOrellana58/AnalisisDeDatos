USE [RepuestosWebDWH]
GO

DECLARE @myid uniqueidentifier = NEWID();  
SELECT CONVERT(CHAR(255), @myid) AS 'char' ;

INSERT INTO [Dimension].[Aseguradoras]
           ([IDAseguradora]
           ,[NombreAseguradora]
           ,[Activa_Aseguradora]
           ,[FechaCreacion]
           ,[UsuarioCreacion]
           ,[FechaModificacion]
           ,[UsuarioModificacion]
           ,[ID_Batch]
           ,[ID_SourceSystem])
SELECT [IDAseguradora]
      ,[NombreAseguradora]
      ,[Activa] AS [Activa_Aseguradora]
	--Columnas Auditoria
	  ,GETDATE() AS FechaCreacion
	  ,CAST(SUSER_NAME() AS nvarchar(100)) AS UsuarioCreacion
	  ,GETDATE() AS FechaModificacion
	  ,CAST(SUSER_NAME() AS nvarchar(100)) AS UsuarioModificacion
	  ,@myid
	  ,'KSDNVB94A8WHNV0PAS8GB302'

  FROM [RepuestosWeb].[dbo].[Aseguradoras]
GO


