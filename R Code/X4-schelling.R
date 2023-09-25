### Implements a variant of
### https://doi.org/10.1080/0022250X.1971.9989794

### Schelling's segregation model #############################################

# Function
schelling <- function(city.size=20,steps=200) {
  
  require(simecol)
  
  # Generate grid
  City <- sample(c(0,1,2),city.size^2,replace=T,prob=c(0.2,0.4,0.4))
  City <- matrix(City,nrow=city.size)
  
  # First result
  City.start <- City
  
  # Cycle
  for(i in 1:steps) {
    
    # Move group A
    N_group_b <- City 
    N_group_b[N_group_b==1] <- 0
    N_group_b[N_group_b==2] <- 1
    ngh_b <- eightneighbours(N_group_b)
    
    move_a <- which(City==1&ngh_b>3,T)
    dest_a <- which(City==0&ngh_b<=3,T)
    
    if(dim(dest_a)[1]>0 & dim(move_a)[1]>0) {
      
      if(dim(dest_a)[1]>1) dest_a <- dest_a[sample(1:dim(dest_a)[1]),]
      if(dim(move_a)[1]>1) move_a <- move_a[sample(1:dim(move_a)[1]),]
      
      upto <- min(dim(dest_a)[1],dim(move_a)[1])
      
      for(j in 1:upto) {
        City[dest_a[j,"row"],dest_a[j,"col"]] <- 1
        City[move_a[j,"row"],move_a[j,"col"]] <- 0
      }
    }
    
    # Move second group
    N_group_a <- City 
    N_group_a[N_group_a==2] <- 0
    ngh_a <- eightneighbours(N_group_a)
    
    move_b <- which(City==2&ngh_a>3,T)
    dest_b <- which(City==0&ngh_a<=3,T)
    
    if(dim(dest_b)[1]>0 & dim(move_b)[1]>0) {
      
      if(dim(dest_b)[1]>1) dest_b <- dest_b[sample(1:dim(dest_b)[1]),]
      if(dim(move_b)[1]>1) move_b <- move_b[sample(1:dim(move_b)[1]),]
      
      upto <- min(dim(dest_b)[1],dim(move_b)[1])
      
      for(j in 1:upto) {
        City[dest_b[j,"row"],dest_b[j,"col"]] <- 2
        City[move_b[j,"row"],move_b[j,"col"]] <- 0
      }
      
    }
    
  }
  
  # Get results
  result <- list(City.start,City)
  return(result)
  
}

# Some examples

# Colors to use
colorset <- c("#f5f5f5","#d7191c","#2b83ba")

# Small example
test <- schelling()
image(test[[1]],col=colorset,axes=F,main="Start")
grid(nx=20,ny=20,lty=1)
image(test[[2]],col=colorset,axes=F,main="Final")
grid(nx=20,ny=20,lty=1)

# Larger example
test <- schelling(city.size=100,steps=500)
image(test[[1]],col=colorset,axes=F,main="Start")
image(test[[2]],col=colorset,axes=F,main="Final")
