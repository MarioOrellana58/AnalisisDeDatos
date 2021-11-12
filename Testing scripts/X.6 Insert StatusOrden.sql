USE [RepuestosWebDWH]
GO


DECLARE @myid uniqueidentifier = NEWID();  
SELECT CONVERT(CHAR(255), @myid) AS 'char'; 

INSERT INTO [Dimension].[StatusOrden]
           ([ID_StatusOrden]
           ,[NombreStatus]
           ,[FechaCreacion]
           ,[UsuarioCreacion]
           ,[FechaModificacion]
           ,[UsuarioModificacion]
           ,[ID_Batch]
           ,[ID_SourceSystem])
SELECT [ID_StatusOrden]
      ,[NombreStatus]
	  --Columnas Auditoria
	  ,GETDATE() AS FechaCreacion
	  ,CAST(SUSER_NAME() AS nvarchar(100)) AS UsuarioCreacion
	  ,GETDATE() AS FechaModificacion
	  ,CAST(SUSER_NAME() AS nvarchar(100)) AS UsuarioModificacion
	  ,@myid
	  ,'KASH9W4BGA8SBN01INASDF'
  FROM [RepuestosWeb].[dbo].[StatusOrden]
GO


