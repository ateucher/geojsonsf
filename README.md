geojsonsf
================

[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/geojsonsf)](http://cran.r-project.org/package=geojsonsf)
![downloads](http://cranlogs.r-pkg.org/badges/grand-total/geojsonsf)
[![CRAN RStudio mirror
downloads](http://cranlogs.r-pkg.org/badges/geojsonsf)](http://cran.r-project.org/web/packages/geojsonsf/index.html)
[![Github
Stars](https://img.shields.io/github/stars/SymbolixAU/geojsonsf.svg?style=social&label=Github)](https://github.com/SymbolixAU/geojsonsf)
[![Build
Status](https://travis-ci.org/SymbolixAU/geojsonsf.svg?branch=master)](https://travis-ci.org/SymbolixAU/geojsonsf)
[![Coverage
Status](https://codecov.io/github/SymbolixAU/geojsonsf/coverage.svg?branch=master)](https://codecov.io/github/SymbolixAU/geojsonsf?branch=master)

## geojsonsf

A simple, low-dependency and **fast** converter between GeoJSON and
Simple Feature objects in R.

-----

**v1.0**

Converts

  - GeoJSON –\> `sf`
  - GeoJSON –\> `sfc`
  - `sf` –\> GeoJSON
  - `sfc` –\> GeoJSON
  - GeoJSON –\> Well-known text

As per GeoJSON ([RFC 7946
specification)](https://tools.ietf.org/html/rfc7946#page-11), foreign
members are ignored, and nested objects and arrays inside the
`properties` object are converted to string/characters.
