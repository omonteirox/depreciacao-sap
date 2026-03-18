@EndUserText.label: 'Parâmetros de Execução de Baixa de Imobilizado'
define abstract entity ZA_RetirementParam
{
  @EndUserText.label: 'Data do Documento'
  DocumentDate   : abap.dats;

  @EndUserText.label: 'Data de Lançamento'
  PostingDate    : abap.dats;

  @EndUserText.label: 'Data de Avaliação do Ativo'
  AssetValueDate : abap.dats;
}
