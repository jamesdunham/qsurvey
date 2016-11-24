
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

A [Qualtrics API key](https://www.qualtrics.com/support/integrations/api-integration/api-integration) is needed to communicate with the survey platform. Set the environment variable `QUALTRICS_KEY` to your key value. You can do this [during R startup](https://www.rdocumentation.org/packages/base/versions/3.3.1/topics/Startup?) (recommended), interactively with [`Sys.setenv()`](https://www.rdocumentation.org/packages/base/versions/3.3.1/topics/Sys.setenv), or through `key_from_file()`.

Qualtrics assigns each survey a unique id. You can search by survey name for an id using `find_id()`. Use `surveys()` to see the ids and other metadata for all surveys, in a table similar to the Qualtrics Control Panel overview.

``` r
find_id(pattern = "test")
#> ..
#>                 test 
#> "SV_cuxfjYWRTB30ouh"
```

### Survey responses

Pass a survey's id to `responses()` to retrieve responses. This is equivalent to using the "Export Data" tool in the "Data and Analysis" view of the Control Panel and then reading the resulting file into R.

``` r
r = responses(id = "SV_cuxfjYWRTB30ouh", verbose = FALSE)
```

The responses vignette demonstrates qsurvey tools for working with survey responses.

### Survey design

To retrieve a survey's design use `design()`. This returns a `qualtrics_design` object that many other qsurvey functions operate on.

``` r
d = design(id = "SV_cuxfjYWRTB30ouh")

print(d)
#> name:        test
#> id:          SV_cuxfjYWRTB30ouh
#> created:     2016-10-19
#> modified:    2016-11-18
#> responses:   0 (closed)
#> questions:   10
#> blocks:      6
```

For example, use `questions()` to see the text and other attributes of each survey question.

``` r
svy_q = questions(design = d)

svy_q[1:2, c(1, 3)]  # subset for briefer output
#>    question_id                           questionText
#> 1:        QID1 This is the question text for mc_sa_1.
#> 2:        QID2 This is the question text for mc_sa_2.
```

### Visualization

Visualize a survey flow with `plot_flow()`. Or for interactive review of a survey's flow and content in a Shiny app, use `render_survey()`. The vignette on visualization demonstrates.

``` r
plot_flow(design = d)
```

<!--html_preserve-->

<script type="application/json" data-for="htmlwidget-14d5992801777f4abbc5">{"x":{"nodes":{"id":[2,3,7,8,9,5,11,12,6,10,13,1,4],"parent_id":[0,0,0,1,1,0,3,4,0,2,4,0,0],"type":["Branch","Branch","EndSurvey","EmbeddedData","EmbeddedData","Block","Block","Block","Block","Block","Block","BlockRandomizer","BlockRandomizer"],"label":["Branch","Branch","End","Set Data","Set Data","Display Logic","Matrix Table","Randomized Block A","Slider","Multiple Choice, Single Answer","Randomized Block B","Randomize: 1 of 2 (evenly)","Randomize: 1 of 2 (evenly)"],"color":["#fc9272","#fc9272","#fef4ab","#a3c4cd","#a3c4cd","#d9d9d9","#d9d9d9","#d9d9d9","#d9d9d9","#d9d9d9","#d9d9d9","#fc9272","#fc9272"]},"edges":{"from":[0,1,2,3,4,5,6,1,1,2,3,4,4],"to":[1,2,3,4,5,6,7,8,9,10,11,12,13],"type":["deterministic","deterministic","deterministic","deterministic","deterministic","deterministic","deterministic","random","random","conditional","conditional","random","random"],"color":["#000000","#000000","#000000","#000000","#000000","#000000","#000000","orange","orange","orange","orange","orange","orange"]},"options":{"width":"100%","height":"100%","nodes":{"shape":"dot"},"manipulation":{"enabled":false},"interaction":{"dragNodes":false,"dragView":false,"zoomView":false},"edges":{"arrows":"to"},"layout":{"hierarchical":{"enabled":true,"direction":"LR","sortMethod":"directed"}}},"groups":null,"width":null,"height":null,"idselection":{"enabled":false},"byselection":{"enabled":false},"main":null,"submain":null,"footer":null},"evals":[],"jsHooks":[]}</script>
<!--/html_preserve-->
