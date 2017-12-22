
qsurvey
=======

[![Build Status](https://travis-ci.org/jamesdunham/qsurvey.svg?branch=master)](https://travis-ci.org/jamesdunham/qsurvey) [![CRAN Status Badge](https://www.r-pkg.org/badges/version/qsurvey)](https://cran.r-project.org/package=qsurvey) [![codecov](https://codecov.io/github/jamesdunham/qsurvey/branch/master/graphs/badge.svg)](https://codecov.io/github/jamesdunham/qsurvey)

qsurvey is a toolkit for working with the Qualtrics survey platform and its data in R. It focuses on testing and review of surveys before fielding, and analysis of responses afterward.

Status
------

Maintained, but not under development. Use the [qualtrics](https://github.com/cloudyr/qualtrics) package, which combines qsurvey, [qualtRics](https://github.com/JasperHG90/qualtRics), and [qualtricsR](https://github.com/saberry/qualtricsR).

Installation
------------

Install the latest version from GitHub:

``` r
# install.packages("devtools")
devtools::install_github("jamesdunham/qsurvey")
```

Usage
-----

``` r
library(qsurvey)
```

A [Qualtrics API key](https://www.qualtrics.com/support/integrations/api-integration/api-integration) is needed to communicate with the survey platform. Set the environment variable `QUALTRICS_KEY` to your key value. You can do this [during R startup](https://www.rdocumentation.org/packages/base/versions/3.3.1/topics/Startup) (recommended), interactively with [`Sys.setenv()`](https://www.rdocumentation.org/packages/base/versions/3.3.1/topics/Sys.setenv), or through `key_from_file()`.

Qualtrics assigns each survey a unique id. You can search by survey name for an id using `find_id()`. Use `surveys()` to see the ids and other metadata for all surveys, in a table similar to the Qualtrics Control Panel overview.

### Survey responses

Pass a survey's id to `responses()` to retrieve responses. This is equivalent to using the "Export Data" tool in the "Data and Analysis" view of the Control Panel and then reading the resulting file into R.

``` r
r <- responses(id = "SV_0CGgkDZJaUvxnGl", verbose = FALSE)
```

For functions that work with survey responses see `names_to_ids()` and `drop_meta()`.

### Survey design

To retrieve a survey's design use `design()`. This returns a `qualtrics_design` object that many other qsurvey functions can operate on.

``` r
d <- design(id = "SV_0CGgkDZJaUvxnGl")

print(d)
#> # A qualtrics_design:
#> name               Student Feedback     
#> id                 SV_0CGgkDZJaUvxnGl   
#> created            2016-11-24           
#> modified           2016-11-24           
#> responses          0 (closed)           
#> questions          26                   
#> blocks             3
```

For example, use `questions()` to see the text and other attributes of each survey question.

``` r
svy_q <- questions(design_object = d)

svy_q[1:2, ]  
#>    question_order  question_id export_name
#> 1:              1 QID132224516          Q1
#> 2:              2 QID132224536          Q3
#>                                                       question_text
#> 1: Overall, how satisfied or dissatisfied were you with this class?
#> 2:                                  How interesting was this class?
```

See also `choices()`, `blocks()`, and `response_counts()`.

### Visualization

Visualize a survey flow with `plot_flow()`. Or for interactive review of a survey's flow and content in a Shiny app, use `render_flow()`.

``` r
plot_flow(design_object = d)
#> PhantomJS not found. You can install it with webshot::install_phantomjs(). If it is installed, please make sure the phantomjs executable can be found via the PATH variable.
```

<!--html_preserve-->

<script type="application/json" data-for="htmlwidget-2096dd7590f4c6777485">{"x":{"nodes":{"id":[2,3,1],"parent_id":[0,0,0],"type":["Block","Block","Block"],"label":["Teacher Evaluation","Student Performance","Class Evaluation"],"block_id":["BL_0wUDDTxrMh9vOAd","BL_6FK8SIrVsXuBxFX","BL_agzU0yMolbPdFGd"],"color":["#d9d9d9","#d9d9d9","#d9d9d9"]},"edges":{"from":[0,1,2],"to":[1,2,3],"type":["deterministic","deterministic","deterministic"],"color":["#000000","#000000","#000000"]},"nodesToDataframe":true,"edgesToDataframe":true,"options":{"width":"100%","height":"100%","nodes":{"shape":"dot"},"manipulation":{"enabled":false},"interaction":{"dragNodes":false,"dragView":false,"zoomView":false},"edges":{"arrows":"to"},"layout":{"hierarchical":{"enabled":true,"direction":"LR","sortMethod":"directed"}}},"groups":null,"width":null,"height":null,"idselection":{"enabled":false},"byselection":{"enabled":false},"main":null,"submain":null,"footer":null,"background":"rgba(0, 0, 0, 0)","tooltipStay":300,"tooltipStyle":"position: fixed;visibility:hidden;padding: 5px;white-space: nowrap;font-family: verdana;font-size:14px;font-color:#000000;background-color: #f5f4ed;-moz-border-radius: 3px;-webkit-border-radius: 3px;border-radius: 3px;border: 1px solid #808074;box-shadow: 3px 3px 10px rgba(0, 0, 0, 0.2);"},"evals":[],"jsHooks":[]}</script>
<!--/html_preserve-->
See also `edges()` and `nodes()`.

Related
-------

-   [qualtRics](https://github.com/JasperHG90/qualtRics) is another R package for working with the Qualtrics API that began around the same time as qsurvey.

-   [qualtricsR](https://github.com/saberry/qualtricsR) focuses on survey creation.

-   I'm aware of two R packages for earlier versions of the Qualtrics API. [Jason Bryer](https://github.com/jbryer/qualtrics) wrote one in 2012. [Eric Green](https://github.com/ericpgreen/qualtrics) forked and revised it for v2.3 of the Qualtrics API, most recently in 2014.

-   [QualtricsTools](https://github.com/ctesta01/QualtricsTools) generates reports from Qualtrics data via Shiny.

-   Python: [PyQualtrics](https://github.com/Baguage/pyqualtrics); [SurveyHelper](https://github.com/cwade/surveyhelper).
