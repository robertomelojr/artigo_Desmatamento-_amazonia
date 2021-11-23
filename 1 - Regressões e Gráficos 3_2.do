clear all

cd "C:\Users\Benevita1\Documents\Acadêmico\1 - Mestrado\Microeconometria Aplicada\Artigo\0 - Base final"


**________________					RESUMO						_______________*
* Clique para minimizar
{

*__________ Variáveis para Event Study "timeToTreatX" 
* Observação: Valor no g. controle deve ser = 0

///// 		PS: X=4 para Lei 2004 ou X=8 para Lei 2008
////		timeToTreatX => 	Grupo Controle = metropolitano (default)
/// 		timeToTreatX_c => 	Grupo Controle = municipio_capital
//		 	timeToTreatX_ti => 	Grupo Controle = municipio_nao_ti

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


///////	 		_ Municipio COM TI 33% / Municipio SEM TI _

/////	CONDIÇÃO AMOSTRA:		keep if (municipio_nao_ti==1 | municipio_ti_2==1)
////	TRATADO: 				municipio_ti_2	=> Município com TI quantil 33%+
///		CONTROLE:				municipio_nao_ti=> Município sem TI
// 		TRATAMENTO:				 diff_efeito04_ti2 ;  diff_efeito08_ti2


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



///////	 		_ Municipio N Metro N Capital SEM TI/ Municipio Capital _

/////	CONDIÇÃO AMOSTRA:		keep if (n_metro_n_cap==1 & municipio_nao_ti| municipio_capital==1)
////	TRATADO: 				n_metro_n_cap	=> Mun. Ñ Metr. Ñ Cap. sem TI
///		CONTROLE:				municipio_capital=> Município Capital
// 		TRATAMENTO: 			diff_efeito04_nmnc ;  diff_efeito08_nmnc
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

}

*___________				 		Covariáveis						____________

global indice_precos indice_precos_real_arroz_2000 indice_precos_real_boi_2000 indice_precos_real_cana_2000 indice_precos_real_milho_2000 indice_precos_real_soja_2000 indice_precos_real_mandioca_2000


* pop densidade_demografica area_lav_permanente area_lav_temporaria, proporcao_ti
* restricao_fundiaria => Significativa, bad control!

*___________					Variáveis Placebo					____________

**		 Anos

* diff_efeito03; diff_efeito03_c; diff_efeito03_ti1; diff_efeito03_ti2; diff_efeito03_ti3; diff_efeito03_ti4
* diff_efeito07; diff_efeito07_c; diff_efeito07_ti1; diff_efeito07_ti2; diff_efeito07_ti3; diff_efeito07_ti4


*___________					Variáveis Resultado					____________

* 	incremento_desmatado; incremento_desmatado_norm04 ; incremento_desmatado_norm08


//

**_______________________      ANÁLISE GRÁFICA     ___________________________**

****   Desmatamento por tipo de município no período

* Gerando variáveis de média do incremento do desmatamento (var y) por tipo de município:
{
sort ano
 
by ano: egen media_metropolitano = mean(incremento_desmatado) if metropolitano==1
by ano: egen media_nao_metropolitano = mean(incremento_desmatado) if nao_metropolitano==1
by ano: egen media_metro_cti = mean(incremento_desmatado) if metro_cti==1
by ano: egen media_metro_sti = mean(incremento_desmatado) if metro_sti==1
by ano: egen media_n_metro_cti = mean(incremento_desmatado) if n_metro_cti==1
by ano: egen media_n_metro_sti = mean(incremento_desmatado) if n_metro_sti==1
			 
label var media_metropolitano "Município Metropolitano"
label var media_nao_metropolitano "Município Não Metropolitano"
label var media_metro_cti "Mun. Metropolitano com TI"
label var media_metro_sti "Mun. Metropolitano sem TI"
label var media_n_metro_cti "Mun. Não Metrop. com TI"
label var media_n_metro_sti "Mun. Não Metrop. sem TI"
}

** Gerando o Gráfico:			 
twoway line media_metropolitano media_nao_metropolitano media_metro_cti media_metro_sti  media_n_metro_cti media_n_metro_sti ano,  ytitle("Incremento do Desmatamento") title("Desmatamento por tipo de município no período") 
			 
			 
			 
