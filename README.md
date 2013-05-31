# SimpleCover

Simple app for downloading album covers as a cover.jpg files and standarizing names of the folders to band_name-album_title-release_year format. SimpleCover is based on the Discogs API, so keep in mind that you can make only 1000 requests in 24 hours time.  

## Installation

Run:

```
git clone https://github.com/Azdaroth/simple_cover.git
```
Then type: 
```
cd simple_cover
```
and execute:
```
bundle
``` 

## How to use

Go to your music directory, then run: 
```
path_to_simple_cover/bin/simple_cover.rb standarize
```
to standarize names, download covers by running:
```
path_to_simple_cover/bin/simple_cover.rb download_covers
```
If the name is already standarized or folder has cover.jpg file, then it is skipped.
```

## TO DO

Writing tags for .mp3 files.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

