pkgs <- installed.packages()
head(pkgs)

nrow(pkgs)

update.packages()
remove.packages("osmdata")

install.packages("magrittr", "osmdata", "sf", "sp")
#install.packages("tmap") --> don't recommend on RStudio.cloud

library(magrittr)
library(osmdata)
library(sf)
library(sp)
#library(tmap)

#Downloading OSM Data
opq(bbox = 'minneapolis') %>%
  add_osm_feature(key = 'highway', value = "cycleway") %>%
  osmdata_sp()

#Bounding box
mpls_bb <- getbb(place_name = "minneapolis")

opq(mpls_bb)
opq(bbox = "minneapolis") # Produces the same thing
opq(bbox = c(-93.32916,44.89015,-93.19386,45.05125)) # Also produces the same thing

#specific features
opq(mpls_bb) %>% 
  add_osm_feature(key = "highway", value = "cycleway")

#query
opq(mpls_bb) %>% 
  add_osm_feature(key = "highway", value = "cycleway") %>% 
  opq_string()

#Features and tags/values:

available_features()
available_tags("highway")

#Full query: 

opq(mpls_bb) %>% 
  add_osm_feature(key = "highway", value = "cycleway") %>% 
               osmdata_sp()

#sf query
mpls_sf <- opq(mpls_bb) %>% 
  add_osm_feature(key = "highway", value = "cycleway") %>% 
  osmdata_sf()

plot(mpls_sf$osm_lines)

#saved data:
mpls_cycleways <- opq(mpls_bb) %>% 
  add_osm_feature(key = "highway", value = "cycleway") %>% 
               osmdata_sp()
mpls_boundaries <- opq(mpls_bb) %>%
  add_osm_feature(key = "boundary", value = "administrative") %>%
               osmdata_sp()

###Map the output!

plot(mpls_cycleways$osm_lines)

#in sf:
mpls_sf <- opq(mpls_bb) %>% 
  add_osm_feature(key = "highway", value = "cycleway") %>% 
               osmdata_sf()
plot(mpls_sf)

plot(mpls_cycleways$osm_lines)
plot(mpls_boundaries$osm_lines, add = T, col = "red")

#advanced plotting:
tmap_mode("view")
tm_shape(mpls_sf$osm_lines) + tm_lines("bridge", lwd = 3)