*___________________		ESTATÍSTICAS DESCRITIVAS	________________________
//

use "base_final_8", replace
drop if ano<2002
drop if metropolitano==1 						// 	=> municipio_ti ; diff_efeito04_ti

*** Desmatamento por tipo de município
{
** Desmatamento municípios pré e pós Lei de 2004
* Pré tratamento
sum incremento_desmatado if nao_metropolitano==1 & ano04==0 & ano<2008
sum incremento_desmatado if nao_metropolitano==1 & municipio_ti==1 & ano04==0 & ano<2008
sum incremento_desmatado if nao_metropolitano==1 & municipio_ti==0 & ano04==0 & ano<2008
sum incremento_desmatado if metropolitano==1 & ano04==0 & ano<2008

* Pós tratamento
sum incremento_desmatado if nao_metropolitano==1 & ano04==1 & ano<2008
sum incremento_desmatado if nao_metropolitano==1 & municipio_ti==1 & ano04==1 & ano<2008
sum incremento_desmatado if nao_metropolitano==1 & municipio_ti==0 & ano04==1 & ano<2008
sum incremento_desmatado if metropolitano==1 & ano04==1 & ano<2008

** Desmatamento municípios pré e pós Lei de 2008
* Pré tratamento
sum incremento_desmatado if nao_metropolitano==1 & ano08==0 & ano>2004
sum incremento_desmatado if nao_metropolitano==1 & municipio_ti==1 & ano08==0 & ano>2004
sum incremento_desmatado if nao_metropolitano==1 & municipio_ti==0 & ano08==0 & ano>2004
sum incremento_desmatado if metropolitano==1 & ano08==0 & ano>2004

* Pós tratamento
sum incremento_desmatado if nao_metropolitano==1 & ano08==1 & ano>2004
sum incremento_desmatado if nao_metropolitano==1 & municipio_ti==1 & ano08==1 & ano>2004
sum incremento_desmatado if nao_metropolitano==1 & municipio_ti==0 & ano08==1 & ano>2004
sum incremento_desmatado if metropolitano==1 & ano08==1 & ano>2004



}

{
** Desmatamento por tipo de municípios - Período 2002~2007
sum incremento_desmatado if ano<2008 // Geral
sum incremento_desmatado if nao_metropolitano==0 & ano<2008 // Metropolitano
sum incremento_desmatado if nao_metropolitano==1 & ano<2008 // Não Metropolitano
sum incremento_desmatado if nao_metropolitano==0 & municipio_ti==1 & ano<2008 // Metropolitano com TI
sum incremento_desmatado if nao_metropolitano==0 & municipio_ti==0 & ano<2008 // Metropolitano sem TI
sum incremento_desmatado if nao_metropolitano==1 & municipio_ti==1 & ano<2008 // Não Metropolitano com TI
sum incremento_desmatado if nao_metropolitano==1 & municipio_ti==0 & ano<2008 // Não Metropolitano sem TI
}

*** Variável de resultado
sum incremento_desmatado
sum incremento_desmatado if ano<2008
sum incremento_desmatado if ano>2004

*** Variáveis de tratamento e controle
sum metropolitano
sum nao_metropolitano
sum metro_cti
sum metro_sti
sum n_metro_cti
sum n_metro_sti

 
**** Covariáveis
* drop if ano>2007
sum pop
sum area_km2
sum area_lav_temporaria
sum indice_precos_real_arroz_2000
sum indice_precos_real_cana_2000
sum indice_precos_real_boi_2000
sum indice_precos_real_mandioca_2000
sum indice_precos_real_milho_2000
sum indice_precos_real_soja_2000

** Verificar municipios com e sem TI na amostra completa
g testesti = municipio_nao_ti*nao_metropolitano
g testesti = municipio_nao_ti*nao_metropolitano

//

*___________________			ANÁLISE EMPÍRICA		________________________
/////
////
///
//

