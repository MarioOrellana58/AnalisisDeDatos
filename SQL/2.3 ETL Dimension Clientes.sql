SELECT	   C.ID_Cliente
	          ,C.PrimerNombre + ' ' + C.SegundoNombre AS NombreCliente
			  ,C.PrimerApellido + ' ' + C.SegundoApellido AS ApellidoCliente
			  ,C.Genero
			  ,C.Correo_Electronico
			  ,C.FechaNacimiento			 
			  --Columnas Auditoria
			  ,GETDATE() AS FechaCreacion
			  ,CAST(SUSER_NAME() AS nvarchar(100)) AS UsuarioCreacion
			  ,GETDATE() AS FechaModificacion
			  ,CAST(SUSER_NAME() AS nvarchar(100)) AS UsuarioModificacion
	FROM RepuestosWeb.dbo.Clientes C