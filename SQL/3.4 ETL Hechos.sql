USE RepuestosWebDWH
--Script de SP para MERGE
create PROCEDURE USP_MergeFact
as
BEGIN

	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRAN
		DECLARE @NuevoGUIDInsert UNIQUEIDENTIFIER = NEWID(), @MaxFechaEjecucion DATETIME, @RowsAffected INT

		INSERT INTO FactLog ([ID_Batch], [FechaEjecucion], [NuevosRegistros])
		VALUES (@NuevoGUIDInsert,NULL,NULL)
		
		MERGE Hecho.OrdenCotizacion AS T
		USING (
			SELECT 
		   [SK_Parte]
		  ,[SK_Geografia]
		  ,[SK_Cliente]
		  ,[SK_Vehiculo]
		  ,[SK_Descuento]
		  ,[SK_Aseguradora]
		  ,[SK_PlantaReparacion]
		  ,[SK_StatusOrden]
		  ,[DateKey]
		  ,[ID_Orden]
		  ,O.[ID_Cliente]
		  ,O.[ID_Ciudad]
		  ,[IDCotizacion]
		  ,O.[ID_StatusOrden]
		  ,[ID_DetalleOrden]
		  ,O.[ID_Descuento]
		  ,[NumLinea]
		  ,O.[VehiculoID]
		  ,[ID_Parte]
		  ,O.[IDAseguradora]
		  ,O.[IDPlantaReparacion]
		  ,[IDPartner]
		  ,[IDClientePlantaReparacion]
		  ,[IDRecotizacion]
		  ,[Total_Orden]
		  ,[Fecha_Orden]
		  ,[NumeroOrden]
		  ,[status]
		  ,[TipoDocumento]
		  ,[FechaCreacionCotizacion]
		  ,[ProcesadoPor]
		  ,[AseguradoraSubsidiaria]
		  ,[NumeroReclamo]
		  ,[OrdenRealizada]
		  ,[CotizacionRealizada]
		  ,[CotizacionDuplicada]
		  ,[procurementFolderID]
		  ,[DireccionEntrega1]
		  ,[DireccionEntrega2]
		  ,[MarcadoEntrega]
		  ,[CodigoPostal_Cotizacion]
		  ,[LeidoPorPlantaReparacion]
		  ,[LeidoPorPlantaReparacionFecha]
		  ,[CotizacionReabierta]
		  ,[EsAseguradora]
		  ,[CodigoVerificacion]
		  ,[FechaCreacionRegistro_Cotizacion]
		  ,[PartnerConfirmado]
		  ,[WrittenBy]
		  ,[SeguroValidado]
		  ,[FechaCaptura]
		  ,[IDOrden]
		  ,[Ruta]
		  ,[FechaLimiteRuta]
		  ,[OETipoParte]
		  ,[AltPartNum]
		  ,[AltTipoParte]
		  ,[ciecaTipoParte]
		  ,[Cantidad]
		  ,[PrecioListaOnRO]
		  ,[PrecioNetoOnRO]
		  ,[NecesitadoParaFecha]
		  ,[OrigenOrden]
			,getdate() as FechaCreacion
			,'ETL' as UsuarioCreacion
			,NULL as FechaModificacion
			,NULL as UsuarioModificacion
			,@NuevoGUIDINsert as ID_Batch
			,'ssis' as ID_SourceSystem
			FROM STAGING.OrdenCotizacion O
				LEFT JOIN Dimension.Clientes C ON(O.ID_Cliente = C.ID_Cliente) 
				LEFT JOIN Dimension.Geografia G ON(O.ID_Ciudad = G.ID_Ciudad) 
				LEFT JOIN Dimension.Vehiculo V ON(O.VehiculoID = V.VehiculoID) 
				LEFT JOIN Dimension.Aseguradoras A ON(O.IDAseguradora = A.IDAseguradora) 
				LEFT JOIN Dimension.PlantaReparacion PR ON(O.IDPlantaReparacion = PR.IDPlantaReparacion) 
				LEFT JOIN Dimension.StatusOrden SO ON(O.ID_StatusOrden = SO.ID_StatusOrden ) 
				LEFT JOIN Dimension.Descuento D ON(O.ID_Descuento = SO.ID_StatusOrden ) 
				LEFT JOIN Dimension.Partes P ON(O.ID_Parte = P.ID_Partes and
													(
														O.Fecha_Orden BETWEEN P.FechaInicioValidez AND ISNULL(P.FechaFinValidez, '9999-12-31') OR 
														O.FechaCreacionCotizacion BETWEEN P.FechaInicioValidez AND ISNULL(P.FechaFinValidez, '9999-12-31') OR 
														O.FechaCreacionRegistro_Cotizacion BETWEEN P.FechaInicioValidez AND ISNULL(P.FechaFinValidez, '9999-12-31')
													)
												)
				LEFT JOIN Dimension.Fecha F ON(CAST( (CAST(YEAR(O.Fecha_Orden) AS VARCHAR(4)))+left('0'+CAST(MONTH(O.Fecha_Orden) AS VARCHAR(4)),2)+left('0'+(CAST(DAY(O.Fecha_Orden) AS VARCHAR(4))),2) AS INT)  = F.DateKey)
				) AS S ON (S.ID_Orden = T.ID_Orden)

		WHEN NOT MATCHED BY TARGET THEN --No existe en Fact
		INSERT ([SK_Parte]
           ,[SK_Geografia]
           ,[SK_Cliente]
           ,[SK_Vehiculo]
           ,[SK_Descuento]
           ,[SK_Aseguradora]
           ,[SK_PlantaReparacion]
           ,[SK_StatusOrden]
           ,[DateKey]
           ,[ID_Orden]
           ,[ID_Cliente]
           ,[ID_Ciudad]
           ,[IDCotizacion]
           ,[ID_StatusOrden]
           ,[ID_DetalleOrden]
           ,[ID_Descuento]
           ,[NumLinea]
           ,[VehiculoID]
           ,[ID_Parte]
           ,[IDAseguradora]
           ,[IDPlantaReparacion]
           ,[IDPartner]
           ,[IDClientePlantaReparacion]
           ,[IDRecotizacion]
           ,[Total_Orden]
           ,[Fecha_Orden]
           ,[NumeroOrden]
           ,[status]
           ,[TipoDocumento]
           ,[FechaCreacionCotizacion]
           ,[ProcesadoPor]
           ,[AseguradoraSubsidiaria]
           ,[NumeroReclamo]
           ,[OrdenRealizada]
           ,[CotizacionRealizada]
           ,[CotizacionDuplicada]
           ,[procurementFolderID]
           ,[DireccionEntrega1]
           ,[DireccionEntrega2]
           ,[MarcadoEntrega]
           ,[CodigoPostal_Cotizacion]
           ,[LeidoPorPlantaReparacion]
           ,[LeidoPorPlantaReparacionFecha]
           ,[CotizacionReabierta]
           ,[EsAseguradora]
           ,[CodigoVerificacion]
           ,[FechaCreacionRegistro_Cotizacion]
           ,[PartnerConfirmado]
           ,[WrittenBy]
           ,[SeguroValidado]
           ,[FechaCaptura]
           ,[IDOrden]
           ,[Ruta]
           ,[FechaLimiteRuta]
           ,[OETipoParte]
           ,[AltPartNum]
           ,[AltTipoParte]
           ,[ciecaTipoParte]
           ,[Cantidad]
           ,[PrecioListaOnRO]
           ,[PrecioNetoOnRO]
           ,[NecesitadoParaFecha]
           ,[OrigenOrden]
           ,[FechaCreacion]
           ,[UsuarioCreacion]
           ,[FechaModificacion]
           ,[UsuarioModificacion]
           ,[ID_Batch]
           ,[ID_SourceSystem])
		VALUES (
			[SK_Parte]
		  ,[SK_Geografia]
		  ,[SK_Cliente]
		  ,[SK_Vehiculo]
		  ,[SK_Descuento]
		  ,[SK_Aseguradora]
		  ,[SK_PlantaReparacion]
		  ,[SK_StatusOrden]
		  ,[DateKey]
		  ,[ID_Orden]
		  ,[ID_Cliente]
		  ,[ID_Ciudad]
		  ,[IDCotizacion]
		  ,[ID_StatusOrden]
		  ,[ID_DetalleOrden]
		  ,[ID_Descuento]
		  ,[NumLinea]
		  ,[VehiculoID]
		  ,[ID_Parte]
		  ,[IDAseguradora]
		  ,[IDPlantaReparacion]
		  ,[IDPartner]
		  ,[IDClientePlantaReparacion]
		  ,[IDRecotizacion]
		  ,[Total_Orden]
		  ,[Fecha_Orden]
		  ,[NumeroOrden]
		  ,[status]
		  ,[TipoDocumento]
		  ,[FechaCreacionCotizacion]
		  ,[ProcesadoPor]
		  ,[AseguradoraSubsidiaria]
		  ,[NumeroReclamo]
		  ,[OrdenRealizada]
		  ,[CotizacionRealizada]
		  ,[CotizacionDuplicada]
		  ,[procurementFolderID]
		  ,[DireccionEntrega1]
		  ,[DireccionEntrega2]
		  ,[MarcadoEntrega]
		  ,[CodigoPostal_Cotizacion]
		  ,[LeidoPorPlantaReparacion]
		  ,[LeidoPorPlantaReparacionFecha]
		  ,[CotizacionReabierta]
		  ,[EsAseguradora]
		  ,[CodigoVerificacion]
		  ,[FechaCreacionRegistro_Cotizacion]
		  ,[PartnerConfirmado]
		  ,[WrittenBy]
		  ,[SeguroValidado]
		  ,[FechaCaptura]
		  ,[IDOrden]
		  ,[Ruta]
		  ,[FechaLimiteRuta]
		  ,[OETipoParte]
		  ,[AltPartNum]
		  ,[AltTipoParte]
		  ,[ciecaTipoParte]
		  ,[Cantidad]
		  ,[PrecioListaOnRO]
		  ,[PrecioNetoOnRO]
		  ,[NecesitadoParaFecha]
		  ,[OrigenOrden]
			,FechaCreacion
			,UsuarioCreacion
			,isnull(S.FechaModificacion, getdate())
			,UsuarioModificacion
			,ID_Batch
			,ID_SourceSystem
			);

		SET @RowsAffected =@@ROWCOUNT

		SELECT @MaxFechaEjecucion=ISNULL(MAX(MaxFechaEjecucion),GETDATE())
		FROM(
			SELECT MAX(Fecha_Orden) as MaxFechaEjecucion
			FROM Hecho.OrdenCotizacion
			UNION
			SELECT MAX(FechaModificacion)  as MaxFechaEjecucion
			FROM Hecho.OrdenCotizacion
		)AS A

		UPDATE FactLog
		SET NuevosRegistros=@RowsAffected, FechaEjecucion = @MaxFechaEjecucion
		WHERE ID_Batch = @NuevoGUIDInsert

		COMMIT
	END TRY
	BEGIN CATCH
		SELECT @@ERROR,'Ocurrio el siguiente error: '+ERROR_MESSAGE()
		IF (@@TRANCOUNT>0)
			ROLLBACK;
	END CATCH

END
go