** CONDIÇÃO => 	drop ou keep => checar seção RESUMO acima
* Ex: 	tratados: Não_metropolitana vs controle Capitais.
* 		drop if metropolitano==1 & municipio_capital==0


*_________________________    		LEI 2004 		 ___________________________
///
//

*___________________   		PARALLEL TRENDS (Colapses) 		 ___________________

* Observações:	Utilizar a CONDIÇÃO DA AMOSTRA antes de usar o comando collapse

***Exemplo:
*_ collapse(mean) VarResultado, by(ano GrupoTratado) overlay
*_ xtline VarResultado if CondiçãoTemporal, t(ano) i(GrupoTratado) overlay

use "base_final_9", replace

 * N Metropolitano com TI x N Metropolitano sem TI	
drop if metropolitano==1 						// 	=> municipio_ti ; diff_efeito04_ti

* N Metropolitano sem TI x Metropolitano			
drop if nao_metropolitano==1 & municipio_ti==1 // => nao_metropolitano ; diff_efeito04_nms
* N Capital sem TI x Capital						
drop if nao_capital==1 & municipio_ti==1		//	=> nao_capital ; diff_efeito04_ncs
* N Metropolitano com TI x N Metropolitano sem TI	
drop if metropolitano==1 						// 	=> municipio_ti ; diff_efeito04_ti
 
collapse (mean) incremento_desmatado, by(ano nao_metropolitano) // ! CUIDADOO !
xtline incremento_desmatado if ano<2008, t(ano) i(nao_metropolitano) overlay title(Parallel Trends Ñ Metr. sem TI x Metr. Inc. Desmat. Lei 2004)


*_______________________	 		REGRESSÃO REG			____________________
* Observação: Carregar a base e condição da amostra após o colapse!

reg incremento_desmatado ano04 nao_metropolitano diff_efeito04_nms i.ano if (ano>2001 | ano<2008), robust // LEI 2004



*_______________________	 		REGRESSÕES AREG			____________________

* Observação1: 	Alterar as variáveis de grupo tratado: nao_metropolitan; nao_capital; municipio_ti; etc
* Observação2: 	Alterar as variáveis de efeito do DD: diff_efeitoX_x => checar lista
* Observação3: 	Alterar a variável de resultado para a que quer estimar
* Observação4:	Alterar variável de tendência do tratado: trend_nao_metropolitano; etc

use "base_final_9", replace
drop if ano<2002

* N. Metropolitano com TI x Metropolitano
drop if nao_metropolitano==1 & municipio_ti==0

* N. Metropolitano sem TI x Metropolitano
drop if nao_metropolitano==1 & municipio_ti==1

* N Metropolitano sem TI x Metropolitano			
drop if nao_metropolitano==1 & municipio_ti==1 // => nao_metropolitano ; diff_efeito04_nms
* N Capital sem TI x Capital						
drop if nao_capital==1 & municipio_ti==1		//	=> nao_capital ; diff_efeito04_ncs
* N Metropolitano com TI x N Metropolitano sem TI	
drop if metropolitano==1 						// 	=> municipio_ti ; diff_efeito04_ti

** Regressões para 2004 	 Incremento_desmatado
{
xi: areg incremento_desmatado ano04 nao_metropolitano diff_efeito04_nms i.ano if ano<2008, absorb(codigo_ibge) robust	// i.ano


xi: areg incremento_desmatado ano04 nao_metropolitano diff_efeito04_nms trend if ano<2008, absorb(codigo_ibge) robust					// trend

xi: areg incremento_desmatado ano04 nao_metropolitano diff_efeito04_nms i.ano area_km2 pop $indice_precos  area_lav_temporaria if ano<2008, absorb(codigo_ibge) robust 	// i.ano cov

xi: areg incremento_desmatado ano04 nao_metropolitano diff_efeito04_nms i.ano pop $indice_precos  area_lav_temporaria [aw=area_km2] if ano<2008, absorb(codigo_ibge) robust 		// i.ano cov [aw=area_km2]

xi: areg incremento_desmatado ano04 nao_metropolitano diff_efeito04_nms i.ano pop $indice_precos  area_lav_temporaria proporcao_ti if ano<2008, absorb(codigo_ibge) robust // i.ano cov + proporcao_ti 

}


