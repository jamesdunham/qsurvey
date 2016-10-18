# qualtrics

This package aims to make working with Qualtrics surveys in R easier.

Main features:

* Download survey responses into an R session
* Retrieve a survey's question identifiers, labels, and text
* List surveys' active/closed status and expiration date
* Drop sensitive columns (like `IPAddress`) from tables of survey responses
* Check response counts

The package works by sending requests to the Qualtrics API. For authentication, 
an API key is needed. The package looks for the key first in the current working
directory in the file `.api_key`, and then as a global variable `api_key`.

qualtrics focuses on survey responses and designs. To access API endpoints that
are not available through package functions, `qget` and `qpost` request wrappers
are available.

I'm aware of two other Qualtrics packages. [Jason Bryer](https://github.com/jbryer/qualtrics) 
wrote one in 2012. [Eric  Green](https://github.com/ericpgreen/qualtrics) forked 
and revised it for v2.3 of the Qualtrics API, most recently in 2014.
