`getBody()`
-----------

Public: Get body from curl -i output

Removes carriage returns with sed due to curl sometimes returning those Removes everthing before the first empty line with sed.

* $1 - curl -i output

Outputs curl response body


`getHeaders()`
--------------

Public: Get headers from curl -i output

Removes carriage returns with sed due to curl sometimes returning those Removes everthing after the first empty line with sed.

* $1 - curl -i output

Outputs curl response headers


`getNextPageLink()`
-------------------

Public: Get next page link from curl headers.

Parses the "next" page link from Link header.

* $1 - curl -i header output from getHeaders

Outputs the parsed "next" http link


