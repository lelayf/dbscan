\name{frNN}
\alias{frNN}
\alias{frnn}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Find the Fixed Radius Nearest Neighbors}
\description{
This function uses a kd-tree to find the fixed radius nearest neighbors
(including distances) fast.
}
\usage{
frNN(x, eps, sort = TRUE, search = "kdtree", bucketSize = 10,
  splitRule = "suggest", approx = 0)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{ a data matrix or a dist object.}
  \item{eps}{ neighbors radius. }
    \item{search}{ nearest neighbor search strategy (one of "kdtree"
    or "linear", "dist").}
  \item{sort}{ sort the neighbors by distance? }
  \item{bucketSize}{ max size of the kd-tree leafs. }
  \item{splitRule}{ rule to split the kd-tree. One of "STD",
      "MIDPT", "FAIR", "SL_MIDPT", "SL_FAIR" or "SUGGEST"
      (SL stands for sliding). "SUGGEST" uses ANNs best guess.}
  \item{approx}{ use approximate nearest neighbors. All NN up to a distance of
    a factor of 1+\code{approx} eps may be used. Some actual NN may be
    omitted leading to spurious clusters and noise points.
    However, the algorithm will enjoy a significant speedup. }
}
\details{
For details on the parameters see \code{\link{kNN}}.

Note: self-matches are not returned!
%%  ~~ If necessary, more details than the description above ~~

To create a frNN object from scratch, you need to supply at least the
elements \code{id} with a list of integer vectors with
the nearest neighbor ids
for each point and \code{eps} (see below).
}
\value{
%%  ~Describe the value returned
An object of class frNN containing a list with the following components:
  \item{id }{a list of integer vectors. Each vector contains the ids
  of the fixed radius nearest neighbors. }
  \item{dist }{a list with distances (same stucture as \code{ids}). }
  \item{eps }{ eps used. }
%% ...
}
\seealso{
\code{\link{kNN}} for k nearest neighbor search.
}
\references{
David M. Mount and Sunil Arya (2010). ANN: A Library for Approximate Nearest Neighbor Searching, \url{http://www.cs.umd.edu/~mount/ANN/}.
}

\author{
    Michael Hahsler
}

\examples{
data(iris)

# Find fixed radius nearest neighbors for each point
nn <- frNN(iris[,-5], eps=.5)

# Number of neighbors
hist(sapply(nn$id, length),
  xlab = "k", main="Number of Neighbors",
  sub = paste("Neighborhood size eps =", nn$eps))

# Explore neighbors of point i = 10
i <- 10
nn$id[[i]]
nn$dist[[i]]

plot(iris[,-5], col = ifelse(1:nrow(iris) \%in\% nn$id[[i]], "red", "black"))

## manually create a frNN object for dbscan (dbscan only needs ids and eps)
nn <- list(ids = list(c(2,3), c(1,3), c(1,2), c(3,5), c(4,5)), eps = 1)
class(nn) <- "frNN"
nn
dbscan(nn, minPts = 2)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{model}