*_______________________	 		EVENT STUDY				____________________

*Observação:	Trocar a variável timeToTreat4	=> timeToTreat4; timeToTreat4_c; timeToTreat4_ti
*Observação2:	Trocar a variável de resultado
*Observação3:	Alterar as opções de legenda do Gráfico


eventdd incremento_desmatado i.ano area_km2 pop $indice_precos area_lav_temporaria if ano<2008, timevar(timeToTreat4_ti) method(fe) graph_op(title(Event Study Ñ Metr. sem TI x Metr. - Inc. Desmat. Lei 2004) ytitle("Incremento Desmatado")) noline ci(rline) baseline(0) robust


//


*_________________________    		LEI 2008 		 ___________________________
///
//

*___________________   		PARALLEL TRENDS (Colapses) 		 ___________________

* Observações:	Utilizar a CONDIÇÃO DA AMOSTRA antes de usar o comando collapse

***Exemplo:
*_ collapse(mean) VarResultado, by(ano GrupoTratado) overlay
*_ xtline VarResultado if CondiçãoTemporal, t(ano) i(GrupoTratado) overlay

* 2008
use "base_final_9", replace
 
* N. Metropolitano com TI x Metropolitano
drop if nao_metropolitano==1 & municipio_ti==0

* N. Metropolitano sem TI x Metropolitano
drop if nao_metropolitano==1 & municipio_ti==1

* N Metropolitano sem TI x Metropolitano			
drop if nao_metropolitano==1 & municipio_ti==1 // => nao_metropolitano ; diff_efeito08_nms
* N Capital sem TI x Capital						
drop if nao_capital==1 & municipio_ti==1		//	=> nao_capital ; diff_efeito08_ncs
* N Metropolitano com TI x N Metropolitano sem TI	
drop if metropolitano==1 						// 	=> municipio_ti ; diff_efeito048ti

collapse (mean) incremento_desmatado, by(ano nao_metropolitano) // ! CUIDADOO !
xtline incremento_desmatado if ano>2004, t(ano) i(nao_metropolitano) overlay title(Parallel Trends Ñ Metr. s/ TI x Metr. - Inc. Desmat. Lei 2008)


*_______________________	 		REGRESSÃO REG			____________________

reg incremento_desmatado ano08 nao_metropolitano diff_efeito08_nms i.ano if ano>2004, robust // LEI 2008

//

*_______________________	 		REGRESSÕES AREG			____________________

* Observação: 	Alterar as variáveis de resultado e diff_efeitoX_x => checar lista

* Observação1: 	Alterar as variáveis de grupo tratado: nao_metropolitan; nao_capital; n_metro_n_cap; etc
* Observação2: 	Alterar as variáveis de efeito do DD: diff_efeitoX_x => checar lista
* Observação3: 	Alterar a variável de resultado para a que quer estimar
* Observação4:	Alterar variável de tendência do tratado: trend_nao_metropolitano; etc

use "base_final_7", replace
drop if ano<2002
 
* N Metropolitano sem TI x Metropolitano			
drop if nao_metropolitano==1 & municipio_ti==1 // => nao_metropolitano ; diff_efeito08_nms
* N Capital sem TI x Capital						
drop if nao_capital==1 & municipio_ti==1		//	=> nao_capital ; diff_efeito08_ncs
* N Metropolitano com TI x N Metropolitano sem TI	
drop if metropolitano==1 						// 	=> municipio_ti ; diff_efeito048ti


** Regressões para 2008		Incremento_desmatado
{
xi: areg incremento_desmatado ano08 nao_metropolitano diff_efeito08 i.ano if ano>2004, absorb(codigo_ibge) robust // i.ano

xi: areg incremento_desmatado ano08 nao_metropolitano diff_efeito08 trend if ano>2004, absorb(codigo_ibge) robust	// trend

xi: areg incremento_desmatado ano08 nao_metropolitano diff_efeito08 i.ano area_km2 pop $indice_precos area_lav_temporaria if ano>2004, absorb(codigo_ibge) robust // i.ano cov

xi: areg incremento_desmatado ano08 nao_metropolitano diff_efeito08 i.ano pop $indice_precos  area_lav_temporaria [aw=area_km2] if ano>2004, absorb(codigo_ibge) robust // i.ano cov [aw=area_km2]

* Somente para TI incluso
xi: areg incremento_desmatado ano08 nao_metropolitano diff_efeito08 i.ano pop $indice_precos area_km2 area_lav_temporaria proporcao_ti if ano>2004, absorb(codigo_ibge) robust // i.ano cov proporcao_ti
}




