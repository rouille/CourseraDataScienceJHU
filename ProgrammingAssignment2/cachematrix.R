## The following pair of functions aim to cache the inverse of a matrix


## This function creates a special 'matrix' object, which is a list containing 
## functions to: set the matrix, get the matrix, set the inverse the matrix and 
## get the inverse of the matrix.
makeCacheMatrix <- function(x = matrix()) {
    inv <- NULL
    set <- function(y) {
        x <<- y
        inv <<- NULL
    }
    get <- function() x
    setinv <- function(z) inv <<- z
    getinv <- function() inv
    list(set = set, get = get, setinv = setinv, getinv = getinv)
}


## This function calculates the inverse of a matrix. 
## The function first checks to see if the inverse of the matrix has already 
## been calculated. If so, it retrieves the object from the cache. Otherwise, 
## this function does the inversion and sets the object in the cache.
cacheSolve <- function(x, ...) {
    inv <- x$getinv()
    if(!is.null(inv)) {
        message("getting cached data")
        return(inv)
    }
    data <- x$get()
    inv <- solve(data, ...)
    x$setinv(inv)
    inv
}
