CLASS lhc_assetretire IMPLEMENTATION.

  METHOD get_global_authorizations.
    result = VALUE #( ( %field-ProcessStatus = if_abap_behv=>auth-allowed ) ).
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

  METHOD setDefaults.
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

  METHOD validateAsset.
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

  METHOD importAssets.
    " Get company code from parameter
    DATA(lv_company) = keys[ 1 ]-%param-CompanyCode.

    IF lv_company IS INITIAL.
      APPEND VALUE #( %msg = new_message_with_text(
        severity = if_abap_behv_message=>severity-error
        text     = 'Informe a empresa' )
      ) TO reported-assetretire.
      RETURN.
    ENDIF.

    " Read active assets from SAP
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

    " Check which assets are already in staging to avoid duplicates
    SELECT master_fixed_asset, fixed_asset
      FROM zasset_retire
      WHERE company_code = @lv_company
      INTO TABLE @DATA(lt_existing).

    " Build creation data
    DATA lt_create TYPE TABLE FOR CREATE zi_assetretire\\AssetRetire.
    DATA(lv_date) = cl_abap_context_info=>get_system_date( ).
    DATA lv_idx TYPE i.

    LOOP AT lt_sap_assets INTO DATA(ls_sap).
      " Skip if already imported
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

    " Create entries via EML
    MODIFY ENTITIES OF zi_assetretire IN LOCAL MODE
      ENTITY AssetRetire
      CREATE SET FIELDS WITH lt_create
      MAPPED mapped
      FAILED failed
      REPORTED reported.

    " Build result
    result = VALUE #( FOR <m> IN mapped-assetretire
      ( %cid_ref = <m>-%cid
        %key     = <m>-%key ) ).

    " Success message
    APPEND VALUE #( %msg = new_message_with_text(
      severity = if_abap_behv_message=>severity-success
      text     = |{ lv_idx } ativos importados com sucesso| )
    ) TO reported-assetretire.
  ENDMETHOD.

  METHOD executeRetirement.
    " Read selected entities
    READ ENTITIES OF zi_assetretire IN LOCAL MODE
      ENTITY AssetRetire
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_assets)
      FAILED failed.

    DATA lt_update TYPE TABLE FOR UPDATE zi_assetretire\\AssetRetire.

    LOOP AT lt_assets INTO DATA(ls_asset).
      " Skip already processed
      IF ls_asset-ProcessStatus = 'S' OR ls_asset-ProcessStatus = 'P'.
        CONTINUE.
      ENDIF.

      DATA lv_proc_status TYPE c LENGTH 1.
      DATA lv_proc_msg    TYPE c LENGTH 255.
      DATA lv_ref_doc     TYPE c LENGTH 10.

      lv_proc_status = 'P'. " Processing

      TRY.
          " Create HTTP destination from Communication Arrangement
          DATA(lo_dest) = cl_http_destination_provider=>create_by_comm_arrangement(
            comm_scenario  = 'ZASSET_RETIRE_CS'
            service_id     = 'ZASSET_RETIRE_REST'
          ).

          " Create HTTP client
          DATA(lo_client) = cl_web_http_client_manager=>create_by_http_destination( lo_dest ).
          DATA(lo_request) = lo_client->get_http_request( ).

          " Format dates as ISO (YYYY-MM-DD)
          DATA(lv_doc_date) = |{ ls_asset-DocumentDate+0(4) }-{ ls_asset-DocumentDate+4(2) }-{ ls_asset-DocumentDate+6(2) }|.
          DATA(lv_post_date) = |{ ls_asset-PostingDate+0(4) }-{ ls_asset-PostingDate+4(2) }-{ ls_asset-PostingDate+6(2) }|.
          DATA(lv_val_date) = |{ ls_asset-AssetValueDate+0(4) }-{ ls_asset-AssetValueDate+4(2) }-{ ls_asset-AssetValueDate+6(2) }|.

          " Build JSON payload for the Post action
          DATA(lv_json) =
            |\{| &&
            |"CompanyCode":"{ ls_asset-CompanyCode }",| &&
            |"MasterFixedAsset":"{ ls_asset-MasterFixedAsset }",| &&
            |"FixedAsset":"{ ls_asset-FixedAsset }",| &&
            |"DocumentDate":"{ lv_doc_date }",| &&
            |"PostingDate":"{ lv_post_date }",| &&
            |"AssetValueDate":"{ lv_val_date }",| &&
            |"FixedAssetRetirementType":"{ ls_asset-RetirementType }",| &&
            |"FxdAstRetirementRatioInPercent":{ ls_asset-RetirementRatio },| &&
            |"AccountingDocumentHeaderText":"{ ls_asset-HeaderText }",| &&
            |"DocumentItemText":"{ ls_asset-ItemText }"| &&
            |\}|.

          " Set request
          lo_request->set_uri_path(
            '/sap/opu/odata4/sap/api_fixedassetretirement/srvd_a2x/sap/fixedassetretirement/0001/FixedAssetRetirement/SAP__self.Post'
          ).
          lo_request->set_header_field( i_name = 'Content-Type' i_value = 'application/json' ).
          lo_request->set_header_field( i_name = 'Accept'       i_value = 'application/json' ).
          lo_request->set_text( lv_json ).

          " Execute POST
          DATA(lo_response) = lo_client->execute( if_web_http_client=>post ).
          DATA(lv_status_code) = lo_response->get_status( )-code.
          DATA(lv_body) = lo_response->get_text( ).

          lo_client->close( ).

          IF lv_status_code >= 200 AND lv_status_code < 300.
            " Success
            lv_proc_status = 'S'.
            lv_proc_msg = 'Baixa realizada com sucesso'.

            " Try to extract ReferenceDocument from response
            TRY.
                FIND REGEX '"ReferenceDocument"\s*:\s*"([^"]*)"' IN lv_body SUBMATCHES lv_ref_doc.
              CATCH cx_root ##NO_HANDLER.
            ENDTRY.
          ELSE.
            " Error
            lv_proc_status = 'E'.
            lv_proc_msg = lv_body.
            IF strlen( lv_proc_msg ) > 255.
              lv_proc_msg = lv_proc_msg+0(255).
            ENDIF.
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

      " Queue update
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

      " Report per-item message
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

    " Apply updates
    MODIFY ENTITIES OF zi_assetretire IN LOCAL MODE
      ENTITY AssetRetire
      UPDATE FROM lt_update
      FAILED DATA(lt_upd_failed)
      REPORTED DATA(lt_upd_reported).

    " Read back updated entities for result
    READ ENTITIES OF zi_assetretire IN LOCAL MODE
      ENTITY AssetRetire
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_result).

    result = VALUE #( FOR ls IN lt_result
      ( %tky = ls-%tky
        %param = ls ) ).
  ENDMETHOD.

ENDCLASS.


CLASS lsc_assetretire IMPLEMENTATION.

  METHOD save_modified.
    " Additional save - admin field handling
    GET TIME STAMP FIELD DATA(lv_ts).

    IF create-assetretire IS NOT INITIAL.
      DATA(lv_user) = cl_abap_context_info=>get_user_technical_name( ).
      LOOP AT create-assetretire ASSIGNING FIELD-SYMBOL(<cr>).
        <cr>-CreatedBy         = lv_user.
        <cr>-CreatedAt         = lv_ts.
        <cr>-LastChangedBy     = lv_user.
        <cr>-LastChangedAt     = lv_ts.
        <cr>-LocalLastChanged  = lv_ts.
      ENDLOOP.
    ENDIF.

    IF update-assetretire IS NOT INITIAL.
      DATA(lv_user_upd) = cl_abap_context_info=>get_user_technical_name( ).
      LOOP AT update-assetretire ASSIGNING FIELD-SYMBOL(<up>).
        <up>-LastChangedBy    = lv_user_upd.
        <up>-LastChangedAt    = lv_ts.
        <up>-LocalLastChanged = lv_ts.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
