# Topography_processing

The following files are contained in this folder:

Subdirectories:
Slope_Processing - The R script and functions used for processing the CONUS domain.
    Note for the most updated functions you should pull from here: https://github.com/lecondon/PriorityFlow

Processed Topography Directories:
These directories contain all the outputs from the topographic processing workflow. The files outputs are listed below along with a description of the differences between each output set. * Denotes our current best output.
- *HSProc_Stream5LakesSinks_Ep0.1 - Using the modified 5th order streams for processing and an epsilon value of 0.1

The input data used for the process:
- maskR: the domain mask, 1 for cells inside the mask, 0 for others
- channelR: the observed channel network, example is from National Water Model (NWM)
- borderR: the border raster, 1 for border, 0 for other cells
- demR: the elevation data
- Lborder: border cells of lakes, 1 for lake borders, 0 for other cells
- lakesR: lake mask, 1 for lakes, 0 for other cells
- sinksR: sinks mask, 1 for cells inside domain, 0 for cells outside domain, 2 for sinks

File Description for processed Topography Outputs:
- area(rainageArea): the drainage area of each cell
- basins: the basin number of each cell
- dem: the updated elevation map 
- direction: the flow direction of each cell
- marked: a matrix to mark whether the cell has been processed
- mask: a domain mask with lakes being removed (0 for cells outside the domain and lakes, 1 for cells inside the domain)
- slopex: slope in the flow dircection of each cell
- slopey: slope in the perpendicular to the direction of flow
- rivermask: the river network raster inside the domain
