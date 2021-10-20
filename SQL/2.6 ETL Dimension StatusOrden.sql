SELECT [ID_StatusOrden]
      ,[NombreStatus]
	  --Columnas Auditoria
	  ,GETDATE() AS FechaCreacion
	  ,CAST(SUSER_NAME() AS nvarchar(100)) AS UsuarioCreacion
	  ,GETDATE() AS FechaModificacion
	  ,CAST(SUSER_NAME() AS nvarchar(100)) AS UsuarioModificacion
  FROM [RepuestosWeb].[dbo].[StatusOrden]