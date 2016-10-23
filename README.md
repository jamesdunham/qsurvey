# qualtrics

A toolkit for working with the Qualtrics platform and its survey data in R.

Main features:

* Download survey responses into an R session
* Retrieve a survey's question identifiers, labels, and text
* List survey metadata (e.g. active/closed status and expiration dates)
* Drop sensitive fields from survey responses

For authentication, an API key is needed. See the [Qualtrics
documentation](https://www.qualtrics.com/support/integrations/api-integration/api-integration).

I'm aware of two other Qualtrics packages. [Jason Bryer](https://github.com/jbryer/qualtrics) 
wrote one in 2012. [Eric  Green](https://github.com/ericpgreen/qualtrics) forked 
and revised it for v2.3 of the Qualtrics API, most recently in 2014.