*_______________________	 		EVENT STUDY				____________________

*Observação1:	Trocar a variável timeToTreat8	=> timeToTreat8; timeToTreat8_c; timeToTreat8_ti
*Observação2:	Trocar a variável de resultado
*Observação3:	Alterar as opções de legenda do Gráfico

use "base_final_7", replace
drop if ano<2002
 
* N Metropolitano sem TI x Metropolitano			
drop if nao_metropolitano==1 & municipio_ti==1 // => nao_metropolitano ; diff_efeito08_nms
* N Capital sem TI x Capital						
drop if nao_capital==1 & municipio_ti==1		//	=> nao_capital ; diff_efeito08_ncs
* N Metropolitano com TI x N Metropolitano sem TI	
drop if metropolitano==1 						// 	=> municipio_ti ; diff_efeito048ti

eventdd incremento_desmatado i.ano area_km2 pop $indice_precos  area_lav_temporaria if ano>2004, timevar(timeToTreat8) method(fe) graph_op(title(Event Study Ñ Metr. s/ TI x Metr. - Inc. Desmat. Lei 2008) ytitle("Incremento Desmatado")) noline ci(rline) baseline(0) robust


*__________________    		  PLACEBOS - 2004 e 2008 		 ___________________

*Observação1:	Placebo em relação ao grupo tratado. ex: nao_metropolitano; nao_capital; n_metro_n_cap; etc

***** Regressões PLACEBO ANO para 2004
* Obs: Placebo Ano para a Lei 2008 não funciona! => Não é possível separar o efeito de 2004 do período de 2008

** Regressões PLACEBO ANO para 2004 	 
xi: areg incremento_desmatado ano03 nao_metropolitano diff_efeito03_nms i.ano if ano<2008, absorb(codigo_ibge) robust


**** PLACEBO VARIÁVEL DE RESULTADO  
* Obs: Variável de Resultado Placebo: Área de Lavoura Permanente => area_lav_permanente

* Regressões PLACEBO VARIÁVEL DE RESULTADO para 2004 	 area_lav_permanente
xi: areg area_lav_permanente ano04 nao_metropolitano diff_efeito04 i.ano if ano<2008, absorb(codigo_ibge) robust

** Regressões PLACEBO VARIÁVEL DE RESULTADO para 2008		area_lav_permanente_
xi: areg area_lav_permanente ano08 nao_metropolitano diff_efeito08 i.ano if ano>2004, absorb(codigo_ibge) robust


**** PLACEBO VARIÁVEL DE TRATAMENTO ALEATÓRIA

* Regressões PLACEBO VARIÁVEL TRATAMENTO ALEATÓRIOA para 2004 	 
xi: areg incremento_desmatado ano04 tratplacebo_nm placebo_efeito04_nm i.ano if ano<2008, absorb(codigo_ibge) robust


* Regressões PLACEBO VARIÁVEL TRATAMENTO ALEATÓRIOA para 2004 	 
xi: areg incremento_desmatado ano08 tratplacebo_nm placebo_efeito08_nm	i.ano if ano>2004, absorb(codigo_ibge) robust



//

use "base_final_9", replace 


