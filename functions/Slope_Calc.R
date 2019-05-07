SlopeCalc=function(dem, mask, smoothing=F, smoothTH=0.001, cutmax=F, maxTH=0.5){

#Mandatory Inputs:
# dem - matrix of elevation values
# mask - matrix with 1 for cells within the domain and 0 for cells outside the domain

#Optional Inputs:
# smoothing - T/F flag indicating whether the smoothing should be applied to the second derivative. If this is turned to T then if the difference between two adjacent slopes is greater than smoothTH, the average slope will be applied
# smoothTH - Threhold of the difference to apply smoothing
# cutmax- T/F flag indicating whether to limit the maximum absolute value of slopes to some threshold
# maxTH - maximum value to be used if cutmax=T

###
##Delete later - hard coding in for testing
#dem0=matrix(scan("dem_test2.txt"), ncol=215, byrow=T)
#mask0=matrix(scan("Test2_mask.txt"), ncol=215, byrow=T)
##Transform so [i,j] indexing works directly as x and y location 
#ny=nrow(dem0)
#nx=ncol(dem0)
#dem=t(dem0[ny:1,])
#mask=t(mask0[ny:1,])
###

ny=ncol(dem)
nx=nrow(dem)
dx=dy=1000

if(missing(mask)){
	mask=matrix(1, nrow=nx, ncol=ny)
}

inmask=which(mask==1)
demMask=dem
demMask[-inmask]=NA

slopex1=matrix(NA, ncol=ny, nrow=nx)
slopey1=matrix(NA, ncol=ny, nrow=nx)

#First pass calculate the x and y slopes as 
# slopex = dem[i+1,j]- dem[i,j]
# slopey = dem[i,j+1] - dem[i,j]
slopex1[1:(nx-1),]=(demMask[2:nx,]-demMask[1:(nx-1),]) /dx
slopex1[nx,]=slopex1[(nx-1),]

slopey1[,1:(ny-1)]=(demMask[,2:ny]-demMask[, 1:(ny-1)])/dy
slopey1[,ny]=slopey1[,(ny-1)]

## Second pass sort out the edge cells for an irregular mask
## Note just looping over 2:nx-1 because the exterior cells are already okay
slopex=slopex1
slopey=slopey1
countx=county=c(0,0,0)
for(i in 2:(nx-1)){
	for(j in 2:(ny-1)){
		
		#First fix issues on the top and right:
		#look for cells inside the mask with NA slopes 
		#these are cells with an upper or right border on the edge of the mask
		#fill with the slope from the cell below or to the left
		#if this is an NA too then set the slope to zero in that direction
		if(mask[i,j]==1){
			#fix slopex
			if(is.na(slopex1[i,j])==T){
				if(is.na(slopex1[(i-1),j])==T){
					slopex[i,j]=0
				} else{
					slopex[i,j]=slopex1[(i-1),j]
				}
			}
			
			
			#fix slopey
			if(is.na(slopey1[i,j])==T){
				if(is.na(slopey1[i,(j-1)])==T){
					slopey[i,j]=0
				} else{
					slopey[i,j]=slopey1[i,(j-1)]
				}
			}
		
		#Next fix issues on the bottom and left	
		#look for cells that point in where the upwind cell has an NA slope 
		#(i.e. falls outside the mask)
		#add a buffer of slope cells to these using the slope from the current cell
		if(slopex[i,j]<0 & is.na(slopex[(i-1),j])==T){
			slopex[(i-1),j]=slopex[i,j]
		}
		
		if(slopey[i,j]<0 & is.na(slopey[i,(j-1)])==T){
			slopey[i,(j-1)]=slopey[i,j]
		}
		
			
		}#end if mask==1
	} #end for j
}#end for i

#Check for flat cells
nflat=length(which(slopex==0 & slopey==0))
if(nflat!=0){
	print(paste("WARNING:", nflat, "Flat cells found"))
}


#If second derivative smoothing is turned on
county=countx=0
if(smoothing==T){
	print("Smoothing Second Derivatives")
for(i in 2:nx){
	for(j in 2:ny){
		#X-direction smoothing:
		#if the cell and its neighbor are both inside the mask
		if(mask[i,j]+mask[(i-1),j]==2){
			#if the difference in slopes is greather than threshold take the average
			if(abs(slopex[i,j]- slopex[(i-1),j]) > smoothTH){
				slopex[i,j] = mean(slopex[i,j], slopex[(i-1),j]) 
				countx=countx+1
			} 	
		}
		
		#Y-direction smoothing:	
		#if the cell and its neighbor are both inside the mask
		if(mask[i,j]+mask[i,(j-1)]==2){
			#if the difference in slopes is greather than threshold take the average
			if(abs(slopey[i,j]- slopey[i,(j-1)]) > smoothTH){
				slopey[i,j] = mean(slopey[i,j], slopey[i,(j-1)]) 
				county=county+1
			} 	
		}	
	}# End for j
} # End for i

} #end if smoothing

#If an upper limit on slopes is set (i.e. cutmax==T)
if(cutmax==T){
	print(paste("Limiting slopes to +/-", maxTH))
	#x slopes
	xclipP=which(slopex>maxTH)
	slopex[xclipP]=maxTH
	xclipN=which(slopex<(-maxTH))
	slopex[xclipN]=(-maxTH)
	
	#y slopes
	yclipP=which(slopey>maxTH)
	slopey[yclipP]=maxTH
	yclipN=which(slopey<(-maxTH))
	slopey[yclipN]=(-maxTH)
}


#replace the NA's with 0s
nax=which(is.na(slopex==T))
nay=which(is.na(slopey==T))
slopex[nax]=0
slopey[nay]=0

#transform back
#slopeyT=t(slopey[,ny:1])
#slopexT=t(slopex[,ny:1])

output_list=list("slopex"=slopex, "slopey"=slopey)
return(output_list)

} # end function









### Testing looking at clipped outputs for special cases
### Delete once finished
#testd=t(demMask[,ny:1])
#testy1=t(slopey1[,ny:1])
#testy2=t(slopey[,ny:1])
#testx1=t(slopex1[,ny:1])
#testx2=t(slopex[,ny:1])

#clipx=50:60
#clipy=80:100

#clipx=178:195
#clipy=50:75
#clipy=100:117


#testd[clipy, clipx]
#round(testx1[clipy, clipx],2)
#round(testx2[clipy,clipx],2)
#testx2[clipy,clipx]-testx1[clipy,clipx]

#testd[clipy, clipx]
#testy1[clipy, clipx]
#round(testy2[clipy,clipx],2)
#testy2[clipy,clipx]-testy1[clipy,clipx]



#write.table(t(slopey[,ny:1]), "Test2_slopey2.txt", row.names=F, col.names=F)
#write.table(t(slopey1[,ny:1]), "Test2_slopey1.txt", row.names=F, col.names=F)

#write.table(t(slopex[,ny:1]), "Test2_slopex2.txt", row.names=F, col.names=F)
#write.table(t(slopex1[,ny:1]), "Test2_slopex1.txt", row.names=F, col.names=F)







