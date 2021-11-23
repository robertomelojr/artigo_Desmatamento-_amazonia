clear all

cd "C:\Users\Benevita1\Documents\Acadêmico\1 - Mestrado\Microeconometria Aplicada\Artigo\0 - Base final"

use "base_final_em_teste1.dta"  // 	É a base que a Carol fez ontem 15:31 02/06/21

drop if ano<2002

** LABEL VAR	=> IMPORTANTE RODAR ANTES!  Possui alguns comandos RENAME em varáveis (diferente de label)
// Clique no + para minimizar!
{
g area_km22 = area_km2
drop area_km2
rename area_km22 area_km2
label var area_km2 "area do município em km2”
label var desmatado "area do município acumulada em km2”
rename incremento_x_1_x incremento_desmatado
label var ano "Ano"
label var incremento_desmatado "incremento anual bruto da área desmatada em km2”
label var floresta "area de floresta do município em km2”
label var nuvem "área estimada de nuvem que estava sobre a terra, no período em km2”
label var nao_observado "area não observada do município em km2”
label var nao_floresta "area de não floresta do município em km2”
label var hidrografia "area hidrográfica do município em km2”
label var superficie_total "superfície (area) total de terras indígenas no municipio em hectares”
label var superficie_total_km2 "superfície (area) total de terras indígenas no municipio em km2”
label var _area_plantada_arroz "% de area plantada de arroz sobre a area total do município”
label var _area_plantada_cana_acucar "% de area plantada de cana sobre a area total do município”
label var _area_plantada_mandioca "% de area plantada de mandioca sobre a area total do município”
label var _area_plantada_milho "% de area plantada de milho sobre a area total do município”
label var _area_plantada_soja "% de area plantada de soja sobre a area total do município”
label var preco_real_anual_medio_arroz  "preco real anual médio arroz por tonelada”
label var indice_precos_real_arroz_2000  "índice precos real arroz a preços constantes de 2000”
label var preco_real_anual_medio_milho  "preco real anual médio milho por tonelada”
label var indice_precos_real_milho_2000  "índice precos real milho a preços constantes de 2000”
label var preco_real_anual_medio_soja  "preco real anual médio soja por tonelada”
label var indice_precos_real_soja_2000  "índice precos real soja a preços constantes de 2000”
label var preco_real_anual_medio_cana  "preco real anual médio cana por tonelada”
label var indice_precos_real_cana_2000  "índice precos real cana a preços constantes de 2000”
rename preco_real_anual_medio_madioca preco_real_anual_medio_mandioca  // pois é
label var preco_real_anual_medio_mandioca  "preco real anual médio mandioca por tonelada”
label var indice_precos_real_mandioca_2000  "índice precos real mandioca a preços constantes de 2000”
label var preco_real_anual_medio_boi  "preco real anual boi arroz por tonelada”
label var indice_precos_real_boi_2000  "índice precos real boi a preços constantes de 2000”
label var preco_real_ponderado_arroz "preco real ponderado do arroz no município i ano t”
label var preco_real_ponderado_milho "preco real ponderado do milho no município i ano t”
label var preco_real_ponderado_mandioca "preco real ponderado da mandioca no município i ano t”
label var preco_real_ponderado_cana "preco real ponderado da cana no município i ano t”
label var preco_real_ponderado_soja "preco real ponderado da soja no município i ano t”
label var area_plantada_total_lav_temporar "area plantada total de lavouras temporárias em km2”
label var area_plantada_total_lav_permanen "area plantada total de lavouras permanentes em km2”
label var perc_lav_temp "% de lavouras temporárias em relação a area total do município em km2”
label var perc_lav_perm "% de lavouras permanentes em relação a area total do município em km2”
label var area_total_rl_e_pp_privada "area total de prot permanente e reserva legal em prop privadas do município”
label var area_total_impropria_prod_agrico "area total de prot permanente e reserva legal em prop privadas do município”
label var n_cst_ag "No. contratos custeio agro"
label var v_cst_ag "Valor contratos custeio agro"
label var n_inv_ag "No. contratos investimento agro"
label var v_inv_ag "Valor contratos investimento agro"
label var n_com_ag "No. contratos comercio agro"
label var v_com_ag "Valor contratos comercio agro"
label var n_tot_ag "No. contratos total agro"
label var v_tot_ag "Valor contratos total agro"
label var n_cst_pe "No. contratos custeio pecuaria"
label var v_cst_pe "Valor contratos custeio pecuaria"
label var n_inv_pe "No. contratos investimento pecuaria"
label var v_inv_pe "Valor contratos investimento pecuaria"
label var n_com_pe "No. contratos comercio pecuaria"
label var v_com_pe "Valor contratos comercio pecuaria"
label var n_tot_pe "No. contratos total pecuaria"
label var v_tot_pe "Valor contratos total pecuaria
drop testex
drop peso_superficie_km2 
rename area_plantada_total_lav_temporar area_lav_temporaria
rename area_plantada_total_lav_permanen area_lav_permanente
drop ti_forte
drop ti_forte0
drop _merge
}
*______________		GERANDO VARIÁVEIS DE TRATAMENTO	E CONTROLE	_______________*

