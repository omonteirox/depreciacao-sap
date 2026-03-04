@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Baixa de Ativo Imobilizado'
define root view entity ZI_AssetRetire
  as select from zasset_retire
{
  key retire_uuid            as RetireUuid,
      company_code           as CompanyCode,
      master_fixed_asset     as MasterFixedAsset,
      fixed_asset            as FixedAsset,
      asset_description      as AssetDescription,
      asset_class            as AssetClass,
      document_date          as DocumentDate,
      posting_date           as PostingDate,
      asset_value_date       as AssetValueDate,
      retirement_type        as RetirementType,
      retirement_ratio       as RetirementRatio,
      header_text            as HeaderText,
      item_text              as ItemText,
      process_status         as ProcessStatus,
      process_msg            as ProcessMsg,
      ref_doc_number         as RefDocNumber,

      cast( case process_status
        when 'S' then 3
        when 'E' then 1
        when 'P' then 2
        else 0
      end as abap.int4 )       as StatusCriticality,

      @Semantics.user.createdBy: true
      created_by             as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at             as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by        as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at        as LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed     as LocalLastChanged
}
