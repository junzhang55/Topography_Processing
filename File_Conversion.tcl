
lappend   auto_path $env(PARFLOW_DIR)/bin
package   require parflow
namespace import Parflow::*

pfset     FileVersion    4

#Converting from pfb to sa
#set   perm  [pfload -silo NA_1km.out.perm_x.silo]
#pfsave $perm	-sa NA_1km.out.perm.sa


#Converting sa to pfb and silo
#set   mask  [pfload -sa pf_mask_LakesSinks.txt]
#pfsetgrid {4442 3256 1} {0.0 0.0 0.0} {1000.0 1000.0 2.0} $mask
#pfsave $mask -silo pf_mask_LakesSinks.silo
#pfsave $mask -pfb  pf_mask_LakesSinks.pfb

#set   slopey  [pfload -sa LW.slopey_mod.sa]
#pfsetgrid {41 41 1} {0.0 0.0 0.0} {1000 1000 2} $slopey
#pfsave $slopey -silo LW.slopey_mod.silo
#pfsave $slopey -pfb  LW.slopey_mod.pfb

#Converting sa to pfb and silo
set   mask  [pfload -sa Str5Ep0.1_area.sa]
pfsetgrid {4442 3256 1} {0.0 0.0 0.0} {1000.0 1000.0 1000.0} $mask
pfsave $mask -silo Str5Ep0.1_area.silo
pfsave $mask -pfb  Str5Ep0.1_area.pfb

#
#set   mask  [pfload -sa Bottom_Border.sa]
#pfsetgrid {4442 3256 1} {0.0 0.0 0.0} {1000.0 1000.0 1000.0} $mask
#pfsave $mask -silo Bottom_Border.silo
#pfsave $mask -pfb  Bottom_Border.pfb
#
#set   mask  [pfload -sa Left_Border.sa]
#pfsetgrid {4442 3256 1} {0.0 0.0 0.0} {1000.0 1000.0 1000.0} $mask
#pfsave $mask -silo Left_Border.silo
#pfsave $mask -pfb  Left_Border.pfb
#
#set   mask  [pfload -sa Right_Border.sa]
#pfsetgrid {4442 3256 1} {0.0 0.0 0.0} {1000.0 1000.0 1000.0} $mask
#pfsave $mask -silo Right_Border.silo
#pfsave $mask -pfb  Right_Border.pfb
#
