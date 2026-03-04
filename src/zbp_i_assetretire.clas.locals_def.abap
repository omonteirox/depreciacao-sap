"! Local handler definition
CLASS lhc_assetretire DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR AssetRetire
      RESULT result.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR AssetRetire
      RESULT result.

    METHODS setDefaults FOR DETERMINE ON MODIFY
      IMPORTING keys FOR AssetRetire~setDefaults.

    METHODS validateAsset FOR VALIDATE ON SAVE
      IMPORTING keys FOR AssetRetire~validateAsset.

    METHODS importAssets FOR MODIFY
      IMPORTING keys FOR ACTION AssetRetire~importAssets
      RESULT result.

    METHODS executeRetirement FOR MODIFY
      IMPORTING keys FOR ACTION AssetRetire~executeRetirement
      RESULT result.

ENDCLASS.

"! Local saver definition
CLASS lsc_assetretire DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.
    METHODS save_modified REDEFINITION.
ENDCLASS.
