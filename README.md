
qsurvey
=======

qsurvey is a toolkit for working with the Qualtrics survey platform and its data in R. It focuses on testing and review of surveys before fielding, and analysis of responses afterward.

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

### Survey design

To retrieve a survey's design use `design()`. This returns a `qualtrics_design` object that many other qsurvey functions can operate on.

``` r
d <- design(id = "SV_0CGgkDZJaUvxnGl")

print(d)
#> name:        Student Feedback
#> id:          SV_0CGgkDZJaUvxnGl
#> created:     2016-11-24
#> modified:    2016-11-24
#> responses:   0 (closed)
#> questions:   26
#> blocks:      3
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

### Visualization

Visualize a survey flow with `plot_flow()`. Or for interactive review of a survey's flow and content in a Shiny app, use `render_flow()`.

``` r
plot_flow(design_object = d)
```

<!--html_preserve-->

<script type="application/json" data-for="htmlwidget-8939141b4e203823afa9">{"x":{"nodes":{"id":[2,3,1],"parent_id":[0,0,0],"type":["Block","Block","Block"],"label":["Teacher Evaluation","Student Performance","Class Evaluation"],"block_id":["BL_0wUDDTxrMh9vOAd","BL_6FK8SIrVsXuBxFX","BL_agzU0yMolbPdFGd"],"color":["#d9d9d9","#d9d9d9","#d9d9d9"]},"edges":{"from":[0,1,2],"to":[1,2,3],"type":["deterministic","deterministic","deterministic"],"color":["#000000","#000000","#000000"]},"options":{"width":"100%","height":"100%","nodes":{"shape":"dot"},"manipulation":{"enabled":false},"interaction":{"dragNodes":false,"dragView":false,"zoomView":false},"edges":{"arrows":"to"},"layout":{"hierarchical":{"enabled":true,"direction":"LR","sortMethod":"directed"}}},"groups":null,"width":null,"height":null,"idselection":{"enabled":false},"byselection":{"enabled":false},"main":null,"submain":null,"footer":null},"evals":[],"jsHooks":[]}</script>
<!--/html_preserve-->
Related
-------

-   [qualtRics](https://github.com/JasperHG90/qualtRics) is another R package for working with the Qualtrics API that began around the same time as qsurvey.

-   [qualtricsR](https://github.com/saberry/qualtricsR) focuses on survey creation.

-   I'm aware of two R packages for earlier versions of the Qualtrics API. [Jason Bryer](https://github.com/jbryer/qualtrics) wrote one in 2012. [Eric Green](https://github.com/ericpgreen/qualtrics) forked and revised it for v2.3 of the Qualtrics API, most recently in 2014.

-   [QualtricsTools](https://github.com/ctesta01/QualtricsTools) generates reports from Qualtrics data via Shiny.

-   Python: [PyQualtrics](https://github.com/Baguage/pyqualtrics); [SurveyHelper](https://github.com/cwade/surveyhelper).
