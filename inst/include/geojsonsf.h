#ifndef GEOJSONSF_H
#define GEOJSONSF_H

//#include "rapidjson/document.h"
#include <Rcpp.h>

//#include "geojson_sfg.h"
//#include "geojson_sfc.h"
//#include "geojson_validate.h"

//#include "geojson_to_sf.h"
//#include "geojson_properties.h"

//#include "geojson_wkt.h"
//#include "sf_geojson.h"

using namespace Rcpp;

// [[Rcpp::depends(rapidjsonr)]]

namespace geojsonsf {
  const int EPSG = 4326;
  const std::string PROJ4STRING = "+proj=longlat +datum=WGS84 +no_defs";
}

template <int RTYPE>
Rcpp::CharacterVector sfClass(Vector<RTYPE> v);

Rcpp::CharacterVector getSfClass(SEXP sf);

#define UNKNOWN            0
#define POINT              1
#define MULTIPOINT         2
#define LINESTRING         3
#define MULTILINESTRING    4
#define POLYGON            5
#define MULTIPOLYGON       6
#define GEOMETRYCOLLECTION 7

#endif
