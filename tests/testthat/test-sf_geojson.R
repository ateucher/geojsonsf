context("sf geojson")


test_that("single sf objects converted to GeoJSON", {

	js <- '{"type":"Point","coordinates":[0,0]}'
	sf <- geojson_sf(js)
	expect_true(sf_geojson(sf) == js)

	js <- '{"type":"MultiPoint","coordinates":[[0,0],[1,1]]}'
	sf <- geojson_sf(js)
	expect_true(sf_geojson(sf) == js)

	js <- '{"type":"LineString","coordinates":[[0,0],[1,1]]}'
	sf <- geojson_sf(js)
	expect_true(sf_geojson(sf) == js)

	js <- '{"type":"MultiLineString","coordinates":[[[0,0],[1,1]]]}'
	sf <- geojson_sf(js)
	expect_true(sf_geojson(sf) == js)

	js <- '{"type":"MultiLineString","coordinates":[[[0,0],[1,1]],[[2,2],[3,3]]]}'
	sf <- geojson_sf(js)
	expect_true(sf_geojson(sf) == js)

	js <- '{"type":"Polygon","coordinates":[[[0,0],[1,1]]]}'
	sf <- geojson_sf(js)
	expect_true(sf_geojson(sf) == js)

	js <- '{"type":"MultiPolygon","coordinates":[[[[0,0],[0,1],[1,1],[1,0],[0,0]],[[2,2],[2,3],[3,3],[3,2],[2,2]]]]}'
	sf <- geojson_sf(js)
	expect_true(sf_geojson(sf) == js)

	js <- '{"type":"MultiPolygon","coordinates":[
    [[[0,0],[0,1],[1,1],[1,0],[0,0]],
    [[0.5,0.5],[0.5,0.75],[0.75,0.75],[0.75,0.5],[0.5,0.5]]],
	  [[[2,2],[2,3],[3,3],[3,2],[2,2]]]
	  ]}'

	expect_true(sf_geojson(geojson_sf(js), TRUE) == gsub(" |\\r|\\n|\\t","",js))

	js <- '{
	  "type": "GeometryCollection", "geometries": [
	    {"type": "Point", "coordinates": [100, 0]},
	    {"type": "LineString", "coordinates": [[101, 0], [102, 1]]},
	    {"type" : "MultiPoint", "coordinates" : [[0,0], [1,1], [2,2]]}
	  ]}'
	sf <- geojson_sf(js)
	j <- sf_geojson(sf)
	expect_true(gsub(" |\\n|\\r|\\t","",js) == j)

	## TODO: decimal points?
	# js <- '{
	#   "type": "GeometryCollection", "geometries": [
	# {"type": "Point", "coordinates": [100.0, 0.0]},
	# {"type": "LineString", "coordinates": [[101.0, 0.0], [102.0, 1.0]]},
	# {"type" : "MultiPoint", "coordinates" : [[0,0], [1,1], [2,2]]}
	# ]}'
	# sf <- geojson_sf(js)
	# j <- sf_geojson(sf)
	# gsub(" |\\n|\\r","",js) == j


})


test_that("sf without properties not converted to FeatureCollections", {

	js <- '[{"type" : "Polygon", "coordinates" : [ [ [0, 0], [1, 1] ] ]},
{"type" : "MultiLineString", "coordinates" : [ [ [0, 0], [1, 1] ], [[3,3],[4,4]] ]}]'
	sf <- geojson_sf(js)
	expect_true(all(sf_geojson(sf, atomise = F) == sf_geojson(sf, atomise = T)))

	js <- '[{"type" : "Polygon", "coordinates" : [ [ [0, 0], [1, 1] ] ]},
	{"type" : "MultiLineString", "coordinates" : [ [ [0, 0], [1, 1] ] ]},
	{
	"type": "GeometryCollection", "geometries": [
	{"type": "Point", "coordinates": [100.0, 0.0]},
	{"type": "LineString", "coordinates": [[101.0, 0.0], [102.0, 1.0]]},
	{"type" : "MultiPoint", "coordinates" : [[0,0], [1,1], [2,2]]}
	]}
	]'
	sf <- geojson_sf(js)
	expect_true(all(sf_geojson(sf, atomise = T) == sf_geojson(sf, atomise = F)))

})

test_that("sf with properties converted to FeatureCollection", {

	## Array of features is actually a FeatureCollection
	skip_on_cran()
	skip_on_travis()
	js <- '[
	{
	  "type": "Feature",
	  "properties" : {"id":null,"foo":null,"bar":null},
	  "geometry": {
	  "type": "Polygon",
	  "coordinates": [[[-10, -10],[10, -10],[10, 10],[-10, -10]]]
	  }
	},
	{
		"type": "Feature",
  		"properties" : { "id" : 1, "foo" : false, "bar" : "world" },
  		"geometry": {
  		"type": "MultiPolygon",
  		"coordinates": [
  		[[[180, 40], [180, 50], [170, 50],[170, 40], [180, 40]]],
      [[[-170, 40], [-170, 50], [-180, 50],[-180, 40], [-170, 40]]]]
		}
	}]'
	sf <- geojson_sf(js)
	jsonlite::validate(sf_geojson(sf, atomise = F))
	v <- sf_geojson(sf, atomise = T)
	expect_true(all(sapply(v, jsonlite::validate)))


	## TODO: should this be a feature, or a feature collection?
	## if it's one row, perhaps just a 'feature'
	# js <- '{
	#   "type": "Feature",
	#   "geometry": {"type": "LineString","coordinates": [[100.0, 0.0], [101.0, 1.0]]},
	#   "properties": {"prop0": "value0"}}'
	#
	# sf_geojson( geojson_sf(js)) == gsub(" |\\r|\\n|\\t","",js)

	js <- '
    {"type": "Feature","geometry": {"type": "LineString","coordinates": [[100.0, 0.0], [101.0, 1.0]]},
	  "properties": {"prop0": "value0","prop1": "value1"}}'
	expect_true(jsonlite::validate(sf_geojson( geojson_sf(js))))

	fgc <- '
	{"type": "Feature","geometry": {"type": "GeometryCollection","geometries": [
    {"type": "Point","coordinates": [100.0, 0.0]},
		{"type": "LineString","coordinates": [[101.0, 0.0], [102.0, 1.0]]}]},
		"properties": {"prop0": "value0","prop1": "value1"}}'
	sf <- geojson_sf(fgc)
	expect_true(jsonlite::validate(sf_geojson(sf)))
	expect_true(grepl("prop0",sf_geojson(sf)))
	expect_true(grepl("prop1",sf_geojson(sf)))
	expect_true(grepl("FeatureCollection",sf_geojson(sf)))

	js <- '{
	  "type" : "Feature",
	  "properties" : {},
	  "geometry" : {
	    "type": "GeometryCollection", "geometries": [
	      {"type": "Point", "coordinates": [100.0, 0.0]},
	      {"type": "LineString", "coordinates": [[101.0, 0.0], [102.0, 1.0]]},
	      {"type" : "MultiPoint", "coordinates" : [[0,0], [1,1], [2,2]]}
	    ]
	  }
	}'
	sf <- geojson_sf(js)
	## properties are null, so they wont' be found to be converted back to JSON
	expect_false(grepl("properties",sf_geojson(sf)))

	fc1 <- '{"type": "FeatureCollection","features": [
	  {"type": "Feature","properties": null,"geometry": {
	    "type": "Point", "coordinates": [100.0, 0.0]}
	  }]
	}'
	sf <- geojson_sf(fc1)
  expect_false(grepl("properties",sf_geojson(sf)))


})

