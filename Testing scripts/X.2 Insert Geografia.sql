USE [RepuestosWebDWH]
GO


DECLARE @myid uniqueidentifier = NEWID();  
SELECT CONVERT(CHAR(255), @myid) AS 'char' ;

INSERT INTO [Dimension].[Geografia]
           ([ID_Ciudad]
           ,[ID_Region]
           ,[ID_Pais]
           ,[NombreCiudad]
           ,[CodigoPostal]
           ,[NombreRegion]
           ,[NombrePais]
           ,[FechaCreacion]
           ,[UsuarioCreacion]
           ,[FechaModificacion]
           ,[UsuarioModificacion]
           ,[ID_Batch]
           ,[ID_SourceSystem])
SELECT	  C.ID_Ciudad
	          ,R.ID_Region
			  ,P.ID_Pais
			  ,C.Nombre [NombreCiudad]
			  ,C.CodigoPostal [CodigoPostalCiudad]
			  ,R.Nombre [NombreRegion]
			  ,P.Nombre [NombrePais]
			  --Columnas Auditoria
			  ,GETDATE() AS FechaCreacion
			  ,CAST(SUSER_NAME() AS nvarchar(100)) AS UsuarioCreacion
			  ,GETDATE() AS FechaModificacion
			  ,CAST(SUSER_NAME() AS nvarchar(100)) AS UsuarioModificacion
			  ,@myid
			  ,'MLASKNG87A9W4G98GVW4'
	FROM RepuestosWeb.dbo.Ciudad C
		INNER JOIN  RepuestosWeb.dbo.Region R ON(C.ID_Region = R.ID_Region)
		INNER JOIN RepuestosWeb.dbo.Pais P ON(R.ID_Pais = P.ID_Pais);
GO


