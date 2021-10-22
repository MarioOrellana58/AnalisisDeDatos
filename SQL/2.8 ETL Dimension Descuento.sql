SELECT [ID_Descuento]
      ,[NombreDescuento]
      ,[PorcentajeDescuento]
	  --Columnas Auditoria
	  ,GETDATE() AS FechaCreacion
	  ,CAST(SUSER_NAME() AS nvarchar(100)) AS UsuarioCreacion
	  ,GETDATE() AS FechaModificacion
	  ,CAST(SUSER_NAME() AS nvarchar(100)) AS UsuarioModificacion
  FROM [RepuestosWeb].[dbo].[Descuento]


CREATE INDEX [IndiceDescuento] ON [Descuento] ( [ID_Descuento] ) INCLUDE ( 
	[NombreDescuento]
    ,[PorcentajeDescuento] )


UPDATE STATISTICS [Descuento] WITH FULLSCAN