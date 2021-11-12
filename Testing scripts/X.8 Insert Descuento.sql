USE [RepuestosWebDWH]
GO

DECLARE @myid uniqueidentifier = NEWID();  
SELECT CONVERT(CHAR(255), @myid) AS 'char'; 

INSERT INTO [Dimension].[Descuento]
           ([ID_Descuento]
           ,[NombreDescuento]
           ,[PorcentajeDescuento]
           ,[FechaCreacion]
           ,[UsuarioCreacion]
           ,[FechaModificacion]
           ,[UsuarioModificacion]
           ,[ID_Batch]
           ,[ID_SourceSystem])
SELECT [ID_Descuento]
      ,[NombreDescuento]
      ,[PorcentajeDescuento]
	  --Columnas Auditoria
	  ,GETDATE() AS FechaCreacion
	  ,CAST(SUSER_NAME() AS nvarchar(100)) AS UsuarioCreacion
	  ,GETDATE() AS FechaModificacion
	  ,CAST(SUSER_NAME() AS nvarchar(100)) AS UsuarioModificacion
	  ,@myid
	  ,'LIASH90Y4QH0NS8DBF39'
  FROM [RepuestosWeb].[dbo].[Descuento]
GO


