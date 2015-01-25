##
## These functions allows the user to calculate the inverse of the matrices 
## in an efficient way by storing the calculated inverses in a cache
## if the passed-in vector is same, and the inverses were calculated earlier, 
## the function will not calculate again and return the value from cache!

## Sample/Usage - the example below, which uses an Identity Matrix, where the Inverse is the same 
##  mx<-matrix(c(1,0,0,1),nrow=2)
##  cmx<-makeCacheMatrix(mx)
##  cacheSolve(cmx)

##
## makeCacheMatrix - 
##       accepts a symmetric/square matrix and 
##       returns a vector/special list of functions and storage for calculated inverse of matrix
##       which allows to calculate the inverse of the matrix 

makeCacheMatrix <- function(mx = matrix()) {
  
  # check if the argument is present
  if (missing(mx)) {
    stop("please specify mx")
  }
  
  # check if the argument is a matrix
  if (!is.matrix(mx)) {
    # throw error & stop as inverse cannot be calculated on a non-symmetrix matrix
    stop("please specify mx as a matrix")
  }
  
  # check if matrix is symmetric/square
  if (nrow(mx)!=ncol(mx)) {
    stop("please specify mx as a symmetric/square matrix")
  }
  # define the local env. to hold the matrix inverse
  mi <- NULL
  # set function - sets the matrix passed in 
  # ??? still not clear on the <<- operator - the func works with normal assignment too ... :(
  set <- function(y) {
    mx <<- y
    mi <<- NULL
  }
  # get function - returns the matrix stored locally 
  get <- function() mx
  # sets the Inverse of the matrix 
  setMatrixInverse <- function(solve) mi <<- solve
  # returns the Inverse of the matrix 
  getMatrixInverse <- function() mi
  # define the list of special functions available on this matrix ... 
  list(set = set, get = get,
       setMatrixInverse = setMatrixInverse,
       getMatrixInverse = getMatrixInverse)
}

##
## cacheSolve - 
##       accepts a vector returned by makeCacheMatrix and 
##       returns a Inverse of the Matrix of the associated matrix 
##       checks first the Inverse is already present in the vector, 
##              if not calculate the Inverse, assign to cache and return the Inverse

cacheSolve <- function(cm = makeCacheMatrix(), ...) {
  # check if the argument is present
  if (missing(cm)) {
    stop("please specify cm of type makeCacheMatrix()")
  }
  
  # check if the argument is atomic! [not sure how to check if type is of 'makeCacheMatrix']
  if (is.atomic(cm)) {
    # throw error & stop as passed argument is a simple atomic vector/list
    stop("please specify cm which is not atomic")
  }
  
  # get the current value from cache ... 
  mi <- cm$getMatrixInverse()
  # check the value ... 
  if(!is.null(mi)) {
    # if not null, cache is already set, return the value
    message("getting cached data")
    return(mi)
  }
  # else continue to calculate the inverse
  data <- cm$get()
  mi <- solve(data, ...)
  # set to cache
  cm$setMatrixInverse(mi)
  mi
}

# TEST CASES !!!
# >
# > mySample <- matrix(c(3, 3.2, 3.5, 3.6), nrow=2, ncol=2)
# > mySample
#       [,1] [,2]
# [1,]  3.0  3.5
# [2,]  3.2  3.6
# > myCachedSample <- makeCacheMatrix(mySample)
# > cacheSolve(myCachedSample)
#      [,1]  [,2]
# [1,]   -9  8.75
# [2,]    8 -7.50
# > cacheSolve(myCachedSample)
# getting cached data
#      [,1]  [,2]
# [1,]   -9  8.75
# [2,]    8 -7.50
# > 

# Identity Matrix - Inverse of an Identity Matrix will bt the Identity Matrix itself!
# > mySample <- matrix(c(1,0,0,1), nrow=2, ncol=2)
# > myCachedSample <- makeCacheMatrix(mySample)
# > cacheSolve(myCachedSample)
#      [,1] [,2]
# [1,]    1    0
# [2,]    0    1
# > cacheSolve(myCachedSample)
# getting cached data
#      [,1] [,2]
# [1,]    1    0
# [2,]    0    1

