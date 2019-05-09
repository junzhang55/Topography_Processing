
lappend   auto_path $env(PARFLOW_DIR)/bin
package   require parflow
namespace import Parflow::*

pfset     FileVersion    4

#Converting sa to pfb and silo
set   mask  [pfload -sa Inputnamex.sa]
pfsetgrid {4442 3256 1} {0.0 0.0 0.0} {1000.0 1000.0 1000.0} $mask
pfsave $mask -silo Inputnamex.silo
pfsave $mask -pfb  Inputnamex.pfb

#Converting sa to pfb and silo
set   mask  [pfload -sa Inputnamey.sa]
pfsetgrid {4442 3256 1} {0.0 0.0 0.0} {1000.0 1000.0 1000.0} $mask
pfsave $mask -silo Inputnamey.silo
pfsave $mask -pfb  Inputnamey.pfb
