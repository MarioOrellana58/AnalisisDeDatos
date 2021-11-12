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
  FROM [RepuestosWeb].[dbo].[Vehiculo]

    create index [IndiceVehiculo] on [Vehiculo] ( [VehiculoID] ) include ( 
	   [VIN_Patron]
      ,[Anio]
      ,[Marca]
      ,[Modelo]
      ,[SubModelo]
      ,[Estilo]
      ,[FechaCreacion] )


  update statistics [Vehiculo] with fullscan