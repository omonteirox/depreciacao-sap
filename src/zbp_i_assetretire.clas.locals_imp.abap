CLASS lhc_assetretire DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR assetretire RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR assetretire RESULT result.

    METHODS executeretirement FOR MODIFY
      IMPORTING keys FOR ACTION assetretire~executeretirement RESULT result.

    METHODS importassets FOR MODIFY
      IMPORTING keys FOR ACTION assetretire~importassets RESULT result.

    METHODS setdefaults FOR DETERMINE ON MODIFY
      IMPORTING keys FOR assetretire~setdefaults.

    METHODS validateasset FOR VALIDATE ON SAVE
      IMPORTING keys FOR assetretire~validateasset.

ENDCLASS.

CLASS lhc_assetretire IMPLEMENTATION.

  METHOD get_global_authorizations.
    IF requested_authorizations-%create EQ if_abap_behv=>mk-on.
      result-%create = if_abap_behv=>auth-allowed.
    ENDIF.
    IF requested_authorizations-%update EQ if_abap_behv=>mk-on.
      result-%update = if_abap_behv=>auth-allowed.
    ENDIF.
    IF requested_authorizations-%delete EQ if_abap_behv=>mk-on.
      result-%delete = if_abap_behv=>auth-allowed.
    ENDIF.
    IF requested_authorizations-%action-executeRetirement EQ if_abap_behv=>mk-on.
      result-%action-executeRetirement = if_abap_behv=>auth-allowed.
    ENDIF.
    IF requested_authorizations-%action-importAssets EQ if_abap_behv=>mk-on.
      result-%action-importAssets = if_abap_behv=>auth-allowed.
    ENDIF.
  ENDMETHOD.

  METHOD get_instance_features.
    READ ENTITIES OF zi_assetretire IN LOCAL MODE
      ENTITY AssetRetire
      FIELDS ( ProcessStatus )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_data)
      FAILED failed.

    result = VALUE #( FOR ls IN lt_data
      ( %tky = ls-%tky
        %action-executeRetirement = COND #(
          WHEN ls-ProcessStatus = 'S' OR ls-ProcessStatus = 'P'
          THEN if_abap_behv=>fc-o-disabled
          ELSE if_abap_behv=>fc-o-enabled ) ) ).
  ENDMETHOD.

  METHOD setdefaults.
    READ ENTITIES OF zi_assetretire IN LOCAL MODE
      ENTITY AssetRetire
      FIELDS ( PostingDate DocumentDate AssetValueDate RetirementType RetirementRatio )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_data).

    DATA(lv_date) = cl_abap_context_info=>get_system_date( ).

    MODIFY ENTITIES OF zi_assetretire IN LOCAL MODE
      ENTITY AssetRetire
      UPDATE FIELDS ( PostingDate DocumentDate AssetValueDate
                      RetirementType RetirementRatio HeaderText )
      WITH VALUE #( FOR ls IN lt_data WHERE ( PostingDate IS INITIAL )
        ( %tky             = ls-%tky
          PostingDate      = lv_date
          DocumentDate     = lv_date
          AssetValueDate   = lv_date
          RetirementType   = '1'
          RetirementRatio  = '100.00'
          HeaderText       = 'BAIXA MASSA' ) )
      REPORTED DATA(lt_reported).
  ENDMETHOD.

  METHOD validateasset.
    READ ENTITIES OF zi_assetretire IN LOCAL MODE
      ENTITY AssetRetire
      FIELDS ( CompanyCode MasterFixedAsset FixedAsset )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_data).

    LOOP AT lt_data INTO DATA(ls_data).
      IF ls_data-CompanyCode IS INITIAL.
        APPEND VALUE #(
          %tky = ls_data-%tky
          %msg = new_message_with_text(
            severity = if_abap_behv_message=>severity-error
            text     = 'Empresa é obrigatória' )
          %element-CompanyCode = if_abap_behv=>mk-on
        ) TO reported-assetretire.
        APPEND VALUE #( %tky = ls_data-%tky ) TO failed-assetretire.
        CONTINUE.
      ENDIF.

      IF ls_data-MasterFixedAsset IS INITIAL.
        APPEND VALUE #(
          %tky = ls_data-%tky
          %msg = new_message_with_text(
            severity = if_abap_behv_message=>severity-error
            text     = 'Imobilizado é obrigatório' )
          %element-MasterFixedAsset = if_abap_behv=>mk-on
        ) TO reported-assetretire.
        APPEND VALUE #( %tky = ls_data-%tky ) TO failed-assetretire.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD importassets.
    DATA(lv_company) = VALUE #( keys[ 1 ]-%param-CompanyCode OPTIONAL ).

    IF lv_company IS INITIAL.
      APPEND VALUE #( %msg = new_message_with_text(
        severity = if_abap_behv_message=>severity-error
        text     = 'Informe a empresa' )
      ) TO reported-assetretire.
      RETURN.
    ENDIF.

    SELECT companycode, masterfixedasset, fixedasset,
           fixedassetdescription, assetclass
      FROM zi_fixedassetlist
      WHERE companycode = @lv_company
      INTO TABLE @DATA(lt_sap_assets).

    IF lt_sap_assets IS INITIAL.
      APPEND VALUE #( %msg = new_message_with_text(
        severity = if_abap_behv_message=>severity-warning
        text     = |Nenhum ativo encontrado para empresa { lv_company }| )
      ) TO reported-assetretire.
      RETURN.
    ENDIF.

    SELECT master_fixed_asset, fixed_asset
      FROM zasset_retire
      WHERE company_code = @lv_company
      INTO TABLE @DATA(lt_existing).

    DATA lt_create TYPE TABLE FOR CREATE zi_assetretire\\AssetRetire.
    DATA(lv_date) = cl_abap_context_info=>get_system_date( ).
    DATA lv_idx TYPE i.

    LOOP AT lt_sap_assets INTO DATA(ls_sap).
      READ TABLE lt_existing WITH KEY
        master_fixed_asset = ls_sap-MasterFixedAsset
        fixed_asset        = ls_sap-FixedAsset
        TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        CONTINUE.
      ENDIF.

      lv_idx += 1.
      APPEND VALUE #(
        %cid             = |IMPORT{ lv_idx }|
        CompanyCode      = ls_sap-CompanyCode
        MasterFixedAsset = ls_sap-MasterFixedAsset
        FixedAsset       = ls_sap-FixedAsset
        AssetDescription = ls_sap-FixedAssetDescription
        AssetClass       = ls_sap-AssetClass
        DocumentDate     = lv_date
        PostingDate      = lv_date
        AssetValueDate   = lv_date
        RetirementType   = '1'
        RetirementRatio  = '100.00'
        HeaderText       = 'BAIXA MASSA'
        ProcessStatus    = ''
      ) TO lt_create.
    ENDLOOP.

    IF lt_create IS INITIAL.
      APPEND VALUE #( %msg = new_message_with_text(
        severity = if_abap_behv_message=>severity-information
        text     = |Todos os ativos da empresa { lv_company } já foram importados| )
      ) TO reported-assetretire.
      RETURN.
    ENDIF.

    " Usar variáveis locais para MAPPED/FAILED/REPORTED
    MODIFY ENTITIES OF zi_assetretire IN LOCAL MODE
      ENTITY AssetRetire
      CREATE SET FIELDS WITH lt_create
      MAPPED DATA(lm_mapped)
      FAILED DATA(lf_failed)
      REPORTED DATA(lr_reported).

    INSERT LINES OF lf_failed-assetretire   INTO TABLE failed-assetretire.
    INSERT LINES OF lr_reported-assetretire INTO TABLE reported-assetretire.

    " NÃO fazemos READ ENTITIES + result aqui.
    " READ ENTITIES ALL FIELDS dentro da action retorna campos administrativos
    " (CreatedAt, LastChangedAt, LocalLastChanged) com flag NODATA no buffer de draft,
    " pois save_modified ainda não executou. Isso causa MOVE_TO_LIT_NOTALLOWED_NODATA
    " quando o framework tenta serializar NODATA para JSON.
    " Para result [0..*] $self, retornar vazio é válido — Fiori refresca a lista.

    APPEND VALUE #( %msg = new_message_with_text(
      severity = if_abap_behv_message=>severity-success
      text     = |{ lv_idx } ativos importados com sucesso| )
    ) TO reported-assetretire.
  ENDMETHOD.

  METHOD executeretirement.
    READ ENTITIES OF zi_assetretire IN LOCAL MODE
      ENTITY AssetRetire
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_assets)
      FAILED failed.

    DATA lt_update TYPE TABLE FOR UPDATE zi_assetretire\\AssetRetire.

    LOOP AT lt_assets INTO DATA(ls_asset).
      IF ls_asset-ProcessStatus = 'S' OR ls_asset-ProcessStatus = 'P'.
        CONTINUE.
      ENDIF.

      DATA lv_proc_status TYPE c LENGTH 1.
      DATA lv_proc_msg    TYPE c LENGTH 255.
      DATA lv_ref_doc     TYPE c LENGTH 10.

      lv_proc_status = 'P'.

      TRY.
          DATA(lo_dest) = cl_http_destination_provider=>create_by_comm_arrangement(
            comm_scenario  = 'ZASSET_RETIRE_CS'
            service_id     = 'ZASSET_RETIRE_REST'
          ).

          DATA(lo_client) = cl_web_http_client_manager=>create_by_http_destination( lo_dest ).
          DATA(lo_request) = lo_client->get_http_request( ).

          DATA(lv_doc_date) = |{ ls_asset-DocumentDate+0(4) }-{ ls_asset-DocumentDate+4(2) }-{ ls_asset-DocumentDate+6(2) }|.
          DATA(lv_post_date) = |{ ls_asset-PostingDate+0(4) }-{ ls_asset-PostingDate+4(2) }-{ ls_asset-PostingDate+6(2) }|.
          DATA(lv_val_date) = |{ ls_asset-AssetValueDate+0(4) }-{ ls_asset-AssetValueDate+4(2) }-{ ls_asset-AssetValueDate+6(2) }|.

          " MasterFixedAsset: ANLN1 = CHAR(12), FixedAsset: ANLN2 = CHAR(4) — zero-padding obrigatório
          DATA(lv_master) = |{ ls_asset-MasterFixedAsset ALPHA = OUT }|.
          DATA(lv_subnr)  = |{ ls_asset-FixedAsset ALPHA = OUT }|.

          DATA(lv_json) =
            |\{| &&
            |"CompanyCode":"{ ls_asset-CompanyCode }",| &&
            |"MasterFixedAsset":"{ lv_master }",| &&
            |"FixedAsset":"{ lv_subnr }",| &&
            |"DocumentDate":"{ lv_doc_date }",| &&
            |"PostingDate":"{ lv_post_date }",| &&
            |"AssetValueDate":"{ lv_val_date }",| &&
            |"FixedAssetRetirementType":"{ ls_asset-RetirementType }",| &&
            |"FxdAstRetirementRatioInPercent":{ ls_asset-RetirementRatio },| &&
            |"AccountingDocumentHeaderText":"{ ls_asset-HeaderText }",| &&
            |"DocumentItemText":"{ ls_asset-ItemText }"| &&
            |\}|.

          lo_request->set_uri_path(
            '/sap/opu/odata4/sap/api_fixedassetretirement/srvd_a2x/sap/fixedassetretirement/0001/FixedAssetRetirement/SAP__self.Post'
          ).
          lo_request->set_header_field( i_name = 'Content-Type' i_value = 'application/json' ).
          lo_request->set_header_field( i_name = 'Accept'       i_value = 'application/json' ).
          lo_request->set_text( lv_json ).

          DATA(lo_response) = lo_client->execute( if_web_http_client=>post ).
          DATA(lv_status_code) = lo_response->get_status( )-code.
          DATA(lv_body) = lo_response->get_text( ).

          lo_client->close( ).

          IF lv_status_code >= 200 AND lv_status_code < 300.
            lv_proc_status = 'S'.
            lv_proc_msg = 'Baixa realizada com sucesso'.
            TRY.
                FIND REGEX '"ReferenceDocument"\s*:\s*"([^"]*)"' IN lv_body SUBMATCHES lv_ref_doc.
              CATCH cx_root ##NO_HANDLER.
            ENDTRY.
          ELSE.
            lv_proc_status = 'E'.
            " Extrair só o campo message do JSON de erro (evitar dump do JSON bruto)
            DATA lv_msg_extracted TYPE c LENGTH 255.
            FIND REGEX '"message"\s*:\s*"([^"]{1,200})"' IN lv_body SUBMATCHES lv_msg_extracted.
            IF lv_msg_extracted IS NOT INITIAL.
              lv_proc_msg = lv_msg_extracted.
            ELSE.
              lv_proc_msg = lv_body.
              IF strlen( lv_proc_msg ) > 255.
                lv_proc_msg = lv_proc_msg+0(255).
              ENDIF.
            ENDIF.
            CLEAR lv_msg_extracted.
          ENDIF.

        CATCH cx_http_dest_provider_error INTO DATA(lx_dest).
          lv_proc_status = 'E'.
          lv_proc_msg = lx_dest->get_text( ).
        CATCH cx_web_http_client_error INTO DATA(lx_http).
          lv_proc_status = 'E'.
          lv_proc_msg = lx_http->get_text( ).
        CATCH cx_root INTO DATA(lx_root).
          lv_proc_status = 'E'.
          lv_proc_msg = lx_root->get_text( ).
      ENDTRY.

      APPEND VALUE #(
        %tky           = ls_asset-%tky
        ProcessStatus  = lv_proc_status
        ProcessMsg     = lv_proc_msg
        RefDocNumber   = lv_ref_doc
        %control = VALUE #(
          ProcessStatus = if_abap_behv=>mk-on
          ProcessMsg    = if_abap_behv=>mk-on
          RefDocNumber  = if_abap_behv=>mk-on )
      ) TO lt_update.

      APPEND VALUE #(
        %tky = ls_asset-%tky
        %msg = new_message_with_text(
          severity = COND #( WHEN lv_proc_status = 'S'
                             THEN if_abap_behv_message=>severity-success
                             ELSE if_abap_behv_message=>severity-error )
          text = |{ ls_asset-MasterFixedAsset }-{ ls_asset-FixedAsset }: { lv_proc_msg }| )
      ) TO reported-assetretire.

      CLEAR: lv_ref_doc, lv_proc_msg.
    ENDLOOP.

    MODIFY ENTITIES OF zi_assetretire IN LOCAL MODE
      ENTITY AssetRetire
      UPDATE FROM lt_update
      FAILED DATA(lt_upd_failed)
      REPORTED DATA(lt_upd_reported).

    " Ler apenas os campos que foram atualizados para evitar NODATA de campos admin no draft
    READ ENTITIES OF zi_assetretire IN LOCAL MODE
      ENTITY AssetRetire
      FIELDS ( CompanyCode MasterFixedAsset FixedAsset AssetDescription AssetClass
               DocumentDate PostingDate AssetValueDate RetirementType RetirementRatio
               HeaderText ItemText ProcessStatus ProcessMsg RefDocNumber StatusCriticality )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_result).

    result = VALUE #( FOR ls IN lt_result
      ( %tky = ls-%tky
        %param = ls ) ).
  ENDMETHOD.

ENDCLASS.

CLASS lsc_zi_assetretire DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_zi_assetretire IMPLEMENTATION.

  METHOD save_modified.
    " Os campos administrativos (CreatedBy, CreatedAt, LastChangedBy, LastChangedAt,
    " LocalLastChanged) são anotados com @Semantics na CDS view e por isso são
    " gerenciados AUTOMATICAMENTE pelo framework RAP managed.
    " Tentar escrevê-los manualmente aqui causa MOVE_TO_LIT_NOTALLOWED_NODATA
    " porque o framework os protege contra escrita externa.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
