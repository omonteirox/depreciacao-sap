@AbapCatalog.viewEnhancementCategory: [#NONE]
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
      AssetCapitalizationDate
}
where
      AssetLifecycleStatus <> '5'
  and AssetLifecycleStatus <> '2'
  and AssetCapitalizationDate > '00000000'
