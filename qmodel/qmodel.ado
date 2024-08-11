*! version 1.0 21dec2018

program qmodel, eclass
if trim("`0'")==""  {
	if "`e(cmd)'"!="qmodel" error 301
	ereturn display
	}
else {
syntax anything(equalok) [if] [in] [, NPoints(integer 99) QPoints(numlist >=0 <=1) INITial(string) LOG cluster(varlist max=1)]
marksample touse
tokenize `"`anything'"', parse("=")
local 1 = subinstr(`"`1'"'," ","",.)
if `"`3'"'=="" {
	local 3 = "_flat"
	}
local 3 = subinstr(`"`3'"', "_cons", "_flat",.)
local 3 = subinstr(`"`3'"', "_chi-square", "_chi2",.)
local 3 = subinstr(`"`3'"', "_poly0", "_flat",.)
local 3 = subinstr(`"`3'"', "_poly1", "_linear",.)
local 3 = subinstr(`"`3'"', "_poly2", "_quadratic",.)
local 3 = subinstr(`"`3'"', "_poly3", "_cubic",.)
local 3 = subinstr(`"`3'"', "_p-cubed", "_p3",.)
local 3 = subinstr(`"`3'"', "_p-squared", "_p2",.)
local 3 = subinstr(`"`3'"', "_sqrt", "_root2",.)
local 3 = subinstr(`"`3'"', "_uniform", "_linear",.)
local 3 = subinstr(`"`3'"', "_[", "_(",.)
local 3 = subinstr(`"`3'"', "]_", ")_",.)
local c 0
while strpos(`"`3'"',"_alogistic")>0 {
	local ++c
	local v = cond(`c'>1,".`c'","")
	local 3 = subinstr(`"`3'"', "_alogistic", "(exp({alogistic`v':log(a)})*log(p)-exp({alogistic`v':log(b)})*log(1-p))",1) 
	}
local c 0
while strpos(`"`3'"',"_beta")>0 {
	local ++c
	local v = cond(`c'>1,".`c'","")
	local 3 = subinstr(`"`3'"', "_beta", "invibeta(exp({beta`v':log(a)}),exp({beta`v':log(b)}),p)",1) 
	}
local c 0
while strpos(`"`3'"',"_chi2")>0 {
	local ++c
	local v = cond(`c'>1,".`c'","")
	local 3 = subinstr(`"`3'"', "_chi2", "invchi2(exp({chi2`v':log(df)}),p)",1) 
	}
local c 0
while strpos(`"`3'"',"_clog")>0 {
	local ++c
	local v = cond(`c'>1,".`c'","")
	local 3 = subinstr(`"`3'"', "_clog", "({clog`v':log(1-p)}*log(1-p))",1)
	}
local c 0
while strpos(`"`3'"',"_cnormal")>0 {
	local ++c
	local v = cond(`c'>1,".`c'","")
	local 3 = subinstr(`"`3'"', "_cnormal", "(exp({cnormal`v':log(sd)})*invnormal(p))",1) 
	}
local c 0
while strpos(`"`3'"',"_cubic")>0 {
	local ++c
	local v = cond(`c'>1,".`c'","")
	local 3 = subinstr(`"`3'"', "_cubic", `"({cubic`v':constant}+{cubic`v':p}*(p-.5)+{cubic`v':p^2}*(p-.5)^2+{cubic`v':p^3}*(p-.5)^3)"',1) 
	}
local c 0
while strpos(`"`3'"',"_cp3")>0 {
	local ++c
	local v = cond(`c'>1,".`c'","")
	local 3 = subinstr(`"`3'"', "_cp3", "({cp3`v':(p-.5)^3}*(p-.5)^3)",1)
	}
local c 0
while strpos(`"`3'"',"_cp2")>0 {
	local ++c
	local v = cond(`c'>1,".`c'","")
	local 3 = subinstr(`"`3'"', "_cp2", "({cp2`v':(p-.5)^2}*(p-.5)^2)",1)
	}
local c 0
while strpos(`"`3'"',"_cp")>0 {
	local ++c
	local v = cond(`c'>1,".`c'","")
	local 3 = subinstr(`"`3'"', "_cp", "({cp`v':p-.5}*(p-.5))",1)
	}
local c 0
while strpos(`"`3'"',"_exponential")>0 {
	local ++c
	local v = cond(`c'>1,".`c'","")
	local 3 = subinstr(`"`3'"', "_exponential", "(-exp({exponential`v':log(mean)})*log(1-p))",1) 
	}
local c 0
while strpos(`"`3'"',"_flat")>0 {
	local ++c
	local v = cond(`c'>1,".`c'","")
	local 3 = subinstr(`"`3'"', "_flat", "({flat`v':constant})",1)
	}
local c 0
while strpos(`"`3'"',"_gamma")>0 {
	local ++c
	local v = cond(`c'>1,".`c'","")
	local 3 = subinstr(`"`3'"', "_gamma", "(exp({gamma`v':log(scale)})*invgammap(exp({gamma`v':log(shape)}),p))",1) 
	}
local c 0
while strpos(`"`3'"',"_lognormal")>0 {
	local ++c
	local v = cond(`c'>1,".`c'","")
	local 3 = subinstr(`"`3'"', "_lognormal", "(exp({lognormal`v':mean}+exp({lognormal`v':log(sd)})*invnormal(p)))",1) 
	}
local c 0
while strpos(`"`3'"',"_logitnormal")>0 {
	local ++c
	local v = cond(`c'>1,".`c'","")
	local 3 = subinstr(`"`3'"', "_logitnormal", "invlogit({logitnormal`v':mean}+exp({logitnormal`v':log(sd)})*invnormal(p))",1) 
	}
local c 0
while strpos(`"`3'"',"_linear")>0 {
	local ++c
	local v = cond(`c'>1,".`c'","")
	local 3 = subinstr(`"`3'"', "_linear", "({linear`v':constant}+{linear`v':p}*(p-.5))",1) 
	}
local c 0
while strpos(`"`3'"',"_log")>0 {
	local ++c
	local v = cond(`c'>1,".`c'","")
	local 3 = subinstr(`"`3'"', "_log", "({log`v':log(p)}*log(p))",1)
	}
local c 0
while strpos(`"`3'"',"_normal")>0 {
	local ++c
	local v = cond(`c'>1,".`c'","")
	local 3 = subinstr(`"`3'"', "_normal", "({normal`v':mean}+exp({normal`v':log(sd)})*invnormal(p))",1) 
	}
local c 0
while strpos(`"`3'"',"_p3")>0 {
	local ++c
	local v = cond(`c'>1,".`c'","")
	local 3 = subinstr(`"`3'"', "_p3", "{p3`v':p^3}*p^3",1)
	}
local c 0
while strpos(`"`3'"',"_p2")>0 {
	local ++c
	local v = cond(`c'>1,".`c'","")
	local 3 = subinstr(`"`3'"', "_p2", "{p2`v':p^2}*p^2",1)
	}
local c 0
while strpos(`"`3'"',"_p")>0 {
	local ++c
	local v = cond(`c'>1,".`c'","")
	local 3 = subinstr(`"`3'"', "_p", "{p`v':p}*p",1)
	}
local c 0
while strpos(`"`3'"',"_quadratic")>0 {
	local ++c
	local v = cond(`c'>1,".`c'","")
	local 3 = subinstr(`"`3'"', "_quadratic", `"({quadratic`v':constant}+{quadratic`v':p}*(p-.5)+{quadratic`v':p^2}*(p-.5)^2)"',1) 
	}
local c 0
while strpos(`"`3'"',"_root2")>0 {
	local ++c
	local v = cond(`c'>1,".`c'","")
	local 3 = subinstr(`"`3'"', "_root2", "({root2`v':p^(1/2)}*p^.5)",1)
	}
local c 0
while strpos(`"`3'"',"_root3")>0 {
	local ++c
	local v = cond(`c'>1,".`c'","")
	local 3 = subinstr(`"`3'"', "_root3", "({root3`v':p^(1/3)}*p^(1/3))",1)
	}
local c 0
while strpos(`"`3'"',"_spline")>0 {
	local ++c
	local v = cond(`c'>1,".`c'","")
	local d = real(substr(`"`3'"',strpos(`"`3'"',"_spline")+7,1))
	local k = cond(real(substr(`"`3'"',strpos(`"`3'"',"_spline")+9,2))!=.,real(substr(`"`3'"',strpos(`"`3'"',"_spline")+9,2)),real(substr(`"`3'"',strpos(`"`3'"',"_spline")+9,1)))
	if !inrange(`d',0,9) {
		di as err "The order of the spline must be between 0 and 9"
		exit
		}
	if !inrange(`k',0,99) {
		di as err "The number of knots must be between 0 and 99"
		exit
		}
	local s "{spline`v':constant}"
	forvalues i = 1/`d' {
		local s = cond(`i'==1,"`s'+{spline`v':p}*p^`i'","`s'+{spline`v':p^`i'}*p^`i'")
		}
	forvalues i = 1/`k' {
		local s = cond(`d'==0,"`s'+{spline`v':constant_`i'}*(p>(`i'/`=`k'+1'))","`s'+{spline`v':spline^`d'_`i'}*(p-`i'/`=`k'+1')^`d'*(p>(`i'/`=`k'+1'))")
		}
	local 3 = subinstr(`"`3'"', "_spline`d'_`k'","`s'",1) 
	}
local c 0
while strpos(`"`3'"',"_weibull")>0 {
	local ++c
	local v = cond(`c'>1,".`c'","")
	local 3 = subinstr(`"`3'"', "_weibull", "(exp({weibull`v':log(mean)})*(-log(1-p))^exp(-{weibull`v':log(shape)}))",1) 
	}


local Q = subinstr(`"`3'"'," ","",.)
local Qc = `"`Q'"'
while strpos(`"`3'"',"{")>0 {
	local tpar = "`tpar'" + " " + substr(`"`3'"',strpos(`"`3'"',"{")+1,strpos(`"`3'"',"}")-strpos(`"`3'"',"{")-1)
	local 3 = substr(`"`3'"',strpos(`"`3'"',"}")+1,.)
	}
local npar 0
foreach x of local tpar {
	if strpos(`"`Q'"',"`x'")>0 {
		local ++npar
		local Q = subinstr(`"`Q'"',"{`x'}","b[1,`npar']",.)
		local lpar = "`lpar' `x'"
		}
	}
local 3 = `"`Q'"'
local c 0
while strpos(`"`3'"',"_(")>0 {
	local ++c
	local groups = "`groups'" + " " + substr(`"`3'"',strpos(`"`3'"',"_(")+2,strpos(`"`3'"',")_")-strpos(`"`3'"',"_(")-2)
	local 3 = substr(`"`3'"',strpos(`"`3'"',")_")+2,.)
	}
local Q = subinstr(`"`Q'"',"_(","(",.)
local Q = subinstr(`"`Q'"',")_",")",.)
tempvar l r loss aic bic
tempname p b V
cap rename p `p'
cap matrix `b' = b
qui gen double `l' = .
qui gen double `r' = .
mat b = J(1,`npar',0)
scalar p = .5
qui replace `r' = `1' - `Q'
qui replace `touse' = `touse'*(`r'!=.)
qui count if `touse'
local nobs = r(N)
if "`initial'"=="" {
	local initial J(1,`npar',0)
	}
	else {
	local initial (`initial')
	}
if "`qpoints'"!="" {
	local a1 = "("+subinstr("`qpoints'"," ",",",.)+")"
	}
    else {
    local a1 = "(1..`npoints'):/(`npoints'+1)"
    }
if "`log'"=="" {
	local qui qui
	}
mata: mata clear
mata: S = optimize_init()
mata: optimize_init_evaluator(S,&iqf())
mata: optimize_init_which(S,"min")
mata: optimize_init_evaluatortype(S,"gf0")
mata: optimize_init_params(S,`initial')
mata: optimize_init_argument(S,1,`a1')
mata: optimize_init_argument(S,2,"`l'")
mata: optimize_init_argument(S,3,`nobs')
if ("`cluster'"!="") {
	mata: optimize_init_cluster(S, "`cluster'")
	}
`qui' mata: st_matrix("b",optimize(S))
mata: st_matrix("`V'",optimize_result_V_robust(S))
mata: st_numscalar("`loss'",optimize_result_value(S))
scalar `aic' = log(`loss') + 2*`npar'
scalar `bic' = log(`loss') + `npar'*log(`nobs')
if c(version)<14 {
	local lpar = subinstr("`lpar'",":","_",.)
	}
mat colnames b = `lpar'
mat colnames `V' = `lpar'
mat rownames `V' = `lpar'
ereturn post b `V', obs(`nobs') depname(`1') esample(`touse')
ereturn scalar loss = `loss'
ereturn scalar aic = `aic'
ereturn scalar bic = `bic'
ereturn local Q `"`Qc'"'
ereturn local Q_b `"`Q'"'
ereturn local groups `groups'
ereturn local predict "qmodel_predict"
ereturn local cmd "qmodel"
ereturn local cmdline `"`0'"'
di _n as txt "Parametric Quantile Model" _col(52) as txt "Number of obs =" as res %12.0gc e(N)
di _col(62) as txt "AIC =   " as res %9.0g `aic'
di as txt "Loss function =" as res %12.0g `loss' _col(62) as txt "BIC =   " as res %9.0g `bic'
ereturn display
cap rename `p' p
cap mat b = `b'
}
end
mata
void iqf(todo, b, a1, a2, a3, l, g, H)
	{
	st_matrix("b",b)
	stata("qui replace `"+"l' = 0")
	for (i=1; i<=length(a1); i++) {
		st_numscalar("p",a1[i])
		stata("qui replace `"+"r' = `"+"Q'-(`"+"1') if `"+"touse'")
		stata("qui replace `"+"l' = `"+"l'-(p-invlogit(`"+"r'*50))*`"+"r' if `"+"touse'")
		}
	l = st_data(.,a2)/length(a1)
	}
end
