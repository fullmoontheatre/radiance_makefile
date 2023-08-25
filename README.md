# radiance_makefile
An opinionated Makefile to simplify using the Radiance physically based rendering system

## Usage

1. Copy the file in your Radiance project folder
2. Edit the Makefile `WORKPATH` variable with the path of your Radiance project folder 
3. Invoke `make dirs` to create a set of directories in the folder
4. Copy the Radiance model, view, grid, materials and sky files in the respective directories
5. Create a `.rad` file with the name of your project which includes the Radiance geometry files
6. Edit the other variables as desired
7. Run one or more of the following commands:

`make rvu` to invoke the interactive Radiance viewer
`make lumpic` to generate a luminance picture
`make illpic` to generate an illuminance picture
`make lumpmap` to generate a luminance picture with photon mapping
`make illpmap` to generate an illuminance picture with photon mapping
`make illgrid` to calculate illuminance values over a grid
`make dfgrid` to calculate daylight factor values over a grid
`make hdrfinalise` to post process the luminance and illuminance pictures

