*! version 1.0 21dec2018

program qmodel_plot
syntax , [ CI REPLACE ADDPLOT(string) * ]
if "`e(cmd)'"!="qmodel" error 301
preserve
tempvar p q s l u
tempname b m
cap rename p `p'
cap mat `b' = b
mat b = e(b)
if `=_N'<99 {
	local obs = `=_N'
	qui set obs 99
	}
if "`=e(groups)'"=="." {
	local groups = e(Q_b)
	}
	else {
	local groups = e(groups)
	}
local c 0
foreach x of local groups {
	local ++c
	local v = cond(`:word count `groups''==1,"",`"name(qmodel`c', `replace')"')
	if "`ci'"=="" {
		qui gen p = _n/100 in 1/99
		qui gen `q' = `x'
		line `q' p, sort xtitle("p") ytitle("") `v' `options' || `addplot'
		drop p `q'
		}
	else {
		local colnames : colfullnames e(b)
		local d 0
		local expr = "`x'"
		foreach i of local colnames {
			local ++d
			local expr = subinstr("`expr'","b[1,`d']","_b[`i']",.)
			}
		qui gen `q' = .
		qui gen `s' = .
		forvalues i = 1/99 {
			gen p = `i'/100
			qui nlcom `expr'
			mat `m' = r(b)
			qui replace `q' = `m'[1,1] in `i'
			mat `m' = r(V)
			qui replace `s' = sqrt(`m'[1,1]) in `i'
			drop p
			}
		qui gen p = _n/100 in 1/99
		qui gen `l' = `q' + invnormal(.025)*`s'
		qui gen `u' = `q' + invnormal(.975)*`s'
		tw rarea `l' `u' p, fc(gs12) lc(gs12) || line `q' p, lc(gs4) legend(off) xtitle("p") ytitle("") `v' `options' || `addplot'
		drop p `q' `s' `l' `u'
		}
	}
if "`obs'"!="" {
	drop if _n>`obs'
	}
cap rename `p' p
cap mat b = `b'
restore
end
