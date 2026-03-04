@EndUserText.label: 'Parâmetros de Importação de Ativos'
define abstract entity ZA_ImportParam
{
  @Consumption.valueHelpDefinition: [{ entity: { name: 'I_CompanyCode', element: 'CompanyCode' } }]
  CompanyCode : bukrs;
}
