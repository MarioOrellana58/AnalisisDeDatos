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
  FROM [RepuestosWeb].[dbo].[PlantaReparacion]


CREATE INDEX [IndicePlantaReparacion] ON [PlantaReparacion] ( [IDPlantaReparacion] ) INCLUDE ( 
	[CompanyNombre]
    ,[Ciudad]
    ,[Estado]
    ,[CodigoPostal]
    ,[Pais]
    ,[AlmacenKeystone]
    ,[LocalizadorCotizacion]
    ,[FechaAgregado]
    ,[ValidacionSeguro]
    ,[Activo] )


UPDATE STATISTICS PlantaReparacion WITH FULLSCAN