{


*** Variável Tratado - Sem Terra Indigena 
{
* Identificando TI durante todos períodos no município
g d_terra_ind1 = 1 if superficie_total_km2>0
recode d_terra_ind .=0
by codigo_ibge: egen d_terra_ind2 = mean(d_terra_ind)
label var  d_terra_ind2 "Identifica se o município já teve TI em algum período"

* Gerando variável de tratamento Município sem Território Indígena (TI)
g municipio_nao_ti= 1 if d_terra_ind2==0
replace municipio_nao_ti=0 if d_terra_ind2==1 //	Identifica grupo tratado (sem TI)
label var  municipio_nao_ti "Dummy município sem TI durante todo periodo"
}


//

*** Variáveis de municípios com território indígena    //   POSSÍVEIS CONTROLES
** Verificar "tab proporcao_ti if proporcao_ti>0" e checar os quantis (%) a definir

*** Gerando "Proporção da superficie km2 da TI em relação a area do municipio"
gen proporcao_ti = (superficie_total_km2/area_km2)
label var proporcao_ti "Peso da superficie km2 da TI em relação a area do municipio"

** Gerando proporção TI * 1000
g proporcao_ti2 = proporcao_ti*1000


//

*** Variáveis dos grupos tratados com variável proporcao_ti como referência

{
gen municipio_ti = 0
replace municipio_ti = 1 if proporcao_ti > 0 
label var municipio_ti "Municipio com TI"

*** Variável de tratamento 2
gen municipio_ti_10 = 0
replace municipio_ti_10 = 1 if proporcao_ti >=  0.0246829 
label var municipio_ti_10 "Municipio c/ TI com sup_km2 acima de 10,00% da freq" // f(x) > 10,00%

*** Variável de tratamento 3
gen municipio_ti_20 = 0
replace municipio_ti_20 = 1 if proporcao_ti >=   0.0863928
label var municipio_ti_20 "Municipio c/ TI com sup_km2 acima de 20% da freq" // f(x) > 20,00%


*** Variável de tratamento 4
gen municipio_ti_30 = 0
replace municipio_ti_30 = 1 if proporcao_ti >=   0.1152866
label var municipio_ti_30 "Municipio c/ TI com sup_km2 acima de 30% da freq" // f(x) > 30,00%

*** Variável de tratamento 5
gen municipio_ti_40 = 0
replace municipio_ti_40 = 1 if proporcao_ti >=   0.1829268
label var municipio_ti_40 "Municipio c/ TI com sup_km2 acima de 40% da freq" // f(x) > 40,00%

*** Variável de tratamento 6
gen municipio_ti_50 = 0
replace municipio_ti_50 = 1 if proporcao_ti >= 0.239841
label var municipio_ti_50 "Municipio c/ TI com sup_km2 acima de 66,66% da freq" // f(x) > 50,00%
}



//

*** Dummies municipio capital
{
**Dummy capital

g municipio_capital =0
replace municipio_capital = 1 if codigo_ibge == 1200401 // Rio Branco - AC
replace municipio_capital = 1 if codigo_ibge == 1302603	// Manaus - AM
replace municipio_capital = 1 if codigo_ibge == 1600303	// Macapa - AP
replace municipio_capital = 1 if codigo_ibge == 5103403 // Cuiaba - MT
replace municipio_capital = 1 if codigo_ibge == 1501402 // Belem - PA
replace municipio_capital = 1 if codigo_ibge == 1100205 // Porto Velho - RO
replace municipio_capital = 1 if codigo_ibge == 1400100 // Boa Vista - RR
replace municipio_capital = 1 if codigo_ibge == 2111300 // Sao Luis - MA
replace municipio_capital = 1 if codigo_ibge == 1721000 // Palmas - TO
label var municipio_capital "Município capital de estado"
** Dummy não capital
g nao_capital = 0
replace nao_capital = 1 if municipio_capital==0
}

//

*** Outras interações
g n_metro_cti = nao_metropolitano*municipio_ti
recode n_metro_cti .=0

g n_metro_sti = nao_metropolitano*municipio_nao_ti
recode n_metro_sti .=0

g metro_cti = metropolitano*municipio_ti
recode metro_cti .=0

g metro_sti = metropolitano*municipio_nao_ti
recode metro_sti .=0

}


//