**** Triple Difference
{

*** Regressão: Areg - "Manualmente"
{
** Lei 2004
{
* DDD - 1
xi: reg incremento_desmatado nao_metropolitano municipio_ti nao_metropolitano_cti ano04 diff_efeito04_nms diff_efeito04_ti diff_efeito04_DDD i.ano if ano<2008, robust	// i.ano

* DDD com tendências temporais - 3
xi: reg incremento_desmatado nao_metropolitano municipio_ti nao_metropolitano_cti ano04 diff_efeito04_nms diff_efeito04_ti trend diff_efeito04_DDD i.ano if ano<2008, robust	// trend

* DDD com Covariáveis - 2
xi: reg incremento_desmatado nao_metropolitano municipio_ti nao_metropolitano_cti ano04 diff_efeito04_nms diff_efeito04_ti diff_efeito04_DDD i.ano area_km2 pop $indice_precos  area_lav_temporaria if ano<2008, robust	// i.ano


* DDD com tendências temporais (variáveis de interação) - 4
xi: reg incremento_desmatado  nao_metropolitano municipio_ti nao_metropolitano_cti ano04 diff_efeito04_nms diff_efeito04_ti trend diff_efeito04_DDD trend_nao_metropolitano trend_municipio_ti i.ano if ano<2008, robust	// i.ano
	
* DDD com tendências temporais (variáveis de interação) e Covariáveis
xi: reg incremento_desmatado  nao_metropolitano municipio_ti nao_metropolitano_cti ano04 diff_efeito04_nms diff_efeito04_ti trend diff_efeito04_DDD trend_nao_metropolitano trend_municipio_ti i.ano area_km2 pop $indice_precos  area_lav_temporaria if ano<2008, robust	// i.ano
}

//

** Conjunto de leis de 2008
{
* DDD - 1
xi: reg incremento_desmatado nao_metropolitano municipio_ti nao_metropolitano_cti ano08 diff_efeito08_nms diff_efeito08_ti diff_efeito08_DDD i.ano if ano>2004,  robust	// i.ano

* DDD com tendências temporais - 3
xi: reg incremento_desmatado nao_metropolitano municipio_ti nao_metropolitano_cti ano08 diff_efeito08_nms diff_efeito08_ti trend diff_efeito08_DDD i.ano if ano>2004,  robust	// i.ano

* DDD com Covariáveis - 2
xi: reg incremento_desmatado nao_metropolitano municipio_ti nao_metropolitano_cti ano08 diff_efeito08_nms diff_efeito08_ti diff_efeito08_DDD i.ano area_km2 pop $indice_precos  area_lav_temporaria if ano>2004,  robust	// i.ano

* DDD com tendência entre grupos - 4 
xi: reg incremento_desmatado nao_metropolitano municipio_ti nao_metropolitano_cti ano08 diff_efeito08_nms diff_efeito08_ti diff_efeito08_DDD trend i.ano area_km2 pop $indice_precos  area_lav_temporaria if ano>2004,  robust	// i.ano

* DDD com tendências temporais (variáveis de interação)
xi: reg incremento_desmatado nao_metropolitano municipio_ti nao_metropolitano_cti ano08 diff_efeito08_nms diff_efeito08_ti trend diff_efeito08_DDD trend_nao_metropolitano trend_municipio_ti i.ano if ano>2004,  robust	// i.ano
	
* DDD com tendências temporais (variáveis de interação) e Covariáveis
xi: reg incremento_desmatado nao_metropolitano municipio_ti nao_metropolitano_cti ano08 diff_efeito08_nms diff_efeito08_ti trend diff_efeito08_DDD trend_nao_metropolitano trend_municipio_ti i.ano area_km2 pop $indice_precos  area_lav_temporaria if ano>2004,  robust	// i.ano
}

}

//

*** Regressão: Diff
** Lei 2004
{
xi: diff incremento_desmatado if ano<2008, period(ano04) treated(nao_metropolitano) cluster(codigo_ibge) id(codigo_ibge) ddd(municipio_ti0) robust // sem covariáveis

xi: diff incremento_desmatado if ano<2008, period(ano04) treated(nao_metropolitano) cov(i.ano area_km2 pop $indice_precos  area_lav_temporaria) cluster(codigo_ibge) id(codigo_ibge) ddd(municipio_ti_30) robust // com covariáveis

** Conjunto de leis 2008
xi: diff incremento_desmatado if ano >2004, period(ano08) treated(nao_metropolitano) cov(i.ano area_km2 pop $indice_precos  area_lav_temporaria) cluster(codigo_ibge) id(codigo_ibge) ddd(municipio_ti) 
}

}
//


