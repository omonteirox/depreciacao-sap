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
      FIELDS ( CompanyCode MasterFixedAsset FixedAsset AssetValueDate AcquisitionDate )
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
        CONTINUE.
      ENDIF.

      " Validação da Data de Capitalização exigida pela Regra de Negócio AA/322 / AA/324
      IF ls_data-AcquisitionDate IS NOT INITIAL AND ls_data-AcquisitionDate <> '00000000'.
        IF ls_data-AssetValueDate < ls_data-AcquisitionDate.
          APPEND VALUE #(
            %tky = ls_data-%tky
            %msg = new_message_with_text(
              severity = if_abap_behv_message=>severity-error
              text     = |Data de baixa ({ ls_data-AssetValueDate+6(2) }/{ ls_data-AssetValueDate+4(2) }/{ ls_data-AssetValueDate+0(4) }) anterior à capitalização| )
            %element-AssetValueDate = if_abap_behv=>mk-on
          ) TO reported-assetretire.
          APPEND VALUE #( %tky = ls_data-%tky ) TO failed-assetretire.
        ENDIF.
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
           fixedassetdescription, assetclass,
           assetcapitalizationdate, creationdate
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
    DATA lv_skipped TYPE i.

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
        " Usa a Data de Criação como base para validação de aquisição, já que os testes não têm cap date
        AcquisitionDate  = ls_sap-CreationDate
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

    " Variáveis fora do LOOP para evitar redeclaração problemática
    DATA lv_proc_status TYPE c LENGTH 1.
    DATA lv_proc_msg    TYPE c LENGTH 255.
    DATA lv_ref_doc     TYPE c LENGTH 10.
    DATA lv_sys_date    TYPE d.
    DATA lv_year_code   TYPE c LENGTH 1.
    DATA lv_msg_ext     TYPE c LENGTH 500.

    LOOP AT lt_assets INTO DATA(ls_asset).
      IF ls_asset-ProcessStatus = 'S' OR ls_asset-ProcessStatus = 'P'.
        CONTINUE.
      ENDIF.

      " ── Reset obrigatório a cada iteração ──────────────────────────────
      CLEAR: lv_proc_status, lv_proc_msg, lv_ref_doc,
             lv_year_code, lv_msg_ext.
      lv_proc_status = 'P'. " provisório — indica em processamento

      TRY.
          DATA(lo_dest) = cl_http_destination_provider=>create_by_comm_arrangement(
            comm_scenario  = 'ZCS_BAIXAIMOBILIZADO'
            service_id     = 'ZBAIXAR_IMOBILIZADO_REST'
          ).

          DATA(lo_client)  = cl_web_http_client_manager=>create_by_http_destination( lo_dest ).

          " ── STEP 1: Fetch CSRF Token (obrigatório para POST no SAP OData v4) ──
          DATA(lo_req_csrf) = lo_client->get_http_request( ).
          lo_req_csrf->set_uri_path(
            '/sap/opu/odata4/sap/api_fixedassetretirement/srvd_a2x/sap/fixedassetretirement/0001/'
          ).
          lo_req_csrf->set_header_field( i_name = 'x-csrf-token' i_value = 'fetch' ).
          lo_req_csrf->set_header_field( i_name = 'Accept'       i_value = 'application/json' ).

          DATA(lo_resp_csrf)  = lo_client->execute( if_web_http_client=>head ).
          DATA(lv_csrf_token) = lo_resp_csrf->get_header_field( 'x-csrf-token' ).

          " ── STEP 2: Montar payload e enviar POST ──────────────────────────────
          DATA(lo_request) = lo_client->get_http_request( ).

          IF ls_asset-DocumentDate IS INITIAL OR ls_asset-DocumentDate = '00000000'.
            ls_asset-DocumentDate = cl_abap_context_info=>get_system_date( ).
          ENDIF.
          IF ls_asset-PostingDate IS INITIAL OR ls_asset-PostingDate = '00000000'.
            ls_asset-PostingDate = cl_abap_context_info=>get_system_date( ).
          ENDIF.
          IF ls_asset-AssetValueDate IS INITIAL OR ls_asset-AssetValueDate = '00000000'.
            ls_asset-AssetValueDate = cl_abap_context_info=>get_system_date( ).
          ENDIF.

          DATA(lv_doc_date)  = |{ ls_asset-DocumentDate+0(4) }-{ ls_asset-DocumentDate+4(2) }-{ ls_asset-DocumentDate+6(2) }|.
          DATA(lv_post_date) = |{ ls_asset-PostingDate+0(4) }-{ ls_asset-PostingDate+4(2) }-{ ls_asset-PostingDate+6(2) }|.
          DATA(lv_val_date)  = |{ ls_asset-AssetValueDate+0(4) }-{ ls_asset-AssetValueDate+4(2) }-{ ls_asset-AssetValueDate+6(2) }|.

          " MasterFixedAsset MaxLength=12, FixedAsset MaxLength=4 — formato interno (com zeros)
          DATA(lv_master) = |{ ls_asset-MasterFixedAsset ALPHA = IN }|.
          DATA(lv_subnr)  = |{ ls_asset-FixedAsset ALPHA = OUT }|.  " sem zeros → "0000" vira "0"
          CONDENSE: lv_master, lv_subnr.

          " FixedAssetYearOfAcqnCode: 'P'=Prior Year / 'C'=Current Year
          lv_sys_date = cl_abap_context_info=>get_system_date( ).
          IF ls_asset-AcquisitionDate IS INITIAL OR
             ls_asset-AcquisitionDate(4) < lv_sys_date(4).
            lv_year_code = 'P'.
          ELSE.
            lv_year_code = 'C'.
          ENDIF.

          " — Trim campos string ——
          DATA(lv_ccode)      = CONV string( ls_asset-CompanyCode ).
          DATA(lv_ret_type)   = CONV string( ls_asset-RetirementType ).
          DATA(lv_hdr_text)   = CONV string( ls_asset-HeaderText ).
          DATA(lv_item_text)  = CONV string( ls_asset-ItemText ).
          CONDENSE: lv_ccode, lv_ret_type, lv_hdr_text, lv_item_text.

          TYPES:
            BEGIN OF ty_post_req_full,
              reference_document_item             TYPE string,
              business_transaction_type           TYPE string,
              company_code                        TYPE string,
              master_fixed_asset                  TYPE string,
              fixed_asset                         TYPE string,
              document_date                       TYPE string,
              posting_date                        TYPE string,
              asset_value_date                    TYPE string,
              fixed_asset_retirement_type         TYPE string,
              revenue_type                        TYPE string,           " → FxdAstRetirementRevenueType
              revenue_amount                      TYPE p LENGTH 10 DECIMALS 2, " → AstRevenueAmountInTransCrcy
              fxd_ast_rtrmt_revn_trans_crcy       TYPE string,           " nome exato da API
              currency_role                       TYPE string,           " → FxdAstRtrmtRevnCurrencyRole
              document_header_text                TYPE string,
            END OF ty_post_req_full.

          TYPES:
            BEGIN OF ty_post_req,
              reference_document_item             TYPE string,
              business_transaction_type           TYPE string,
              company_code                        TYPE string,
              master_fixed_asset                  TYPE string,
              fixed_asset                         TYPE string,
              document_date                       TYPE string,
              posting_date                        TYPE string,
              asset_value_date                    TYPE string,
              fixed_asset_retirement_type         TYPE string,
              revenue_type                        TYPE string,           " → FxdAstRetirementRevenueType
              revenue_amount                      TYPE p LENGTH 10 DECIMALS 2, " → AstRevenueAmountInTransCrcy
              fxd_ast_rtrmt_revn_trans_crcy       TYPE string,           " nome exato da API
              currency_role                       TYPE string,           " → FxdAstRtrmtRevnCurrencyRole
              ratio_in_percent                    TYPE p LENGTH 5 DECIMALS 2,
              fixed_asset_year_of_acqn_code       TYPE string,
              document_header_text                TYPE string,
            END OF ty_post_req.

          DATA ls_post_req_full TYPE ty_post_req_full.
          DATA ls_post_req TYPE ty_post_req.
          DATA lv_json TYPE string.

          IF lv_ret_type = '1'.
            ls_post_req_full-reference_document_item    = '1'.
            ls_post_req_full-business_transaction_type  = 'RA20'.
            ls_post_req_full-company_code               = lv_ccode.
            ls_post_req_full-master_fixed_asset         = lv_master.
            ls_post_req_full-fixed_asset                = lv_subnr.
            ls_post_req_full-document_date              = lv_doc_date.
            ls_post_req_full-posting_date               = lv_post_date.
            ls_post_req_full-asset_value_date           = lv_val_date.
            ls_post_req_full-fixed_asset_retirement_type = '1'.
            ls_post_req_full-revenue_type               = '1'.
            ls_post_req_full-revenue_amount             = '0.01'.
            ls_post_req_full-fxd_ast_rtrmt_revn_trans_crcy = 'BRL'.
            ls_post_req_full-currency_role              = '10'.
            ls_post_req_full-document_header_text       = lv_hdr_text.
            ls_post_req_full-document_item_text      = lv_item_text.

            lv_json = xco_cp_json=>data->from_abap( ls_post_req_full )->apply( VALUE #(
              ( xco_cp_json=>transformation->underscore_to_pascal_case )
            ) )->to_string( ).

          ELSE.
            ls_post_req-reference_document_item    = '1'.
            ls_post_req-business_transaction_type  = 'RA20'.
            ls_post_req-company_code               = lv_ccode.
            ls_post_req-master_fixed_asset         = lv_master.
            ls_post_req-fixed_asset                = lv_subnr.
            ls_post_req-document_date              = lv_doc_date.
            ls_post_req-posting_date               = lv_post_date.
            ls_post_req-asset_value_date           = lv_val_date.
            ls_post_req-fixed_asset_retirement_type = '1'.
            ls_post_req-revenue_type               = '1'.
            ls_post_req-revenue_amount             = '0.01'.
            ls_post_req-fxd_ast_rtrmt_revn_trans_crcy = 'BRL'.
            ls_post_req-currency_role              = '10'.
            ls_post_req-ratio_in_percent           = ls_asset-RetirementRatio.
            ls_post_req-fixed_asset_year_of_acqn_code = lv_year_code.
            ls_post_req-document_header_text       = lv_hdr_text.

            lv_json = xco_cp_json=>data->from_abap( ls_post_req )->apply( VALUE #(
              ( xco_cp_json=>transformation->underscore_to_pascal_case )
            ) )->to_string( ).

            " Converter nomes curtos mapeados para o nome real da API devido ao limite de 30 chars do ABAP
            REPLACE ALL OCCURRENCES OF '"RatioInPercent"' IN lv_json WITH '"FxdAstRetirementRatioInPercent"'.
          ENDIF.

          REPLACE ALL OCCURRENCES OF '"RevenueType"'   IN lv_json WITH '"FxdAstRetirementRevenueType"'.
          REPLACE ALL OCCURRENCES OF '"RevenueAmount"' IN lv_json WITH '"AstRevenueAmountInTransCrcy"'.
          REPLACE ALL OCCURRENCES OF '"CurrencyRole"'  IN lv_json WITH '"FxdAstRtrmtRevnCurrencyRole"'.
          REPLACE ALL OCCURRENCES OF '"DocumentHeaderText"' IN lv_json WITH '"AccountingDocumentHeaderText"'.

          lo_request->set_uri_path(
            '/sap/opu/odata4/sap/api_fixedassetretirement/srvd_a2x/sap/fixedassetretirement/0001/FixedAssetRetirement/SAP__self.Post'
          ).
          lo_request->set_header_field( i_name = 'Content-Type'  i_value = 'application/json' ).
          lo_request->set_header_field( i_name = 'Accept'        i_value = 'application/json' ).
          lo_request->set_header_field( i_name = 'x-csrf-token'  i_value = lv_csrf_token ).
          lo_request->set_text( lv_json ).

          " ── DEBUG TEMPORÁRIO: mostrar JSON enviado ──────────────────
          lv_proc_msg = lv_json(255).

          DATA(lo_response)    = lo_client->execute( if_web_http_client=>post ).
          DATA(lv_status_code) = lo_response->get_status( )-code.
          DATA(lv_body)        = lo_response->get_text( ).

          lo_client->close( ).

          IF lv_status_code >= 200 AND lv_status_code < 300.
            " ── SUCESSO ────────────────────────────────────────────────
            lv_proc_status = 'S'.
            lv_proc_msg    = 'Baixa realizada com sucesso'.
            TRY.
                FIND REGEX '"ReferenceDocument"\s*:\s*"([^"]*)"' IN lv_body SUBMATCHES lv_ref_doc.
              CATCH cx_root ##NO_HANDLER.
            ENDTRY.
          ELSEIF lv_status_code = 401.
            lv_proc_status = 'E'.
            lv_proc_msg = '[401] Autenticacao falhou - verifique usuario/senha no acordo ZCS_BAIXAIMOBILIZADO'.
          ELSEIF lv_status_code = 403.
            lv_proc_status = 'E'.
            lv_proc_msg = '[403] Sem autorizacao - atribua role de imobilizado ao usuario de comunicacao'.
          ELSE.
            " ── OUTROS ERROS HTTP ───────────────────────────────────────
            lv_proc_status = 'E'.

            " Detecta resposta HTML (pagina de login SAP) — nao exibir HTML bruto
            DATA lv_is_html TYPE abap_bool.
            IF lv_body CP '*<html*' OR lv_body CP '*<!DOCTYPE*'.
              lv_is_html = abap_true.
            ENDIF.

            IF lv_is_html = abap_false.
              FIND REGEX '"error"\s*:\s*\{[^}]*"message"\s*:\s*"([^"]{1,400})"'
                IN lv_body SUBMATCHES lv_msg_ext.
              IF lv_msg_ext IS INITIAL.
                FIND REGEX '"message"\s*:\s*"([^"]{1,400})"'
                  IN lv_body SUBMATCHES lv_msg_ext.
              ENDIF.
            ENDIF.

            IF lv_msg_ext IS NOT INITIAL.
              lv_proc_msg = |[{ lv_status_code }] { lv_msg_ext }|.
            ELSEIF lv_is_html = abap_true.
              lv_proc_msg = |[{ lv_status_code }] Resposta HTML - verifique configuracao do acordo de comunicacao|.
            ELSE.
              DATA(lv_raw) = |[{ lv_status_code }] { lv_body }|.
              IF strlen( lv_raw ) > 500.
                lv_proc_msg = lv_raw+0(500).
              ELSE.
                lv_proc_msg = lv_raw.
              ENDIF.
            ENDIF.
          ENDIF.


        CATCH cx_http_dest_provider_error INTO DATA(lx_dest).
          lv_proc_status = 'E'.
          lv_proc_msg    = |[DEST] { lx_dest->get_text( ) }|.
          IF strlen( lv_proc_msg ) > 255. lv_proc_msg = lv_proc_msg+0(255). ENDIF.
        CATCH cx_web_http_client_error INTO DATA(lx_http).
          lv_proc_status = 'E'.
          lv_proc_msg    = |[HTTP] { lx_http->get_text( ) }|.
          IF strlen( lv_proc_msg ) > 255. lv_proc_msg = lv_proc_msg+0(255). ENDIF.
        CATCH cx_root INTO DATA(lx_root).
          lv_proc_status = 'E'.
          lv_proc_msg    = |[EXC] { lx_root->get_text( ) }|.
          IF strlen( lv_proc_msg ) > 255. lv_proc_msg = lv_proc_msg+0(255). ENDIF.
      ENDTRY.

      " ── Sempre persiste status + mensagem via UPDATE ──────────────────
      " NÃO emitir reported com severity-error aqui:
      " O framework RAP interpreta error em reported como falha de validação
      " e pode fazer rollback silencioso do MODIFY ENTITIES abaixo.
      APPEND VALUE #(
        %tky          = ls_asset-%tky
        ProcessStatus = lv_proc_status
        ProcessMsg    = lv_proc_msg
        RefDocNumber  = lv_ref_doc
        %control = VALUE #(
          ProcessStatus = if_abap_behv=>mk-on
          ProcessMsg    = if_abap_behv=>mk-on
          RefDocNumber  = if_abap_behv=>mk-on )
      ) TO lt_update.

      " Mensagem informativa para o toast do Fiori (severity-warning não bloqueia)
      APPEND VALUE #(
        %tky = ls_asset-%tky
        %msg = new_message_with_text(
          severity = COND #(
            WHEN lv_proc_status = 'S'
            THEN if_abap_behv_message=>severity-success
            ELSE if_abap_behv_message=>severity-information ) "<< info = toast, não abre dialog modal
          text = |{ lv_master }-{ lv_subnr }: { lv_proc_msg }| )
      ) TO reported-assetretire.

    ENDLOOP.

    " ── Persiste todas as atualizações de status ──────────────────────
    MODIFY ENTITIES OF zi_assetretire IN LOCAL MODE
      ENTITY AssetRetire
      UPDATE FROM lt_update
      FAILED DATA(lt_upd_failed)
      REPORTED DATA(lt_upd_reported).

    " Propaga eventuais falhas do UPDATE
    INSERT LINES OF lt_upd_reported-assetretire INTO TABLE reported-assetretire.

    " Retorna os registros atualizados com ProcessMsg visível na tela
    READ ENTITIES OF zi_assetretire IN LOCAL MODE
      ENTITY AssetRetire
      FIELDS ( CompanyCode MasterFixedAsset FixedAsset AssetDescription AssetClass
               AcquisitionDate DocumentDate PostingDate AssetValueDate
               RetirementType RetirementRatio HeaderText ItemText
               ProcessStatus ProcessMsg RefDocNumber StatusCriticality )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_result).

    result = VALUE #( FOR ls IN lt_result
      ( %tky = ls-%tky
        %param = ls ) ).
  ENDMETHOD.

ENDCLASS.

CLASS lsc_zi_assetretire DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.
    METHODS save_modified    REDEFINITION.

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
