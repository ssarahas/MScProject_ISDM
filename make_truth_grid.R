# function to make a grid of the truth data to compare to predicted
# will be the average intensity of each grid square

make_truth_grid <- function(resolution, 
                            dat1, 
                            dimensions, 
                            type=c('truth', 'grid'), 
                            absolute = TRUE){
  
  minnum <- resolution[1]-1
  
  grid = matrix(NA, nrow=dimensions[2], ncol=dimensions[1])
  grid_numbers <- 1:prod(dimensions/resolution)
  
  # loop for y values
  for(j in 1:(dimensions[2]/resolution[2])){
    index.y <- seq(((j-1)*(dimensions[2]/resolution[2]))+1,(j*dimensions[2]/resolution[2]),1)
    temp_grid_numbers <- grid_numbers[index.y]
    row_nos <- seq((j*resolution[1]-minnum),(j*resolution[1]),1)
    
    # loop for x values
    for(i in 1:(dimensions[1]/resolution[1])){
      index.x <- seq((i*resolution[1]-minnum),(i*resolution[1]),1)
      grid[row_nos,index.x] <- temp_grid_numbers[i]
    }
  }
  
  # sum average abundance by grid square for truth
  output <- rep(NA, length(1:max(grid)))
  if(absolute == TRUE){
    data <- dat1$rf.s
  }
  if(absolute == FALSE){
    data <- dat1$rf.s-mean(dat1$rf.s)
  }
  for(i in 1:max(grid)){
    marker <- which(grid==i)
    output[i] <- mean(data[marker])
  }
  if(type=='truth'){return(output)}
  if(type=='grid'){return(grid)}
}