**** EVENT STUDY TRIPLE DIFFERENCE

* Modelo
eventdd incremento_desmatado i.ano area_km2 pop $indice_precos area_lav_temporaria  if ano<2008, timevar(timeToTreat4) method(fe) graph_op(title(Event Study Ñ Metr. sem TI x Metr. - Inc. Desmat. Lei 2004) ytitle("Incremento Desmatado")) noline ci(rline) baseline(0) robust


** Lei 2004
eventdd incremento_desmatado i.ano area_km2 pop $indice_precos area_lav_temporaria  if ano<2008, timevar(timeToTreat4_DDD) method(fe) graph_op(title(Event Study DDD - Inc. Desmat. Lei 2004) ytitle("Incremento Desmatado"))  noline ci(rline) baseline(0) robust level(90)

*eventdd incremento_desmatado i.ano area_km2 pop $indice_precos area_lav_temporaria nao_metropolitano municipio_ti diff_efeito04_ti ano04 diff_efeito04 diff_efeito04_DDD if ano<2008, timevar(timeToTreat4_DDD) method(fe) graph_op(title(Event Study DDD - Inc. Desmat. Lei 2004) ytitle("Incremento Desmatado"))  noline ci(rline) baseline(0) robust

** Leis 2008
eventdd incremento_desmatado i.ano area_km2 pop $indice_precos area_lav_temporaria nao_metropolitano municipio_ti diff_efeito08_ti ano08 diff_efeito08 diff_efeito08_DDD if ano>2004, timevar(timeToTreat8_DDD) method(fe) graph_op(title(Event Study DDD - Inc. Desmat. Leis 2008) ytitle("Incremento Desmatado")) noline ci(rline) baseline(0) robust


//

**** Placebo Triple Difference

*** PLACEBO DDD para o ano do tratamento: 2004 => 2003
** Regressões PLACEBO ANO para lei de 2004 	 
xi: reg incremento_desmatado  nao_metropolitano municipio_ti nao_metropolitano_cti ano04 diff_efeito03_nms diff_efeito03_ti diff_efeito03_DDD i.ano if ano<2008, robust
}

//

*** PLACEBO DDD VARIÁVEL DE RESULTADO  
** Regressões PLACEBO VARIÁVEL DE RESULTADO para lei de 2004 	 area_lav_permanente
xi: areg area_lav_permanente ano04 nao_metropolitano diff_efeito04_nms municipio_ti diff_efeito04_ti diff_efeito04_DDD i.ano if ano<2008, absorb(codigo_ibge) robust

//

*** PLACEBO DDD VARIÁVEL DE TRATAMENTO ALEATÓRIA
** Para melhor entendimento: checar variáveis no do-file "2 - Construção da Base e Variáveis", linhas 728-787
* Regressões PLACEBO VARIÁVEL TRATAMENTO ALEATÓRIOA para lei de 2004 	 

xi: reg incremento_desmatado tratplacebo_nm tratplacebo_ti placebo_nao_metro_ti ano04 placebo_efeito04_nm placebo_efeito04_ti placebo_efeito04_DDD if ano<2008, robust


//

use "base_final_9", replace

//


** TESTE PARALLEL TRENDS
* Teste Parallel Trends: Ano < 2004
xi: areg incremento_desmatado trend i.trend n_metro_cti_04_trend if trend<3, absorb(codigo_ibge) cluster(codigo_ibge)
test n_metro_cti_04_trend 

xi: reg incremento_desmatado n_metro_cti_04 trend n_metro_cti_04_trend if trend<3, cluster(codigo_ibge)
test n_metro_cti_04_trend

// Parallel Trends: Ano < 2005
xi: areg incremento_desmatado trend n_metro_cti_04_trend i.trend if trend<4, absorb(codigo_ibge) cluster(codigo_ibge)
test n_metro_cti_04_trend 

xi:  reg incremento_desmatado trend n_metro_cti_04_trend n_metro_cti_04 if trend<4, cluster(codigo_ibge)
test n_metro_cti_04_trend