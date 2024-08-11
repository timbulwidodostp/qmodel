{smcl}
{* *! version 1.0 21dec2018}{...}
{cmd:help qmodel}{right: ({browse "https://doi.org/10.1177/1536867X19854002":SJ19-2: st0555})}
{hline}

{title:Title}

{p2colset 5 15 17 2}{...}
{p2col :{cmd:qmodel} {hline 2}}Parametric quantile models{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 14 2}
{cmd:qmodel} {it:exp_varname} {cmd:=} {it:quantile_function}  
{ifin} 
[{cmd:,} {it:{help qmodel##option_table:options}}]

{synoptset 18}{...}
{marker option_table}{...}
{synopthdr}
{synoptline}
{synopt :{opt cluster(varname)}}cluster variable{p_end}
{synopt :{opt np:oints(integer)}}number of equally spaced points for numeric integration{p_end}
{synopt :{opth qp:oints(numlist)}}list of points for numeric integration{p_end}
{synopt :{opt init:ial(values)}}initial values of the parameters for the optimization algorithm; the values are  separated by commas{p_end}
{synopt :{opt log}}show the iteration log{p_end}
{synoptline}
{p 4 6 2}
{it:exp_varname} is the variable whose quantile function is modeled or an
expression of it such as {opt log(varname)} and {opt logit(varname)}.

{p 4 6 2}
{it:quantile_function} is an expression representing the parametric quantile
model.  It can be any combination of {help qmodel##builtin:built-in functions}, 
{help mlexp##remarks:substitutable expressions}, and
{help math_functions:mathematical functions}.  Its argument is indicated by
the letter {cmd:p}.  For example, the standard exponential quantile function
can be estimated using the built-in function

{phang2}
{cmd:qmodel y = _exponential}

{phang}
or, equivalently, the substitutable expression

{phang2}
{cmd:qmodel y = -log({mean})*log(1-p)}

{phang}
If a variable named or abbreviated as {cmd:p} is included in
{it:quantile_function}, it is interpreted as the order of the quantile, not
the variable.  To include such a variable, you must first rename it.
Similarly, if a covariate is named, or abbreviated, as one of the built-in
functions, it is interpreted as the function, not the covariate.{p_end}

{pstd}  
{help qmodel_postestimation:qmodel postestimation} includes {cmd:predict},
{cmd:qmodel_quantile}, and {cmd:qmodel_plot}.{p_end}


{marker description}{...}
{title:Description}

{pstd}
{cmd:qmodel} fits parametric models for conditional quantile functions given
covariates by minimizing the definite integral between 0 and 1 of the quantile
loss function with respect to the order of the quantile.


{marker options}{...}
{title:Options}

{phang}
{cmd:cluster(}{it:varname}{cmd:)} specifies the cluster variable used in the
cluster-robust sandwich estimator for the standard errors.

{phang}
{cmd:npoints(}{it:{help datatype:integer}}{cmd:)} specifies the number of
equally spaced internal points for the numerical integration.  The default is
{cmd:npoints(99)}, which results in the following set of points: 0.01, 0.02,
..., 0.99.

{phang}
{cmd:qpoints(}{it:{help numlist}}{cmd:)} specifies a list of points for the
numerical integration.  For example, {cmd:qpoints(.05 .1(.1).9 .95)}.  If both
{cmd:qpoints()} and {cmd:npoints()} are specified, {cmd:npoints()} is ignored.

{phang}
{cmd:initial(}{it:string}{cmd:)} specifies the initial values of the
parameters for the optimization algorithm.  The values are separated by
commas.  The default is a vector of zeros.  The initial values correspond to
the parameters in the order they appear in the quantile model expression
{it:quantile_function}.  For example, {cmd:initial(10, 0, -1)}.

{phang}
{cmd:log} shows the iteration log.


{marker  builtin}{...}
{title:Built-in functions}

{p 4 8 2}
{opt _alogistic}{break}
Description: asymmetric logistic quantile function{break}
Expression: {cmd:(exp({alogistic:log(a)})*log(p)-exp({alogistic:log(b)})*log(1-p))}

{p 4 8 2}
{opt _beta}{break}
Description: beta quantile function{break}
Expression: {cmd:invibeta(exp({beta:log(a)}),exp({beta:log(b)}),p)}

{p 4 8 2}
{opt _chi2}{break}
Alias: {cmd:_chi-square}{break}
Description: chi-square quantile function{break}
Expression: {cmd:invchi2(exp({chi2:log(df)}),p)}

{p 4 8 2}
{opt _clog}{break}
Description: complementary log term{break}
Expression: {cmd:({clog:log(1-p)}*log(1-p))}

{p 4 8 2}
{opt _cnormal}{break}
Description: centered normal quantile function{break}
Expression: {cmd:(exp({cnormal:log(sd)})*invnormal(p))}

{p 4 8 2}
{opt _cubic}{break}
Alias: {cmd:_poly3}{break}
Description: centered cubic polynomial{break}
Expression:
{cmd:({cubic:constant}+{cubic:p}*(p-.5)+{cubic:p^2}*(p-.5)^2+{cubic:p^3}*(p-.5)^3)}

{p 4 8 2}
{opt _cp3}{break}
Description: centered cubic term{break}
Expression: {cmd:({cp3:(p-.5)^3}*(p-.5)^3)}
 
{p 4 8 2}
{opt _cp2}{break}
Description: centered quadratic term{break}
Expression: {cmd:({cp2:(p-.5)^2}*(p-.5)^2)}

{p 4 8 2}
{opt _cp}{break}
Description: centered linear term{break}
Expression: {cmd:({cp:p-.5}*(p-.5))}

{p 4 8 2}
{opt _exponential}{break}
Description: exponential quantile function{break}
Expression: {cmd:(-exp({exponential:log(mean)})*log(1-p))}

{p 4 8 2}
{opt _flat}{break}
Alias: {cmd:_cons}, {cmd:_poly0}{break}
Description: flat quantile function{break}
Expression: {cmd:({flat:constant})}

{p 4 8 2}
{opt _gamma}{break}
Description: gamma quantile function{break}
Expression: {cmd:(exp({gamma:log(scale)})*invgammap(exp({gamma:log(shape)}),p))}

{p 4 8 2}
{opt _lognormal}{break}
Description: log-normal quantile function{break}
Expression: {cmd:(exp({lognormal:mean}+exp({lognormal:log(sd)})*invnormal(p)))}

{p 4 8 2}
{opt _logitnormal}{break}
Description: logit-normal quantile function{break}
Expression: {cmd:invlogit({logitnormal:mean}+exp({logitnormal:log(sd)})*invnormal(p))}

{p 4 8 2}
{opt _linear}{break}
Alias: {cmd:_uniform}, {cmd:poly1}{break}
Description: centered linear (uniform) quantile function{break}
Expression: {cmd:({linear:constant}+{linear:p}*(p-.5))}

{p 4 8 2}
{opt _log}{break}
Description: log term{break}
Expression: {cmd:({log:log(p)}*log(p))}

{p 4 8 2}
{opt _normal}{break}
Description: normal quantile function{break}
Expression: {cmd:({normal:mean}+exp({normal:log(sd)})*invnormal(p))}

{p 4 8 2}
{opt _p3}{break}
Alias: {cmd:_p-cubed}{break}
Description: cubic term{break}
Expression: {cmd:{p3:p^3}*p^3}

{p 4 8 2}
{opt _p2}{break}
Alias: {cmd:_p-squared}{break}
Description: quadratic term{break}
Expression: {cmd:{p2:p^2}*p^2}

{p 4 8 2}
{opt _p}{break}
Description: linear term{break}
Expression: {cmd:{p:p}*p}

{p 4 8 2}
{opt _quadratic}{break}
Alias: {cmd:_poly2}{break}
Description: centered quadratic polynomial{break}
Expression:
{cmd:({quadratic:constant}+{quadratic:p}*(p-.5)+{quadratic:p^2}*(p-.5)^2)}

{p 4 8 2}
{opt _root2}{break}
Alias: {cmd:_sqrt}{break}
Description: square root term{break}
Expression: {cmd:({root2:p^(1/2)}*p^.5)}

{p 4 8 2}
{opt _root3}{break}
Description: cubic root term{break}
Expression: {cmd:({root3:p^(1/3)}*p^(1/3))}

{p 4 8 2}
{cmd:_spline}{it:D}{cmd:_}{it:K}{break}
Description: spline of order {it:D} with {it:K} equally-spaced internal knots between 0 and 1{break}
Expression for linear splines with one knot:
{cmd:{spline:constant}+{spline:p}*p^1+{spline:spline^1_1}*(p-1/2)^1*(p>(1/2))}

{p 4 8 2}
{cmd:_weibull}{break}
Description: Weibull quantile function{break}
Expression:
{cmd:(exp({weibull:log(mean)})*(-log(1-p))^exp(-{weibull:log(shape)}))}


{marker results}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{bf:. net install quaids, from("https://raw.githubusercontent.com/timbulwidodostp/qmodel/main/qmodel") replace}{p_end}
{phang2}{bf:. import excel "https://raw.githubusercontent.com/timbulwidodostp/qmodel/main/qmodel/qmodel.xlsx", sheet("Sheet1") firstrow clear}{p_end}

{pstd}Normal quantile function{p_end}
{phang2}{bf:. {stata "qmodel y1 = _normal"}}{p_end}

{pstd}Normal quantile function by using substitutable expressions{p_end}
{phang2}{bf:. {stata "qmodel y1 = {mean} + exp({log(sd)})*invnormal(p)"}}{p_end}

{pstd}Log-normal quantile function using three alternative model expressions{p_end}
{phang2}{bf:. {stata "qmodel y2 = _lognormal"}}{p_end}
{phang2}{bf:. {stata "qmodel y2 = exp(_normal)"}}{p_end}
{phang2}{bf:. {stata "qmodel log(y2) = _normal"}}{p_end}

{pstd}Logit-normal quantile function using three alternative model expressions{p_end}
{phang2}{bf:. {stata "qmodel y3 = _logitnormal"}}{p_end}
{phang2}{bf:. {stata "qmodel y3 = invlogit(_normal)"}}{p_end}
{phang2}{bf:. {stata "qmodel logit(y3) = _normal"}}{p_end}

{pstd}Mixtures for modeling skewness and kurtosis{p_end}
{phang2}{bf:. {stata "qmodel y4 = _normal + _exponential"}}{p_end}

{pstd}Modeling conditional parametric quantile functions{p_end}
{phang2}{bf:. {stata "qmodel y5 =  _normal + _flat*x1 + _flat*x2"}}{p_end}

{title:Stored results}

{pstd}
{cmd:qmodel} stores the following in {cmd:e()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:e(N)}}number of observations{p_end}
{synopt:{cmd:e(bic)}}Bayesian information criterion{p_end}
{synopt:{cmd:e(aic)}}Akaike's information criterion{p_end}
{synopt:{cmd:e(loss)}}loss function{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:e(cmd)}}{cmd:qmodel}{p_end}
{synopt:{cmd:e(cmdline)}}command as typed{p_end}
{synopt:{cmd:e(Q_b)}}quantile model for Mata{p_end}
{synopt:{cmd:e(Q)}}quantile model with substitutable expressions{p_end}
{synopt:{cmd:e(properties)}}{cmd:b V}{p_end}
{synopt:{cmd:e(predict)}}program used to implement {cmd:predict}{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Matrices}{p_end}
{synopt:{cmd:e(b)}}coefficient vector{p_end}
{synopt:{cmd:e(V)}}variance-covariance matrix of the estimators{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Functions}{p_end}
{synopt:{cmd:e(sample)}}marks estimation sample{p_end}


{title:Authors}

{pstd}Matteo Bottai{p_end}
{pstd}Division of Biostatistics{p_end}
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
