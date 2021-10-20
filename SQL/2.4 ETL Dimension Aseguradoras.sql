SELECT [IDAseguradora]
      ,[NombreAseguradora]
      ,[Activa] AS [Activa_Aseguradora]

	--Columnas Auditoria
	  ,GETDATE() AS FechaCreacion
	  ,CAST(SUSER_NAME() AS nvarchar(100)) AS UsuarioCreacion
	  ,GETDATE() AS FechaModificacion
	  ,CAST(SUSER_NAME() AS nvarchar(100)) AS UsuarioModificacion

  FROM [RepuestosWeb].[dbo].[Aseguradoras]