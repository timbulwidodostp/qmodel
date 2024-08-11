{smcl}
{* *! version 1.0 21dec2018}{...}
{cmd:help qmodel postestimation}{right: ({browse "https://doi.org/10.1177/1536867X19854002":SJ19-2: st0555})}
{hline}

{title:Title}
{p2colset 5 30 30 2}
{p2col:{hi:qmodel postestimation} {hline 2}}Postestimation tools for qmodel{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Postestimation commands}

{pstd}
The following postestimation commands can be used after {helpb qmodel}.

{synoptset 16}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
{synopt :{helpb qmodel postestimation##predict:predict}}predict specified functions of the parameters{p_end}
{synopt :{helpb qmodel postestimation##qmodel_plot:qmodel_plot}}plot specified functions of the parameters{p_end}
{synopt :{helpb qmodel postestimation##qmodel_quantile:qmodel_quantile}}estimate specific quantiles and their standard errors{p_end}
{synoptline}
{p2colreset}{...}


{marker predict}{...}
{title:Syntax for predict} 

{p 8 17 2}
{cmd:predict} {it:{help newvarlist}}{cmd:,}
{cmdab:p:roportion(}{it:varname}{cmd:)} [{it:predict_options}]

{synoptset 20 tabbed}{...}
{marker predict_options}{...}
{synopthdr:predict_options}
{synoptline}
{p2coldent :* {opt p:roportion(varname)}}name of an existing variable containing
proportions{p_end}
{synopt:{opt se}}standard error of the prediction{p_end}
{synoptline}
{pstd}
* {cmd:proportion()} is required.


{title:Description for predict}

{pstd}
The {cmd:predict} command predicts specified functions of parameters at the
proportions stored in the existing variable specified in
{cmd:proportion(}{it:varname}{cmd:)}.  The functions of parameters to be
predicted are specified in {it:quantile_function} of {cmd:qmodel} using the
special symbols {cmd:_(} and {cmd:)_} or, equivalently, {cmd:_[} and {cmd:]_}.
Standard errors of the predicted quantiles can be obtained with the {opt se}
option.{p_end}


{marker qmodel_plot}{...}
{title:Syntax for qmodel_plot}

{p 8 17 2}
{cmd:qmodel_plot} [{cmd:,} {it:{help qmodel_postestimation##plot_options:plot_options}}]
{p_end}

{synoptset 25}{...}
{marker plot_options}{...}
{synopthdr:plot_options}
{synoptline}
{synopt:{opt ci}}show confidence intervals of the quantiles{p_end}
{synopt:{opt replace}}replace previous graph{p_end}
{synopt:{opt addplot(string)}}add other plots to the generated graph{p_end}
{synopt:{it:{help twoway_options}}}specify standard options of twoway graphs{p_end}
{synoptline}


{title:Description for qmodel_plot}

{pstd}
The {cmd:qmodel_plot} command plots specified functions of the parameters
against the proportion.  The functions of parameters to be predicted are
specified in {it:quantile_function} of {cmd:qmodel} using the special symbols
{cmd:_(} and {cmd:)_} or, equivalently, {cmd:_[} and {cmd:]_}.{p_end}


{marker qmodel_quantile}{...}
{title:Syntax for qmodel_quantile}

{p 8 17 2}
{cmd:qmodel_quantile} {it:{help numlist}} [{cmd:,} {it:{help qmodel_postestimation##quantile_options:quantile_options}}]
{p_end}

{p2colreset}{...}
{synoptset 25}{...}
{marker quantile_options}{...}
{synopthdr:quantile_options}
{synoptline}
{synopt:{cmd:at(}{it:varname} {cmd:=} {it:#} [...]{cmd:)}}specify the values of the covariates at which the quantiles are to be estimated{p_end}
{synopt:{it:{help nlcom:nlcom_options}}}specify standard {cmd:nlcom} options{p_end}
{synoptline}
{p2colreset}{...}


{title:Description for qmodel_quantile}

{pstd}
The {cmd:qmodel_quantile} command computes point estimates, standard errors,
test statistics, significance levels, and confidence intervals for the
quantile of {it:exp_varname} in {cmd:qmodel} at the proportions specified in
{it:{help numlist}}.  The default is the median.


{title:Examples}

{phang2}{bf:. {stata "set obs 1000"}}{p_end}
{phang2}{bf:. {stata "generate y = rnormal()"}}{p_end}
{phang2}{bf:. {stata "qmodel y = _normal"}}{p_end}
{phang2}{bf:. {stata "qmodel_plot"}}{p_end}
{phang2}{bf:. {stata "range proportion .01 .99 99"}}{p_end}
{phang2}{bf:. {stata "predict quantile, p(proportion)"}}{p_end}
{phang2}{bf:. {stata "histogram y, fcolor(gs10) lcolor(gs16) frequency name(a, replace)"}}{p_end}
{phang2}{bf:. {stata `"twoway function invnormal(x) || line quantile p, lcolor(red) xtitle("p") name(b, replace)"'}}{p_end}
{phang2}{bf:. {stata "graph combine a b"}}{p_end}
{phang2}{bf:. {stata "qmodel_quantile .5(.1).7"}}{p_end}

{pstd}Predict quantiles{p_end}
{phang2}{bf:. {stata "clear all"}}{p_end}
{phang2}{bf:. {stata "set obs 1000"}}{p_end}
{phang2}{bf:. {stata "generate x1 = rbinomial(1,.5)"}}{p_end}
{phang2}{bf:. {stata "generate x2 = rnormal()"}}{p_end}
{phang2}{bf:. {stata "generate p = runiform()"}}{p_end}
{phang2}{bf:. {stata "generate y = 10 + exp(.5)*invnormal(p) + log(p)*x1 + (1-p)*x2"}}{p_end}
{phang2}{bf:. {stata "qmodel y = _(_normal)_ + _(_log)_*x1 + _(_linear)_*x2"}}{p_end}
{phang2}{bf:. {stata "qmodel_plot, ci"}}{p_end}
{phang2}{bf:. {stata "range proportion .01 .99 99"}}{p_end}
{phang2}{bf:. {stata "predict base beta_x1 beta_x2, p(proportion)"}}{p_end}
{phang2}{bf:. {stata "qmodel_quantile .9, at(x1=0 x2=1.5) noheader"}}{p_end}
 

{title:Authors}

{pstd}Matteo Bottai{p_end}
{pstd}Unit of Biostatistics{p_end}
{pstd}Institute of Environmental Medicine{p_end}
{pstd}Karolinska Institutet{p_end}
{pstd}Stockholm, Sweden{p_end}
{pstd}matteo.bottai@ki.se{p_end}

{pstd}Nicola Orsini{p_end}
{pstd}Biostatistics Team{p_end}
{pstd}Department of Public Health Sciences{p_end}
{pstd}Karolinska Institutet{p_end}
{pstd}Stockholm, Sweden{p_end}
{pstd}nicola.orsini@ki.se{p_end}


{title:Also see}

{p 4 14 2}
Article:  {it:Stata Journal}, volume 19, number 2: {browse "https://doi.org/10.1177/1536867X19854002":st0555}{p_end}
