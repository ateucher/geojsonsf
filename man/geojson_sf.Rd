% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/geojson_sf.R
\name{geojson_sf}
\alias{geojson_sf}
\title{Geojson to sf}
\usage{
geojson_sf(geojson, expand_geometries = FALSE)
}
\arguments{
\item{geojson}{string or vector of GeoJSON, or a URL or file pointing to a geojson file}

\item{expand_geometries}{logical indicating whether to unnest GEOMETRYCOLLECTION rows. see details}
}
\description{
Converts GeoJSON to an `sf` object
}
\details{
specifying \code{expand_geometries = TRUE} will expand individual \code{GEOMETRYCOLLECTION}
geometries to their own row in the resulting `sf` object. If the geometries are part
of a \code{Feature} (i.e., with properties), the properties will be repeated on each row.

The \code{GEOMETRYCOLLECTION} information is not kept when using \code{expand_geometries = TRUE}. Therefore,
it is not possible to reconstruct the \code{GEOMETRYCOLLECTION} after unnesting it.
}
\examples{

## character string of GeoJSON

## load 'sf' for print methods
# library(sf)
geojson <- '{ "type" : "Point", "coordinates" : [0, 0] }'
geojson_sf(geojson)


\dontrun{
## GeoJSON at a url
myurl <- "http://eric.clst.org/assets/wiki/uploads/Stuff/gz_2010_us_050_00_500k.json"
sf <- geojson_sf(myurl)
}

}
