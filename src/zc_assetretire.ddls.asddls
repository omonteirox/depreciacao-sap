@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Baixa de Ativo Imobilizado'
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: ['CompanyCode', 'MasterFixedAsset', 'FixedAsset']
define root view entity ZC_AssetRetire
  provider contract transactional_query
  as projection on ZI_AssetRetire
{
  key RetireUuid,
      CompanyCode,
      MasterFixedAsset,
      FixedAsset,
      AssetDescription,
      AssetClass,
      AcquisitionDate,
      DocumentDate,
      PostingDate,
      AssetValueDate,
      RetirementType,
      RetirementRatio,
      HeaderText,
      ItemText,
      ProcessStatus,
      ProcessMsg,
      RefDocNumber,
      StatusCriticality,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      LocalLastChanged
}