*______________		GERANDO VARIÁVEIS DE AUXÍLIO ANÁLISE		_______________*
{
//
** Gerando Densidade Demográfica

g densidade_demografica = pop/area_km2
label var densidade_demografica "Densidade Demográfica"

*** Gerando variáveis dos períodos dos tratamentos
{
** 2004	=> 2003+
g ano04=1 if ano>2003
recode ano04 .=0 //	é necessário gerar os 0s para identificar o efeito do ano!
label var ano04 "Dummy período de tratamento Lei 2004"

** 2008 => 2007+
g ano08=1 if ano>2007
recode ano08 .=0 //	é necessário gerar os 0s para identificar o efeito do ano!
label var ano08 "Dummy período de tratamento Lei 2008"
}

*** Gerando variáveis de dos períodos PLACEBO
{
** Placebo 2004	=> 2002+
g ano03=1 if ano>2002
recode ano03 .=0 //	é necessário gerar os 0s para identificar o efeito do ano!
label var ano03 "Dummy PLACEBO período de tratamento Lei 2004"

** Placebo 2008 => 2006+
g ano07=1 if ano>2006
recode ano07 .=0 //	é necessário gerar os 0s para identificar o efeito do ano!
label var ano07 "Dummy PLACEBO período de tratamento Lei 2008"
}

** Gerando variável de crédito total
{
g v_credito_total = v_tot_ag + v_tot_pe
label var v_credito_total "Valor total de crédito rural no município"

g n_credito_total = n_tot_ag + n_tot_pe
label var n_credito_total "Número total de contratos de crédito rural no município"
}


** Gerando variável de distância do ano em relação ao ano do tratamento => Event Study
{
** Default: Tratado: Não Metropole / Controle: Metropole
{
*Para 2004 
gen anotrat4 = 2004

gen timeToTreat4 = ano - anotrat4
replace timeToTreat4 = 0 if metropolitano==1

* Para 2008
gen anotrat8 = 2008

gen timeToTreat8 = ano - anotrat8
replace timeToTreat8 = 0 if metropolitano==1
}

//

*** Não Capital: Tratado: Não Capital / Controle: Capital
{
*Para 2004
gen timeToTreat4_c = ano - anotrat4
replace timeToTreat4_c = 0 if municipio_capital==1

* Para 2008
gen timeToTreat8_c = ano - anotrat8
replace timeToTreat8_c = 0 if municipio_capital==1
}

//

*** Município com território indígena: Tratado: Mun. c TI / Controle: Mun. s TI
*Para 2004
gen timeToTreat4_ti = ano - anotrat4
replace timeToTreat4_ti = 0 if municipio_nao_ti==1

* Para 2008
gen timeToTreat8_ti = ano - anotrat8
replace timeToTreat8_ti = 0 if municipio_nao_ti==1

}

//

** Gerando variável de tendências
g trend = ano - 2001

** gerando Tendência nos tratados Nao_Metropolitano
g trend_nao_metropolitano = trend*nao_metropolitano

** gerando Tendência nos tratados Nao_Capital
g trend_nao_capital = trend*nao_capital

** gerando Tendência nos tratados Município com Território Indígena
g trend_municipio_ti = trend*municipio_ti


** Estabelecendo xtset para rodar outras análises (xtreg, bacondecomp, etc)
xtset codigo_ibge ano

//
}





*______________			GERANDO VARIÁVEIS DE RESULTADO			_______________*

