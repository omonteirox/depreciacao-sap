"! <p class="shorttext synchronized">Consumption model for client proxy - generated</p>
"! This class has been generated based on the metadata with namespace
"! <em>com.sap.gateway.srvd_a2x.api_fixedassetretirement.v0001</em>
CLASS zsc_fixedasset DEFINITION
  PUBLIC
  INHERITING FROM /iwbep/cl_v4_abs_pm_model_prov
  CREATE PUBLIC.

  PUBLIC SECTION.

    TYPES:
      "! <p class="shorttext synchronized">Types for "OData Primitive Types"</p>
      BEGIN OF tys_types_for_prim_types,
        "! Used for primitive type ACCOUNTING_DOCUMENT_HEADER
        accounting_document_header TYPE c LENGTH 25,
        "! Used for primitive type ACCOUNTING_DOCUMENT_TYPE
        accounting_document_type   TYPE c LENGTH 2,
        "! Used for primitive type ASSET_VALUE_DATE
        asset_value_date           TYPE datn,
        "! Used for primitive type ASSIGNMENT_REFERENCE
        assignment_reference       TYPE c LENGTH 18,
        "! Used for primitive type AST_REVENUE_AMOUNT_IN_TRAN
        ast_revenue_amount_in_tran TYPE decfloat34,
        "! Used for primitive type AST_RTRMT_AMT_IN_TRANS_CRC
        ast_rtrmt_amt_in_trans_crc TYPE decfloat34,
        "! Used for primitive type BASE_UNIT_ISOCODE
        base_unit_isocode          TYPE c LENGTH 3,
        "! Used for primitive type BASE_UNIT_SAPCODE
        base_unit_sapcode          TYPE c LENGTH 3,
        "! Used for primitive type BUSINESS_TRANSACTION_TYPE
        business_transaction_type  TYPE c LENGTH 4,
        "! Used for primitive type COMPANY_CODE
        company_code               TYPE c LENGTH 4,
        "! Used for primitive type DOCUMENT_DATE
        document_date              TYPE datn,
        "! Used for primitive type DOCUMENT_ITEM_TEXT
        document_item_text         TYPE c LENGTH 50,
        "! Used for primitive type DOCUMENT_REFERENCE_ID
        document_reference_id      TYPE c LENGTH 16,
        "! Used for primitive type FIXED_ASSET
        fixed_asset                TYPE c LENGTH 4,
        "! Used for primitive type FIXED_ASSET_RETIREMENT_T_2
        fixed_asset_retirement_t_2 TYPE c LENGTH 1,
        "! Used for primitive type FIXED_ASSET_YEAR_OF_ACQN_C
        fixed_asset_year_of_acqn_c TYPE c LENGTH 1,
        "! Used for primitive type FXD_AST_RETIREMENT_RATIO_I
        fxd_ast_retirement_ratio_i TYPE p LENGTH 3 DECIMALS 2,
        "! Used for primitive type FXD_AST_RETIREMENT_REVENUE
        fxd_ast_retirement_revenue TYPE c LENGTH 1,
        "! Used for primitive type FXD_AST_RETIREMENT_TRANS_C
        fxd_ast_retirement_trans_c TYPE c LENGTH 3,
        "! Used for primitive type FXD_AST_REVN_DETN_DEPR_ARE
        fxd_ast_revn_detn_depr_are TYPE c LENGTH 2,
        "! Used for primitive type FXD_AST_RTRMT_QUANTITY_IN
        fxd_ast_rtrmt_quantity_in  TYPE p LENGTH 7 DECIMALS 3,
        "! Used for primitive type FXD_AST_RTRMT_REVN_CURRENC
        fxd_ast_rtrmt_revn_currenc TYPE c LENGTH 2,
        "! Used for primitive type FXD_AST_RTRMT_REVN_TRANS_C
        fxd_ast_rtrmt_revn_trans_c TYPE c LENGTH 3,
        "! Used for primitive type MASTER_FIXED_ASSET
        master_fixed_asset         TYPE c LENGTH 12,
        "! Used for primitive type POSTING_DATE
        posting_date               TYPE datn,
        "! Used for primitive type REFERENCE_DOCUMENT_ITEM
        reference_document_item    TYPE c LENGTH 6,
        "! Used for primitive type TRADING_PARTNER
        trading_partner            TYPE c LENGTH 6,
      END OF tys_types_for_prim_types.

    TYPES:
      "! <p class="shorttext synchronized">Types for primitive collection fields</p>
      BEGIN OF tys_types_for_prim_colls,
        "! additionalTargets
        "! Used for TYS_SAP_MESSAGE-ADDITIONAL_TARGETS
        additional_targets TYPE string,
      END OF tys_types_for_prim_colls.

    TYPES:
      "! <p class="shorttext synchronized">D_FxdAstPostRetirementValnP</p>
      BEGIN OF tys_d_fxd_ast_post_retiremen_2,
        "! AssetDepreciationArea
        asset_depreciation_area TYPE c LENGTH 2,
      END OF tys_d_fxd_ast_post_retiremen_2,
      "! <p class="shorttext synchronized">List of D_FxdAstPostRetirementValnP</p>
      tyt_d_fxd_ast_post_retiremen_2 TYPE STANDARD TABLE OF tys_d_fxd_ast_post_retiremen_2 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">D_FxdAstPostRetirementLedgerP</p>
      BEGIN OF tys_d_fxd_ast_post_retirement,
        "! Ledger
        ledger    TYPE c LENGTH 2,
        "! _Valuation
        valuation TYPE tyt_d_fxd_ast_post_retiremen_2,
      END OF tys_d_fxd_ast_post_retirement,
      "! <p class="shorttext synchronized">List of D_FxdAstPostRetirementLedgerP</p>
      tyt_d_fxd_ast_post_retirement TYPE STANDARD TABLE OF tys_d_fxd_ast_post_retirement WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">Value Control Structure of SAP_MESSAGE</p>
      BEGIN OF tys_value_controls_1,
        "! TARGET
        target       TYPE /iwbep/v4_value_control,
        "! LONGTEXT_URL
        longtext_url TYPE /iwbep/v4_value_control,
      END OF tys_value_controls_1.

    TYPES:
      "! <p class="shorttext synchronized">SAP__Message</p>
      BEGIN OF tys_sap_message,
        "! <em>Value Control Structure</em>
        value_controls     TYPE tys_value_controls_1,
        "! code
        code               TYPE string,
        "! message
        message            TYPE string,
        "! target
        target             TYPE string,
        "! additionalTargets
        additional_targets TYPE STANDARD TABLE OF tys_types_for_prim_colls-additional_targets WITH DEFAULT KEY,
        "! transition
        transition         TYPE abap_bool,
        "! numericSeverity
        numeric_severity   TYPE int1,
        "! longtextUrl
        longtext_url       TYPE string,
      END OF tys_sap_message,
      "! <p class="shorttext synchronized">List of SAP__Message</p>
      tyt_sap_message TYPE STANDARD TABLE OF tys_sap_message WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">Value Control Structure of FIXED_ASSET_RETIREMENT_L_2</p>
      BEGIN OF tys_value_controls_2,
        "! FIXED_ASSET_POSTING_VALUAT
        fixed_asset_posting_valuat TYPE /iwbep/v4_value_control,
      END OF tys_value_controls_2.

    TYPES:
      "! <p class="shorttext synchronized">Value Control Structure of FIXED_ASSET_RETIREMENT_TYP</p>
      BEGIN OF tys_value_controls_3,
        "! DOCUMENT_DATE
        document_date              TYPE /iwbep/v4_value_control,
        "! POSTING_DATE
        posting_date               TYPE /iwbep/v4_value_control,
        "! ASSET_VALUE_DATE
        asset_value_date           TYPE /iwbep/v4_value_control,
        "! FIXED_ASSET_POSTING_LEDGER
        fixed_asset_posting_ledger TYPE /iwbep/v4_value_control,
        "! FIXED_ASSET_POSTING_VALUAT
        fixed_asset_posting_valuat TYPE /iwbep/v4_value_control,
      END OF tys_value_controls_3.

    TYPES:
      "! <p class="shorttext synchronized">Value Control Structure</p>
      BEGIN OF tys_value_controls_4,
        "! DOCUMENT_DATE
        document_date    TYPE /iwbep/v4_value_control,
        "! POSTING_DATE
        posting_date     TYPE /iwbep/v4_value_control,
        "! ASSET_VALUE_DATE
        asset_value_date TYPE /iwbep/v4_value_control,
      END OF tys_value_controls_4.

    TYPES:
      "! <p class="shorttext synchronized">Parameters of action Post</p>
      "! <em>with the internal name</em> POST
      BEGIN OF tys_parameters_1,
        "! ReferenceDocumentItem
        reference_document_item    TYPE c LENGTH 6,
        "! BusinessTransactionType
        business_transaction_type  TYPE c LENGTH 4,
        "! CompanyCode
        company_code               TYPE c LENGTH 4,
        "! MasterFixedAsset
        master_fixed_asset         TYPE c LENGTH 12,
        "! FixedAsset
        fixed_asset                TYPE c LENGTH 4,
        "! DocumentDate
        document_date              TYPE datn,
        "! PostingDate
        posting_date               TYPE datn,
        "! AssetValueDate
        asset_value_date           TYPE datn,
        "! FxdAstRetirementRevenueType
        fxd_ast_retirement_revenue TYPE c LENGTH 1,
        "! AstRevenueAmountInTransCrcy
        ast_revenue_amount_in_tran TYPE decfloat34,
        "! FxdAstRtrmtRevnTransCrcy
        fxd_ast_rtrmt_revn_trans_c TYPE c LENGTH 3,
        "! FxdAstRtrmtRevnCurrencyRole
        fxd_ast_rtrmt_revn_currenc TYPE c LENGTH 2,
        "! FxdAstRevnDetnDeprArea
        fxd_ast_revn_detn_depr_are TYPE c LENGTH 2,
        "! FixedAssetRetirementType
        fixed_asset_retirement_typ TYPE c LENGTH 1,
        "! AstRtrmtAmtInTransCrcy
        ast_rtrmt_amt_in_trans_crc TYPE decfloat34,
        "! FxdAstRetirementTransCrcy
        fxd_ast_retirement_trans_c TYPE c LENGTH 3,
        "! FxdAstRetirementRatioInPercent
        fxd_ast_retirement_ratio_i TYPE p LENGTH 3 DECIMALS 2,
        "! FixedAssetYearOfAcqnCode
        fixed_asset_year_of_acqn_c TYPE c LENGTH 1,
        "! DocumentReferenceID
        document_reference_id      TYPE c LENGTH 16,
        "! AccountingDocumentHeaderText
        accounting_document_header TYPE c LENGTH 25,
        "! FxdAstRtrmtQuantityInBaseUnit
        fxd_ast_rtrmt_quantity_in  TYPE p LENGTH 7 DECIMALS 3,
        "! BaseUnitSAPCode
        base_unit_sapcode          TYPE c LENGTH 3,
        "! BaseUnitISOCode
        base_unit_isocode          TYPE c LENGTH 3,
        "! AccountingDocumentType
        accounting_document_type   TYPE c LENGTH 2,
        "! TradingPartner
        trading_partner            TYPE c LENGTH 6,
        "! AssignmentReference
        assignment_reference       TYPE c LENGTH 18,
        "! DocumentItemText
        document_item_text         TYPE c LENGTH 50,
        "! _Ledger
        ledger                     TYPE tyt_d_fxd_ast_post_retirement,
        "! <em>Value Control Structure</em>
        value_controls             TYPE tys_value_controls_4,
      END OF tys_parameters_1,
      "! <p class="shorttext synchronized">List of TYS_PARAMETERS_1</p>
      tyt_parameters_1 TYPE STANDARD TABLE OF tys_parameters_1 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">FixedAssetRetirementLedger_Type</p>
      BEGIN OF tys_fixed_asset_retirement_l_2,
        "! <em>Value Control Structure</em>
        value_controls           TYPE tys_value_controls_2,
        "! <em>Key property</em> FixedAssetPostingUUID
        fixed_asset_posting_uuid TYPE sysuuid_x16,
        "! <em>Key property</em> ReferenceDocumentItem
        reference_document_item  TYPE c LENGTH 6,
        "! <em>Key property</em> Ledger
        ledger                   TYPE c LENGTH 2,
      END OF tys_fixed_asset_retirement_l_2,
      "! <p class="shorttext synchronized">List of FixedAssetRetirementLedger_Type</p>
      tyt_fixed_asset_retirement_l_2 TYPE STANDARD TABLE OF tys_fixed_asset_retirement_l_2 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">FixedAssetRetirement_Type</p>
      BEGIN OF tys_fixed_asset_retirement_typ,
        "! <em>Value Control Structure</em>
        value_controls             TYPE tys_value_controls_3,
        "! <em>Key property</em> FixedAssetPostingUUID
        fixed_asset_posting_uuid   TYPE sysuuid_x16,
        "! <em>Key property</em> ReferenceDocumentItem
        reference_document_item    TYPE c LENGTH 6,
        "! ReferenceDocumentType
        reference_document_type    TYPE c LENGTH 5,
        "! ReferenceDocument
        reference_document         TYPE c LENGTH 10,
        "! ReferenceDocumentContext
        reference_document_context TYPE c LENGTH 10,
        "! ReferenceDocumentLogicalSystem
        reference_document_logical TYPE c LENGTH 10,
        "! CompanyCode
        company_code               TYPE c LENGTH 4,
        "! MasterFixedAsset
        master_fixed_asset         TYPE c LENGTH 12,
        "! FixedAsset
        fixed_asset                TYPE c LENGTH 4,
        "! AssetClass
        asset_class                TYPE c LENGTH 8,
        "! DocumentDate
        document_date              TYPE datn,
        "! PostingDate
        posting_date               TYPE datn,
        "! AssetValueDate
        asset_value_date           TYPE datn,
        "! BusinessTransactionType
        business_transaction_type  TYPE c LENGTH 4,
        "! DocumentReferenceID
        document_reference_id      TYPE c LENGTH 16,
        "! AccountingDocumentHeaderText
        accounting_document_header TYPE c LENGTH 25,
        "! FxdAstRetirementRevenueType
        fxd_ast_retirement_revenue TYPE c LENGTH 1,
        "! AstRevenueAmountInTransCrcy
        ast_revenue_amount_in_tran TYPE decfloat34,
        "! FxdAstRtrmtRevnTransCrcy
        fxd_ast_rtrmt_revn_trans_c TYPE c LENGTH 3,
        "! FxdAstRtrmtRevnCurrencyRole
        fxd_ast_rtrmt_revn_currenc TYPE c LENGTH 2,
        "! FxdAstRevnDetnDeprArea
        fxd_ast_revn_detn_depr_are TYPE c LENGTH 2,
        "! FixedAssetRetirementType
        fixed_asset_retirement_t_2 TYPE c LENGTH 1,
        "! AstRtrmtAmtInTransCrcy
        ast_rtrmt_amt_in_trans_crc TYPE decfloat34,
        "! FxdAstRetirementTransCrcy
        fxd_ast_retirement_trans_c TYPE c LENGTH 3,
        "! FxdAstRetirementRatioInPercent
        fxd_ast_retirement_ratio_i TYPE p LENGTH 3 DECIMALS 2,
        "! FxdAstRtrmtQuantityInBaseUnit
        fxd_ast_rtrmt_quantity_in  TYPE p LENGTH 7 DECIMALS 3,
        "! BaseUnitSAPCode
        base_unit_sapcode          TYPE c LENGTH 3,
        "! BaseUnitISOCode
        base_unit_isocode          TYPE c LENGTH 3,
        "! FixedAssetYearOfAcqnCode
        fixed_asset_year_of_acqn_c TYPE c LENGTH 1,
        "! AccountingDocumentType
        accounting_document_type   TYPE c LENGTH 2,
        "! TradingPartner
        trading_partner            TYPE c LENGTH 6,
        "! AssignmentReference
        assignment_reference       TYPE c LENGTH 18,
        "! DocumentItemText
        document_item_text         TYPE c LENGTH 50,
        "! SAP__Messages
        sap_messages               TYPE tyt_sap_message,
      END OF tys_fixed_asset_retirement_typ,
      "! <p class="shorttext synchronized">List of FixedAssetRetirement_Type</p>
      tyt_fixed_asset_retirement_typ TYPE STANDARD TABLE OF tys_fixed_asset_retirement_typ WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">FixedAssetRtrmtValuation_Type</p>
      BEGIN OF tys_fixed_asset_rtrmt_valuat_2,
        "! <em>Key property</em> FixedAssetPostingUUID
        fixed_asset_posting_uuid TYPE sysuuid_x16,
        "! <em>Key property</em> ReferenceDocumentItem
        reference_document_item  TYPE c LENGTH 6,
        "! <em>Key property</em> Ledger
        ledger                   TYPE c LENGTH 2,
        "! <em>Key property</em> AssetDepreciationArea
        asset_depreciation_area  TYPE c LENGTH 2,
      END OF tys_fixed_asset_rtrmt_valuat_2,
      "! <p class="shorttext synchronized">List of FixedAssetRtrmtValuation_Type</p>
      tyt_fixed_asset_rtrmt_valuat_2 TYPE STANDARD TABLE OF tys_fixed_asset_rtrmt_valuat_2 WITH DEFAULT KEY.


    CONSTANTS:
      "! <p class="shorttext synchronized">Internal Names of the entity sets</p>
      BEGIN OF gcs_entity_set,
        "! FixedAssetRetirement
        "! <br/> Collection of type 'FixedAssetRetirement_Type'
        fixed_asset_retirement     TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'FIXED_ASSET_RETIREMENT',
        "! FixedAssetRetirementLedger
        "! <br/> Collection of type 'FixedAssetRetirementLedger_Type'
        fixed_asset_retirement_led TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'FIXED_ASSET_RETIREMENT_LED',
        "! FixedAssetRtrmtValuation
        "! <br/> Collection of type 'FixedAssetRtrmtValuation_Type'
        fixed_asset_rtrmt_valuatio TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'FIXED_ASSET_RTRMT_VALUATIO',
      END OF gcs_entity_set .

    CONSTANTS:
      "! <p class="shorttext synchronized">Internal Names of the bound actions</p>
      BEGIN OF gcs_bound_action,
        "! Post
        "! <em>bound against collections of entity type</em> FixedAssetRetirement_Type
        "! <br/> See structure type {@link ..tys_parameters_1} for the parameters
        post TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'POST',
      END OF gcs_bound_action.

    CONSTANTS:
      "! <p class="shorttext synchronized">Internal names for complex types</p>
      BEGIN OF gcs_complex_type,
        "! <p class="shorttext synchronized">Internal names for D_FxdAstPostRetirementLedgerP</p>
        "! See also structure type {@link ..tys_d_fxd_ast_post_retirement}
        BEGIN OF d_fxd_ast_post_retirement,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! Dummy field - Structure must not be empty
            dummy TYPE int1 VALUE 0,
          END OF navigation,
        END OF d_fxd_ast_post_retirement,
        "! <p class="shorttext synchronized">Internal names for D_FxdAstPostRetirementValnP</p>
        "! See also structure type {@link ..tys_d_fxd_ast_post_retiremen_2}
        BEGIN OF d_fxd_ast_post_retiremen_2,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! Dummy field - Structure must not be empty
            dummy TYPE int1 VALUE 0,
          END OF navigation,
        END OF d_fxd_ast_post_retiremen_2,
        "! <p class="shorttext synchronized">Internal names for SAP__Message</p>
        "! See also structure type {@link ..tys_sap_message}
        BEGIN OF sap_message,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! Dummy field - Structure must not be empty
            dummy TYPE int1 VALUE 0,
          END OF navigation,
        END OF sap_message,
      END OF gcs_complex_type.

    CONSTANTS:
      "! <p class="shorttext synchronized">Internal names for entity types</p>
      BEGIN OF gcs_entity_type,
        "! <p class="shorttext synchronized">Internal names for FixedAssetRetirementLedger_Type</p>
        "! See also structure type {@link ..tys_fixed_asset_retirement_l_2}
        BEGIN OF fixed_asset_retirement_l_2,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! _FixedAssetPosting
            fixed_asset_posting        TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'FIXED_ASSET_POSTING',
            "! _FixedAssetPostingValuation
            fixed_asset_posting_valuat TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'FIXED_ASSET_POSTING_VALUAT',
          END OF navigation,
        END OF fixed_asset_retirement_l_2,
        "! <p class="shorttext synchronized">Internal names for FixedAssetRetirement_Type</p>
        "! See also structure type {@link ..tys_fixed_asset_retirement_typ}
        BEGIN OF fixed_asset_retirement_typ,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! _FixedAssetPostingLedger
            fixed_asset_posting_ledger TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'FIXED_ASSET_POSTING_LEDGER',
            "! _FixedAssetPostingValuation
            fixed_asset_posting_valuat TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'FIXED_ASSET_POSTING_VALUAT',
          END OF navigation,
        END OF fixed_asset_retirement_typ,
        "! <p class="shorttext synchronized">Internal names for FixedAssetRtrmtValuation_Type</p>
        "! See also structure type {@link ..tys_fixed_asset_rtrmt_valuat_2}
        BEGIN OF fixed_asset_rtrmt_valuat_2,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! _FixedAssetPosting
            fixed_asset_posting        TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'FIXED_ASSET_POSTING',
            "! _FixedAssetPostingLedger
            fixed_asset_posting_ledger TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'FIXED_ASSET_POSTING_LEDGER',
          END OF navigation,
        END OF fixed_asset_rtrmt_valuat_2,
      END OF gcs_entity_type.


    METHODS /iwbep/if_v4_mp_basic_pm~define REDEFINITION.


  PRIVATE SECTION.

    "! <p class="shorttext synchronized">Model</p>
    DATA mo_model TYPE REF TO /iwbep/if_v4_pm_model.


    "! <p class="shorttext synchronized">Define D_FxdAstPostRetirementLedgerP</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_d_fxd_ast_post_retirement RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define D_FxdAstPostRetirementValnP</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_d_fxd_ast_post_retiremen_2 RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define SAP__Message</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_sap_message RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define FixedAssetRetirementLedger_Type</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_fixed_asset_retirement_l_2 RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define FixedAssetRetirement_Type</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_fixed_asset_retirement_typ RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define FixedAssetRtrmtValuation_Type</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_fixed_asset_rtrmt_valuat_2 RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define Post</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_post RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define all primitive types</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS define_primitive_types RAISING /iwbep/cx_gateway.

