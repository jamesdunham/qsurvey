# qsurvey

A toolkit for working with the Qualtrics platform and its survey data in R.
Download responses and designs directly into a session, then:

* Examine branching, randomization, and question attributes like validation
* Represent survey flows as directed graphs for interactive review in Shiny
* Map question ids to labels and translate between choice codes and descriptions in response data

Functionality focuses on testing and review of surveys, before fielding, and
analysis of responses afterward. 

For authentication, an API key is needed. See the [Qualtrics
documentation](https://www.qualtrics.com/support/integrations/api-integration/api-integration).

I'm aware of two other Qualtrics packages. [Jason Bryer](https://github.com/jbryer/qualtrics) 
wrote one in 2012. [Eric  Green](https://github.com/ericpgreen/qualtrics) forked 
and revised it for v2.3 of the Qualtrics API, most recently in 2014. I started
qsurvey while staffing [MIT
PERL](http://web.mit.edu/polisci/research/perl.html).
