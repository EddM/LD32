# Levels

Levels are defined by two files: metadata (a json file) and a layout (.map file).

## Metadata

Should be a json object with the following keys:

* `name` (a descriptive string)
* `layout` (filename of the layout file, described below)
* `music` (filename of the music file to be used)
* `tiles` (*optional*, filename of the tileset to be used if different from default)
* `background` (*optional*, filename of the background image to be used if different from default)

## Layout

.map files are plain text files containing characters that are arranged in the shape of the level. Different characters mean different things. Follow this key:

* `_` Solid ground
* `#` Solid tile, not ground-level
* `=` Solid tile but is not on the ground
* `^` Hazard ("spikes" - only contact from above does damage)
* `*` Hazard ("fire" - any contact does damage)
* `1` Enemy (AI type 1)
* `2` Enemy (AI type 2)
* `$` Coin/collectable pickup
* `R` Spawn point
* `E` Level exit

### Tilesets

Tiles in a tileset should be 64x64 in size. A tileset is an array of 64x64 pixel tiles in a single image. They should appear in this image in the following order from left to right.

1. Solid ground
2. Solid ground, variant
2. Solid tile
3. Solid tile, not on ground