ENDCLASS.



CLASS ZSC_FIXEDASSET IMPLEMENTATION.


  METHOD /iwbep/if_v4_mp_basic_pm~define.

    mo_model = io_model.
    mo_model->set_schema_namespace( 'com.sap.gateway.srvd_a2x.api_fixedassetretirement.v0001' ) ##NO_TEXT.

    def_d_fxd_ast_post_retirement( ).
    def_d_fxd_ast_post_retiremen_2( ).
    def_sap_message( ).
    def_fixed_asset_retirement_l_2( ).
    def_fixed_asset_retirement_typ( ).
    def_fixed_asset_rtrmt_valuat_2( ).
    def_post( ).
    define_primitive_types( ).

  ENDMETHOD.


  METHOD define_primitive_types.

    DATA lo_primitive_type TYPE REF TO /iwbep/if_v4_pm_prim_type.


    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'ACCOUNTING_DOCUMENT_HEADER'
                            iv_element             = VALUE tys_types_for_prim_types-accounting_document_header( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'ACCOUNTING_DOCUMENT_TYPE'
                            iv_element             = VALUE tys_types_for_prim_types-accounting_document_type( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'ASSET_VALUE_DATE'
                            iv_element             = VALUE tys_types_for_prim_types-asset_value_date( ) ).
    lo_primitive_type->set_edm_type( 'Date' ) ##NO_TEXT.

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'ASSIGNMENT_REFERENCE'
                            iv_element             = VALUE tys_types_for_prim_types-assignment_reference( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'AST_REVENUE_AMOUNT_IN_TRAN'
                            iv_element             = VALUE tys_types_for_prim_types-ast_revenue_amount_in_tran( ) ).
    lo_primitive_type->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_type->set_precision( 23 ) ##NUMBER_OK.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'AST_RTRMT_AMT_IN_TRANS_CRC'
                            iv_element             = VALUE tys_types_for_prim_types-ast_rtrmt_amt_in_trans_crc( ) ).
    lo_primitive_type->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_type->set_precision( 23 ) ##NUMBER_OK.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'BASE_UNIT_ISOCODE'
                            iv_element             = VALUE tys_types_for_prim_types-base_unit_isocode( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'BASE_UNIT_SAPCODE'
                            iv_element             = VALUE tys_types_for_prim_types-base_unit_sapcode( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'BUSINESS_TRANSACTION_TYPE'
                            iv_element             = VALUE tys_types_for_prim_types-business_transaction_type( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'COMPANY_CODE'
                            iv_element             = VALUE tys_types_for_prim_types-company_code( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'DOCUMENT_DATE'
                            iv_element             = VALUE tys_types_for_prim_types-document_date( ) ).
    lo_primitive_type->set_edm_type( 'Date' ) ##NO_TEXT.

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'DOCUMENT_ITEM_TEXT'
                            iv_element             = VALUE tys_types_for_prim_types-document_item_text( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'DOCUMENT_REFERENCE_ID'
                            iv_element             = VALUE tys_types_for_prim_types-document_reference_id( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'FIXED_ASSET'
                            iv_element             = VALUE tys_types_for_prim_types-fixed_asset( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'FIXED_ASSET_RETIREMENT_T_2'
                            iv_element             = VALUE tys_types_for_prim_types-fixed_asset_retirement_t_2( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'FIXED_ASSET_YEAR_OF_ACQN_C'
                            iv_element             = VALUE tys_types_for_prim_types-fixed_asset_year_of_acqn_c( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'FXD_AST_RETIREMENT_RATIO_I'
                            iv_element             = VALUE tys_types_for_prim_types-fxd_ast_retirement_ratio_i( ) ).
    lo_primitive_type->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_type->set_precision( 5 ) ##NUMBER_OK.
    lo_primitive_type->set_scale( 2 ) ##NUMBER_OK.

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'FXD_AST_RETIREMENT_REVENUE'
                            iv_element             = VALUE tys_types_for_prim_types-fxd_ast_retirement_revenue( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'FXD_AST_RETIREMENT_TRANS_C'
                            iv_element             = VALUE tys_types_for_prim_types-fxd_ast_retirement_trans_c( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'FXD_AST_REVN_DETN_DEPR_ARE'
                            iv_element             = VALUE tys_types_for_prim_types-fxd_ast_revn_detn_depr_are( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'FXD_AST_RTRMT_QUANTITY_IN'
                            iv_element             = VALUE tys_types_for_prim_types-fxd_ast_rtrmt_quantity_in( ) ).
    lo_primitive_type->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_type->set_precision( 13 ) ##NUMBER_OK.
    lo_primitive_type->set_scale( 3 ) ##NUMBER_OK.

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'FXD_AST_RTRMT_REVN_CURRENC'
                            iv_element             = VALUE tys_types_for_prim_types-fxd_ast_rtrmt_revn_currenc( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'FXD_AST_RTRMT_REVN_TRANS_C'
                            iv_element             = VALUE tys_types_for_prim_types-fxd_ast_rtrmt_revn_trans_c( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'MASTER_FIXED_ASSET'
                            iv_element             = VALUE tys_types_for_prim_types-master_fixed_asset( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'POSTING_DATE'
                            iv_element             = VALUE tys_types_for_prim_types-posting_date( ) ).
    lo_primitive_type->set_edm_type( 'Date' ) ##NO_TEXT.

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'REFERENCE_DOCUMENT_ITEM'
                            iv_element             = VALUE tys_types_for_prim_types-reference_document_item( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'TRADING_PARTNER'
                            iv_element             = VALUE tys_types_for_prim_types-trading_partner( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.

  ENDMETHOD.


  METHOD def_d_fxd_ast_post_retirement.

    DATA:
      lo_complex_property    TYPE REF TO /iwbep/if_v4_pm_cplx_prop,
      lo_complex_type        TYPE REF TO /iwbep/if_v4_pm_cplx_type,
      lo_navigation_property TYPE REF TO /iwbep/if_v4_pm_nav_prop,
      lo_primitive_property  TYPE REF TO /iwbep/if_v4_pm_prim_prop.


    lo_complex_type = mo_model->create_complex_type_by_struct(
                                    iv_complex_type_name      = 'D_FXD_AST_POST_RETIREMENT'
                                    is_structure              = VALUE tys_d_fxd_ast_post_retirement( )
                                    iv_do_gen_prim_props         = abap_true
                                    iv_do_gen_prim_prop_colls    = abap_true
                                    iv_do_add_conv_to_prim_props = abap_true ).

    lo_complex_type->set_edm_name( 'D_FxdAstPostRetirementLedgerP' ) ##NO_TEXT.


    lo_primitive_property = lo_complex_type->get_primitive_property( 'LEDGER' ).
    lo_primitive_property->set_edm_name( 'Ledger' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 2 ) ##NUMBER_OK.

    lo_complex_property = lo_complex_type->create_complex_property( 'VALUATION' ).
    lo_complex_property->set_edm_name( '_Valuation' ) ##NO_TEXT.
    lo_complex_property->set_complex_type( 'D_FXD_AST_POST_RETIREMEN_2' ).
    lo_complex_property->set_is_collection( ).

  ENDMETHOD.


  METHOD def_d_fxd_ast_post_retiremen_2.

    DATA:
      lo_complex_property    TYPE REF TO /iwbep/if_v4_pm_cplx_prop,
      lo_complex_type        TYPE REF TO /iwbep/if_v4_pm_cplx_type,
      lo_navigation_property TYPE REF TO /iwbep/if_v4_pm_nav_prop,
      lo_primitive_property  TYPE REF TO /iwbep/if_v4_pm_prim_prop.


    lo_complex_type = mo_model->create_complex_type_by_struct(
                                    iv_complex_type_name      = 'D_FXD_AST_POST_RETIREMEN_2'
                                    is_structure              = VALUE tys_d_fxd_ast_post_retiremen_2( )
                                    iv_do_gen_prim_props         = abap_true
                                    iv_do_gen_prim_prop_colls    = abap_true
                                    iv_do_add_conv_to_prim_props = abap_true ).

    lo_complex_type->set_edm_name( 'D_FxdAstPostRetirementValnP' ) ##NO_TEXT.


    lo_primitive_property = lo_complex_type->get_primitive_property( 'ASSET_DEPRECIATION_AREA' ).
    lo_primitive_property->set_edm_name( 'AssetDepreciationArea' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 2 ) ##NUMBER_OK.

  ENDMETHOD.


  METHOD def_fixed_asset_retirement_l_2.

    DATA:
      lo_complex_property    TYPE REF TO /iwbep/if_v4_pm_cplx_prop,
      lo_entity_type         TYPE REF TO /iwbep/if_v4_pm_entity_type,
      lo_entity_set          TYPE REF TO /iwbep/if_v4_pm_entity_set,
      lo_navigation_property TYPE REF TO /iwbep/if_v4_pm_nav_prop,
      lo_primitive_property  TYPE REF TO /iwbep/if_v4_pm_prim_prop.


    lo_entity_type = mo_model->create_entity_type_by_struct(
                                    iv_entity_type_name       = 'FIXED_ASSET_RETIREMENT_L_2'
                                    is_structure              = VALUE tys_fixed_asset_retirement_l_2( )
                                    iv_do_gen_prim_props         = abap_true
                                    iv_do_gen_prim_prop_colls    = abap_true
                                    iv_do_add_conv_to_prim_props = abap_true ).

    lo_entity_type->set_edm_name( 'FixedAssetRetirementLedger_Type' ) ##NO_TEXT.
    lo_entity_type->create_complex_prop_for_vcs( 'VALUE_CONTROLS' ).


    lo_entity_set = lo_entity_type->create_entity_set( 'FIXED_ASSET_RETIREMENT_LED' ).
    lo_entity_set->set_edm_name( 'FixedAssetRetirementLedger' ) ##NO_TEXT.


    lo_primitive_property = lo_entity_type->get_primitive_property( 'FIXED_ASSET_POSTING_UUID' ).
    lo_primitive_property->set_edm_name( 'FixedAssetPostingUUID' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Guid' ) ##NO_TEXT.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'REFERENCE_DOCUMENT_ITEM' ).
    lo_primitive_property->set_edm_name( 'ReferenceDocumentItem' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 6 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'LEDGER' ).
    lo_primitive_property->set_edm_name( 'Ledger' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 2 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_navigation_property = lo_entity_type->create_navigation_property( 'FIXED_ASSET_POSTING' ).
    lo_navigation_property->set_edm_name( '_FixedAssetPosting' ) ##NO_TEXT.
    lo_navigation_property->set_target_entity_type_name( 'FIXED_ASSET_RETIREMENT_TYP' ).
    lo_navigation_property->set_target_multiplicity( /iwbep/if_v4_pm_types=>gcs_nav_multiplicity-to_one ).

    lo_navigation_property = lo_entity_type->create_navigation_property( 'FIXED_ASSET_POSTING_VALUAT' ).
    lo_navigation_property->set_edm_name( '_FixedAssetPostingValuation' ) ##NO_TEXT.
    lo_navigation_property->set_target_entity_type_name( 'FIXED_ASSET_RTRMT_VALUAT_2' ).
    lo_navigation_property->set_target_multiplicity( /iwbep/if_v4_pm_types=>gcs_nav_multiplicity-to_many_optional ).
    lo_navigation_property->create_vcs_value_control( ).

  ENDMETHOD.


  METHOD def_fixed_asset_retirement_typ.

    DATA:
      lo_complex_property    TYPE REF TO /iwbep/if_v4_pm_cplx_prop,
      lo_entity_type         TYPE REF TO /iwbep/if_v4_pm_entity_type,
      lo_entity_set          TYPE REF TO /iwbep/if_v4_pm_entity_set,
      lo_navigation_property TYPE REF TO /iwbep/if_v4_pm_nav_prop,
      lo_primitive_property  TYPE REF TO /iwbep/if_v4_pm_prim_prop.


    lo_entity_type = mo_model->create_entity_type_by_struct(
                                    iv_entity_type_name       = 'FIXED_ASSET_RETIREMENT_TYP'
                                    is_structure              = VALUE tys_fixed_asset_retirement_typ( )
                                    iv_do_gen_prim_props         = abap_true
                                    iv_do_gen_prim_prop_colls    = abap_true
                                    iv_do_add_conv_to_prim_props = abap_true ).

    lo_entity_type->set_edm_name( 'FixedAssetRetirement_Type' ) ##NO_TEXT.
    lo_entity_type->create_complex_prop_for_vcs( 'VALUE_CONTROLS' ).


    lo_entity_set = lo_entity_type->create_entity_set( 'FIXED_ASSET_RETIREMENT' ).
    lo_entity_set->set_edm_name( 'FixedAssetRetirement' ) ##NO_TEXT.


    lo_primitive_property = lo_entity_type->get_primitive_property( 'FIXED_ASSET_POSTING_UUID' ).
    lo_primitive_property->set_edm_name( 'FixedAssetPostingUUID' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Guid' ) ##NO_TEXT.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'REFERENCE_DOCUMENT_ITEM' ).
    lo_primitive_property->set_edm_name( 'ReferenceDocumentItem' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 6 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'REFERENCE_DOCUMENT_TYPE' ).
    lo_primitive_property->set_edm_name( 'ReferenceDocumentType' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 5 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'REFERENCE_DOCUMENT' ).
    lo_primitive_property->set_edm_name( 'ReferenceDocument' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'REFERENCE_DOCUMENT_CONTEXT' ).
    lo_primitive_property->set_edm_name( 'ReferenceDocumentContext' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'REFERENCE_DOCUMENT_LOGICAL' ).
    lo_primitive_property->set_edm_name( 'ReferenceDocumentLogicalSystem' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'COMPANY_CODE' ).
    lo_primitive_property->set_edm_name( 'CompanyCode' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 4 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'MASTER_FIXED_ASSET' ).
    lo_primitive_property->set_edm_name( 'MasterFixedAsset' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 12 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'FIXED_ASSET' ).
    lo_primitive_property->set_edm_name( 'FixedAsset' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 4 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'ASSET_CLASS' ).
    lo_primitive_property->set_edm_name( 'AssetClass' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 8 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'DOCUMENT_DATE' ).
    lo_primitive_property->set_edm_name( 'DocumentDate' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Date' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).
    lo_primitive_property->create_vcs_value_control( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'POSTING_DATE' ).
    lo_primitive_property->set_edm_name( 'PostingDate' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Date' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).
    lo_primitive_property->create_vcs_value_control( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'ASSET_VALUE_DATE' ).
    lo_primitive_property->set_edm_name( 'AssetValueDate' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Date' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).
    lo_primitive_property->create_vcs_value_control( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'BUSINESS_TRANSACTION_TYPE' ).
    lo_primitive_property->set_edm_name( 'BusinessTransactionType' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 4 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'DOCUMENT_REFERENCE_ID' ).
    lo_primitive_property->set_edm_name( 'DocumentReferenceID' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 16 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'ACCOUNTING_DOCUMENT_HEADER' ).
    lo_primitive_property->set_edm_name( 'AccountingDocumentHeaderText' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 25 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'FXD_AST_RETIREMENT_REVENUE' ).
    lo_primitive_property->set_edm_name( 'FxdAstRetirementRevenueType' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'AST_REVENUE_AMOUNT_IN_TRAN' ).
    lo_primitive_property->set_edm_name( 'AstRevenueAmountInTransCrcy' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_property->set_precision( 23 ) ##NUMBER_OK.
    lo_primitive_property->set_scale_variable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'FXD_AST_RTRMT_REVN_TRANS_C' ).
    lo_primitive_property->set_edm_name( 'FxdAstRtrmtRevnTransCrcy' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 3 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'FXD_AST_RTRMT_REVN_CURRENC' ).
    lo_primitive_property->set_edm_name( 'FxdAstRtrmtRevnCurrencyRole' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 2 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'FXD_AST_REVN_DETN_DEPR_ARE' ).
    lo_primitive_property->set_edm_name( 'FxdAstRevnDetnDeprArea' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 2 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'FIXED_ASSET_RETIREMENT_T_2' ).
    lo_primitive_property->set_edm_name( 'FixedAssetRetirementType' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'AST_RTRMT_AMT_IN_TRANS_CRC' ).
    lo_primitive_property->set_edm_name( 'AstRtrmtAmtInTransCrcy' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_property->set_precision( 23 ) ##NUMBER_OK.
    lo_primitive_property->set_scale_variable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'FXD_AST_RETIREMENT_TRANS_C' ).
    lo_primitive_property->set_edm_name( 'FxdAstRetirementTransCrcy' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 3 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'FXD_AST_RETIREMENT_RATIO_I' ).
    lo_primitive_property->set_edm_name( 'FxdAstRetirementRatioInPercent' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_property->set_precision( 5 ) ##NUMBER_OK.
    lo_primitive_property->set_scale( 2 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'FXD_AST_RTRMT_QUANTITY_IN' ).
    lo_primitive_property->set_edm_name( 'FxdAstRtrmtQuantityInBaseUnit' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_property->set_precision( 13 ) ##NUMBER_OK.
    lo_primitive_property->set_scale( 3 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'BASE_UNIT_SAPCODE' ).
    lo_primitive_property->set_edm_name( 'BaseUnitSAPCode' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 3 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'BASE_UNIT_ISOCODE' ).
    lo_primitive_property->set_edm_name( 'BaseUnitISOCode' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 3 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'FIXED_ASSET_YEAR_OF_ACQN_C' ).
    lo_primitive_property->set_edm_name( 'FixedAssetYearOfAcqnCode' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'ACCOUNTING_DOCUMENT_TYPE' ).
    lo_primitive_property->set_edm_name( 'AccountingDocumentType' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 2 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'TRADING_PARTNER' ).
    lo_primitive_property->set_edm_name( 'TradingPartner' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 6 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'ASSIGNMENT_REFERENCE' ).
    lo_primitive_property->set_edm_name( 'AssignmentReference' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 18 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'DOCUMENT_ITEM_TEXT' ).
    lo_primitive_property->set_edm_name( 'DocumentItemText' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 50 ) ##NUMBER_OK.

    lo_complex_property = lo_entity_type->create_complex_property( 'SAP_MESSAGES' ).
    lo_complex_property->set_edm_name( 'SAP__Messages' ) ##NO_TEXT.
    lo_complex_property->set_complex_type( 'SAP_MESSAGE' ).
    lo_complex_property->set_is_collection( ).

    lo_navigation_property = lo_entity_type->create_navigation_property( 'FIXED_ASSET_POSTING_LEDGER' ).
    lo_navigation_property->set_edm_name( '_FixedAssetPostingLedger' ) ##NO_TEXT.
    lo_navigation_property->set_target_entity_type_name( 'FIXED_ASSET_RETIREMENT_L_2' ).
    lo_navigation_property->set_target_multiplicity( /iwbep/if_v4_pm_types=>gcs_nav_multiplicity-to_many_optional ).
    lo_navigation_property->create_vcs_value_control( ).

    lo_navigation_property = lo_entity_type->create_navigation_property( 'FIXED_ASSET_POSTING_VALUAT' ).
    lo_navigation_property->set_edm_name( '_FixedAssetPostingValuation' ) ##NO_TEXT.
    lo_navigation_property->set_target_entity_type_name( 'FIXED_ASSET_RTRMT_VALUAT_2' ).
    lo_navigation_property->set_target_multiplicity( /iwbep/if_v4_pm_types=>gcs_nav_multiplicity-to_many_optional ).
    lo_navigation_property->create_vcs_value_control( ).

  ENDMETHOD.


  METHOD def_fixed_asset_rtrmt_valuat_2.

    DATA:
      lo_complex_property    TYPE REF TO /iwbep/if_v4_pm_cplx_prop,
      lo_entity_type         TYPE REF TO /iwbep/if_v4_pm_entity_type,
      lo_entity_set          TYPE REF TO /iwbep/if_v4_pm_entity_set,
      lo_navigation_property TYPE REF TO /iwbep/if_v4_pm_nav_prop,
      lo_primitive_property  TYPE REF TO /iwbep/if_v4_pm_prim_prop.


    lo_entity_type = mo_model->create_entity_type_by_struct(
                                    iv_entity_type_name       = 'FIXED_ASSET_RTRMT_VALUAT_2'
                                    is_structure              = VALUE tys_fixed_asset_rtrmt_valuat_2( )
                                    iv_do_gen_prim_props         = abap_true
                                    iv_do_gen_prim_prop_colls    = abap_true
                                    iv_do_add_conv_to_prim_props = abap_true ).

    lo_entity_type->set_edm_name( 'FixedAssetRtrmtValuation_Type' ) ##NO_TEXT.


    lo_entity_set = lo_entity_type->create_entity_set( 'FIXED_ASSET_RTRMT_VALUATIO' ).
    lo_entity_set->set_edm_name( 'FixedAssetRtrmtValuation' ) ##NO_TEXT.


    lo_primitive_property = lo_entity_type->get_primitive_property( 'FIXED_ASSET_POSTING_UUID' ).
    lo_primitive_property->set_edm_name( 'FixedAssetPostingUUID' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Guid' ) ##NO_TEXT.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'REFERENCE_DOCUMENT_ITEM' ).
    lo_primitive_property->set_edm_name( 'ReferenceDocumentItem' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 6 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'LEDGER' ).
    lo_primitive_property->set_edm_name( 'Ledger' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 2 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'ASSET_DEPRECIATION_AREA' ).
    lo_primitive_property->set_edm_name( 'AssetDepreciationArea' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 2 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_navigation_property = lo_entity_type->create_navigation_property( 'FIXED_ASSET_POSTING' ).
    lo_navigation_property->set_edm_name( '_FixedAssetPosting' ) ##NO_TEXT.
    lo_navigation_property->set_target_entity_type_name( 'FIXED_ASSET_RETIREMENT_TYP' ).
    lo_navigation_property->set_target_multiplicity( /iwbep/if_v4_pm_types=>gcs_nav_multiplicity-to_one ).

    lo_navigation_property = lo_entity_type->create_navigation_property( 'FIXED_ASSET_POSTING_LEDGER' ).
    lo_navigation_property->set_edm_name( '_FixedAssetPostingLedger' ) ##NO_TEXT.
    lo_navigation_property->set_target_entity_type_name( 'FIXED_ASSET_RETIREMENT_L_2' ).
    lo_navigation_property->set_target_multiplicity( /iwbep/if_v4_pm_types=>gcs_nav_multiplicity-to_one ).

  ENDMETHOD.


  METHOD def_post.

    DATA:
      lo_action        TYPE REF TO /iwbep/if_v4_pm_action,
      lo_action_import TYPE REF TO /iwbep/if_v4_pm_action_imp,
      lo_parameter     TYPE REF TO /iwbep/if_v4_pm_act_param,
      lo_return        TYPE REF TO /iwbep/if_v4_pm_act_return.


    lo_action = mo_model->create_action( 'POST' ).
    lo_action->set_edm_name( 'Post' ) ##NO_TEXT.
    lo_action->create_complex_prop_for_vcs( 'VALUE_CONTROLS' ).

    " Name of the runtime structure that represents the parameters of this operation
    lo_action->/iwbep/if_v4_pm_ac_advanced~set_parameter_structure_info( VALUE tys_parameters_1( ) ).


    lo_parameter = lo_action->create_parameter( 'IT' ).
    lo_parameter->set_edm_name( '_it' ) ##NO_TEXT.
    lo_parameter->set_entity_type( 'FIXED_ASSET_RETIREMENT_TYP' ).
    lo_parameter->set_is_binding_parameter( ).
    lo_parameter->set_is_collection( ).

    lo_parameter = lo_action->create_parameter( 'REFERENCE_DOCUMENT_ITEM' ).
    lo_parameter->set_edm_name( 'ReferenceDocumentItem' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'REFERENCE_DOCUMENT_ITEM' ).

    lo_parameter = lo_action->create_parameter( 'BUSINESS_TRANSACTION_TYPE' ).
    lo_parameter->set_edm_name( 'BusinessTransactionType' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'BUSINESS_TRANSACTION_TYPE' ).

    lo_parameter = lo_action->create_parameter( 'COMPANY_CODE' ).
    lo_parameter->set_edm_name( 'CompanyCode' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'COMPANY_CODE' ).

    lo_parameter = lo_action->create_parameter( 'MASTER_FIXED_ASSET' ).
    lo_parameter->set_edm_name( 'MasterFixedAsset' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'MASTER_FIXED_ASSET' ).

    lo_parameter = lo_action->create_parameter( 'FIXED_ASSET' ).
    lo_parameter->set_edm_name( 'FixedAsset' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'FIXED_ASSET' ).

    lo_parameter = lo_action->create_parameter( 'DOCUMENT_DATE' ).
    lo_parameter->set_edm_name( 'DocumentDate' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'DOCUMENT_DATE' ).
    lo_parameter->create_vcs_value_control( ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_action->create_parameter( 'POSTING_DATE' ).
    lo_parameter->set_edm_name( 'PostingDate' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'POSTING_DATE' ).
    lo_parameter->create_vcs_value_control( ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_action->create_parameter( 'ASSET_VALUE_DATE' ).
    lo_parameter->set_edm_name( 'AssetValueDate' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'ASSET_VALUE_DATE' ).
    lo_parameter->create_vcs_value_control( ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_action->create_parameter( 'FXD_AST_RETIREMENT_REVENUE' ).
    lo_parameter->set_edm_name( 'FxdAstRetirementRevenueType' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'FXD_AST_RETIREMENT_REVENUE' ).

    lo_parameter = lo_action->create_parameter( 'AST_REVENUE_AMOUNT_IN_TRAN' ).
    lo_parameter->set_edm_name( 'AstRevenueAmountInTransCrcy' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'AST_REVENUE_AMOUNT_IN_TRAN' ).

    lo_parameter = lo_action->create_parameter( 'FXD_AST_RTRMT_REVN_TRANS_C' ).
    lo_parameter->set_edm_name( 'FxdAstRtrmtRevnTransCrcy' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'FXD_AST_RTRMT_REVN_TRANS_C' ).

    lo_parameter = lo_action->create_parameter( 'FXD_AST_RTRMT_REVN_CURRENC' ).
    lo_parameter->set_edm_name( 'FxdAstRtrmtRevnCurrencyRole' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'FXD_AST_RTRMT_REVN_CURRENC' ).

    lo_parameter = lo_action->create_parameter( 'FXD_AST_REVN_DETN_DEPR_ARE' ).
    lo_parameter->set_edm_name( 'FxdAstRevnDetnDeprArea' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'FXD_AST_REVN_DETN_DEPR_ARE' ).

    lo_parameter = lo_action->create_parameter( 'FIXED_ASSET_RETIREMENT_TYP' ).
    lo_parameter->set_edm_name( 'FixedAssetRetirementType' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'FIXED_ASSET_RETIREMENT_T_2' ).

    lo_parameter = lo_action->create_parameter( 'AST_RTRMT_AMT_IN_TRANS_CRC' ).
    lo_parameter->set_edm_name( 'AstRtrmtAmtInTransCrcy' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'AST_RTRMT_AMT_IN_TRANS_CRC' ).

    lo_parameter = lo_action->create_parameter( 'FXD_AST_RETIREMENT_TRANS_C' ).
    lo_parameter->set_edm_name( 'FxdAstRetirementTransCrcy' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'FXD_AST_RETIREMENT_TRANS_C' ).

    lo_parameter = lo_action->create_parameter( 'FXD_AST_RETIREMENT_RATIO_I' ).
    lo_parameter->set_edm_name( 'FxdAstRetirementRatioInPercent' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'FXD_AST_RETIREMENT_RATIO_I' ).

    lo_parameter = lo_action->create_parameter( 'FIXED_ASSET_YEAR_OF_ACQN_C' ).
    lo_parameter->set_edm_name( 'FixedAssetYearOfAcqnCode' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'FIXED_ASSET_YEAR_OF_ACQN_C' ).

    lo_parameter = lo_action->create_parameter( 'DOCUMENT_REFERENCE_ID' ).
    lo_parameter->set_edm_name( 'DocumentReferenceID' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'DOCUMENT_REFERENCE_ID' ).

    lo_parameter = lo_action->create_parameter( 'ACCOUNTING_DOCUMENT_HEADER' ).
    lo_parameter->set_edm_name( 'AccountingDocumentHeaderText' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'ACCOUNTING_DOCUMENT_HEADER' ).

    lo_parameter = lo_action->create_parameter( 'FXD_AST_RTRMT_QUANTITY_IN' ).
    lo_parameter->set_edm_name( 'FxdAstRtrmtQuantityInBaseUnit' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'FXD_AST_RTRMT_QUANTITY_IN' ).

    lo_parameter = lo_action->create_parameter( 'BASE_UNIT_SAPCODE' ).
    lo_parameter->set_edm_name( 'BaseUnitSAPCode' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'BASE_UNIT_SAPCODE' ).

    lo_parameter = lo_action->create_parameter( 'BASE_UNIT_ISOCODE' ).
    lo_parameter->set_edm_name( 'BaseUnitISOCode' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'BASE_UNIT_ISOCODE' ).

    lo_parameter = lo_action->create_parameter( 'ACCOUNTING_DOCUMENT_TYPE' ).
    lo_parameter->set_edm_name( 'AccountingDocumentType' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'ACCOUNTING_DOCUMENT_TYPE' ).

    lo_parameter = lo_action->create_parameter( 'TRADING_PARTNER' ).
    lo_parameter->set_edm_name( 'TradingPartner' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'TRADING_PARTNER' ).

    lo_parameter = lo_action->create_parameter( 'ASSIGNMENT_REFERENCE' ).
    lo_parameter->set_edm_name( 'AssignmentReference' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'ASSIGNMENT_REFERENCE' ).

    lo_parameter = lo_action->create_parameter( 'DOCUMENT_ITEM_TEXT' ).
    lo_parameter->set_edm_name( 'DocumentItemText' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'DOCUMENT_ITEM_TEXT' ).

    lo_parameter = lo_action->create_parameter( 'LEDGER' ).
    lo_parameter->set_edm_name( '_Ledger' ) ##NO_TEXT.
    lo_parameter->set_complex_type( 'D_FXD_AST_POST_RETIREMENT' ).
    lo_parameter->set_is_collection( ).

    lo_return = lo_action->create_return( ).
    lo_return->set_entity_type( 'FIXED_ASSET_RETIREMENT_TYP' ).

  ENDMETHOD.


  METHOD def_sap_message.

    DATA:
      lo_complex_property    TYPE REF TO /iwbep/if_v4_pm_cplx_prop,
      lo_complex_type        TYPE REF TO /iwbep/if_v4_pm_cplx_type,
      lo_navigation_property TYPE REF TO /iwbep/if_v4_pm_nav_prop,
      lo_primitive_property  TYPE REF TO /iwbep/if_v4_pm_prim_prop.


    lo_complex_type = mo_model->create_complex_type_by_struct(
                                    iv_complex_type_name      = 'SAP_MESSAGE'
                                    is_structure              = VALUE tys_sap_message( )
                                    iv_do_gen_prim_props         = abap_true
                                    iv_do_gen_prim_prop_colls    = abap_true
                                    iv_do_add_conv_to_prim_props = abap_true ).

    lo_complex_type->set_edm_name( 'SAP__Message' ) ##NO_TEXT.
    lo_complex_type->create_complex_prop_for_vcs( 'VALUE_CONTROLS' ).


    lo_primitive_property = lo_complex_type->get_primitive_property( 'CODE' ).
    lo_primitive_property->set_edm_name( 'code' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.

    lo_primitive_property = lo_complex_type->get_primitive_property( 'MESSAGE' ).
    lo_primitive_property->set_edm_name( 'message' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.

    lo_primitive_property = lo_complex_type->get_primitive_property( 'TARGET' ).
    lo_primitive_property->set_edm_name( 'target' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).
    lo_primitive_property->create_vcs_value_control( ).

    lo_primitive_property = lo_complex_type->get_primitive_property( 'ADDITIONAL_TARGETS' ).
    lo_primitive_property->set_edm_name( 'additionalTargets' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_is_collection( ).

    lo_primitive_property = lo_complex_type->get_primitive_property( 'TRANSITION' ).
    lo_primitive_property->set_edm_name( 'transition' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Boolean' ) ##NO_TEXT.

    lo_primitive_property = lo_complex_type->get_primitive_property( 'NUMERIC_SEVERITY' ).
    lo_primitive_property->set_edm_name( 'numericSeverity' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Byte' ) ##NO_TEXT.

    lo_primitive_property = lo_complex_type->get_primitive_property( 'LONGTEXT_URL' ).
    lo_primitive_property->set_edm_name( 'longtextUrl' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).
    lo_primitive_property->create_vcs_value_control( ).

  ENDMETHOD.
ENDCLASS.