{



** Gerando variável Log desmatado
g desmatado_log=log(desmatado)
recode desmatado_log .=0

** Gerando variável Log incremento_desmatado
g incremento_desmatado_log=log(incremento_desmatado)
recode incremento_desmatado_log .=0

** Gerar variável desmatamento proporcional
g desmatado_prop = (desmatado/area_km2)
label var desmatado_prop "Desmatamento proporcional a area km2"

*** Gerando variável Log desmatado_prop
g desmatado_prop_log=log(desmatado_prop)
recode desmatado_prop_log .=0



*** Gerando o índice de desmatamento		=> CRIEI PARA 3 ANOS BASE: 2000, 2001 e 2002
{
* Ano Base 2000
gen dummy_2000_1 = 0
replace dummy_2000_1 = 1 if ano==2000

gen valor_2000 = dummy_2000_1*desmatado

by codigo_ibge: egen desmatado_2000 = max(valor_2000)

g indice_desmatado00 = 100 * (desmatado/desmatado_2000)
label var indice_desmatado00 "Índice desmatamento Ano Base 2000"

** Tratando indices espúrios para Ano base 2000 // 	OPCIONAL!!!!!!! 
{
* mean indice_desmatado00 if ano==2000 // Checar antes
* mean indice_desmatado00 if ano==2001 // Comparar média do ano 2001 com 2000

*drop if indice_desmatado00 > 200 & ano==2001

*_ identificando o município com erro
*by codigo_ibge: egen erro_ano2 = sum(ano)

* dropando municípios sem observações em todos os anos => codigo_ibge==4314530
*drop if erro_ano2 !=22055
}

* Ano Base 2001
gen dummy_2001_1 = 0
replace dummy_2001_1 = 1 if ano==2001
gen valor_2001 = dummy_2001_1*desmatado
by codigo_ibge: egen desmatado_2001 = max(valor_2001)

g indice_desmatado01 = 100 * (desmatado/desmatado_2001)
label var indice_desmatado01 "Índice desmatamento Ano Base 2002"


* Ano Base 2002
gen dummy_2002_1 = 0
replace dummy_2002_1 = 1 if ano==2002 // Dummy que reconhece ano 2002
gen valor_2002 = dummy_2002_1*desmatado // Valor desmatado em 2002
by codigo_ibge: egen desmatado_2002 = max(valor_2002) // Variável desmatado ano base (2002)

g indice_desmatado02 = 100 * (desmatado/desmatado_2002)
label var indice_desmatado02 "Índice desmatamento Ano Base 2002"
//
}



*** Gerando variáveis Log indice desmatado para cada ano base
{
** Gerando variável Log indice desmatado
g indice_desmatado00_log=log(indice_desmatado00)
recode indice_desmatado00_log .=0
label var indice_desmatado00_log "Log do Indice de Desmatamento Ano Base 2000"

*** Gerando variável Log indice desmatado
g indice_desmatado01_log=log(indice_desmatado01)
recode indice_desmatado01_log .=0
label var indice_desmatado01_log "Log do Indice de Desmatamento Ano Base 2001"

*** Gerando variável Log indice desmatado
g indice_desmatado02_log=log(indice_desmatado02)
recode indice_desmatado02_log .=0
label var indice_desmatado02_log "Log do Indice de Desmatamento Ano Base 2002"
}

//
}




*______________		GERANDO VARIÁVEIS DE EFEITO DO TRATAMENTO	_______________*

