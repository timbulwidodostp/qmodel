*! version 1.0 21dec2018

program qmodel_quantile, rclass
syntax [anything] [, at(string) *]
if "`e(cmd)'"!="qmodel" error 301
preserve
tempname b V
local expr = e(Q_b)
local colnames : colfullnames e(b)
local c 0
foreach x of local colnames {
	local ++c
	local expr = subinstr("`expr'","b[1,`c']","_b[`x']",.)
	}
if "`anything'"=="" {
	local anything .5
	}
while strpos(`"`at'"'," =")>0 | strpos(`"`at'"',"= ")>0 {
	local at = subinstr(`"`at'"'," =","=",.)
	local at = subinstr(`"`at'"',"= ","=",.)
	}
local t = `"`at'"'
while `"`t'"'!="" {
	gettoken x t : t
	qui replace `x'
	}
cap gen p = .
mat `b' = 0
mat `V' = 0
foreach y of num `anything' {
	if `y'<0 | `y'>1 {
		di as txt "The proportion, `y', must be between 0 and 1."
		continue
		}
	qui replace p = `y'
	di as txt _n "Quantile p=" as res "`y'" _c
	if "`at'"!="" {
		di as txt " at " as res "`at'" _c
		}
	nlcom quantile:`expr', `options'
	mat `b' = `b' \ r(b)
	mat `V' = `V' \ r(V)
	}
mat `b' = `b'[2..rowsof(`b'),1]
mat `V' = `V'[2..rowsof(`V'),1]
return matrix b = `b'
return matrix V = `V'
restore
end
