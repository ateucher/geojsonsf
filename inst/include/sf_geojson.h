#ifndef SFGEOJSON_H
#define SFGEOJSON_H

#include <Rcpp.h>
using namespace Rcpp;


//void add_geometrycollection_to_stream(std::ostringstream& os, Rcpp::List& gc);

void begin_geojson_geometry(Rcpp::String& geojson, std::string& geom_type);

void begin_geojson_geometry(Rcpp::String& geojson, Rcpp::List& sfc, std::string& geom_type);

void end_geojson_geometry(Rcpp::String& geojson, std::string& geom_type);

void add_lonlat_to_stream(Rcpp::String& geojson, Rcpp::NumericVector& points);

void fetch_coordinates(Rcpp::String& geojson, Rcpp::List& sfc, int& object_counter);

void coord_separator(Rcpp::String& geojson, int i, int n);

void line_separator_geojson(Rcpp::String& geojson, int i, int n);

void polygon_separator_geojson(Rcpp::String& geojson, int i, int n);

#endif