{

** Variável de efeito OFICIAL => Treat: Não Metropolitano sem TI / Control: Metropolitano
{
*** variáveis diff-in-diff para 2004
* Diff effect 2004 
g diff_efeito04 = nao_metropolitano*ano04
label var diff_efeito04 "Efeito do tratamento Lei 2004"


*** variáveis diff-in-diff para 2008
* Diff effect 2008
g diff_efeito08 = nao_metropolitano*ano08
label var diff_efeito08 "Efeito do tratamento Lei 2008"


//
}

//


**** Gerando OUTROS efeitos para os tratamentos

** Efeito tratado/controle: 	_ Não Capital / Capital _
{
*** variáveis diff-in-diff para 2004
g diff_efeito04_c = nao_capital*ano04
label var diff_efeito04_c "Efeito do tratamento Não Capital sem 2004"

*** variáveis diff-in-diff para 2008
** Tratamentos para 2008
g diff_efeito08_c = nao_capital*ano08
label var diff_efeito08_c "Efeito do tratamento Não Capital sem 2008"
//
}


** Efeito tratado/controle: 	_ Não Capital SEM TI / Capital _
{
*** variáveis diff-in-diff para 2004
g diff_efeito04_ncs = nao_capital*ano04
label var diff_efeito04_ncs "Efeito do tratamento Não Capital sem 2004"

*** variáveis diff-in-diff para 2008
** Tratamentos para 2008
g diff_efeito08_ncs = nao_capital*ano08
label var diff_efeito08_ncs "Efeito do tratamento Não Capital sem 2008"
//
}


** Efeito tratado/controle: 	_ Não Capital COM TI / Capital _
{
*** variáveis diff-in-diff para 2004
g diff_efeito04_ncc = nao_capital*ano04
label var diff_efeito04_ncc "Efeito do tratamento Não Capital com TI 2004"

*** variáveis diff-in-diff para 2008
** Tratamentos para 2008
g diff_efeito08_ncc = nao_capital*ano08
label var diff_efeito08_ncc "Efeito do tratamento Não Capital com TI 2008"
//
}


** Efeito tratado/controle: 	_ Não Metropolitano SEM TI / Metropolitano _
{
*** variáveis diff-in-diff para 2004
g diff_efeito04_nms = nao_metropolitano*ano04
label var diff_efeito04_nms "Efeito do tratamento Não Metropolitano SEM TI 2004"

*** variáveis diff-in-diff para 2008
** Tratamentos para 2008
g diff_efeito08_nms = nao_metropolitano*ano08
label var diff_efeito08_nms "Efeito do tratamento Não Metropolitano SEM TI  2008"
//
}


** Efeito tratado/controle: 	_ Municipio COM TI / Municipio SEM TI _
{
*** variáveis diff-in-diff para 2004
g diff_efeito04_ti = municipio_ti*ano04
label var diff_efeito04_ti "Efeito do tratamento Município com TI 2004"

g diff_efeito04_nti = municipio_nao_ti*ano04
label var diff_efeito04_nti "Efeito do tratamento Município com TI 2004"
*** variáveis diff-in-diff para 2008
** Tratamentos para 2008
g diff_efeito08_ti = municipio_ti*ano08
label var diff_efeito08_ti "Efeito do tratamento Município com TI 2008"

g diff_efeito08_nti = municipio_nao_ti*ano08
label var diff_efeito08_nti "Efeito do tratamento Município com TI 2004"
//
}

*** variáveis diff-in-diff para 2004
g diff_efeito04_ti_10 = municipio_ti_10*ano04
label var diff_efeito04_ti_10 "Efeito Lei 2004 Município com TI acima do quantil 10%"

g diff_efeito04_ti_20 = municipio_ti_20*ano04
label var diff_efeito04_ti_20 "Efeito Lei 2004 Município com TI acima do quantil 20%"

g diff_efeito04_ti_30 = municipio_ti_30*ano04
label var diff_efeito04_ti_30 "Efeito Lei 2004 Município com TI acima do quantil 30%"

g diff_efeito04_ti_40 = municipio_ti_40*ano04
label var diff_efeito04_ti_40 "Efeito Lei 2004 Município com TI acima do quantil 40%"

g diff_efeito04_ti_50 = municipio_ti_50*ano04
label var diff_efeito04_ti_50 "Efeito Lei 2004 Município com TI acima do quantil 50%"

//


***				PLACEBO

* Diff effect 2004 PLACEBO
g diff_efeito03 = nao_metropolitano*ano03
label var diff_efeito03 "Placebo Ano Lei 2004"

* Diff effect 2008 PLACEBO
g diff_efeito07 = nao_metropolitano*ano07
label var diff_efeito07 "Placebo Ano Lei 2008"


** Efeito tratado/controle: 	_ Não Metropolitano SEM TI / Metropolitano _
{
*** variáveis diff-in-diff para 2003
g diff_efeito03_nms = nao_metropolitano*ano03
label var diff_efeito03_nms "Efeito do tratamento Não Metropolitano SEM TI 2003"

*** variáveis diff-in-diff para 2007
** Tratamentos para 2007
g diff_efeito07_nms = nao_metropolitano*ano07
label var diff_efeito07_nms "Efeito do tratamento Não Metropolitano SEM TI  2007"
//
}


** Efeito tratado/controle: 	_ Municipio COM TI / Municipio SEM TI _
{
*** variáveis diff-in-diff para 2003
g diff_efeito03_ti = municipio_ti*ano03
label var diff_efeito03_ti "Efeito do tratamento Município com TI 2003"

*** variáveis diff-in-diff para 2007
** Tratamentos para 2007
g diff_efeito07_ti = municipio_ti*ano07
label var diff_efeito07_ti "Efeito do tratamento Município com TI 2007"

//
}

g nao_metropolitano_cti = 0
replace nao_metropolitano_cti = 1 if nao_metropolitano==1 & municipio_ti==1
label var nao_metropolitano_cti "Município Não Metropolitano com TI"

g nao_metropolitano_sti = 0
replace nao_metropolitano_sti = 1 if nao_metropolitano==1 & municipio_ti==0
label var nao_metropolitano_sti "Município Não Metropolitano sem TI"

}


//


**** PLACEBO: CRIANDO VARIÁVEL DE TRATAMENTO ALEATÓRIA

*** Gerando Variável Aleatória GRUPO TRATADO => Município Região Não-Metropolitana
{
*Checando média
sum nao_metropolitano

set seed 100000 // Define a semente => Permite a replicação da análise => V. ALEATÓRIA

*- gerar VA
sort codigo_ibge
by codigo_ibge: g newaleat_nm = runiform() if ano==2002

g tratplacebo_nm1 = 0
recode tratplacebo_nm1 0=1 if newaleat_nm <=0.9432918 // valor verificado no comando sum

*- identificando a média e d.p. da variavel
sum tratplacebo_nm1 // Estatísticas próximas => Está certo!

by codigo_ibge: egen tratplacebo_nm2 = mean(tratplacebo_nm1)
g tratplacebo_nm = 0
recode tratplacebo_nm 0=1 if tratplacebo_nm2 > 0
}

