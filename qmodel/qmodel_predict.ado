*! version 1.0 21dec2018

program qmodel_predict, sortpreserve
syntax newvarlist, Proportion(varname) [ SE ]
if "`e(cmd)'"!="qmodel" error 301
if "`proportion'"!="p" {
	cap gen p = `proportion'
	if _rc!=0 {
		local rp 1
		tempvar p
		cap rename p `p'
		gen p = `proportion'
		}
	}
qui sum p, meanonly
if r(min)<0 | r(max)>1 {
	di as err "The proportion variable, `proportion', must be between 0 and 1."
	exit
	}
if "`=e(groups)'"=="." {
	local groups = e(Q_b)
	}
	else {
	local groups = e(groups)
	}
tempname b
cap mat `b' = b
mat b = e(b)
local c 0
foreach x of local varlist {
	local ++c
	if "`x'"=="p" {
		tempvar v
		local x `v'
		}
	if "`se'"=="" {
		qui gen `x' = `: word `c' of `groups''
		}
	else {
		sort p, stable
		qui count if p!=.
		local pobs = r(N)
		local expr : word `c' of `groups'
		local colnames : colfullnames e(b)
		local d 0
		foreach v of local colnames {
			local ++d
			local expr = subinstr("`expr'","b[1,`d']","_b[`v']",.)
			}
		tempvar t
		tempname m
		qui gen `t' = p
		qui gen `x' = .
		forvalues i = 1/`pobs' {
			qui replace p = `t'[`i']
			qui nlcom `expr'
			mat `m' = r(V)
			qui replace `x' = sqrt(`m'[1,1]) in `i'
			}
		qui replace p = `t'
		}
	}
cap mat b = `b'
if "`proportion'"!="p" {
drop p
	if "`rp'"=="1" {
		rename `p' p
		}
	}
if "`v'"!="" {
	rename `v' p
	}
end
