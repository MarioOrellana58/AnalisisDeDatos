USE [RepuestosWebDWH]
GO

DECLARE @myid uniqueidentifier = NEWID();  
SELECT CONVERT(CHAR(255), @myid) AS 'char' ;

INSERT INTO [Dimension].[Clientes]
           ([ID_Cliente]
           ,[Genero]
           ,[Correo_Electronico]
           ,[Direccion]
           ,[FechaNacimiento]
           ,[FechaCreacion]
           ,[UsuarioCreacion]
           ,[FechaModificacion]
           ,[UsuarioModificacion]
           ,[ID_Batch]
           ,[ID_SourceSystem])
SELECT	   C.ID_Cliente
			  ,C.Genero
			  ,C.Correo_Electronico
			  ,C.Direccion
			  ,C.FechaNacimiento
			  --Columnas Auditoria
			  ,GETDATE() AS FechaCreacion
			  ,CAST(SUSER_NAME() AS nvarchar(100)) AS UsuarioCreacion
			  ,GETDATE() AS FechaModificacion
			  ,CAST(SUSER_NAME() AS nvarchar(100)) AS UsuarioModificacion
			  ,@myid
			  ,'LKASNDG978W4HG99BW34'

	FROM RepuestosWeb.dbo.Clientes C
GO