*** Gerando variáveis de interação entre placebo e tratamento (ano)
{
** Variáveis diff-in-diff para 2004
* Efeito para os tratamanetos para 2004
g placebo_efeito04_nm = tratplacebo_nm*ano04
label var placebo_efeito04_nm "Efeito do placebo do tratamento Município Não-Metropolitano 2004"

** Variáveis diff-in-diff para 2008
* Efeito para os tratamanetos para 2008
g placebo_efeito08_nm = tratplacebo_nm*ano08
label var placebo_efeito08_nm "Efeito do placebo do tratamento Município Não-Metropolitano 2008"
}

//

** Gerando Variável Aleatória GRUPO TRATADO => Município com TI
{
*Checando média
sum municipio_ti	

set seed 100000 // Define a semente => Permite a replicação da análise => V. ALEATÓRIA

*- gerar VA
sort codigo_ibge
by codigo_ibge: g newaleat_ti = runiform() if ano==2002

g tratplacebo_ti1 = 0
recode tratplacebo_ti1 0=1 if newaleat_ti <=0.2987552 // valor verificado no comando sum

*- identificando a média e d.p. da variavel
*Checando média
sum municipio_ti
sum tratplacebo_ti 
// Estatísticas próximas => Está certo!


by codigo_ibge: egen tratplacebo_ti2 = mean(tratplacebo_ti1)
g tratplacebo_ti = 0
recode tratplacebo_ti 0=1 if tratplacebo_ti2 > 0
}

*** Gerando variáveis de interação entre placebo e tratamento (ano)
{
** Variáveis diff-in-diff para 2004
* Efeito para os tratamanetos para 2004
g placebo_efeito04_ti = tratplacebo_ti*ano04
label var placebo_efeito04_ti "Efeito do placebo do tratamento Município com TI 2004"

** Variáveis diff-in-diff para 2008
* Efeito para os tratamanetos para 2008
g placebo_efeito08_ti = tratplacebo_ti*ano08
label var placebo_efeito08_ti "Efeito do placebo do tratamento Município com TI 2008"
}

* Interação entre Placebo Mun. Não Metropolitano e Placebo Mun. com TI
g placebo_nao_metro_ti = tratplacebo_nm*tratplacebo_ti

//

**** GERANDO VARIÁVEL DE RESULTADO: INCREMENTO DESMATAMENTO NORMALIZADO

*** Normalizando a distribuição 

** 2002~2010

by codigo_ibge: egen test_min = min(incremento_desmatado)
by codigo_ibge: egen test_max = max(incremento_desmatado)
g test_normal = (incremento_desmatado - test_min)/(test_max - test_min)

** 2004

by codigo_ibge: egen test_min04 = min(incremento_desmatado)  if ano>=2002 & ano<2008
by codigo_ibge: egen test_max04 = max(incremento_desmatado) if ano>=2002 & ano<2008
g test_normal04 = (incremento_desmatado - test_min04)/(test_max04 - test_min04) if ano>=2002 & ano<2008

** 2008

by codigo_ibge: egen test_min08 = min(incremento_desmatado) if ano>=2005
by codigo_ibge: egen test_max08 = max(incremento_desmatado) if ano>=2005
g test_normal08 = (incremento_desmatado - test_min08)/(test_max08 - test_min08) if ano>=2005



*** Geral -> 2002 a 2010
{
** Gerando média desmatamento 2002~2010
egen mean_increm=mean(incremento_desmatado), by(codigo_ibge)
egen mean_increm_max=max(mean_increm), by(codigo_ibge)
drop mean_increm
rename mean_increm_max mean_increm

** Gerando SD desmatamento 2002~2010
egen sd_increm=sd(incremento_desmatado), by(codigo_ibge)
egen sd_increm_max=max(sd_increm), by(codigo_ibge)
drop sd_increm
rename sd_increm_max sd_increm

** GERANDO INCREMENTO DESMATAMENTO NORMALIZADO
gen incremento_desmatado_norm = (incremento_desmatado - mean_increm)/  sd_increm
label var incremento_desmatado_norm "Incremento de desmatamento t-1 a t normalizado"
}

*** Lei 2004
{
** Gerando média desmatamento 2002~2007
egen mean_increm04=mean(incremento_desmatado) if ano>=2002 & ano<2008, by(codigo_ibge)
egen mean_increm_max04=max(mean_increm04), by(codigo_ibge)
drop mean_increm04
rename mean_increm_max04 mean_increm04

** Gerando SD desmatamento 2002~2007
egen sd_increm04=sd(incremento_desmatado) if ano>=2002 & ano<2008, by(codigo_ibge)


** GERANDO INCREMENTO DESMATAMENTO NORMALIZADO 2002~2007
gen incremento_desmatado_norm04 = (incremento_desmatado - mean_increm04)/  sd_increm04
label var incremento_desmatado_norm04 "Incremento de desmatamento t-1 a t normalizado Lei 2004"

gen incremento_desmatado_padro04 = incremento_desmatado - mean_increm04
label var incremento_desmatado_norm04 "Incremento de desmatamento t-1 a t padronizado Lei 2004"
}

