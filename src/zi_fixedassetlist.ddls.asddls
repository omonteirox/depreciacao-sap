@AbapCatalog.viewEnhancementCategory: [ #NONE ]

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Lista de Ativos Imobilizados (SAP Base)'

@Metadata.ignorePropagatedAnnotations: true

define view entity ZI_FixedAssetList
  as select from I_FixedAsset

{
  key CompanyCode,
  key MasterFixedAsset,
  key FixedAsset,

      AssetClass,
      FixedAssetDescription,
      AssetLifecycleStatus,
      AssetCapitalizationDate,
      CreationDate
}

where AssetLifecycleStatus = '3'
   or AssetLifecycleStatus = '4'
