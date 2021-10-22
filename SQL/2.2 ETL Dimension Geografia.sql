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
	FROM RepuestosWeb.dbo.Ciudad C
		INNER JOIN  RepuestosWeb.dbo.Region R ON(C.ID_Region = R.ID_Region)
		INNER JOIN RepuestosWeb.dbo.Pais P ON(R.ID_Pais = P.ID_Pais);

--Ciudad
CREATE INDEX [IndiceCiudad] on [Ciudad] ( [ID_Ciudad] ) include (
       [Nombre]
      ,[CodigoPostal] )

update statistics Ciudad with fullscan

--Pais
CREATE INDEX [IndicePais] on [Pais] ( [ID_Pais] ) include (
       [Nombre])

update statistics Pais with fullscan

--Region
CREATE INDEX [IndiceRegion] on [Region] ( [ID_Region] ) include (
       [Nombre])

update statistics Region with fullscan