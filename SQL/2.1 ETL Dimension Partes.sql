
SELECT P.[ID_Parte] AS [ID_Partes]
      ,C.[ID_Categoria]
      ,L.[ID_Linea]
      ,P.[Nombre] AS [NombreParte]
      ,P.[Precio]
      ,C.[Nombre] AS [NombreCategoria]
      ,L.[Nombre] AS [NombreLinea]
	  		--Columnas Auditoria
		,GETDATE() AS FechaCreacion
		,CAST(SUSER_NAME() AS nvarchar(100)) AS UsuarioCreacion
		,GETDATE() AS FechaModificacion
		,CAST(SUSER_NAME() AS nvarchar(100)) AS UsuarioModificacion
  FROM [RepuestosWeb].[dbo].[Partes] P
	INNER JOIN Categoria C ON P.ID_Categoria = C.ID_Categoria
	INNER JOIN Linea L ON C.ID_Linea = L.ID_Linea
