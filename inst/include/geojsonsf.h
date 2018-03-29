#include <Rcpp.h>
using namespace Rcpp;

#ifndef GEOJSONSF_H
#define GEOJSONSF_H

namespace geojsonsf {
  const int EPSG = 4326;
  const std::string PROJ4STRING = "+proj=longlat +datum=WGS84 +no_defs";
}


#endif
