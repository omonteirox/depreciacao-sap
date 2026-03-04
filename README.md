# Baixa em Massa de Ativos Imobilizados

Aplicação RAP (ABAP Cloud) para baixa em massa de ativos imobilizados utilizando a API `CE_FIXEDASSETRETIREMENT_0001`.

## Pré-requisitos

- SAP S/4HANA Cloud (Public Edition) 2602+
- ADT (ABAP Development Tools) com abapGit
- Communication Scenario `SAP_COM_0563` ou `SAP_COM_0A95`

## Como Importar

1. **Clone** este repositório no ADT via abapGit
2. **Crie o pacote** `ZASSET_RETIREMENT` no seu sistema (ou use outro nome e ajuste)
3. **Importe** os objetos pelo abapGit pull
4. **Ative** os objetos na seguinte ordem:
   - Tabelas: `ZASSET_RETIRE`, `ZASSET_RETIRE_D`
   - CDS: `ZI_FixedAssetList` → `ZI_AssetRetire` → `ZA_ImportParam` → `ZC_AssetRetire`
   - BDEF: `ZI_AssetRetire` → `ZC_AssetRetire`
   - Classe: `ZBP_I_AssetRetire`
   - MDE: `ZC_AssetRetire`
   - Service Def: `ZASSET_RETIREMENT_SD`
5. **Crie o Service Binding** manualmente no ADT:
   - Nome: `ZASSET_RETIREMENT_SB`
   - Tipo: `OData V4 - UI`
   - Service Definition: `ZASSET_RETIREMENT_SD`
   - Publique o binding

## Configuração da Comunicação

### Service Consumption Model (SRVC)

1. No ADT, crie um **Service Consumption Model**:
   - Nome: `ZSC_ASSET_RETIREMENT`
   - Tipo: OData V4
   - Importe o arquivo `CE_FIXEDASSETRETIREMENT_0001.json` que está na raiz do projeto
2. Os abstract entities gerados servem como referência de tipos

### Communication Arrangement

1. Acesse o app Fiori: **Communication Arrangements**
2. Crie um arrangement para o cenário `SAP_COM_0563`
3. Configure o **Communication System** apontando para o próprio sistema (loopback)
4. **Outbound Service**: Configure o serviço `API_FIXEDASSETRETIREMENT`
5. Anote o `service_id` configurado e ajuste na classe `ZBP_I_AssetRetire` (constante `ZASSET_RETIRE_REST`)

## Como Usar

1. Acesse o app pela **preview** do Service Binding
2. Clique em **"Importar Ativos"** → informe a empresa (ex: `JA01`)
3. O sistema carrega todos os ativos ativos da base SAP (via `I_FixedAsset`)
4. **Selecione** os ativos que deseja baixar
5. Clique em **"Executar Baixa"**
6. Acompanhe o **Status** de cada ativo:
   - 🟢 `S` = Sucesso (com nº do documento contábil)
   - 🔴 `E` = Erro (com mensagem detalhada)
   - 🟡 `P` = Processando

## Estrutura do Projeto

```
src/
├── zasset_retire.tabl.xml        # Tabela de staging
├── zasset_retire_d.tabl.xml      # Tabela draft
├── zi_fixedassetlist.ddls.*      # CDS Helper (I_FixedAsset)
├── zi_assetretire.ddls.*         # CDS Interface View
├── zc_assetretire.ddls.*         # CDS Consumption View
├── za_importparam.ddls.*         # Abstract Entity (parâmetros)
├── zi_assetretire.bdef.*         # Behavior Definition (interface)
├── zc_assetretire.bdef.*         # Behavior Definition (projection)
├── zbp_i_assetretire.clas.*      # Behavior Pool (lógica)
├── zc_assetretire.ddlx.*         # Metadata Extension (Fiori UI)
└── zasset_retirement_sd.srvd.*   # Service Definition
```

## API Utilizada

**CE_FIXEDASSETRETIREMENT_0001** — Fixed Asset Post Asset Retirement
- Tipo: OData V4
- Ação: `POST /FixedAssetRetirement/SAP__self.Post`
- Communication Scenarios: `SAP_COM_0563`, `SAP_COM_0A95`