*** Lei 2008
{
** Gerando média desmatamento 2005~2010
egen mean_increm08=mean(incremento_desmatado) if ano>=2005, by(codigo_ibge)
egen mean_increm_max08=max(mean_increm08), by(codigo_ibge)
drop mean_increm08
rename mean_increm_max08 mean_increm08

** Gerando SD desmatamento 2005~2010
egen sd_increm08=sd(incremento_desmatado) if ano>=2005, by(codigo_ibge)
egen sd_increm_max08=max(sd_increm08), by(codigo_ibge)
drop sd_increm08
rename sd_increm_max08 sd_increm08

** GERANDO INCREMENTO DESMATAMENTO NORMALIZADO 2005~2010
gen incremento_desmatado_norm08 = (incremento_desmatado - mean_increm08)/  sd_increm08
label var incremento_desmatado_norm08 "Incremento de desmatamento t-1 a t normalizado Lei 2008"
}

///

****  GERANDO VARIÁVEIS TRIPLE DIFFERENCE
** Gerando variável de tratamento
{
g diff_efeito04_DDD = n_metro_cti*ano04
g diff_efeito08_DDD = n_metro_cti*ano08
}

** Parallel Trends Tripla Diferença
{
* Gerando identificador de tratamento
{
sort n_metro_cti

by n_metro_cti: egen n_metro_cti_04 = mean(diff_efeito04_DDD) 
tab n_metro_cti_04
replace n_metro_cti_04 = 1 if n_metro_cti_04 !=0
tab n_metro_cti_04 
}

* Gerando interação de tratamento e tendências para realização do teste de Parallel Trends
g n_metro_cti_04_trend = n_metro_cti_04*trend
}

** Gerando variável Event Study Triple Difference
{
gen timeToTreat4_DDD = ano - anotrat4 if metropolitano==0 & municipio_ti==1
recode timeToTreat4_DDD .=0

gen timeToTreat8_DDD = ano - anotrat8 if metropolitano==0 & municipio_ti==1
recode timeToTreat8_DDD .=0
}

*** GERANDO VARIÁVEIS PLACEBO TRIPLE DIFFERENCE
* Gerando variável de efeito do DDD para o ano de 2003:
g diff_efeito03_DDD = n_metro_cti*ano03


* Gerando variável placebo do efeito de tripla diferença
g placebo_efeito04_DDD  = tratplacebo_ti*tratplacebo_nm*ano04


///////////////////////

** Globais
global indices_precos indice_precos_real_arroz_2000 indice_precos_real_boi_2000 indice_precos_real_cana_2000 indice_precos_real_mandioca_2000 indice_precos_real_milho_2000 indice_precos_real_soja_2000



//


**** TRATANDO MISSINGS
* Observação:  Utilizar somente se o período considerar os anos 2000 e 2001
{
** Tratando missings em caso de desmatado==0 no ano 2000
*drop if ano==2000 & desmatado==0

*_ Dropando municípios com menos de 11 observações (anos)
*by codigo_ibge: gen testex = _N
*drop if testex !=11

*** Arrumando missings em pop: 	=> CHECAR O TAMANHO DA POPULAÇÃO DESTAS CIDADES EM 2000 !
*sum pop if uf=="MT" & pop<10000 & ano==2000 
*sum pop if uf=="MT" & pop<10000 & ano==2001 
* => MANUALMENTE: Fazer a razão entre méda do ano 2001 e 2000, somar à 1 e multiplicar pop de 2000
//
}




**________________					RESUMO						_______________*
* Clique para minimizar


*__________ Variáveis para Event Study "timeToTreatX" 
* Observação: Valor no grupo controle deve ser = 0

///// 		PS: X=4 para Lei 2004 ou X=8 para Lei 2008
////		timeToTreatX => 	Grupo Controle = metropolitano (default)
/// 		timeToTreatX_c => 	Grupo Controle = municipio_capital
//		 	timeToTreatX_ti => 	Grupo Controle = municipio_nao_ti
			
//			VAR. RESULTADO: incremento_desmatado ; incremento_desmatado_norm04 ; incremento_desmatado_norm08
//



*___________				 Variáveis de Tratamento				____________
*

///////	 		REGRESSÃO OFICIAL:  _ Não Metropolitano  / Metropolitano _

/////	CONDIÇÃO AMOSTRA:		-
////	TRATADO: 				nao_metropolitano	=> Não metropolitano SEM TI
///		CONTROLE:				metropolitano		=> metropolitano
// 		TRATAMENTO: 			diff_efeito04 ;  diff_efeito08

** Utilizar CONDIÇÃO AMOSTRA antes das regressões e colapses!

