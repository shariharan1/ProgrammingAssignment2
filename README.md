## Programming Assignment 2 - INTRO 

### Assignment: Caching the Inverse of a Matrix

Matrix inversion is usually a costly computation and there may be some
benefit to caching the inverse of a matrix rather than computing it
repeatedly (there are also alternatives to matrix inversion that we will
not discuss here). Your assignment is to write a pair of functions that
cache the inverse of a matrix.



 These functions allows the user to calculate the inverse of the matrices 
 in an efficient way by storing the calculated inverses in a cache
 if the passed-in vector is same, and the inverses were calculated earlier, 
 the function will not calculate again and return the value from cache!

## Sample/Usage - 
  the example below, which uses an Identity Matrix, where the Inverse is the same 
  	mx<-matrix(c(1,0,0,1),nrow=2)
  	cmx<-makeCacheMatrix(mx)
  	cacheSolve(cmx)


## makeCacheMatrix - 
    - accepts a symmetric/square matrix and 
    - returns a vector/special list of functions and storage for calculated inverse of matrix
    - which allows to calculate the inverse of the matrix 


## cacheSolve - 
    - accepts a vector returned by makeCacheMatrix and 
    - returns a Inverse of the Matrix of the associated matrix 
    - checks first the Inverse is already present in the vector, 
              if not calculate the Inverse, assign to cache and return the Inverse
