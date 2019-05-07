# Topography_processing

the following files are contained in this folder:

Inside the folder: 
- Functions: all functions used in topography processing
- .rmd: r markdown script for this specific process, should be able to run by changing the input files paths.
      
To run the r markdown file, Rstudio/R is required.
Options in the topography processing:
  - ep: Epsilon - value to be added if adjacent cells have the same elvation
  - river order
  - MaxSlope: Maximum slope threshold
  - MinSlope: Minimum slope threshold
  - SecTH: Maximum ratio of secondary to primary slopes. If 0, then all secondary slopes are zero, if -1 then secondary slopes were not limited at all.
  - upwind: slopes were adjusted to reflect upwinding (i.e. upflag=T in the slope function), stan means all slopes are calculated as i+1-I (i.e. upflag=F)
  - All the input files are stored in Avra, the paths can be found in the r markdown file.

File Description for processed Topography Outputs:
    - area(drainageArea): the drainage area of each cell
    - basins: the basin number of each cell
    - dem: the final elevation raster which has been processed to ensure drainage with PriorityFlow
    - direction: the flow direction of each cell(1=down, 2=left, 3=up, 4=right)
    - marked: a matrix to mark whether the cell has been processed
    - mask: a domain mask (0 for cells outside the domain or lakes and sinks that are removed, 1 for cells inside the domain)
    - slopex: slope in the x dircection
    - slopey: slope in the y direction
    - rivermask: the river network raster inside the domain
    
 The code was modified according to Laura E. Condon's PriorityFlow repo (https://github.com/lecondon/PriorityFlow).
