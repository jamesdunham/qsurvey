
qsurvey
=======

[![Build Status](https://travis-ci.org/jamesdunham/qsurvey.svg?branch=master)](https://travis-ci.org/jamesdunham/qsurvey)

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
#> $id
#> [1] "SV_0CGgkDZJaUvxnGl"
#> 
#> $name
#> [1] "Student Feedback"
#> 
#> $ownerId
#> [1] "UR_8J1114L8aAeMCPP"
#> 
#> $organizationId
#> [1] "mit"
#> 
#> $isActive
#> [1] FALSE
#> 
#> $creationDate
#> [1] "2016-11-24T03:35:27Z"
#> 
#> $lastModifiedDate
#> [1] "2016-11-24T03:36:38Z"
#> 
#> $expiration
#> $expiration$startDate
#> NULL
#> 
#> $expiration$endDate
#> NULL
#> 
#> 
#> $questions
#> $questions$QID132224516
#> $questions$QID132224516$questionType
#> $questions$QID132224516$questionType$type
#> [1] "MC"
#> 
#> $questions$QID132224516$questionType$selector
#> [1] "SAVR"
#> 
#> $questions$QID132224516$questionType$subSelector
#> [1] "TX"
#> 
#> 
#> $questions$QID132224516$questionText
#> [1] "Overall, how satisfied or dissatisfied were you with this class?"
#> 
#> $questions$QID132224516$questionLabel
#> NULL
#> 
#> $questions$QID132224516$validation
#> $questions$QID132224516$validation$doesForceResponse
#> [1] FALSE
#> 
#> 
#> $questions$QID132224516$choices
#> $questions$QID132224516$choices$`1`
#> $questions$QID132224516$choices$`1`$recode
#> [1] "1"
#> 
#> $questions$QID132224516$choices$`1`$description
#> [1] "Extremely satisfied"
#> 
#> $questions$QID132224516$choices$`1`$choiceText
#> [1] "Extremely satisfied"
#> 
#> $questions$QID132224516$choices$`1`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224516$choices$`2`
#> $questions$QID132224516$choices$`2`$recode
#> [1] "2"
#> 
#> $questions$QID132224516$choices$`2`$description
#> [1] "Moderately satisfied"
#> 
#> $questions$QID132224516$choices$`2`$choiceText
#> [1] "Moderately satisfied"
#> 
#> $questions$QID132224516$choices$`2`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224516$choices$`3`
#> $questions$QID132224516$choices$`3`$recode
#> [1] "3"
#> 
#> $questions$QID132224516$choices$`3`$description
#> [1] "Slightly satisfied"
#> 
#> $questions$QID132224516$choices$`3`$choiceText
#> [1] "Slightly satisfied"
#> 
#> $questions$QID132224516$choices$`3`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224516$choices$`4`
#> $questions$QID132224516$choices$`4`$recode
#> [1] "4"
#> 
#> $questions$QID132224516$choices$`4`$description
#> [1] "Neither satisfied nor dissatisfied"
#> 
#> $questions$QID132224516$choices$`4`$choiceText
#> [1] "Neither satisfied nor dissatisfied"
#> 
#> $questions$QID132224516$choices$`4`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224516$choices$`5`
#> $questions$QID132224516$choices$`5`$recode
#> [1] "5"
#> 
#> $questions$QID132224516$choices$`5`$description
#> [1] "Slightly dissatisfied"
#> 
#> $questions$QID132224516$choices$`5`$choiceText
#> [1] "Slightly dissatisfied"
#> 
#> $questions$QID132224516$choices$`5`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224516$choices$`6`
#> $questions$QID132224516$choices$`6`$recode
#> [1] "6"
#> 
#> $questions$QID132224516$choices$`6`$description
#> [1] "Moderately dissatisfied"
#> 
#> $questions$QID132224516$choices$`6`$choiceText
#> [1] "Moderately dissatisfied"
#> 
#> $questions$QID132224516$choices$`6`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224516$choices$`7`
#> $questions$QID132224516$choices$`7`$recode
#> [1] "7"
#> 
#> $questions$QID132224516$choices$`7`$description
#> [1] "Extremely dissatisfied"
#> 
#> $questions$QID132224516$choices$`7`$choiceText
#> [1] "Extremely dissatisfied"
#> 
#> $questions$QID132224516$choices$`7`$variableName
#> NULL
#> 
#> 
#> 
#> 
#> $questions$QID132224536
#> $questions$QID132224536$questionType
#> $questions$QID132224536$questionType$type
#> [1] "MC"
#> 
#> $questions$QID132224536$questionType$selector
#> [1] "SAVR"
#> 
#> $questions$QID132224536$questionType$subSelector
#> [1] "TX"
#> 
#> 
#> $questions$QID132224536$questionText
#> [1] "How interesting was this class?"
#> 
#> $questions$QID132224536$questionLabel
#> NULL
#> 
#> $questions$QID132224536$validation
#> $questions$QID132224536$validation$doesForceResponse
#> [1] FALSE
#> 
#> 
#> $questions$QID132224536$choices
#> $questions$QID132224536$choices$`1`
#> $questions$QID132224536$choices$`1`$recode
#> [1] "1"
#> 
#> $questions$QID132224536$choices$`1`$description
#> [1] "Extremely interesting"
#> 
#> $questions$QID132224536$choices$`1`$choiceText
#> [1] "Extremely interesting"
#> 
#> $questions$QID132224536$choices$`1`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224536$choices$`2`
#> $questions$QID132224536$choices$`2`$recode
#> [1] "2"
#> 
#> $questions$QID132224536$choices$`2`$description
#> [1] "Very interesting"
#> 
#> $questions$QID132224536$choices$`2`$choiceText
#> [1] "Very interesting"
#> 
#> $questions$QID132224536$choices$`2`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224536$choices$`3`
#> $questions$QID132224536$choices$`3`$recode
#> [1] "3"
#> 
#> $questions$QID132224536$choices$`3`$description
#> [1] "Moderately interesting"
#> 
#> $questions$QID132224536$choices$`3`$choiceText
#> [1] "Moderately interesting"
#> 
#> $questions$QID132224536$choices$`3`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224536$choices$`4`
#> $questions$QID132224536$choices$`4`$recode
#> [1] "4"
#> 
#> $questions$QID132224536$choices$`4`$description
#> [1] "Slightly interesting"
#> 
#> $questions$QID132224536$choices$`4`$choiceText
#> [1] "Slightly interesting"
#> 
#> $questions$QID132224536$choices$`4`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224536$choices$`5`
#> $questions$QID132224536$choices$`5`$recode
#> [1] "5"
#> 
#> $questions$QID132224536$choices$`5`$description
#> [1] "Not interesting at all"
#> 
#> $questions$QID132224536$choices$`5`$choiceText
#> [1] "Not interesting at all"
#> 
#> $questions$QID132224536$choices$`5`$variableName
#> NULL
#> 
#> 
#> 
#> 
#> $questions$QID132224537
#> $questions$QID132224537$questionType
#> $questions$QID132224537$questionType$type
#> [1] "MC"
#> 
#> $questions$QID132224537$questionType$selector
#> [1] "SAVR"
#> 
#> $questions$QID132224537$questionType$subSelector
#> [1] "TX"
#> 
#> 
#> $questions$QID132224537$questionText
#> [1] "How challenging was this class?"
#> 
#> $questions$QID132224537$questionLabel
#> NULL
#> 
#> $questions$QID132224537$validation
#> $questions$QID132224537$validation$doesForceResponse
#> [1] FALSE
#> 
#> 
#> $questions$QID132224537$choices
#> $questions$QID132224537$choices$`1`
#> $questions$QID132224537$choices$`1`$recode
#> [1] "1"
#> 
#> $questions$QID132224537$choices$`1`$description
#> [1] "Extremely challenging"
#> 
#> $questions$QID132224537$choices$`1`$choiceText
#> [1] "Extremely challenging"
#> 
#> $questions$QID132224537$choices$`1`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224537$choices$`2`
#> $questions$QID132224537$choices$`2`$recode
#> [1] "2"
#> 
#> $questions$QID132224537$choices$`2`$description
#> [1] "Very challenging"
#> 
#> $questions$QID132224537$choices$`2`$choiceText
#> [1] "Very challenging"
#> 
#> $questions$QID132224537$choices$`2`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224537$choices$`3`
#> $questions$QID132224537$choices$`3`$recode
#> [1] "3"
#> 
#> $questions$QID132224537$choices$`3`$description
#> [1] "Moderately challenging"
#> 
#> $questions$QID132224537$choices$`3`$choiceText
#> [1] "Moderately challenging"
#> 
#> $questions$QID132224537$choices$`3`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224537$choices$`4`
#> $questions$QID132224537$choices$`4`$recode
#> [1] "4"
#> 
#> $questions$QID132224537$choices$`4`$description
#> [1] "Slightly challenging"
#> 
#> $questions$QID132224537$choices$`4`$choiceText
#> [1] "Slightly challenging"
#> 
#> $questions$QID132224537$choices$`4`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224537$choices$`5`
#> $questions$QID132224537$choices$`5`$recode
#> [1] "5"
#> 
#> $questions$QID132224537$choices$`5`$description
#> [1] "Not challenging at all"
#> 
#> $questions$QID132224537$choices$`5`$choiceText
#> [1] "Not challenging at all"
#> 
#> $questions$QID132224537$choices$`5`$variableName
#> NULL
#> 
#> 
#> 
#> 
#> $questions$QID132224526
#> $questions$QID132224526$questionType
#> $questions$QID132224526$questionType$type
#> [1] "MC"
#> 
#> $questions$QID132224526$questionType$selector
#> [1] "SAVR"
#> 
#> $questions$QID132224526$questionType$subSelector
#> [1] "TX"
#> 
#> 
#> $questions$QID132224526$questionText
#> [1] "How fair or unfair was the workload in this class?"
#> 
#> $questions$QID132224526$questionLabel
#> NULL
#> 
#> $questions$QID132224526$validation
#> $questions$QID132224526$validation$doesForceResponse
#> [1] FALSE
#> 
#> 
#> $questions$QID132224526$choices
#> $questions$QID132224526$choices$`1`
#> $questions$QID132224526$choices$`1`$recode
#> [1] "1"
#> 
#> $questions$QID132224526$choices$`1`$description
#> [1] "Extremely fair"
#> 
#> $questions$QID132224526$choices$`1`$choiceText
#> [1] "Extremely fair"
#> 
#> $questions$QID132224526$choices$`1`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224526$choices$`2`
#> $questions$QID132224526$choices$`2`$recode
#> [1] "2"
#> 
#> $questions$QID132224526$choices$`2`$description
#> [1] "Moderately fair"
#> 
#> $questions$QID132224526$choices$`2`$choiceText
#> [1] "Moderately fair"
#> 
#> $questions$QID132224526$choices$`2`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224526$choices$`3`
#> $questions$QID132224526$choices$`3`$recode
#> [1] "3"
#> 
#> $questions$QID132224526$choices$`3`$description
#> [1] "Slightly fair"
#> 
#> $questions$QID132224526$choices$`3`$choiceText
#> [1] "Slightly fair"
#> 
#> $questions$QID132224526$choices$`3`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224526$choices$`4`
#> $questions$QID132224526$choices$`4`$recode
#> [1] "4"
#> 
#> $questions$QID132224526$choices$`4`$description
#> [1] "Neither fair nor unfair"
#> 
#> $questions$QID132224526$choices$`4`$choiceText
#> [1] "Neither fair nor unfair"
#> 
#> $questions$QID132224526$choices$`4`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224526$choices$`5`
#> $questions$QID132224526$choices$`5`$recode
#> [1] "5"
#> 
#> $questions$QID132224526$choices$`5`$description
#> [1] "Slightly unfair"
#> 
#> $questions$QID132224526$choices$`5`$choiceText
#> [1] "Slightly unfair"
#> 
#> $questions$QID132224526$choices$`5`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224526$choices$`6`
#> $questions$QID132224526$choices$`6`$recode
#> [1] "6"
#> 
#> $questions$QID132224526$choices$`6`$description
#> [1] "Moderately unfair"
#> 
#> $questions$QID132224526$choices$`6`$choiceText
#> [1] "Moderately unfair"
#> 
#> $questions$QID132224526$choices$`6`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224526$choices$`7`
#> $questions$QID132224526$choices$`7`$recode
#> [1] "7"
#> 
#> $questions$QID132224526$choices$`7`$description
#> [1] "Extremely unfair"
#> 
#> $questions$QID132224526$choices$`7`$choiceText
#> [1] "Extremely unfair"
#> 
#> $questions$QID132224526$choices$`7`$variableName
#> NULL
#> 
#> 
#> 
#> 
#> $questions$QID132224538
#> $questions$QID132224538$questionType
#> $questions$QID132224538$questionType$type
#> [1] "MC"
#> 
#> $questions$QID132224538$questionType$selector
#> [1] "SAVR"
#> 
#> $questions$QID132224538$questionType$subSelector
#> [1] "TX"
#> 
#> 
#> $questions$QID132224538$questionText
#> [1] "How clear or unclear were the assignments given in this class?"
#> 
#> $questions$QID132224538$questionLabel
#> NULL
#> 
#> $questions$QID132224538$validation
#> $questions$QID132224538$validation$doesForceResponse
#> [1] FALSE
#> 
#> 
#> $questions$QID132224538$choices
#> $questions$QID132224538$choices$`1`
#> $questions$QID132224538$choices$`1`$recode
#> [1] "1"
#> 
#> $questions$QID132224538$choices$`1`$description
#> [1] "Extremely clear"
#> 
#> $questions$QID132224538$choices$`1`$choiceText
#> [1] "Extremely clear"
#> 
#> $questions$QID132224538$choices$`1`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224538$choices$`2`
#> $questions$QID132224538$choices$`2`$recode
#> [1] "2"
#> 
#> $questions$QID132224538$choices$`2`$description
#> [1] "Moderately clear"
#> 
#> $questions$QID132224538$choices$`2`$choiceText
#> [1] "Moderately clear"
#> 
#> $questions$QID132224538$choices$`2`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224538$choices$`3`
#> $questions$QID132224538$choices$`3`$recode
#> [1] "3"
#> 
#> $questions$QID132224538$choices$`3`$description
#> [1] "Slightly clear"
#> 
#> $questions$QID132224538$choices$`3`$choiceText
#> [1] "Slightly clear"
#> 
#> $questions$QID132224538$choices$`3`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224538$choices$`4`
#> $questions$QID132224538$choices$`4`$recode
#> [1] "4"
#> 
#> $questions$QID132224538$choices$`4`$description
#> [1] "Neither clear nor unclear"
#> 
#> $questions$QID132224538$choices$`4`$choiceText
#> [1] "Neither clear nor unclear"
#> 
#> $questions$QID132224538$choices$`4`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224538$choices$`5`
#> $questions$QID132224538$choices$`5`$recode
#> [1] "5"
#> 
#> $questions$QID132224538$choices$`5`$description
#> [1] "Slightly unclear"
#> 
#> $questions$QID132224538$choices$`5`$choiceText
#> [1] "Slightly unclear"
#> 
#> $questions$QID132224538$choices$`5`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224538$choices$`6`
#> $questions$QID132224538$choices$`6`$recode
#> [1] "6"
#> 
#> $questions$QID132224538$choices$`6`$description
#> [1] "Moderately unclear"
#> 
#> $questions$QID132224538$choices$`6`$choiceText
#> [1] "Moderately unclear"
#> 
#> $questions$QID132224538$choices$`6`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224538$choices$`7`
#> $questions$QID132224538$choices$`7`$recode
#> [1] "7"
#> 
#> $questions$QID132224538$choices$`7`$description
#> [1] "Extremely unclear"
#> 
#> $questions$QID132224538$choices$`7`$choiceText
#> [1] "Extremely unclear"
#> 
#> $questions$QID132224538$choices$`7`$variableName
#> NULL
#> 
#> 
#> 
#> 
#> $questions$QID132224539
#> $questions$QID132224539$questionType
#> $questions$QID132224539$questionType$type
#> [1] "MC"
#> 
#> $questions$QID132224539$questionType$selector
#> [1] "SAVR"
#> 
#> $questions$QID132224539$questionType$subSelector
#> [1] "TX"
#> 
#> 
#> $questions$QID132224539$questionText
#> [1] "How relevant or irrelevant were the tests and quizzes to the topics covered in class?"
#> 
#> $questions$QID132224539$questionLabel
#> NULL
#> 
#> $questions$QID132224539$validation
#> $questions$QID132224539$validation$doesForceResponse
#> [1] FALSE
#> 
#> 
#> $questions$QID132224539$choices
#> $questions$QID132224539$choices$`1`
#> $questions$QID132224539$choices$`1`$recode
#> [1] "1"
#> 
#> $questions$QID132224539$choices$`1`$description
#> [1] "Extremely relevant"
#> 
#> $questions$QID132224539$choices$`1`$choiceText
#> [1] "Extremely relevant"
#> 
#> $questions$QID132224539$choices$`1`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224539$choices$`2`
#> $questions$QID132224539$choices$`2`$recode
#> [1] "2"
#> 
#> $questions$QID132224539$choices$`2`$description
#> [1] "Moderately relevant"
#> 
#> $questions$QID132224539$choices$`2`$choiceText
#> [1] "Moderately relevant"
#> 
#> $questions$QID132224539$choices$`2`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224539$choices$`3`
#> $questions$QID132224539$choices$`3`$recode
#> [1] "3"
#> 
#> $questions$QID132224539$choices$`3`$description
#> [1] "Slightly relevant"
#> 
#> $questions$QID132224539$choices$`3`$choiceText
#> [1] "Slightly relevant"
#> 
#> $questions$QID132224539$choices$`3`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224539$choices$`4`
#> $questions$QID132224539$choices$`4`$recode
#> [1] "4"
#> 
#> $questions$QID132224539$choices$`4`$description
#> [1] "Neither relevant nor irrelevant"
#> 
#> $questions$QID132224539$choices$`4`$choiceText
#> [1] "Neither relevant nor irrelevant"
#> 
#> $questions$QID132224539$choices$`4`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224539$choices$`5`
#> $questions$QID132224539$choices$`5`$recode
#> [1] "5"
#> 
#> $questions$QID132224539$choices$`5`$description
#> [1] "Slightly irrelevant"
#> 
#> $questions$QID132224539$choices$`5`$choiceText
#> [1] "Slightly irrelevant"
#> 
#> $questions$QID132224539$choices$`5`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224539$choices$`6`
#> $questions$QID132224539$choices$`6`$recode
#> [1] "6"
#> 
#> $questions$QID132224539$choices$`6`$description
#> [1] "Moderately irrelevant"
#> 
#> $questions$QID132224539$choices$`6`$choiceText
#> [1] "Moderately irrelevant"
#> 
#> $questions$QID132224539$choices$`6`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224539$choices$`7`
#> $questions$QID132224539$choices$`7`$recode
#> [1] "7"
#> 
#> $questions$QID132224539$choices$`7`$description
#> [1] "Extremely irrelevant"
#> 
#> $questions$QID132224539$choices$`7`$choiceText
#> [1] "Extremely irrelevant"
#> 
#> $questions$QID132224539$choices$`7`$variableName
#> NULL
#> 
#> 
#> 
#> 
#> $questions$QID132224540
#> $questions$QID132224540$questionType
#> $questions$QID132224540$questionType$type
#> [1] "MC"
#> 
#> $questions$QID132224540$questionType$selector
#> [1] "NPS"
#> 
#> $questions$QID132224540$questionType$subSelector
#> NULL
#> 
#> 
#> $questions$QID132224540$questionText
#> [1] "On a scale from 0-10, how likely are you to recommend this class to a friend or colleague?"
#> 
#> $questions$QID132224540$questionLabel
#> NULL
#> 
#> $questions$QID132224540$validation
#> $questions$QID132224540$validation$doesForceResponse
#> [1] FALSE
#> 
#> 
#> $questions$QID132224540$choices
#> $questions$QID132224540$choices$`0`
#> $questions$QID132224540$choices$`0`$recode
#> [1] "0"
#> 
#> $questions$QID132224540$choices$`0`$description
#> [1] "0"
#> 
#> $questions$QID132224540$choices$`0`$choiceText
#> [1] "0"
#> 
#> $questions$QID132224540$choices$`0`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224540$choices$`1`
#> $questions$QID132224540$choices$`1`$recode
#> [1] "1"
#> 
#> $questions$QID132224540$choices$`1`$description
#> [1] "1"
#> 
#> $questions$QID132224540$choices$`1`$choiceText
#> [1] "1"
#> 
#> $questions$QID132224540$choices$`1`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224540$choices$`2`
#> $questions$QID132224540$choices$`2`$recode
#> [1] "2"
#> 
#> $questions$QID132224540$choices$`2`$description
#> [1] "2"
#> 
#> $questions$QID132224540$choices$`2`$choiceText
#> [1] "2"
#> 
#> $questions$QID132224540$choices$`2`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224540$choices$`3`
#> $questions$QID132224540$choices$`3`$recode
#> [1] "3"
#> 
#> $questions$QID132224540$choices$`3`$description
#> [1] "3"
#> 
#> $questions$QID132224540$choices$`3`$choiceText
#> [1] "3"
#> 
#> $questions$QID132224540$choices$`3`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224540$choices$`4`
#> $questions$QID132224540$choices$`4`$recode
#> [1] "4"
#> 
#> $questions$QID132224540$choices$`4`$description
#> [1] "4"
#> 
#> $questions$QID132224540$choices$`4`$choiceText
#> [1] "4"
#> 
#> $questions$QID132224540$choices$`4`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224540$choices$`5`
#> $questions$QID132224540$choices$`5`$recode
#> [1] "5"
#> 
#> $questions$QID132224540$choices$`5`$description
#> [1] "5"
#> 
#> $questions$QID132224540$choices$`5`$choiceText
#> [1] "5"
#> 
#> $questions$QID132224540$choices$`5`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224540$choices$`6`
#> $questions$QID132224540$choices$`6`$recode
#> [1] "6"
#> 
#> $questions$QID132224540$choices$`6`$description
#> [1] "6"
#> 
#> $questions$QID132224540$choices$`6`$choiceText
#> [1] "6"
#> 
#> $questions$QID132224540$choices$`6`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224540$choices$`7`
#> $questions$QID132224540$choices$`7`$recode
#> [1] "7"
#> 
#> $questions$QID132224540$choices$`7`$description
#> [1] "7"
#> 
#> $questions$QID132224540$choices$`7`$choiceText
#> [1] "7"
#> 
#> $questions$QID132224540$choices$`7`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224540$choices$`8`
#> $questions$QID132224540$choices$`8`$recode
#> [1] "8"
#> 
#> $questions$QID132224540$choices$`8`$description
#> [1] "8"
#> 
#> $questions$QID132224540$choices$`8`$choiceText
#> [1] "8"
#> 
#> $questions$QID132224540$choices$`8`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224540$choices$`9`
#> $questions$QID132224540$choices$`9`$recode
#> [1] "9"
#> 
#> $questions$QID132224540$choices$`9`$description
#> [1] "9"
#> 
#> $questions$QID132224540$choices$`9`$choiceText
#> [1] "9"
#> 
#> $questions$QID132224540$choices$`9`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224540$choices$`10`
#> $questions$QID132224540$choices$`10`$recode
#> [1] "10"
#> 
#> $questions$QID132224540$choices$`10`$description
#> [1] "10"
#> 
#> $questions$QID132224540$choices$`10`$choiceText
#> [1] "10"
#> 
#> $questions$QID132224540$choices$`10`$variableName
#> NULL
#> 
#> 
#> 
#> 
#> $questions$QID132224541
#> $questions$QID132224541$questionType
#> $questions$QID132224541$questionType$type
#> [1] "MC"
#> 
#> $questions$QID132224541$questionType$selector
#> [1] "SAVR"
#> 
#> $questions$QID132224541$questionType$subSelector
#> [1] "TX"
#> 
#> 
#> $questions$QID132224541$questionText
#> [1] "<p>Overall, how satisfied or dissatisfied were you with the teacher of this class?</p>"
#> 
#> $questions$QID132224541$questionLabel
#> NULL
#> 
#> $questions$QID132224541$validation
#> $questions$QID132224541$validation$doesForceResponse
#> [1] FALSE
#> 
#> 
#> $questions$QID132224541$choices
#> $questions$QID132224541$choices$`1`
#> $questions$QID132224541$choices$`1`$recode
#> [1] "1"
#> 
#> $questions$QID132224541$choices$`1`$description
#> [1] "Extremely satisfied"
#> 
#> $questions$QID132224541$choices$`1`$choiceText
#> [1] "Extremely satisfied"
#> 
#> $questions$QID132224541$choices$`1`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224541$choices$`2`
#> $questions$QID132224541$choices$`2`$recode
#> [1] "2"
#> 
#> $questions$QID132224541$choices$`2`$description
#> [1] "Moderately satisfied"
#> 
#> $questions$QID132224541$choices$`2`$choiceText
#> [1] "Moderately satisfied"
#> 
#> $questions$QID132224541$choices$`2`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224541$choices$`3`
#> $questions$QID132224541$choices$`3`$recode
#> [1] "3"
#> 
#> $questions$QID132224541$choices$`3`$description
#> [1] "Slightly satisfied"
#> 
#> $questions$QID132224541$choices$`3`$choiceText
#> [1] "Slightly satisfied"
#> 
#> $questions$QID132224541$choices$`3`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224541$choices$`4`
#> $questions$QID132224541$choices$`4`$recode
#> [1] "4"
#> 
#> $questions$QID132224541$choices$`4`$description
#> [1] "Neither satisfied nor dissatisfied"
#> 
#> $questions$QID132224541$choices$`4`$choiceText
#> [1] "Neither satisfied nor dissatisfied"
#> 
#> $questions$QID132224541$choices$`4`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224541$choices$`5`
#> $questions$QID132224541$choices$`5`$recode
#> [1] "5"
#> 
#> $questions$QID132224541$choices$`5`$description
#> [1] "Slightly dissatisfied"
#> 
#> $questions$QID132224541$choices$`5`$choiceText
#> [1] "Slightly dissatisfied"
#> 
#> $questions$QID132224541$choices$`5`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224541$choices$`6`
#> $questions$QID132224541$choices$`6`$recode
#> [1] "6"
#> 
#> $questions$QID132224541$choices$`6`$description
#> [1] "Moderately dissatisfied"
#> 
#> $questions$QID132224541$choices$`6`$choiceText
#> [1] "Moderately dissatisfied"
#> 
#> $questions$QID132224541$choices$`6`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224541$choices$`7`
#> $questions$QID132224541$choices$`7`$recode
#> [1] "7"
#> 
#> $questions$QID132224541$choices$`7`$description
#> [1] "Extremely dissatisfied"
#> 
#> $questions$QID132224541$choices$`7`$choiceText
#> [1] "Extremely dissatisfied"
#> 
#> $questions$QID132224541$choices$`7`$variableName
#> NULL
#> 
#> 
#> 
#> 
#> $questions$QID132224518
#> $questions$QID132224518$questionType
#> $questions$QID132224518$questionType$type
#> [1] "MC"
#> 
#> $questions$QID132224518$questionType$selector
#> [1] "SAVR"
#> 
#> $questions$QID132224518$questionType$subSelector
#> [1] "TX"
#> 
#> 
#> $questions$QID132224518$questionText
#> [1] "<p>How clear or unclear was the teacher’s presentation of class material?</p>"
#> 
#> $questions$QID132224518$questionLabel
#> NULL
#> 
#> $questions$QID132224518$validation
#> $questions$QID132224518$validation$doesForceResponse
#> [1] FALSE
#> 
#> 
#> $questions$QID132224518$choices
#> $questions$QID132224518$choices$`1`
#> $questions$QID132224518$choices$`1`$recode
#> [1] "1"
#> 
#> $questions$QID132224518$choices$`1`$description
#> [1] "Extremely clear"
#> 
#> $questions$QID132224518$choices$`1`$choiceText
#> [1] "Extremely clear"
#> 
#> $questions$QID132224518$choices$`1`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224518$choices$`2`
#> $questions$QID132224518$choices$`2`$recode
#> [1] "2"
#> 
#> $questions$QID132224518$choices$`2`$description
#> [1] "Moderately clear"
#> 
#> $questions$QID132224518$choices$`2`$choiceText
#> [1] "Moderately clear"
#> 
#> $questions$QID132224518$choices$`2`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224518$choices$`3`
#> $questions$QID132224518$choices$`3`$recode
#> [1] "3"
#> 
#> $questions$QID132224518$choices$`3`$description
#> [1] "Slightly clear"
#> 
#> $questions$QID132224518$choices$`3`$choiceText
#> [1] "Slightly clear"
#> 
#> $questions$QID132224518$choices$`3`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224518$choices$`4`
#> $questions$QID132224518$choices$`4`$recode
#> [1] "4"
#> 
#> $questions$QID132224518$choices$`4`$description
#> [1] "Neither clear nor unclear"
#> 
#> $questions$QID132224518$choices$`4`$choiceText
#> [1] "Neither clear nor unclear"
#> 
#> $questions$QID132224518$choices$`4`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224518$choices$`5`
#> $questions$QID132224518$choices$`5`$recode
#> [1] "5"
#> 
#> $questions$QID132224518$choices$`5`$description
#> [1] "Slightly unclear"
#> 
#> $questions$QID132224518$choices$`5`$choiceText
#> [1] "Slightly unclear"
#> 
#> $questions$QID132224518$choices$`5`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224518$choices$`6`
#> $questions$QID132224518$choices$`6`$recode
#> [1] "6"
#> 
#> $questions$QID132224518$choices$`6`$description
#> [1] "Moderately unclear"
#> 
#> $questions$QID132224518$choices$`6`$choiceText
#> [1] "Moderately unclear"
#> 
#> $questions$QID132224518$choices$`6`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224518$choices$`7`
#> $questions$QID132224518$choices$`7`$recode
#> [1] "7"
#> 
#> $questions$QID132224518$choices$`7`$description
#> [1] "Extremely unclear"
#> 
#> $questions$QID132224518$choices$`7`$choiceText
#> [1] "Extremely unclear"
#> 
#> $questions$QID132224518$choices$`7`$variableName
#> NULL
#> 
#> 
#> 
#> 
#> $questions$QID132224517
#> $questions$QID132224517$questionType
#> $questions$QID132224517$questionType$type
#> [1] "MC"
#> 
#> $questions$QID132224517$questionType$selector
#> [1] "SAVR"
#> 
#> $questions$QID132224517$questionType$subSelector
#> [1] "TX"
#> 
#> 
#> $questions$QID132224517$questionText
#> [1] "How well did the teacher facilitate your understanding of class material?"
#> 
#> $questions$QID132224517$questionLabel
#> NULL
#> 
#> $questions$QID132224517$validation
#> $questions$QID132224517$validation$doesForceResponse
#> [1] FALSE
#> 
#> 
#> $questions$QID132224517$choices
#> $questions$QID132224517$choices$`1`
#> $questions$QID132224517$choices$`1`$recode
#> [1] "1"
#> 
#> $questions$QID132224517$choices$`1`$description
#> [1] "Extremely well"
#> 
#> $questions$QID132224517$choices$`1`$choiceText
#> [1] "Extremely well"
#> 
#> $questions$QID132224517$choices$`1`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224517$choices$`2`
#> $questions$QID132224517$choices$`2`$recode
#> [1] "2"
#> 
#> $questions$QID132224517$choices$`2`$description
#> [1] "Very well"
#> 
#> $questions$QID132224517$choices$`2`$choiceText
#> [1] "Very well"
#> 
#> $questions$QID132224517$choices$`2`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224517$choices$`3`
#> $questions$QID132224517$choices$`3`$recode
#> [1] "3"
#> 
#> $questions$QID132224517$choices$`3`$description
#> [1] "Moderately well"
#> 
#> $questions$QID132224517$choices$`3`$choiceText
#> [1] "Moderately well"
#> 
#> $questions$QID132224517$choices$`3`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224517$choices$`4`
#> $questions$QID132224517$choices$`4`$recode
#> [1] "4"
#> 
#> $questions$QID132224517$choices$`4`$description
#> [1] "Slightly well"
#> 
#> $questions$QID132224517$choices$`4`$choiceText
#> [1] "Slightly well"
#> 
#> $questions$QID132224517$choices$`4`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224517$choices$`5`
#> $questions$QID132224517$choices$`5`$recode
#> [1] "5"
#> 
#> $questions$QID132224517$choices$`5`$description
#> [1] "Not well at all"
#> 
#> $questions$QID132224517$choices$`5`$choiceText
#> [1] "Not well at all"
#> 
#> $questions$QID132224517$choices$`5`$variableName
#> NULL
#> 
#> 
#> 
#> 
#> $questions$QID132224519
#> $questions$QID132224519$questionType
#> $questions$QID132224519$questionType$type
#> [1] "MC"
#> 
#> $questions$QID132224519$questionType$selector
#> [1] "SAVR"
#> 
#> $questions$QID132224519$questionType$subSelector
#> [1] "TX"
#> 
#> 
#> $questions$QID132224519$questionText
#> [1] "How approachable was the teacher outside of class?"
#> 
#> $questions$QID132224519$questionLabel
#> NULL
#> 
#> $questions$QID132224519$validation
#> $questions$QID132224519$validation$doesForceResponse
#> [1] FALSE
#> 
#> 
#> $questions$QID132224519$choices
#> $questions$QID132224519$choices$`1`
#> $questions$QID132224519$choices$`1`$recode
#> [1] "1"
#> 
#> $questions$QID132224519$choices$`1`$description
#> [1] "Extremely approachable"
#> 
#> $questions$QID132224519$choices$`1`$choiceText
#> [1] "Extremely approachable"
#> 
#> $questions$QID132224519$choices$`1`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224519$choices$`2`
#> $questions$QID132224519$choices$`2`$recode
#> [1] "2"
#> 
#> $questions$QID132224519$choices$`2`$description
#> [1] "Very approachable"
#> 
#> $questions$QID132224519$choices$`2`$choiceText
#> [1] "Very approachable"
#> 
#> $questions$QID132224519$choices$`2`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224519$choices$`3`
#> $questions$QID132224519$choices$`3`$recode
#> [1] "3"
#> 
#> $questions$QID132224519$choices$`3`$description
#> [1] "Moderately approachable"
#> 
#> $questions$QID132224519$choices$`3`$choiceText
#> [1] "Moderately approachable"
#> 
#> $questions$QID132224519$choices$`3`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224519$choices$`4`
#> $questions$QID132224519$choices$`4`$recode
#> [1] "4"
#> 
#> $questions$QID132224519$choices$`4`$description
#> [1] "Slightly approachable"
#> 
#> $questions$QID132224519$choices$`4`$choiceText
#> [1] "Slightly approachable"
#> 
#> $questions$QID132224519$choices$`4`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224519$choices$`5`
#> $questions$QID132224519$choices$`5`$recode
#> [1] "5"
#> 
#> $questions$QID132224519$choices$`5`$description
#> [1] "Not approachable at all"
#> 
#> $questions$QID132224519$choices$`5`$choiceText
#> [1] "Not approachable at all"
#> 
#> $questions$QID132224519$choices$`5`$variableName
#> NULL
#> 
#> 
#> 
#> 
#> $questions$QID132224520
#> $questions$QID132224520$questionType
#> $questions$QID132224520$questionType$type
#> [1] "MC"
#> 
#> $questions$QID132224520$questionType$selector
#> [1] "SAVR"
#> 
#> $questions$QID132224520$questionType$subSelector
#> [1] "TX"
#> 
#> 
#> $questions$QID132224520$questionText
#> [1] "How fair or unfair was the teacher’s grading policy?"
#> 
#> $questions$QID132224520$questionLabel
#> NULL
#> 
#> $questions$QID132224520$validation
#> $questions$QID132224520$validation$doesForceResponse
#> [1] FALSE
#> 
#> 
#> $questions$QID132224520$choices
#> $questions$QID132224520$choices$`1`
#> $questions$QID132224520$choices$`1`$recode
#> [1] "1"
#> 
#> $questions$QID132224520$choices$`1`$description
#> [1] "Extremely fair"
#> 
#> $questions$QID132224520$choices$`1`$choiceText
#> [1] "Extremely fair"
#> 
#> $questions$QID132224520$choices$`1`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224520$choices$`2`
#> $questions$QID132224520$choices$`2`$recode
#> [1] "2"
#> 
#> $questions$QID132224520$choices$`2`$description
#> [1] "Moderately fair"
#> 
#> $questions$QID132224520$choices$`2`$choiceText
#> [1] "Moderately fair"
#> 
#> $questions$QID132224520$choices$`2`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224520$choices$`3`
#> $questions$QID132224520$choices$`3`$recode
#> [1] "3"
#> 
#> $questions$QID132224520$choices$`3`$description
#> [1] "Slightly fair"
#> 
#> $questions$QID132224520$choices$`3`$choiceText
#> [1] "Slightly fair"
#> 
#> $questions$QID132224520$choices$`3`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224520$choices$`4`
#> $questions$QID132224520$choices$`4`$recode
#> [1] "4"
#> 
#> $questions$QID132224520$choices$`4`$description
#> [1] "Neither fair nor unfair"
#> 
#> $questions$QID132224520$choices$`4`$choiceText
#> [1] "Neither fair nor unfair"
#> 
#> $questions$QID132224520$choices$`4`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224520$choices$`5`
#> $questions$QID132224520$choices$`5`$recode
#> [1] "5"
#> 
#> $questions$QID132224520$choices$`5`$description
#> [1] "Slightly unfair"
#> 
#> $questions$QID132224520$choices$`5`$choiceText
#> [1] "Slightly unfair"
#> 
#> $questions$QID132224520$choices$`5`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224520$choices$`6`
#> $questions$QID132224520$choices$`6`$recode
#> [1] "6"
#> 
#> $questions$QID132224520$choices$`6`$description
#> [1] "Moderately unfair"
#> 
#> $questions$QID132224520$choices$`6`$choiceText
#> [1] "Moderately unfair"
#> 
#> $questions$QID132224520$choices$`6`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224520$choices$`7`
#> $questions$QID132224520$choices$`7`$recode
#> [1] "7"
#> 
#> $questions$QID132224520$choices$`7`$description
#> [1] "Extremely unfair"
#> 
#> $questions$QID132224520$choices$`7`$choiceText
#> [1] "Extremely unfair"
#> 
#> $questions$QID132224520$choices$`7`$variableName
#> NULL
#> 
#> 
#> 
#> 
#> $questions$QID132224521
#> $questions$QID132224521$questionType
#> $questions$QID132224521$questionType$type
#> [1] "MC"
#> 
#> $questions$QID132224521$questionType$selector
#> [1] "SAVR"
#> 
#> $questions$QID132224521$questionType$subSelector
#> [1] "TX"
#> 
#> 
#> $questions$QID132224521$questionText
#> [1] "How effective was the teacher’s approach to teaching?"
#> 
#> $questions$QID132224521$questionLabel
#> NULL
#> 
#> $questions$QID132224521$validation
#> $questions$QID132224521$validation$doesForceResponse
#> [1] FALSE
#> 
#> 
#> $questions$QID132224521$choices
#> $questions$QID132224521$choices$`1`
#> $questions$QID132224521$choices$`1`$recode
#> [1] "1"
#> 
#> $questions$QID132224521$choices$`1`$description
#> [1] "Extremely effective"
#> 
#> $questions$QID132224521$choices$`1`$choiceText
#> [1] "Extremely effective"
#> 
#> $questions$QID132224521$choices$`1`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224521$choices$`2`
#> $questions$QID132224521$choices$`2`$recode
#> [1] "2"
#> 
#> $questions$QID132224521$choices$`2`$description
#> [1] "Very effective"
#> 
#> $questions$QID132224521$choices$`2`$choiceText
#> [1] "Very effective"
#> 
#> $questions$QID132224521$choices$`2`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224521$choices$`3`
#> $questions$QID132224521$choices$`3`$recode
#> [1] "3"
#> 
#> $questions$QID132224521$choices$`3`$description
#> [1] "Moderately effective"
#> 
#> $questions$QID132224521$choices$`3`$choiceText
#> [1] "Moderately effective"
#> 
#> $questions$QID132224521$choices$`3`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224521$choices$`4`
#> $questions$QID132224521$choices$`4`$recode
#> [1] "4"
#> 
#> $questions$QID132224521$choices$`4`$description
#> [1] "Slightly effective"
#> 
#> $questions$QID132224521$choices$`4`$choiceText
#> [1] "Slightly effective"
#> 
#> $questions$QID132224521$choices$`4`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224521$choices$`5`
#> $questions$QID132224521$choices$`5`$recode
#> [1] "5"
#> 
#> $questions$QID132224521$choices$`5`$description
#> [1] "Not effective at all"
#> 
#> $questions$QID132224521$choices$`5`$choiceText
#> [1] "Not effective at all"
#> 
#> $questions$QID132224521$choices$`5`$variableName
#> NULL
#> 
#> 
#> 
#> 
#> $questions$QID132224522
#> $questions$QID132224522$questionType
#> $questions$QID132224522$questionType$type
#> [1] "MC"
#> 
#> $questions$QID132224522$questionType$selector
#> [1] "SAVR"
#> 
#> $questions$QID132224522$questionType$subSelector
#> [1] "TX"
#> 
#> 
#> $questions$QID132224522$questionText
#> [1] "How much did the teacher care about the students?"
#> 
#> $questions$QID132224522$questionLabel
#> NULL
#> 
#> $questions$QID132224522$validation
#> $questions$QID132224522$validation$doesForceResponse
#> [1] FALSE
#> 
#> 
#> $questions$QID132224522$choices
#> $questions$QID132224522$choices$`1`
#> $questions$QID132224522$choices$`1`$recode
#> [1] "1"
#> 
#> $questions$QID132224522$choices$`1`$description
#> [1] "A great deal"
#> 
#> $questions$QID132224522$choices$`1`$choiceText
#> [1] "A great deal"
#> 
#> $questions$QID132224522$choices$`1`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224522$choices$`2`
#> $questions$QID132224522$choices$`2`$recode
#> [1] "2"
#> 
#> $questions$QID132224522$choices$`2`$description
#> [1] "A lot"
#> 
#> $questions$QID132224522$choices$`2`$choiceText
#> [1] "A lot"
#> 
#> $questions$QID132224522$choices$`2`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224522$choices$`3`
#> $questions$QID132224522$choices$`3`$recode
#> [1] "3"
#> 
#> $questions$QID132224522$choices$`3`$description
#> [1] "A moderate amount"
#> 
#> $questions$QID132224522$choices$`3`$choiceText
#> [1] "A moderate amount"
#> 
#> $questions$QID132224522$choices$`3`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224522$choices$`4`
#> $questions$QID132224522$choices$`4`$recode
#> [1] "4"
#> 
#> $questions$QID132224522$choices$`4`$description
#> [1] "A little"
#> 
#> $questions$QID132224522$choices$`4`$choiceText
#> [1] "A little"
#> 
#> $questions$QID132224522$choices$`4`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224522$choices$`5`
#> $questions$QID132224522$choices$`5`$recode
#> [1] "5"
#> 
#> $questions$QID132224522$choices$`5`$description
#> [1] "Not at all"
#> 
#> $questions$QID132224522$choices$`5`$choiceText
#> [1] "Not at all"
#> 
#> $questions$QID132224522$choices$`5`$variableName
#> NULL
#> 
#> 
#> 
#> 
#> $questions$QID132224523
#> $questions$QID132224523$questionType
#> $questions$QID132224523$questionType$type
#> [1] "MC"
#> 
#> $questions$QID132224523$questionType$selector
#> [1] "SAVR"
#> 
#> $questions$QID132224523$questionType$subSelector
#> [1] "TX"
#> 
#> 
#> $questions$QID132224523$questionText
#> [1] "How open minded was the teacher?"
#> 
#> $questions$QID132224523$questionLabel
#> NULL
#> 
#> $questions$QID132224523$validation
#> $questions$QID132224523$validation$doesForceResponse
#> [1] FALSE
#> 
#> 
#> $questions$QID132224523$choices
#> $questions$QID132224523$choices$`1`
#> $questions$QID132224523$choices$`1`$recode
#> [1] "1"
#> 
#> $questions$QID132224523$choices$`1`$description
#> [1] "Extremely open minded"
#> 
#> $questions$QID132224523$choices$`1`$choiceText
#> [1] "Extremely open minded"
#> 
#> $questions$QID132224523$choices$`1`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224523$choices$`2`
#> $questions$QID132224523$choices$`2`$recode
#> [1] "2"
#> 
#> $questions$QID132224523$choices$`2`$description
#> [1] "Very open minded"
#> 
#> $questions$QID132224523$choices$`2`$choiceText
#> [1] "Very open minded"
#> 
#> $questions$QID132224523$choices$`2`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224523$choices$`3`
#> $questions$QID132224523$choices$`3`$recode
#> [1] "3"
#> 
#> $questions$QID132224523$choices$`3`$description
#> [1] "Moderately open minded"
#> 
#> $questions$QID132224523$choices$`3`$choiceText
#> [1] "Moderately open minded"
#> 
#> $questions$QID132224523$choices$`3`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224523$choices$`4`
#> $questions$QID132224523$choices$`4`$recode
#> [1] "4"
#> 
#> $questions$QID132224523$choices$`4`$description
#> [1] "Slightly open minded"
#> 
#> $questions$QID132224523$choices$`4`$choiceText
#> [1] "Slightly open minded"
#> 
#> $questions$QID132224523$choices$`4`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224523$choices$`5`
#> $questions$QID132224523$choices$`5`$recode
#> [1] "5"
#> 
#> $questions$QID132224523$choices$`5`$description
#> [1] "Not open minded at all"
#> 
#> $questions$QID132224523$choices$`5`$choiceText
#> [1] "Not open minded at all"
#> 
#> $questions$QID132224523$choices$`5`$variableName
#> NULL
#> 
#> 
#> 
#> 
#> $questions$QID132224524
#> $questions$QID132224524$questionType
#> $questions$QID132224524$questionType$type
#> [1] "MC"
#> 
#> $questions$QID132224524$questionType$selector
#> [1] "SAVR"
#> 
#> $questions$QID132224524$questionType$subSelector
#> [1] "TX"
#> 
#> 
#> $questions$QID132224524$questionText
#> [1] "How knowledgeable was the teacher of the material being taught in class?"
#> 
#> $questions$QID132224524$questionLabel
#> NULL
#> 
#> $questions$QID132224524$validation
#> $questions$QID132224524$validation$doesForceResponse
#> [1] FALSE
#> 
#> 
#> $questions$QID132224524$choices
#> $questions$QID132224524$choices$`1`
#> $questions$QID132224524$choices$`1`$recode
#> [1] "1"
#> 
#> $questions$QID132224524$choices$`1`$description
#> [1] "Extremely knowledgeable"
#> 
#> $questions$QID132224524$choices$`1`$choiceText
#> [1] "Extremely knowledgeable"
#> 
#> $questions$QID132224524$choices$`1`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224524$choices$`2`
#> $questions$QID132224524$choices$`2`$recode
#> [1] "2"
#> 
#> $questions$QID132224524$choices$`2`$description
#> [1] "Very knowledgeable"
#> 
#> $questions$QID132224524$choices$`2`$choiceText
#> [1] "Very knowledgeable"
#> 
#> $questions$QID132224524$choices$`2`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224524$choices$`3`
#> $questions$QID132224524$choices$`3`$recode
#> [1] "3"
#> 
#> $questions$QID132224524$choices$`3`$description
#> [1] "Moderately knowledgeable"
#> 
#> $questions$QID132224524$choices$`3`$choiceText
#> [1] "Moderately knowledgeable"
#> 
#> $questions$QID132224524$choices$`3`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224524$choices$`4`
#> $questions$QID132224524$choices$`4`$recode
#> [1] "4"
#> 
#> $questions$QID132224524$choices$`4`$description
#> [1] "Slightly knowledgeable"
#> 
#> $questions$QID132224524$choices$`4`$choiceText
#> [1] "Slightly knowledgeable"
#> 
#> $questions$QID132224524$choices$`4`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224524$choices$`5`
#> $questions$QID132224524$choices$`5`$recode
#> [1] "5"
#> 
#> $questions$QID132224524$choices$`5`$description
#> [1] "Not knowledgeable at all"
#> 
#> $questions$QID132224524$choices$`5`$choiceText
#> [1] "Not knowledgeable at all"
#> 
#> $questions$QID132224524$choices$`5`$variableName
#> NULL
#> 
#> 
#> 
#> 
#> $questions$QID132224525
#> $questions$QID132224525$questionType
#> $questions$QID132224525$questionType$type
#> [1] "MC"
#> 
#> $questions$QID132224525$questionType$selector
#> [1] "SAVR"
#> 
#> $questions$QID132224525$questionType$subSelector
#> [1] "TX"
#> 
#> 
#> $questions$QID132224525$questionText
#> [1] "How satisfied or dissatisfied were you with your effort in class?"
#> 
#> $questions$QID132224525$questionLabel
#> NULL
#> 
#> $questions$QID132224525$validation
#> $questions$QID132224525$validation$doesForceResponse
#> [1] FALSE
#> 
#> 
#> $questions$QID132224525$choices
#> $questions$QID132224525$choices$`1`
#> $questions$QID132224525$choices$`1`$recode
#> [1] "1"
#> 
#> $questions$QID132224525$choices$`1`$description
#> [1] "Extremely satisfied"
#> 
#> $questions$QID132224525$choices$`1`$choiceText
#> [1] "Extremely satisfied"
#> 
#> $questions$QID132224525$choices$`1`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224525$choices$`2`
#> $questions$QID132224525$choices$`2`$recode
#> [1] "2"
#> 
#> $questions$QID132224525$choices$`2`$description
#> [1] "Moderately satisifed"
#> 
#> $questions$QID132224525$choices$`2`$choiceText
#> [1] "Moderately satisifed"
#> 
#> $questions$QID132224525$choices$`2`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224525$choices$`3`
#> $questions$QID132224525$choices$`3`$recode
#> [1] "3"
#> 
#> $questions$QID132224525$choices$`3`$description
#> [1] "Slightly satisfied"
#> 
#> $questions$QID132224525$choices$`3`$choiceText
#> [1] "Slightly satisfied"
#> 
#> $questions$QID132224525$choices$`3`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224525$choices$`4`
#> $questions$QID132224525$choices$`4`$recode
#> [1] "4"
#> 
#> $questions$QID132224525$choices$`4`$description
#> [1] "Neither satisfied nor dissatisfied"
#> 
#> $questions$QID132224525$choices$`4`$choiceText
#> [1] "Neither satisfied nor dissatisfied"
#> 
#> $questions$QID132224525$choices$`4`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224525$choices$`5`
#> $questions$QID132224525$choices$`5`$recode
#> [1] "5"
#> 
#> $questions$QID132224525$choices$`5`$description
#> [1] "Slightly dissatisfied"
#> 
#> $questions$QID132224525$choices$`5`$choiceText
#> [1] "Slightly dissatisfied"
#> 
#> $questions$QID132224525$choices$`5`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224525$choices$`6`
#> $questions$QID132224525$choices$`6`$recode
#> [1] "6"
#> 
#> $questions$QID132224525$choices$`6`$description
#> [1] "Moderately dissatisfied"
#> 
#> $questions$QID132224525$choices$`6`$choiceText
#> [1] "Moderately dissatisfied"
#> 
#> $questions$QID132224525$choices$`6`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224525$choices$`7`
#> $questions$QID132224525$choices$`7`$recode
#> [1] "7"
#> 
#> $questions$QID132224525$choices$`7`$description
#> [1] "Extremely dissatisfied"
#> 
#> $questions$QID132224525$choices$`7`$choiceText
#> [1] "Extremely dissatisfied"
#> 
#> $questions$QID132224525$choices$`7`$variableName
#> NULL
#> 
#> 
#> 
#> 
#> $questions$QID132224528
#> $questions$QID132224528$questionType
#> $questions$QID132224528$questionType$type
#> [1] "MC"
#> 
#> $questions$QID132224528$questionType$selector
#> [1] "SAVR"
#> 
#> $questions$QID132224528$questionType$subSelector
#> [1] "TX"
#> 
#> 
#> $questions$QID132224528$questionText
#> [1] "How satisfied or dissatisfied were you with your work in this class?"
#> 
#> $questions$QID132224528$questionLabel
#> NULL
#> 
#> $questions$QID132224528$validation
#> $questions$QID132224528$validation$doesForceResponse
#> [1] FALSE
#> 
#> 
#> $questions$QID132224528$choices
#> $questions$QID132224528$choices$`1`
#> $questions$QID132224528$choices$`1`$recode
#> [1] "1"
#> 
#> $questions$QID132224528$choices$`1`$description
#> [1] "Extremely satisfied"
#> 
#> $questions$QID132224528$choices$`1`$choiceText
#> [1] "Extremely satisfied"
#> 
#> $questions$QID132224528$choices$`1`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224528$choices$`2`
#> $questions$QID132224528$choices$`2`$recode
#> [1] "2"
#> 
#> $questions$QID132224528$choices$`2`$description
#> [1] "Moderately satisifed"
#> 
#> $questions$QID132224528$choices$`2`$choiceText
#> [1] "Moderately satisifed"
#> 
#> $questions$QID132224528$choices$`2`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224528$choices$`3`
#> $questions$QID132224528$choices$`3`$recode
#> [1] "3"
#> 
#> $questions$QID132224528$choices$`3`$description
#> [1] "Slightly satisfied"
#> 
#> $questions$QID132224528$choices$`3`$choiceText
#> [1] "Slightly satisfied"
#> 
#> $questions$QID132224528$choices$`3`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224528$choices$`4`
#> $questions$QID132224528$choices$`4`$recode
#> [1] "4"
#> 
#> $questions$QID132224528$choices$`4`$description
#> [1] "Neither satisfied nor dissatisfied"
#> 
#> $questions$QID132224528$choices$`4`$choiceText
#> [1] "Neither satisfied nor dissatisfied"
#> 
#> $questions$QID132224528$choices$`4`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224528$choices$`5`
#> $questions$QID132224528$choices$`5`$recode
#> [1] "5"
#> 
#> $questions$QID132224528$choices$`5`$description
#> [1] "Slightly dissatisfied"
#> 
#> $questions$QID132224528$choices$`5`$choiceText
#> [1] "Slightly dissatisfied"
#> 
#> $questions$QID132224528$choices$`5`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224528$choices$`6`
#> $questions$QID132224528$choices$`6`$recode
#> [1] "6"
#> 
#> $questions$QID132224528$choices$`6`$description
#> [1] "Moderately dissatisfied"
#> 
#> $questions$QID132224528$choices$`6`$choiceText
#> [1] "Moderately dissatisfied"
#> 
#> $questions$QID132224528$choices$`6`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224528$choices$`7`
#> $questions$QID132224528$choices$`7`$recode
#> [1] "7"
#> 
#> $questions$QID132224528$choices$`7`$description
#> [1] "Extremely dissatisfied"
#> 
#> $questions$QID132224528$choices$`7`$choiceText
#> [1] "Extremely dissatisfied"
#> 
#> $questions$QID132224528$choices$`7`$variableName
#> NULL
#> 
#> 
#> 
#> 
#> $questions$QID132224527
#> $questions$QID132224527$questionType
#> $questions$QID132224527$questionType$type
#> [1] "MC"
#> 
#> $questions$QID132224527$questionType$selector
#> [1] "SAVR"
#> 
#> $questions$QID132224527$questionType$subSelector
#> [1] "TX"
#> 
#> 
#> $questions$QID132224527$questionText
#> [1] "How much do you feel you learned from this class?"
#> 
#> $questions$QID132224527$questionLabel
#> NULL
#> 
#> $questions$QID132224527$validation
#> $questions$QID132224527$validation$doesForceResponse
#> [1] FALSE
#> 
#> 
#> $questions$QID132224527$choices
#> $questions$QID132224527$choices$`1`
#> $questions$QID132224527$choices$`1`$recode
#> [1] "1"
#> 
#> $questions$QID132224527$choices$`1`$description
#> [1] "A great deal"
#> 
#> $questions$QID132224527$choices$`1`$choiceText
#> [1] "A great deal"
#> 
#> $questions$QID132224527$choices$`1`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224527$choices$`2`
#> $questions$QID132224527$choices$`2`$recode
#> [1] "2"
#> 
#> $questions$QID132224527$choices$`2`$description
#> [1] "A lot"
#> 
#> $questions$QID132224527$choices$`2`$choiceText
#> [1] "A lot"
#> 
#> $questions$QID132224527$choices$`2`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224527$choices$`3`
#> $questions$QID132224527$choices$`3`$recode
#> [1] "3"
#> 
#> $questions$QID132224527$choices$`3`$description
#> [1] "A moderate amount"
#> 
#> $questions$QID132224527$choices$`3`$choiceText
#> [1] "A moderate amount"
#> 
#> $questions$QID132224527$choices$`3`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224527$choices$`4`
#> $questions$QID132224527$choices$`4`$recode
#> [1] "4"
#> 
#> $questions$QID132224527$choices$`4`$description
#> [1] "A little"
#> 
#> $questions$QID132224527$choices$`4`$choiceText
#> [1] "A little"
#> 
#> $questions$QID132224527$choices$`4`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224527$choices$`5`
#> $questions$QID132224527$choices$`5`$recode
#> [1] "5"
#> 
#> $questions$QID132224527$choices$`5`$description
#> [1] "Nothing at all"
#> 
#> $questions$QID132224527$choices$`5`$choiceText
#> [1] "Nothing at all"
#> 
#> $questions$QID132224527$choices$`5`$variableName
#> NULL
#> 
#> 
#> 
#> 
#> $questions$QID132224530
#> $questions$QID132224530$questionType
#> $questions$QID132224530$questionType$type
#> [1] "MC"
#> 
#> $questions$QID132224530$questionType$selector
#> [1] "SAVR"
#> 
#> $questions$QID132224530$questionType$subSelector
#> [1] "TX"
#> 
#> 
#> $questions$QID132224530$questionText
#> [1] "How much did you enjoy taking this class?"
#> 
#> $questions$QID132224530$questionLabel
#> NULL
#> 
#> $questions$QID132224530$validation
#> $questions$QID132224530$validation$doesForceResponse
#> [1] FALSE
#> 
#> 
#> $questions$QID132224530$choices
#> $questions$QID132224530$choices$`1`
#> $questions$QID132224530$choices$`1`$recode
#> [1] "1"
#> 
#> $questions$QID132224530$choices$`1`$description
#> [1] "A great deal"
#> 
#> $questions$QID132224530$choices$`1`$choiceText
#> [1] "A great deal"
#> 
#> $questions$QID132224530$choices$`1`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224530$choices$`2`
#> $questions$QID132224530$choices$`2`$recode
#> [1] "2"
#> 
#> $questions$QID132224530$choices$`2`$description
#> [1] "A lot"
#> 
#> $questions$QID132224530$choices$`2`$choiceText
#> [1] "A lot"
#> 
#> $questions$QID132224530$choices$`2`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224530$choices$`3`
#> $questions$QID132224530$choices$`3`$recode
#> [1] "3"
#> 
#> $questions$QID132224530$choices$`3`$description
#> [1] "A moderate amount"
#> 
#> $questions$QID132224530$choices$`3`$choiceText
#> [1] "A moderate amount"
#> 
#> $questions$QID132224530$choices$`3`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224530$choices$`4`
#> $questions$QID132224530$choices$`4`$recode
#> [1] "4"
#> 
#> $questions$QID132224530$choices$`4`$description
#> [1] "A little"
#> 
#> $questions$QID132224530$choices$`4`$choiceText
#> [1] "A little"
#> 
#> $questions$QID132224530$choices$`4`$variableName
#> NULL
#> 
#> 
#> $questions$QID132224530$choices$`5`
#> $questions$QID132224530$choices$`5`$recode
#> [1] "5"
#> 
#> $questions$QID132224530$choices$`5`$description
#> [1] "Nothing at all"
#> 
#> $questions$QID132224530$choices$`5`$choiceText
#> [1] "Nothing at all"
#> 
#> $questions$QID132224530$choices$`5`$variableName
#> NULL
#> 
#> 
#> 
#> 
#> $questions$QID132224529
#> $questions$QID132224529$questionType
#> $questions$QID132224529$questionType$type
#> [1] "TE"
#> 
#> $questions$QID132224529$questionType$selector
#> [1] "ML"
#> 
#> $questions$QID132224529$questionType$subSelector
#> NULL
#> 
#> 
#> $questions$QID132224529$questionText
#> [1] "What did you like most about this class?  Be as specific as possible, and list as many aspects as you feel are appropriate."
#> 
#> $questions$QID132224529$questionLabel
#> NULL
#> 
#> $questions$QID132224529$validation
#> $questions$QID132224529$validation$doesForceResponse
#> [1] FALSE
#> 
#> $questions$QID132224529$validation$type
#> [1] "MinChar"
#> 
#> $questions$QID132224529$validation$settings
#> $questions$QID132224529$validation$settings$minChars
#> [1] 5
#> 
#> 
#> 
#> 
#> $questions$QID132224531
#> $questions$QID132224531$questionType
#> $questions$QID132224531$questionType$type
#> [1] "TE"
#> 
#> $questions$QID132224531$questionType$selector
#> [1] "ML"
#> 
#> $questions$QID132224531$questionType$subSelector
#> NULL
#> 
#> 
#> $questions$QID132224531$questionText
#> [1] "What did you like least about this class?  Be as specific as possible, and list as many aspects as you feel are appropriate."
#> 
#> $questions$QID132224531$questionLabel
#> NULL
#> 
#> $questions$QID132224531$validation
#> $questions$QID132224531$validation$doesForceResponse
#> [1] FALSE
#> 
#> $questions$QID132224531$validation$type
#> [1] "MinChar"
#> 
#> $questions$QID132224531$validation$settings
#> $questions$QID132224531$validation$settings$minChars
#> [1] 5
#> 
#> 
#> 
#> 
#> $questions$QID132224532
#> $questions$QID132224532$questionType
#> $questions$QID132224532$questionType$type
#> [1] "TE"
#> 
#> $questions$QID132224532$questionType$selector
#> [1] "ML"
#> 
#> $questions$QID132224532$questionType$subSelector
#> NULL
#> 
#> 
#> $questions$QID132224532$questionText
#> [1] "What did you enjoy about this teacher’s style of teaching?"
#> 
#> $questions$QID132224532$questionLabel
#> NULL
#> 
#> $questions$QID132224532$validation
#> $questions$QID132224532$validation$doesForceResponse
#> [1] FALSE
#> 
#> $questions$QID132224532$validation$type
#> [1] "MinChar"
#> 
#> $questions$QID132224532$validation$settings
#> $questions$QID132224532$validation$settings$minChars
#> [1] 5
#> 
#> 
#> 
#> 
#> $questions$QID132224533
#> $questions$QID132224533$questionType
#> $questions$QID132224533$questionType$type
#> [1] "TE"
#> 
#> $questions$QID132224533$questionType$selector
#> [1] "ML"
#> 
#> $questions$QID132224533$questionType$subSelector
#> NULL
#> 
#> 
#> $questions$QID132224533$questionText
#> [1] "How could this teacher improve his/her teaching style and/or class?"
#> 
#> $questions$QID132224533$questionLabel
#> NULL
#> 
#> $questions$QID132224533$validation
#> $questions$QID132224533$validation$doesForceResponse
#> [1] FALSE
#> 
#> $questions$QID132224533$validation$type
#> [1] "MinChar"
#> 
#> $questions$QID132224533$validation$settings
#> $questions$QID132224533$validation$settings$minChars
#> [1] 5
#> 
#> 
#> 
#> 
#> $questions$QID132224534
#> $questions$QID132224534$questionType
#> $questions$QID132224534$questionType$type
#> [1] "TE"
#> 
#> $questions$QID132224534$questionType$selector
#> [1] "ML"
#> 
#> $questions$QID132224534$questionType$subSelector
#> NULL
#> 
#> 
#> $questions$QID132224534$questionText
#> [1] "What is one thing that you will take away from this class?"
#> 
#> $questions$QID132224534$questionLabel
#> NULL
#> 
#> $questions$QID132224534$validation
#> $questions$QID132224534$validation$doesForceResponse
#> [1] FALSE
#> 
#> $questions$QID132224534$validation$type
#> [1] "MinChar"
#> 
#> $questions$QID132224534$validation$settings
#> $questions$QID132224534$validation$settings$minChars
#> [1] 5
#> 
#> 
#> 
#> 
#> $questions$QID132224535
#> $questions$QID132224535$questionType
#> $questions$QID132224535$questionType$type
#> [1] "TE"
#> 
#> $questions$QID132224535$questionType$selector
#> [1] "ML"
#> 
#> $questions$QID132224535$questionType$subSelector
#> NULL
#> 
#> 
#> $questions$QID132224535$questionText
#> [1] "If you have any other thoughts/comments/feedback on this teacher or this class, please include them below."
#> 
#> $questions$QID132224535$questionLabel
#> NULL
#> 
#> $questions$QID132224535$validation
#> $questions$QID132224535$validation$doesForceResponse
#> [1] FALSE
#> 
#> $questions$QID132224535$validation$type
#> [1] "MinChar"
#> 
#> $questions$QID132224535$validation$settings
#> $questions$QID132224535$validation$settings$minChars
#> [1] 5
#> 
#> 
#> 
#> 
#> 
#> $exportColumnMap
#> $exportColumnMap$Q1
#> $exportColumnMap$Q1$question
#> [1] "QID132224516"
#> 
#> 
#> $exportColumnMap$Q3
#> $exportColumnMap$Q3$question
#> [1] "QID132224536"
#> 
#> 
#> $exportColumnMap$Q4
#> $exportColumnMap$Q4$question
#> [1] "QID132224537"
#> 
#> 
#> $exportColumnMap$Q2
#> $exportColumnMap$Q2$question
#> [1] "QID132224526"
#> 
#> 
#> $exportColumnMap$Q6
#> $exportColumnMap$Q6$question
#> [1] "QID132224538"
#> 
#> 
#> $exportColumnMap$Q7
#> $exportColumnMap$Q7$question
#> [1] "QID132224539"
#> 
#> 
#> $exportColumnMap$Q8
#> $exportColumnMap$Q8$question
#> [1] "QID132224540"
#> 
#> 
#> $exportColumnMap$Q9
#> $exportColumnMap$Q9$question
#> [1] "QID132224541"
#> 
#> 
#> $exportColumnMap$Q11
#> $exportColumnMap$Q11$question
#> [1] "QID132224518"
#> 
#> 
#> $exportColumnMap$Q10
#> $exportColumnMap$Q10$question
#> [1] "QID132224517"
#> 
#> 
#> $exportColumnMap$Q12
#> $exportColumnMap$Q12$question
#> [1] "QID132224519"
#> 
#> 
#> $exportColumnMap$Q13
#> $exportColumnMap$Q13$question
#> [1] "QID132224520"
#> 
#> 
#> $exportColumnMap$Q14
#> $exportColumnMap$Q14$question
#> [1] "QID132224521"
#> 
#> 
#> $exportColumnMap$Q15
#> $exportColumnMap$Q15$question
#> [1] "QID132224522"
#> 
#> 
#> $exportColumnMap$Q16
#> $exportColumnMap$Q16$question
#> [1] "QID132224523"
#> 
#> 
#> $exportColumnMap$Q17
#> $exportColumnMap$Q17$question
#> [1] "QID132224524"
#> 
#> 
#> $exportColumnMap$Q19
#> $exportColumnMap$Q19$question
#> [1] "QID132224525"
#> 
#> 
#> $exportColumnMap$Q21
#> $exportColumnMap$Q21$question
#> [1] "QID132224528"
#> 
#> 
#> $exportColumnMap$Q20
#> $exportColumnMap$Q20$question
#> [1] "QID132224527"
#> 
#> 
#> $exportColumnMap$Q23
#> $exportColumnMap$Q23$question
#> [1] "QID132224530"
#> 
#> 
#> $exportColumnMap$Q22
#> $exportColumnMap$Q22$question
#> [1] "QID132224529"
#> 
#> 
#> $exportColumnMap$Q24
#> $exportColumnMap$Q24$question
#> [1] "QID132224531"
#> 
#> 
#> $exportColumnMap$Q26
#> $exportColumnMap$Q26$question
#> [1] "QID132224532"
#> 
#> 
#> $exportColumnMap$Q27
#> $exportColumnMap$Q27$question
#> [1] "QID132224533"
#> 
#> 
#> $exportColumnMap$Q28
#> $exportColumnMap$Q28$question
#> [1] "QID132224534"
#> 
#> 
#> $exportColumnMap$Q29
#> $exportColumnMap$Q29$question
#> [1] "QID132224535"
#> 
#> 
#> 
#> $blocks
#> $blocks$BL_agzU0yMolbPdFGd
#> $blocks$BL_agzU0yMolbPdFGd$description
#> [1] "Class Evaluation"
#> 
#> $blocks$BL_agzU0yMolbPdFGd$elements
#> $blocks$BL_agzU0yMolbPdFGd$elements[[1]]
#> $blocks$BL_agzU0yMolbPdFGd$elements[[1]]$type
#> [1] "Question"
#> 
#> $blocks$BL_agzU0yMolbPdFGd$elements[[1]]$questionId
#> [1] "QID132224516"
#> 
#> 
#> $blocks$BL_agzU0yMolbPdFGd$elements[[2]]
#> $blocks$BL_agzU0yMolbPdFGd$elements[[2]]$type
#> [1] "Question"
#> 
#> $blocks$BL_agzU0yMolbPdFGd$elements[[2]]$questionId
#> [1] "QID132224536"
#> 
#> 
#> $blocks$BL_agzU0yMolbPdFGd$elements[[3]]
#> $blocks$BL_agzU0yMolbPdFGd$elements[[3]]$type
#> [1] "Question"
#> 
#> $blocks$BL_agzU0yMolbPdFGd$elements[[3]]$questionId
#> [1] "QID132224537"
#> 
#> 
#> $blocks$BL_agzU0yMolbPdFGd$elements[[4]]
#> $blocks$BL_agzU0yMolbPdFGd$elements[[4]]$type
#> [1] "Question"
#> 
#> $blocks$BL_agzU0yMolbPdFGd$elements[[4]]$questionId
#> [1] "QID132224526"
#> 
#> 
#> $blocks$BL_agzU0yMolbPdFGd$elements[[5]]
#> $blocks$BL_agzU0yMolbPdFGd$elements[[5]]$type
#> [1] "Question"
#> 
#> $blocks$BL_agzU0yMolbPdFGd$elements[[5]]$questionId
#> [1] "QID132224538"
#> 
#> 
#> $blocks$BL_agzU0yMolbPdFGd$elements[[6]]
#> $blocks$BL_agzU0yMolbPdFGd$elements[[6]]$type
#> [1] "Question"
#> 
#> $blocks$BL_agzU0yMolbPdFGd$elements[[6]]$questionId
#> [1] "QID132224539"
#> 
#> 
#> $blocks$BL_agzU0yMolbPdFGd$elements[[7]]
#> $blocks$BL_agzU0yMolbPdFGd$elements[[7]]$type
#> [1] "Question"
#> 
#> $blocks$BL_agzU0yMolbPdFGd$elements[[7]]$questionId
#> [1] "QID132224540"
#> 
#> 
#> 
#> 
#> $blocks$BL_0wUDDTxrMh9vOAd
#> $blocks$BL_0wUDDTxrMh9vOAd$description
#> [1] "Teacher Evaluation"
#> 
#> $blocks$BL_0wUDDTxrMh9vOAd$elements
#> $blocks$BL_0wUDDTxrMh9vOAd$elements[[1]]
#> $blocks$BL_0wUDDTxrMh9vOAd$elements[[1]]$type
#> [1] "Question"
#> 
#> $blocks$BL_0wUDDTxrMh9vOAd$elements[[1]]$questionId
#> [1] "QID132224541"
#> 
#> 
#> $blocks$BL_0wUDDTxrMh9vOAd$elements[[2]]
#> $blocks$BL_0wUDDTxrMh9vOAd$elements[[2]]$type
#> [1] "Question"
#> 
#> $blocks$BL_0wUDDTxrMh9vOAd$elements[[2]]$questionId
#> [1] "QID132224518"
#> 
#> 
#> $blocks$BL_0wUDDTxrMh9vOAd$elements[[3]]
#> $blocks$BL_0wUDDTxrMh9vOAd$elements[[3]]$type
#> [1] "Question"
#> 
#> $blocks$BL_0wUDDTxrMh9vOAd$elements[[3]]$questionId
#> [1] "QID132224517"
#> 
#> 
#> $blocks$BL_0wUDDTxrMh9vOAd$elements[[4]]
#> $blocks$BL_0wUDDTxrMh9vOAd$elements[[4]]$type
#> [1] "Question"
#> 
#> $blocks$BL_0wUDDTxrMh9vOAd$elements[[4]]$questionId
#> [1] "QID132224519"
#> 
#> 
#> $blocks$BL_0wUDDTxrMh9vOAd$elements[[5]]
#> $blocks$BL_0wUDDTxrMh9vOAd$elements[[5]]$type
#> [1] "Question"
#> 
#> $blocks$BL_0wUDDTxrMh9vOAd$elements[[5]]$questionId
#> [1] "QID132224520"
#> 
#> 
#> $blocks$BL_0wUDDTxrMh9vOAd$elements[[6]]
#> $blocks$BL_0wUDDTxrMh9vOAd$elements[[6]]$type
#> [1] "Question"
#> 
#> $blocks$BL_0wUDDTxrMh9vOAd$elements[[6]]$questionId
#> [1] "QID132224521"
#> 
#> 
#> $blocks$BL_0wUDDTxrMh9vOAd$elements[[7]]
#> $blocks$BL_0wUDDTxrMh9vOAd$elements[[7]]$type
#> [1] "Question"
#> 
#> $blocks$BL_0wUDDTxrMh9vOAd$elements[[7]]$questionId
#> [1] "QID132224522"
#> 
#> 
#> $blocks$BL_0wUDDTxrMh9vOAd$elements[[8]]
#> $blocks$BL_0wUDDTxrMh9vOAd$elements[[8]]$type
#> [1] "Question"
#> 
#> $blocks$BL_0wUDDTxrMh9vOAd$elements[[8]]$questionId
#> [1] "QID132224523"
#> 
#> 
#> $blocks$BL_0wUDDTxrMh9vOAd$elements[[9]]
#> $blocks$BL_0wUDDTxrMh9vOAd$elements[[9]]$type
#> [1] "Question"
#> 
#> $blocks$BL_0wUDDTxrMh9vOAd$elements[[9]]$questionId
#> [1] "QID132224524"
#> 
#> 
#> 
#> 
#> $blocks$BL_6FK8SIrVsXuBxFX
#> $blocks$BL_6FK8SIrVsXuBxFX$description
#> [1] "Student Performance"
#> 
#> $blocks$BL_6FK8SIrVsXuBxFX$elements
#> $blocks$BL_6FK8SIrVsXuBxFX$elements[[1]]
#> $blocks$BL_6FK8SIrVsXuBxFX$elements[[1]]$type
#> [1] "Question"
#> 
#> $blocks$BL_6FK8SIrVsXuBxFX$elements[[1]]$questionId
#> [1] "QID132224525"
#> 
#> 
#> $blocks$BL_6FK8SIrVsXuBxFX$elements[[2]]
#> $blocks$BL_6FK8SIrVsXuBxFX$elements[[2]]$type
#> [1] "Question"
#> 
#> $blocks$BL_6FK8SIrVsXuBxFX$elements[[2]]$questionId
#> [1] "QID132224528"
#> 
#> 
#> $blocks$BL_6FK8SIrVsXuBxFX$elements[[3]]
#> $blocks$BL_6FK8SIrVsXuBxFX$elements[[3]]$type
#> [1] "Question"
#> 
#> $blocks$BL_6FK8SIrVsXuBxFX$elements[[3]]$questionId
#> [1] "QID132224527"
#> 
#> 
#> $blocks$BL_6FK8SIrVsXuBxFX$elements[[4]]
#> $blocks$BL_6FK8SIrVsXuBxFX$elements[[4]]$type
#> [1] "Question"
#> 
#> $blocks$BL_6FK8SIrVsXuBxFX$elements[[4]]$questionId
#> [1] "QID132224530"
#> 
#> 
#> $blocks$BL_6FK8SIrVsXuBxFX$elements[[5]]
#> $blocks$BL_6FK8SIrVsXuBxFX$elements[[5]]$type
#> [1] "Question"
#> 
#> $blocks$BL_6FK8SIrVsXuBxFX$elements[[5]]$questionId
#> [1] "QID132224529"
#> 
#> 
#> $blocks$BL_6FK8SIrVsXuBxFX$elements[[6]]
#> $blocks$BL_6FK8SIrVsXuBxFX$elements[[6]]$type
#> [1] "Question"
#> 
#> $blocks$BL_6FK8SIrVsXuBxFX$elements[[6]]$questionId
#> [1] "QID132224531"
#> 
#> 
#> $blocks$BL_6FK8SIrVsXuBxFX$elements[[7]]
#> $blocks$BL_6FK8SIrVsXuBxFX$elements[[7]]$type
#> [1] "Question"
#> 
#> $blocks$BL_6FK8SIrVsXuBxFX$elements[[7]]$questionId
#> [1] "QID132224532"
#> 
#> 
#> $blocks$BL_6FK8SIrVsXuBxFX$elements[[8]]
#> $blocks$BL_6FK8SIrVsXuBxFX$elements[[8]]$type
#> [1] "Question"
#> 
#> $blocks$BL_6FK8SIrVsXuBxFX$elements[[8]]$questionId
#> [1] "QID132224533"
#> 
#> 
#> $blocks$BL_6FK8SIrVsXuBxFX$elements[[9]]
#> $blocks$BL_6FK8SIrVsXuBxFX$elements[[9]]$type
#> [1] "Question"
#> 
#> $blocks$BL_6FK8SIrVsXuBxFX$elements[[9]]$questionId
#> [1] "QID132224534"
#> 
#> 
#> $blocks$BL_6FK8SIrVsXuBxFX$elements[[10]]
#> $blocks$BL_6FK8SIrVsXuBxFX$elements[[10]]$type
#> [1] "Question"
#> 
#> $blocks$BL_6FK8SIrVsXuBxFX$elements[[10]]$questionId
#> [1] "QID132224535"
#> 
#> 
#> 
#> 
#> 
#> $flow
#> $flow[[1]]
#> $flow[[1]]$id
#> [1] "BL_agzU0yMolbPdFGd"
#> 
#> $flow[[1]]$type
#> [1] "Block"
#> 
#> 
#> $flow[[2]]
#> $flow[[2]]$id
#> [1] "BL_0wUDDTxrMh9vOAd"
#> 
#> $flow[[2]]$type
#> [1] "Block"
#> 
#> 
#> $flow[[3]]
#> $flow[[3]]$id
#> [1] "BL_6FK8SIrVsXuBxFX"
#> 
#> $flow[[3]]$type
#> [1] "Block"
#> 
#> 
#> 
#> $embeddedData
#> list()
#> 
#> $comments
#> named list()
#> 
#> $responseCounts
#> $responseCounts$auditable
#> [1] 0
#> 
#> $responseCounts$generated
#> [1] 100
#> 
#> $responseCounts$deleted
#> [1] 0
#> 
#> 
#> $json
#> [1] "{\"result\":{\"id\":\"SV_0CGgkDZJaUvxnGl\",\"name\":\"Student Feedback\",\"ownerId\":\"UR_8J1114L8aAeMCPP\",\"organizationId\":\"mit\",\"isActive\":false,\"creationDate\":\"2016-11-24T03:35:27Z\",\"lastModifiedDate\":\"2016-11-24T03:36:38Z\",\"expiration\":{\"startDate\":null,\"endDate\":null},\"questions\":{\"QID132224516\":{\"questionType\":{\"type\":\"MC\",\"selector\":\"SAVR\",\"subSelector\":\"TX\"},\"questionText\":\"Overall, how satisfied or dissatisfied were you with this class?\",\"questionLabel\":null,\"validation\":{\"doesForceResponse\":false},\"choices\":{\"1\":{\"recode\":\"1\",\"description\":\"Extremely satisfied\",\"choiceText\":\"Extremely satisfied\",\"variableName\":null},\"2\":{\"recode\":\"2\",\"description\":\"Moderately satisfied\",\"choiceText\":\"Moderately satisfied\",\"variableName\":null},\"3\":{\"recode\":\"3\",\"description\":\"Slightly satisfied\",\"choiceText\":\"Slightly satisfied\",\"variableName\":null},\"4\":{\"recode\":\"4\",\"description\":\"Neither satisfied nor dissatisfied\",\"choiceText\":\"Neither satisfied nor dissatisfied\",\"variableName\":null},\"5\":{\"recode\":\"5\",\"description\":\"Slightly dissatisfied\",\"choiceText\":\"Slightly dissatisfied\",\"variableName\":null},\"6\":{\"recode\":\"6\",\"description\":\"Moderately dissatisfied\",\"choiceText\":\"Moderately dissatisfied\",\"variableName\":null},\"7\":{\"recode\":\"7\",\"description\":\"Extremely dissatisfied\",\"choiceText\":\"Extremely dissatisfied\",\"variableName\":null}}},\"QID132224536\":{\"questionType\":{\"type\":\"MC\",\"selector\":\"SAVR\",\"subSelector\":\"TX\"},\"questionText\":\"How interesting was this class?\",\"questionLabel\":null,\"validation\":{\"doesForceResponse\":false},\"choices\":{\"1\":{\"recode\":\"1\",\"description\":\"Extremely interesting\",\"choiceText\":\"Extremely interesting\",\"variableName\":null},\"2\":{\"recode\":\"2\",\"description\":\"Very interesting\",\"choiceText\":\"Very interesting\",\"variableName\":null},\"3\":{\"recode\":\"3\",\"description\":\"Moderately interesting\",\"choiceText\":\"Moderately interesting\",\"variableName\":null},\"4\":{\"recode\":\"4\",\"description\":\"Slightly interesting\",\"choiceText\":\"Slightly interesting\",\"variableName\":null},\"5\":{\"recode\":\"5\",\"description\":\"Not interesting at all\",\"choiceText\":\"Not interesting at all\",\"variableName\":null}}},\"QID132224537\":{\"questionType\":{\"type\":\"MC\",\"selector\":\"SAVR\",\"subSelector\":\"TX\"},\"questionText\":\"How challenging was this class?\",\"questionLabel\":null,\"validation\":{\"doesForceResponse\":false},\"choices\":{\"1\":{\"recode\":\"1\",\"description\":\"Extremely challenging\",\"choiceText\":\"Extremely challenging\",\"variableName\":null},\"2\":{\"recode\":\"2\",\"description\":\"Very challenging\",\"choiceText\":\"Very challenging\",\"variableName\":null},\"3\":{\"recode\":\"3\",\"description\":\"Moderately challenging\",\"choiceText\":\"Moderately challenging\",\"variableName\":null},\"4\":{\"recode\":\"4\",\"description\":\"Slightly challenging\",\"choiceText\":\"Slightly challenging\",\"variableName\":null},\"5\":{\"recode\":\"5\",\"description\":\"Not challenging at all\",\"choiceText\":\"Not challenging at all\",\"variableName\":null}}},\"QID132224526\":{\"questionType\":{\"type\":\"MC\",\"selector\":\"SAVR\",\"subSelector\":\"TX\"},\"questionText\":\"How fair or unfair was the workload in this class?\",\"questionLabel\":null,\"validation\":{\"doesForceResponse\":false},\"choices\":{\"1\":{\"recode\":\"1\",\"description\":\"Extremely fair\",\"choiceText\":\"Extremely fair\",\"variableName\":null},\"2\":{\"recode\":\"2\",\"description\":\"Moderately fair\",\"choiceText\":\"Moderately fair\",\"variableName\":null},\"3\":{\"recode\":\"3\",\"description\":\"Slightly fair\",\"choiceText\":\"Slightly fair\",\"variableName\":null},\"4\":{\"recode\":\"4\",\"description\":\"Neither fair nor unfair\",\"choiceText\":\"Neither fair nor unfair\",\"variableName\":null},\"5\":{\"recode\":\"5\",\"description\":\"Slightly unfair\",\"choiceText\":\"Slightly unfair\",\"variableName\":null},\"6\":{\"recode\":\"6\",\"description\":\"Moderately unfair\",\"choiceText\":\"Moderately unfair\",\"variableName\":null},\"7\":{\"recode\":\"7\",\"description\":\"Extremely unfair\",\"choiceText\":\"Extremely unfair\",\"variableName\":null}}},\"QID132224538\":{\"questionType\":{\"type\":\"MC\",\"selector\":\"SAVR\",\"subSelector\":\"TX\"},\"questionText\":\"How clear or unclear were the assignments given in this class?\",\"questionLabel\":null,\"validation\":{\"doesForceResponse\":false},\"choices\":{\"1\":{\"recode\":\"1\",\"description\":\"Extremely clear\",\"choiceText\":\"Extremely clear\",\"variableName\":null},\"2\":{\"recode\":\"2\",\"description\":\"Moderately clear\",\"choiceText\":\"Moderately clear\",\"variableName\":null},\"3\":{\"recode\":\"3\",\"description\":\"Slightly clear\",\"choiceText\":\"Slightly clear\",\"variableName\":null},\"4\":{\"recode\":\"4\",\"description\":\"Neither clear nor unclear\",\"choiceText\":\"Neither clear nor unclear\",\"variableName\":null},\"5\":{\"recode\":\"5\",\"description\":\"Slightly unclear\",\"choiceText\":\"Slightly unclear\",\"variableName\":null},\"6\":{\"recode\":\"6\",\"description\":\"Moderately unclear\",\"choiceText\":\"Moderately unclear\",\"variableName\":null},\"7\":{\"recode\":\"7\",\"description\":\"Extremely unclear\",\"choiceText\":\"Extremely unclear\",\"variableName\":null}}},\"QID132224539\":{\"questionType\":{\"type\":\"MC\",\"selector\":\"SAVR\",\"subSelector\":\"TX\"},\"questionText\":\"How relevant or irrelevant were the tests and quizzes to the topics covered in class?\",\"questionLabel\":null,\"validation\":{\"doesForceResponse\":false},\"choices\":{\"1\":{\"recode\":\"1\",\"description\":\"Extremely relevant\",\"choiceText\":\"Extremely relevant\",\"variableName\":null},\"2\":{\"recode\":\"2\",\"description\":\"Moderately relevant\",\"choiceText\":\"Moderately relevant\",\"variableName\":null},\"3\":{\"recode\":\"3\",\"description\":\"Slightly relevant\",\"choiceText\":\"Slightly relevant\",\"variableName\":null},\"4\":{\"recode\":\"4\",\"description\":\"Neither relevant nor irrelevant\",\"choiceText\":\"Neither relevant nor irrelevant\",\"variableName\":null},\"5\":{\"recode\":\"5\",\"description\":\"Slightly irrelevant\",\"choiceText\":\"Slightly irrelevant\",\"variableName\":null},\"6\":{\"recode\":\"6\",\"description\":\"Moderately irrelevant\",\"choiceText\":\"Moderately irrelevant\",\"variableName\":null},\"7\":{\"recode\":\"7\",\"description\":\"Extremely irrelevant\",\"choiceText\":\"Extremely irrelevant\",\"variableName\":null}}},\"QID132224540\":{\"questionType\":{\"type\":\"MC\",\"selector\":\"NPS\",\"subSelector\":null},\"questionText\":\"On a scale from 0-10, how likely are you to recommend this class to a friend or colleague?\",\"questionLabel\":null,\"validation\":{\"doesForceResponse\":false},\"choices\":{\"0\":{\"recode\":\"0\",\"description\":\"0\",\"choiceText\":\"0\",\"variableName\":null},\"1\":{\"recode\":\"1\",\"description\":\"1\",\"choiceText\":\"1\",\"variableName\":null},\"2\":{\"recode\":\"2\",\"description\":\"2\",\"choiceText\":\"2\",\"variableName\":null},\"3\":{\"recode\":\"3\",\"description\":\"3\",\"choiceText\":\"3\",\"variableName\":null},\"4\":{\"recode\":\"4\",\"description\":\"4\",\"choiceText\":\"4\",\"variableName\":null},\"5\":{\"recode\":\"5\",\"description\":\"5\",\"choiceText\":\"5\",\"variableName\":null},\"6\":{\"recode\":\"6\",\"description\":\"6\",\"choiceText\":\"6\",\"variableName\":null},\"7\":{\"recode\":\"7\",\"description\":\"7\",\"choiceText\":\"7\",\"variableName\":null},\"8\":{\"recode\":\"8\",\"description\":\"8\",\"choiceText\":\"8\",\"variableName\":null},\"9\":{\"recode\":\"9\",\"description\":\"9\",\"choiceText\":\"9\",\"variableName\":null},\"10\":{\"recode\":\"10\",\"description\":\"10\",\"choiceText\":\"10\",\"variableName\":null}}},\"QID132224541\":{\"questionType\":{\"type\":\"MC\",\"selector\":\"SAVR\",\"subSelector\":\"TX\"},\"questionText\":\"<p>Overall, how satisfied or dissatisfied were you with the teacher of this class?</p>\",\"questionLabel\":null,\"validation\":{\"doesForceResponse\":false},\"choices\":{\"1\":{\"recode\":\"1\",\"description\":\"Extremely satisfied\",\"choiceText\":\"Extremely satisfied\",\"variableName\":null},\"2\":{\"recode\":\"2\",\"description\":\"Moderately satisfied\",\"choiceText\":\"Moderately satisfied\",\"variableName\":null},\"3\":{\"recode\":\"3\",\"description\":\"Slightly satisfied\",\"choiceText\":\"Slightly satisfied\",\"variableName\":null},\"4\":{\"recode\":\"4\",\"description\":\"Neither satisfied nor dissatisfied\",\"choiceText\":\"Neither satisfied nor dissatisfied\",\"variableName\":null},\"5\":{\"recode\":\"5\",\"description\":\"Slightly dissatisfied\",\"choiceText\":\"Slightly dissatisfied\",\"variableName\":null},\"6\":{\"recode\":\"6\",\"description\":\"Moderately dissatisfied\",\"choiceText\":\"Moderately dissatisfied\",\"variableName\":null},\"7\":{\"recode\":\"7\",\"description\":\"Extremely dissatisfied\",\"choiceText\":\"Extremely dissatisfied\",\"variableName\":null}}},\"QID132224518\":{\"questionType\":{\"type\":\"MC\",\"selector\":\"SAVR\",\"subSelector\":\"TX\"},\"questionText\":\"<p>How clear or unclear was the teacher’s presentation of class material?</p>\",\"questionLabel\":null,\"validation\":{\"doesForceResponse\":false},\"choices\":{\"1\":{\"recode\":\"1\",\"description\":\"Extremely clear\",\"choiceText\":\"Extremely clear\",\"variableName\":null},\"2\":{\"recode\":\"2\",\"description\":\"Moderately clear\",\"choiceText\":\"Moderately clear\",\"variableName\":null},\"3\":{\"recode\":\"3\",\"description\":\"Slightly clear\",\"choiceText\":\"Slightly clear\",\"variableName\":null},\"4\":{\"recode\":\"4\",\"description\":\"Neither clear nor unclear\",\"choiceText\":\"Neither clear nor unclear\",\"variableName\":null},\"5\":{\"recode\":\"5\",\"description\":\"Slightly unclear\",\"choiceText\":\"Slightly unclear\",\"variableName\":null},\"6\":{\"recode\":\"6\",\"description\":\"Moderately unclear\",\"choiceText\":\"Moderately unclear\",\"variableName\":null},\"7\":{\"recode\":\"7\",\"description\":\"Extremely unclear\",\"choiceText\":\"Extremely unclear\",\"variableName\":null}}},\"QID132224517\":{\"questionType\":{\"type\":\"MC\",\"selector\":\"SAVR\",\"subSelector\":\"TX\"},\"questionText\":\"How well did the teacher facilitate your understanding of class material?\",\"questionLabel\":null,\"validation\":{\"doesForceResponse\":false},\"choices\":{\"1\":{\"recode\":\"1\",\"description\":\"Extremely well\",\"choiceText\":\"Extremely well\",\"variableName\":null},\"2\":{\"recode\":\"2\",\"description\":\"Very well\",\"choiceText\":\"Very well\",\"variableName\":null},\"3\":{\"recode\":\"3\",\"description\":\"Moderately well\",\"choiceText\":\"Moderately well\",\"variableName\":null},\"4\":{\"recode\":\"4\",\"description\":\"Slightly well\",\"choiceText\":\"Slightly well\",\"variableName\":null},\"5\":{\"recode\":\"5\",\"description\":\"Not well at all\",\"choiceText\":\"Not well at all\",\"variableName\":null}}},\"QID132224519\":{\"questionType\":{\"type\":\"MC\",\"selector\":\"SAVR\",\"subSelector\":\"TX\"},\"questionText\":\"How approachable was the teacher outside of class?\",\"questionLabel\":null,\"validation\":{\"doesForceResponse\":false},\"choices\":{\"1\":{\"recode\":\"1\",\"description\":\"Extremely approachable\",\"choiceText\":\"Extremely approachable\",\"variableName\":null},\"2\":{\"recode\":\"2\",\"description\":\"Very approachable\",\"choiceText\":\"Very approachable\",\"variableName\":null},\"3\":{\"recode\":\"3\",\"description\":\"Moderately approachable\",\"choiceText\":\"Moderately approachable\",\"variableName\":null},\"4\":{\"recode\":\"4\",\"description\":\"Slightly approachable\",\"choiceText\":\"Slightly approachable\",\"variableName\":null},\"5\":{\"recode\":\"5\",\"description\":\"Not approachable at all\",\"choiceText\":\"Not approachable at all\",\"variableName\":null}}},\"QID132224520\":{\"questionType\":{\"type\":\"MC\",\"selector\":\"SAVR\",\"subSelector\":\"TX\"},\"questionText\":\"How fair or unfair was the teacher’s grading policy?\",\"questionLabel\":null,\"validation\":{\"doesForceResponse\":false},\"choices\":{\"1\":{\"recode\":\"1\",\"description\":\"Extremely fair\",\"choiceText\":\"Extremely fair\",\"variableName\":null},\"2\":{\"recode\":\"2\",\"description\":\"Moderately fair\",\"choiceText\":\"Moderately fair\",\"variableName\":null},\"3\":{\"recode\":\"3\",\"description\":\"Slightly fair\",\"choiceText\":\"Slightly fair\",\"variableName\":null},\"4\":{\"recode\":\"4\",\"description\":\"Neither fair nor unfair\",\"choiceText\":\"Neither fair nor unfair\",\"variableName\":null},\"5\":{\"recode\":\"5\",\"description\":\"Slightly unfair\",\"choiceText\":\"Slightly unfair\",\"variableName\":null},\"6\":{\"recode\":\"6\",\"description\":\"Moderately unfair\",\"choiceText\":\"Moderately unfair\",\"variableName\":null},\"7\":{\"recode\":\"7\",\"description\":\"Extremely unfair\",\"choiceText\":\"Extremely unfair\",\"variableName\":null}}},\"QID132224521\":{\"questionType\":{\"type\":\"MC\",\"selector\":\"SAVR\",\"subSelector\":\"TX\"},\"questionText\":\"How effective was the teacher’s approach to teaching?\",\"questionLabel\":null,\"validation\":{\"doesForceResponse\":false},\"choices\":{\"1\":{\"recode\":\"1\",\"description\":\"Extremely effective\",\"choiceText\":\"Extremely effective\",\"variableName\":null},\"2\":{\"recode\":\"2\",\"description\":\"Very effective\",\"choiceText\":\"Very effective\",\"variableName\":null},\"3\":{\"recode\":\"3\",\"description\":\"Moderately effective\",\"choiceText\":\"Moderately effective\",\"variableName\":null},\"4\":{\"recode\":\"4\",\"description\":\"Slightly effective\",\"choiceText\":\"Slightly effective\",\"variableName\":null},\"5\":{\"recode\":\"5\",\"description\":\"Not effective at all\",\"choiceText\":\"Not effective at all\",\"variableName\":null}}},\"QID132224522\":{\"questionType\":{\"type\":\"MC\",\"selector\":\"SAVR\",\"subSelector\":\"TX\"},\"questionText\":\"How much did the teacher care about the students?\",\"questionLabel\":null,\"validation\":{\"doesForceResponse\":false},\"choices\":{\"1\":{\"recode\":\"1\",\"description\":\"A great deal\",\"choiceText\":\"A great deal\",\"variableName\":null},\"2\":{\"recode\":\"2\",\"description\":\"A lot\",\"choiceText\":\"A lot\",\"variableName\":null},\"3\":{\"recode\":\"3\",\"description\":\"A moderate amount\",\"choiceText\":\"A moderate amount\",\"variableName\":null},\"4\":{\"recode\":\"4\",\"description\":\"A little\",\"choiceText\":\"A little\",\"variableName\":null},\"5\":{\"recode\":\"5\",\"description\":\"Not at all\",\"choiceText\":\"Not at all\",\"variableName\":null}}},\"QID132224523\":{\"questionType\":{\"type\":\"MC\",\"selector\":\"SAVR\",\"subSelector\":\"TX\"},\"questionText\":\"How open minded was the teacher?\",\"questionLabel\":null,\"validation\":{\"doesForceResponse\":false},\"choices\":{\"1\":{\"recode\":\"1\",\"description\":\"Extremely open minded\",\"choiceText\":\"Extremely open minded\",\"variableName\":null},\"2\":{\"recode\":\"2\",\"description\":\"Very open minded\",\"choiceText\":\"Very open minded\",\"variableName\":null},\"3\":{\"recode\":\"3\",\"description\":\"Moderately open minded\",\"choiceText\":\"Moderately open minded\",\"variableName\":null},\"4\":{\"recode\":\"4\",\"description\":\"Slightly open minded\",\"choiceText\":\"Slightly open minded\",\"variableName\":null},\"5\":{\"recode\":\"5\",\"description\":\"Not open minded at all\",\"choiceText\":\"Not open minded at all\",\"variableName\":null}}},\"QID132224524\":{\"questionType\":{\"type\":\"MC\",\"selector\":\"SAVR\",\"subSelector\":\"TX\"},\"questionText\":\"How knowledgeable was the teacher of the material being taught in class?\",\"questionLabel\":null,\"validation\":{\"doesForceResponse\":false},\"choices\":{\"1\":{\"recode\":\"1\",\"description\":\"Extremely knowledgeable\",\"choiceText\":\"Extremely knowledgeable\",\"variableName\":null},\"2\":{\"recode\":\"2\",\"description\":\"Very knowledgeable\",\"choiceText\":\"Very knowledgeable\",\"variableName\":null},\"3\":{\"recode\":\"3\",\"description\":\"Moderately knowledgeable\",\"choiceText\":\"Moderately knowledgeable\",\"variableName\":null},\"4\":{\"recode\":\"4\",\"description\":\"Slightly knowledgeable\",\"choiceText\":\"Slightly knowledgeable\",\"variableName\":null},\"5\":{\"recode\":\"5\",\"description\":\"Not knowledgeable at all\",\"choiceText\":\"Not knowledgeable at all\",\"variableName\":null}}},\"QID132224525\":{\"questionType\":{\"type\":\"MC\",\"selector\":\"SAVR\",\"subSelector\":\"TX\"},\"questionText\":\"How satisfied or dissatisfied were you with your effort in class?\",\"questionLabel\":null,\"validation\":{\"doesForceResponse\":false},\"choices\":{\"1\":{\"recode\":\"1\",\"description\":\"Extremely satisfied\",\"choiceText\":\"Extremely satisfied\",\"variableName\":null},\"2\":{\"recode\":\"2\",\"description\":\"Moderately satisifed\",\"choiceText\":\"Moderately satisifed\",\"variableName\":null},\"3\":{\"recode\":\"3\",\"description\":\"Slightly satisfied\",\"choiceText\":\"Slightly satisfied\",\"variableName\":null},\"4\":{\"recode\":\"4\",\"description\":\"Neither satisfied nor dissatisfied\",\"choiceText\":\"Neither satisfied nor dissatisfied\",\"variableName\":null},\"5\":{\"recode\":\"5\",\"description\":\"Slightly dissatisfied\",\"choiceText\":\"Slightly dissatisfied\",\"variableName\":null},\"6\":{\"recode\":\"6\",\"description\":\"Moderately dissatisfied\",\"choiceText\":\"Moderately dissatisfied\",\"variableName\":null},\"7\":{\"recode\":\"7\",\"description\":\"Extremely dissatisfied\",\"choiceText\":\"Extremely dissatisfied\",\"variableName\":null}}},\"QID132224528\":{\"questionType\":{\"type\":\"MC\",\"selector\":\"SAVR\",\"subSelector\":\"TX\"},\"questionText\":\"How satisfied or dissatisfied were you with your work in this class?\",\"questionLabel\":null,\"validation\":{\"doesForceResponse\":false},\"choices\":{\"1\":{\"recode\":\"1\",\"description\":\"Extremely satisfied\",\"choiceText\":\"Extremely satisfied\",\"variableName\":null},\"2\":{\"recode\":\"2\",\"description\":\"Moderately satisifed\",\"choiceText\":\"Moderately satisifed\",\"variableName\":null},\"3\":{\"recode\":\"3\",\"description\":\"Slightly satisfied\",\"choiceText\":\"Slightly satisfied\",\"variableName\":null},\"4\":{\"recode\":\"4\",\"description\":\"Neither satisfied nor dissatisfied\",\"choiceText\":\"Neither satisfied nor dissatisfied\",\"variableName\":null},\"5\":{\"recode\":\"5\",\"description\":\"Slightly dissatisfied\",\"choiceText\":\"Slightly dissatisfied\",\"variableName\":null},\"6\":{\"recode\":\"6\",\"description\":\"Moderately dissatisfied\",\"choiceText\":\"Moderately dissatisfied\",\"variableName\":null},\"7\":{\"recode\":\"7\",\"description\":\"Extremely dissatisfied\",\"choiceText\":\"Extremely dissatisfied\",\"variableName\":null}}},\"QID132224527\":{\"questionType\":{\"type\":\"MC\",\"selector\":\"SAVR\",\"subSelector\":\"TX\"},\"questionText\":\"How much do you feel you learned from this class?\",\"questionLabel\":null,\"validation\":{\"doesForceResponse\":false},\"choices\":{\"1\":{\"recode\":\"1\",\"description\":\"A great deal\",\"choiceText\":\"A great deal\",\"variableName\":null},\"2\":{\"recode\":\"2\",\"description\":\"A lot\",\"choiceText\":\"A lot\",\"variableName\":null},\"3\":{\"recode\":\"3\",\"description\":\"A moderate amount\",\"choiceText\":\"A moderate amount\",\"variableName\":null},\"4\":{\"recode\":\"4\",\"description\":\"A little\",\"choiceText\":\"A little\",\"variableName\":null},\"5\":{\"recode\":\"5\",\"description\":\"Nothing at all\",\"choiceText\":\"Nothing at all\",\"variableName\":null}}},\"QID132224530\":{\"questionType\":{\"type\":\"MC\",\"selector\":\"SAVR\",\"subSelector\":\"TX\"},\"questionText\":\"How much did you enjoy taking this class?\",\"questionLabel\":null,\"validation\":{\"doesForceResponse\":false},\"choices\":{\"1\":{\"recode\":\"1\",\"description\":\"A great deal\",\"choiceText\":\"A great deal\",\"variableName\":null},\"2\":{\"recode\":\"2\",\"description\":\"A lot\",\"choiceText\":\"A lot\",\"variableName\":null},\"3\":{\"recode\":\"3\",\"description\":\"A moderate amount\",\"choiceText\":\"A moderate amount\",\"variableName\":null},\"4\":{\"recode\":\"4\",\"description\":\"A little\",\"choiceText\":\"A little\",\"variableName\":null},\"5\":{\"recode\":\"5\",\"description\":\"Nothing at all\",\"choiceText\":\"Nothing at all\",\"variableName\":null}}},\"QID132224529\":{\"questionType\":{\"type\":\"TE\",\"selector\":\"ML\",\"subSelector\":null},\"questionText\":\"What did you like most about this class?  Be as specific as possible, and list as many aspects as you feel are appropriate.\",\"questionLabel\":null,\"validation\":{\"doesForceResponse\":false,\"type\":\"MinChar\",\"settings\":{\"minChars\":5}}},\"QID132224531\":{\"questionType\":{\"type\":\"TE\",\"selector\":\"ML\",\"subSelector\":null},\"questionText\":\"What did you like least about this class?  Be as specific as possible, and list as many aspects as you feel are appropriate.\",\"questionLabel\":null,\"validation\":{\"doesForceResponse\":false,\"type\":\"MinChar\",\"settings\":{\"minChars\":5}}},\"QID132224532\":{\"questionType\":{\"type\":\"TE\",\"selector\":\"ML\",\"subSelector\":null},\"questionText\":\"What did you enjoy about this teacher’s style of teaching?\",\"questionLabel\":null,\"validation\":{\"doesForceResponse\":false,\"type\":\"MinChar\",\"settings\":{\"minChars\":5}}},\"QID132224533\":{\"questionType\":{\"type\":\"TE\",\"selector\":\"ML\",\"subSelector\":null},\"questionText\":\"How could this teacher improve his/her teaching style and/or class?\",\"questionLabel\":null,\"validation\":{\"doesForceResponse\":false,\"type\":\"MinChar\",\"settings\":{\"minChars\":5}}},\"QID132224534\":{\"questionType\":{\"type\":\"TE\",\"selector\":\"ML\",\"subSelector\":null},\"questionText\":\"What is one thing that you will take away from this class?\",\"questionLabel\":null,\"validation\":{\"doesForceResponse\":false,\"type\":\"MinChar\",\"settings\":{\"minChars\":5}}},\"QID132224535\":{\"questionType\":{\"type\":\"TE\",\"selector\":\"ML\",\"subSelector\":null},\"questionText\":\"If you have any other thoughts/comments/feedback on this teacher or this class, please include them below.\",\"questionLabel\":null,\"validation\":{\"doesForceResponse\":false,\"type\":\"MinChar\",\"settings\":{\"minChars\":5}}}},\"exportColumnMap\":{\"Q1\":{\"question\":\"QID132224516\"},\"Q3\":{\"question\":\"QID132224536\"},\"Q4\":{\"question\":\"QID132224537\"},\"Q2\":{\"question\":\"QID132224526\"},\"Q6\":{\"question\":\"QID132224538\"},\"Q7\":{\"question\":\"QID132224539\"},\"Q8\":{\"question\":\"QID132224540\"},\"Q9\":{\"question\":\"QID132224541\"},\"Q11\":{\"question\":\"QID132224518\"},\"Q10\":{\"question\":\"QID132224517\"},\"Q12\":{\"question\":\"QID132224519\"},\"Q13\":{\"question\":\"QID132224520\"},\"Q14\":{\"question\":\"QID132224521\"},\"Q15\":{\"question\":\"QID132224522\"},\"Q16\":{\"question\":\"QID132224523\"},\"Q17\":{\"question\":\"QID132224524\"},\"Q19\":{\"question\":\"QID132224525\"},\"Q21\":{\"question\":\"QID132224528\"},\"Q20\":{\"question\":\"QID132224527\"},\"Q23\":{\"question\":\"QID132224530\"},\"Q22\":{\"question\":\"QID132224529\"},\"Q24\":{\"question\":\"QID132224531\"},\"Q26\":{\"question\":\"QID132224532\"},\"Q27\":{\"question\":\"QID132224533\"},\"Q28\":{\"question\":\"QID132224534\"},\"Q29\":{\"question\":\"QID132224535\"}},\"blocks\":{\"BL_agzU0yMolbPdFGd\":{\"description\":\"Class Evaluation\",\"elements\":[{\"type\":\"Question\",\"questionId\":\"QID132224516\"},{\"type\":\"Question\",\"questionId\":\"QID132224536\"},{\"type\":\"Question\",\"questionId\":\"QID132224537\"},{\"type\":\"Question\",\"questionId\":\"QID132224526\"},{\"type\":\"Question\",\"questionId\":\"QID132224538\"},{\"type\":\"Question\",\"questionId\":\"QID132224539\"},{\"type\":\"Question\",\"questionId\":\"QID132224540\"}]},\"BL_0wUDDTxrMh9vOAd\":{\"description\":\"Teacher Evaluation\",\"elements\":[{\"type\":\"Question\",\"questionId\":\"QID132224541\"},{\"type\":\"Question\",\"questionId\":\"QID132224518\"},{\"type\":\"Question\",\"questionId\":\"QID132224517\"},{\"type\":\"Question\",\"questionId\":\"QID132224519\"},{\"type\":\"Question\",\"questionId\":\"QID132224520\"},{\"type\":\"Question\",\"questionId\":\"QID132224521\"},{\"type\":\"Question\",\"questionId\":\"QID132224522\"},{\"type\":\"Question\",\"questionId\":\"QID132224523\"},{\"type\":\"Question\",\"questionId\":\"QID132224524\"}]},\"BL_6FK8SIrVsXuBxFX\":{\"description\":\"Student Performance\",\"elements\":[{\"type\":\"Question\",\"questionId\":\"QID132224525\"},{\"type\":\"Question\",\"questionId\":\"QID132224528\"},{\"type\":\"Question\",\"questionId\":\"QID132224527\"},{\"type\":\"Question\",\"questionId\":\"QID132224530\"},{\"type\":\"Question\",\"questionId\":\"QID132224529\"},{\"type\":\"Question\",\"questionId\":\"QID132224531\"},{\"type\":\"Question\",\"questionId\":\"QID132224532\"},{\"type\":\"Question\",\"questionId\":\"QID132224533\"},{\"type\":\"Question\",\"questionId\":\"QID132224534\"},{\"type\":\"Question\",\"questionId\":\"QID132224535\"}]}},\"flow\":[{\"id\":\"BL_agzU0yMolbPdFGd\",\"type\":\"Block\"},{\"id\":\"BL_0wUDDTxrMh9vOAd\",\"type\":\"Block\"},{\"id\":\"BL_6FK8SIrVsXuBxFX\",\"type\":\"Block\"}],\"embeddedData\":[],\"comments\":{},\"responseCounts\":{\"auditable\":0,\"generated\":100,\"deleted\":0}},\"meta\":{\"httpStatus\":\"200 - OK\",\"requestId\":\"33781d5a-7cdc-47ec-bfa7-916a3d5ee127\"}}"
#> 
#> attr(,"class")
#> [1] "qualtrics_design" "list"
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

<script type="application/json" data-for="htmlwidget-4c1254f21126e293cb6c">{"x":{"nodes":{"id":[2,3,1],"parent_id":[0,0,0],"type":["Block","Block","Block"],"label":["Teacher Evaluation","Student Performance","Class Evaluation"],"block_id":["BL_0wUDDTxrMh9vOAd","BL_6FK8SIrVsXuBxFX","BL_agzU0yMolbPdFGd"],"color":["#d9d9d9","#d9d9d9","#d9d9d9"]},"edges":{"from":[0,1,2],"to":[1,2,3],"type":["deterministic","deterministic","deterministic"],"color":["#000000","#000000","#000000"]},"options":{"width":"100%","height":"100%","nodes":{"shape":"dot"},"manipulation":{"enabled":false},"interaction":{"dragNodes":false,"dragView":false,"zoomView":false},"edges":{"arrows":"to"},"layout":{"hierarchical":{"enabled":true,"direction":"LR","sortMethod":"directed"}}},"groups":null,"width":null,"height":null,"idselection":{"enabled":false},"byselection":{"enabled":false},"main":null,"submain":null,"footer":null},"evals":[],"jsHooks":[]}</script>
<!--/html_preserve-->
Related
-------

-   [qualtRics](https://github.com/JasperHG90/qualtRics) is another R package for working with the Qualtrics API that began around the same time as qsurvey.

-   [qualtricsR](https://github.com/saberry/qualtricsR) focuses on survey creation.

-   I'm aware of two R packages for earlier versions of the Qualtrics API. [Jason Bryer](https://github.com/jbryer/qualtrics) wrote one in 2012. [Eric Green](https://github.com/ericpgreen/qualtrics) forked and revised it for v2.3 of the Qualtrics API, most recently in 2014.

-   [QualtricsTools](https://github.com/ctesta01/QualtricsTools) generates reports from Qualtrics data via Shiny.

-   Python: [PyQualtrics](https://github.com/Baguage/pyqualtrics); [SurveyHelper](https://github.com/cwade/surveyhelper).
