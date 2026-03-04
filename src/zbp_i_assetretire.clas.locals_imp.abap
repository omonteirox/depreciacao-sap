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

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD executeretirement.
  ENDMETHOD.

  METHOD importassets.
  ENDMETHOD.

  METHOD setdefaults.
  ENDMETHOD.

  METHOD validateasset.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_zi_assetretire DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_zi_assetretire IMPLEMENTATION.

  METHOD save_modified.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
