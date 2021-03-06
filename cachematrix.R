## makeCacheMatrix: This function creates a list that contains a matrix
## cacheSolve: This function computes the inverse matrix of the special "matrix" 
## returned by makeCacheMatrix above. If the inverse has already been calculated
## (and the matrix has not changed), then the cachesolve should retrieve 
## the inverse from the cache.

## function makeCacheMatrix input a matrix x, and then create a list 
## to store 4 "sub-functions" that can
## (1) set the matrix (function set)
## (2) get the matrix (function get)
## (3) set the inverse matrix (function setinverse)
## (4) get the inverse matrix (function getinverse)

makeCacheMatrix <- function(x = matrix()) {
  m <- NULL
  
  # function set: set the input argument x in containing environment
  # also reset m to Null
  set <- function(y) {
    x <<- y
    m <<- NULL
  }
  
  # function get: return the input argument x
  get <- function() x
  
  # function setmean: input argument = mean, then setting the m = mean 
  # in containing environment
  setinverse <- function(inverse) m <<- inverse
  
  # function getmean: return the value of m
  getinverse <- function() m
  
  # output argument of function makeVector
  # functions set, get, setinverse, getinverse
  list(set = set, get = get,
       setinverse = setinverse,
       getinverse = getinverse)

}


## function cacheSolve input a matrix x, and then return a matrix that is the inverse of 'x' 
## If the inverse matrix is already calculated, then return the calcuated value
## If not, then calculate the inverse matrix and return the value

cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  # input argument: the list x generated by function makeCacheMatrix
  # check if there is calcualted inverse matrix in x, and then store in  
  # m in the "LOCAL" environment
  m <- x$getinverse()
  
  # If m in the local environment is not null, then return the value m
  if(!is.null(m)) {
    message("getting cached data")
    return(m)
  }
  
  # If m in the local environment is null, then calculate the inverse matrix
  # first get the data in the list x
  data <- x$get()
  
  # check if the matrix is a square matrix
  if (nrow(data) == ncol(data))
    
    # then calculate inverse matrix, and store it in m in the local environment 
    m <- solve(data, ...)
  
  else
    stop("***Matrix is not a square matrix***")
  
  # using function setinverse to store the inverse matrix in m in the "containing"
  # environment
  x$setinverse(m)
  m
}
