\name{fastBoost-package}
\alias{fastBoost-package}
\alias{fastBoost}
\docType{package}
\title{
\packageTitle{fastBoost}
}
\description{
\packageDescription{fastBoost}
}
\details{

The DESCRIPTION file:
\packageDESCRIPTION{fastBoost}
\packageIndices{fastBoost}
~~ An overview of how to use the package, including the most important functions ~~
}
\author{
\packageAuthor{fastBoost}

Maintainer: \packageMaintainer{fastBoost}
}
\references{
~~ Literature or other references for background information ~~
}
~~ Optionally other standard keywords, one per line, from file KEYWORDS in the R documentation ~~
~~ directory ~~
\keyword{ package }
\seealso{
~~ Optional links to other man pages, e.g. ~~
~~ \code{\link[<pkg>:<pkg>-package]{<pkg>}} ~~
}
\examples{
fakedata <- data.frame( X=c(rnorm(100,0,1),rnorm(100,1,1)), Y=c(rep(0,100),rep(1,100) ) )
fakedata$Y <- factor(fakedata$Y)
A <- adaboost(Y~X, fakedata, 10)
pred <- predict(A,newdata=fakedata)
}
