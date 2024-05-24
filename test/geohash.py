import geohash
# Set the latitude and longitude coordinates
latitude = 28.732862
longitude = 77.088923
# Encode the coordinates into a geohash
geohash_code = geohash.encode(latitude, longitude, precision=12)
print(geohash_code)