*_________________________  	OUTRAS VARIANTES	___________________________*

**		Minimizar se não for usar!!
{

///////				_ Não Capital TI / Capital _

/////	CONDIÇÃO AMOSTRA:		-
////	TRATADO: 				nao_capital		=> Não capital sem TI
///		CONTROLE:				capital 		=> Capital
// 		TRATAMENTO: 			diff_efeito04_c ;  diff_efeito08_c	=> _ncs : Nao Capital


///////				_ Não Capital SEM TI / Capital _

/////	CONDIÇÃO AMOSTRA:		drop if nao_capital==1 & municipio_ti==1
////	TRATADO: 				nao_capital		=> Não capital sem TI
///		CONTROLE:				capital 		=> Capital
// 		TRATAMENTO: 			diff_efeito04_ncs ;  diff_efeito08_ncs	=> _ncs : Nao Capital Sem ti


/////// 			_ Não Capital COM TI / Capital _

/////	CONDIÇÃO AMOSTRA:		drop if nao_capital==1 & municipio_ti==0
////	TRATADO: 				nao_capital		=> Não capital com TI
///		CONTROLE:				capital 		=> Capital
// 		TRATAMENTO: 			diff_efeito04_ncc ;  diff_efeito08_ncc  => _ncc : Nao Capital Com ti


///////	 		_ Não Metropolitano SEM TI / Metropolitano _

/////	CONDIÇÃO AMOSTRA:		drop if nao_metropolitano==1 & municipio_ti==1
////	TRATADO: 				nao_metropolitano	=> Não metropolitano sem TI
///		CONTROLE:				metropolitano		=> metropolitano
// 		TRATAMENTO:				 diff_efeito04_nms ;  diff_efeito08_nms
		

///////	 		_ Não Metropolitano COM TI / Metropolitano _

/////	CONDIÇÃO AMOSTRA:		drop if nao_metropolitano==1 & municipio_ti==0
////	TRATADO: 				nao_metropolitano	=> Não metropolitano com TI
///		CONTROLE:				metropolitano		=> metropolitano
// 		TRATAMENTO: 			diff_efeito04_nmc ;  diff_efeito08_nmc




///////	 		_ Municipio COM TI / Municipio SEM TI _

/////	CONDIÇÃO AMOSTRA:		-
////	TRATADO: 				municipio_ti		=> Município com TI
///		CONTROLE:				municipio_nao_ti	=> Município sem TI
// 		TRATAMENTO: 			diff_efeito04_ti1 ;  diff_efeito08_ti1


///////	 		_ Municipio COM TI 50% / Municipio SEM TI _

/////	CONDIÇÃO AMOSTRA:		keep if (municipio_nao_ti==1 | municipio_ti_3==1)
////	TRATADO: 				municipio_ti_3	=> Município com TI quantil 50%+
///		CONTROLE:				municipio_nao_ti=> Município sem TI
// 		TRATAMENTO:				 diff_efeito04_ti3 ;  diff_efeito08_ti3



///////	 		_ Municipio COM TI 66% / Municipio SEM TI _

/////	CONDIÇÃO AMOSTRA:		keep if (municipio_nao_ti==1 | municipio_ti_4==1)
////	TRATADO: 				municipio_ti_4	=> Município com TI quantil 66%+
///		CONTROLE:				municipio_nao_ti=> Município sem TI
// 		TRATAMENTO: 			diff_efeito04_ti4 ;  diff_efeito08_ti4
}

*___________				 Variáveis de Resultado					____________


*	desmatado
*	desmatado_log
*	incremento_desmatado
*	incremento_desmatado_log
*	desmatado_prop
*	desmatado_prop_log
*	indice_desmatado
*	indice_desmatado00
*	indice_desmatado01
*	indice_desmatado02
*	indice_desmatado00_log
*	indice_desmatado01_log
*	indice_desmatado02_log


*___________				 		Covariáveis						____________

global indice_precos indice_precos_real_arroz_2000 indice_precos_real_boi_2000 indice_precos_real_cana_2000 indice_precos_real_milho_2000 indice_precos_real_soja_2000 indice_precos_real_mandioca_2000


* pop densidade_demografica area_lav_permanente area_lav_temporaria, proporcao_ti
* restricao_fundiaria => Significativa, bad control!

*___________					Variáveis Placebo					____________

**		 Anos

* diff_efeito03; diff_efeito03_c; diff_efeito03_ti1; diff_efeito03_ti2; diff_efeito03_ti3; diff_efeito03_ti4
* diff_efeito07; diff_efeito07_c; diff_efeito07_ti1; diff_efeito07_ti2; diff_efeito07_ti3; diff_efeito07_ti4


//

sort ano
save "base_final_9", replace // Botei no final de novo para ficar mais fácil se o do-file rodou corretamente