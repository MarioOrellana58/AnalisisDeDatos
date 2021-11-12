SELECT P.[ID_Parte]
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

--Partes
CREATE INDEX [IndicePartes] on [Partes] ( [ID_Parte] ) include (
       [Nombre]
      ,[Precio] )

update statistics Partes with fullscan

--Linea
CREATE INDEX [IndiceLinea] on [Linea] ( [ID_Linea] ) include (
	  [Nombre]
	  )

update statistics Linea with fullscan

--Categoria
CREATE INDEX [IndiceCategoria] on [Categoria] ( [ID_Categoria] ) include (
[Nombre]
)

update statistics Categoria with fullscan