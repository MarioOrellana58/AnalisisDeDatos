USE [RepuestosWebDWH]
GO


DECLARE @myid uniqueidentifier = NEWID();  
SELECT CONVERT(CHAR(255), @myid) AS 'char'; 

INSERT INTO [Dimension].[Partes]
           ([ID_Parte]
           ,[ID_Categoria]
           ,[ID_Linea]
           ,[NombreParte]
           ,[Precio]
           ,[NombreCategoria]
           ,[NombreLinea]
           ,[FechaInicioValidez]
           ,[FechaFinValidez]
           ,[FechaCreacion]
           ,[UsuarioCreacion]
           ,[FechaModificacion]
           ,[UsuarioModificacion]
           ,[ID_Batch]
           ,[ID_SourceSystem])
SELECT P.[ID_Parte]
      ,C.[ID_Categoria]
      ,L.[ID_Linea]
      ,P.[Nombre] AS [NombreParte]
      ,P.[Precio]
      ,C.[Nombre] AS [NombreCategoria]
      ,L.[Nombre] AS [NombreLinea]
	  ,GETDATE() AS [FechaInicioValidez]
	  , NULL AS [FechaFinValidez]
	--Columnas Auditoria
	  ,GETDATE() AS FechaCreacion
	  ,CAST(SUSER_NAME() AS nvarchar(100)) AS UsuarioCreacion
	  ,GETDATE() AS FechaModificacion
	  ,CAST(SUSER_NAME() AS nvarchar(100)) AS UsuarioModificacion
	  ,@myid
	  ,'ASLKDNVA894GBNKASJ9'
  FROM [RepuestosWeb].[dbo].[Partes] P
	INNER JOIN  [RepuestosWeb].[dbo].Categoria C ON P.ID_Categoria = C.ID_Categoria
	INNER JOIN  [RepuestosWeb].[dbo].Linea L ON C.ID_Linea = L.ID_Linea
GO


