---
title: R Packages and Seeking Help
teaching: 10
exercises: 5
source: Rmd
---

::::::::::::::::::::::::::::::::::::::: objectives

- To be able to install packages, and load them into your R session
- To be able to use CRAN task views to identify packages to solve a problem
- To be able to read R help files for functions and special operators
- To be able to seek help from your peers
- To be able to manage a workspace in an interactive R session

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: questions
- How do I use packages in R?
- How can I get help in R?
- How can I manage my environment?
::::::::::::::::::::::::::::::::::::::::::::::::::



## R packages

R packages extend the functionality of R.  Over 13,000 packages have been written
by others. It's also possible to write your own packages; this can be a great way of disseminating your research and making it useful to others.  A number of useful packages are installed by default with R (are part of the R core distribution). The teaching machines at the University have a number of additional packages installed by default.

We can see the packages installed on an R installation via the "packages" tab in RStudio, or by typing `installed.packages()` at the prompt, or by selecting the "Packages" tab in RStudio.

In this course we will be using packages in the  [tidyverse](https://www.tidyverse.org) to perform the bulk of our plotting and data analysis.   Although we could do most of the tasks without using extra packages, the tidyverse makes it quicker and easier to perform common data analysis tasks.  The tidyverse packages are already installed on the university teaching machines.

## Finding and installing new packages

There are several sources of packages in R; the ones you are most likely to encounter are:

### CRAN

[CRAN](https://cran.r-project.org) is the main repository of packages for R.  All the packages have undergone basic quality assurance when they were submitted.  There are over 12,000 packages in the archive; there is a lot of overlap between some packages.  Working out _what_ the most appropriate package to use isn't always straightforward.

### Bioconductor

[Bioconductor](https://www.bioconductor.org/) is a more specialised repository, which contains packages for bioinformatics.  Common workflows are provided, and the packages are more thoroughly quality assured.   Because of its more specialised nature we don't focus on Bioconductor in this course.

### Github / personal websites

Some authors distribute packages via [Github](https://www.github.com) or their own personal web-pages.  These packages may not have undergone any form of quality assurance.   Note that many packages have their own website, but the package itself is distributed via CRAN.

### Finding packages to help with your research

There are various ways of finding packages that might be useful in your research:

* The [CRAN task view](https://cran.r-project.org/web/views/) provides an overview of the packages available for various research fields and methodologies.

* [rOpenSci](https://ropensci.org/) provides packages for performing open and reproducible science.  Most of these are available from CRAN or Bioconductor.

* Journal articles should cite the R packages they used in their analysis.

* [The Journal of Statistical Software](https://www.jstatsoft.org/index) contains peer-reviewed articles for R packages (and other statistical software).

* [The R Journal](https://journal.r-project.org/) contains articles about new packages in R.

### Installing packages

If a package is available on [CRAN](https://cran.r-project.org), you can install it by typing:


``` r
install.packages("packagename")
```

This will automatically install any packages that the package you are installing depends on.

Installing a package doesn't make the functions included in it available to you; to do this you must use the `library()` function.  As we will be using the tidyverse later in the course, let's load that now:


``` r
library("tidyverse")
```

``` output
── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
✔ dplyr     1.1.4     ✔ readr     2.1.5
✔ forcats   1.0.0     ✔ stringr   1.5.1
✔ ggplot2   3.5.1     ✔ tibble    3.2.1
✔ lubridate 1.9.3     ✔ tidyr     1.3.1
✔ purrr     1.0.2     
── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
✖ dplyr::filter() masks stats::filter()
✖ dplyr::lag()    masks stats::lag()
ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors
```

The tidyverse is a collection of other packages that work well together.  The `tidyverse` package's main function is to load some of these other packages.   We will be using some of these later in the course.

::: callout
## Conflicting names

You may get a warning message when loading a package that a function is "masked". This happens when a function name has already been "claimed" by a package that's already loaded.  The most recently loaded function wins.

If you want to use the function from the other package, use `packagename::function()`.
:::


## Reading Help files

R, and every package, provide help files for functions. The general syntax to search for help on any
function, say `function_name`:


``` r
?function_name
# OR
help(function_name)
```

This will load up a help page in RStudio (or by launching a web browser, or  as plain text if you are using R without RStudio).

Each help page is broken down into sections:

 - Description: An extended description of what the function does.
 - Usage: The arguments of the function and their default values.
 - Arguments: An explanation of the data each argument is expecting.
 - Details: Any important details to be aware of.
 - Value: The data the function returns.
 - See Also: Any related functions you might find useful.
 - Examples: Some examples for how to use the function.

Different functions might have different sections, but these are the main ones you should be aware of.

::: callout
## Tip: Reading help files

One of the most daunting aspects of R is the large number of functions
available. It would be prohibitive, if not impossible to remember the
correct usage for every function you use. Luckily, the help files
mean you don't have to!
:::

## Special Operators

To seek help on special operators, use quotes:


``` r
?"<-"
```

## Getting help on packages

Many packages come with "vignettes": tutorials and extended example documentation.
Without any arguments, `vignette()` will list all vignettes for all installed packages;
`vignette(package="package-name")` will list all available vignettes for
`package-name`, and `vignette("vignette-name")` will open the specified vignette.

If a package doesn't have any vignettes, you can usually find help by typing
`help("package-name")`, or `package?package-name`.

## When you kind of remember the function

If you're not sure what package a function is in, or how it's specifically spelled you can do a fuzzy search:


``` r
??function_name
```
::: callout

## Citing R and R packages

If you use R in your work you should cite it, and the packages you use. The
`citation()` command will return the appropriate citation for R itself.  
`citation(packagename)` will provide the citation for `packagename`.

:::

## When your code doesn't work: seeking help from your peers

If you're having trouble using a function, 9 times out of 10,
the answers you are seeking have already been answered on
[Stack Overflow](https://stackoverflow.com/). You can search using
the `[r]` tag.

If you can't find the answer, there are a few useful functions to
help you ask a question from your peers:


``` r
?dput
```

Will dump the data you're working with into a format so that it can
be copy and pasted by anyone else into their R session.


## Package versions

Many of the packages in R are frequently updated.  This does mean that code written for one version of a package may not work with another version of the package (or, potentially even worse, run but give a _different_ result).  The `sessionInfo()` command prints information about the system, and the names and versions of packages that have been loaded.  You should include the output of `sessionInfo()` somewhere in your research.  The [packrat package](https://rstudio.github.io/packrat/) provides a way of keeping specific versions of packages associated with each of your projects.




``` r
sessionInfo()
```

:::::::::::::::::::::::::::::::::::::::  challenge

## Challenge 1

Use help to find a function (and its associated parameters) that you could
use to load data from a tabular file in which columns are delimited with "\\t"
(tab) and the decimal point is a "." (period). This check for decimal
separator is important, especially if you are working with international
colleagues, because different countries have different conventions for the
decimal point (i.e. comma vs period).
Hint: use `??"read table"` to look up functions related to reading in tabular data.

:::::::::::::::  solution

## Solution to Challenge 1

The standard R function for reading tab-delimited files with a period
decimal separator is read.delim(). You can also do this with
`read.table(file, sep="\t")` (the period is the *default* decimal
separator for `read.table()`), although you may have to change
the `comment.char` argument as well if your data file contains
hash (#) characters.



:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::  challenge

## Challenge 2

Vignettes are often useful tutorials.   We will be using the `dplyr` package
to manipulate tables of data.   List the vignettes available
in the package.   You might want to take a look at these now, or later when
we cover `dplyr`.

:::::::::::::::  solution

## Solution to Challenge 2



``` r
vignette(package="dplyr")
```
Shows that there are several vignettes included in the package.  The `dplyr`
vignette looks like it might be useful later.  We can view this with:


``` r
vignette(package="dplyr", "dplyr")
```

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

## Managing your environment

There are a few useful commands you can use to interact with the R session.
Let's create tow varables `x` and `y` to demonstrate this. 


``` r
x <- 5
y <- "birds"
```

`ls` will list all of the variables and functions stored in the global environment
(your working R session):


``` r
ls()
```


``` output
[1] "x" "y"
```

:::::::::::::::::::::::::::::::::::::::::  callout

## Tip: hidden objects

Like in the shell, `ls` will hide any variables or functions starting
with a "." by default. To list all objects, type `ls(all.names=TRUE)`
instead

::::::::::::::::::::::::::::::::::::::::::::::::::

Note here that we didn't give any arguments to `ls`, but we still
needed to give the parentheses to tell R to call the function.

If we type `ls` by itself, R prints a bunch of code instead of a listing of objects.


``` r
ls
```

``` output
function (name, pos = -1L, envir = as.environment(pos), all.names = FALSE, 
    pattern, sorted = TRUE) 
{
    if (!missing(name)) {
        pos <- tryCatch(name, error = function(e) e)
        if (inherits(pos, "error")) {
            name <- substitute(name)
            if (!is.character(name)) 
                name <- deparse(name)
            warning(gettextf("%s converted to character string", 
                sQuote(name)), domain = NA)
            pos <- name
        }
    }
    all.names <- .Internal(ls(envir, all.names, sorted))
    if (!missing(pattern)) {
        if ((ll <- length(grep("[", pattern, fixed = TRUE))) && 
            ll != length(grep("]", pattern, fixed = TRUE))) {
            if (pattern == "[") {
                pattern <- "\\["
                warning("replaced regular expression pattern '[' by  '\\\\['")
            }
            else if (length(grep("[^\\\\]\\[<-", pattern))) {
                pattern <- sub("\\[<-", "\\\\\\[<-", pattern)
                warning("replaced '[<-' by '\\\\[<-' in regular expression pattern")
            }
        }
        grep(pattern, all.names, value = TRUE)
    }
    else all.names
}
<bytecode: 0x5572603d1d60>
<environment: namespace:base>
```

What's going on here?

Like everything in R, `ls` is the name of an object, and entering the name of
an object by itself prints the contents of the object. The object `x` that we
created earlier contains 5:


``` r
x
```

``` output
[1] 5
```

The object `ls` contains the R code that makes the `ls` function work! We'll talk
more about how functions work and start writing our own later.

You can use `rm` to delete objects you no longer need:


``` r
rm(x)
```

If you have lots of things in your environment and want to delete all of them,
you can pass the results of `ls` to the `rm` function:


``` r
rm(list = ls())
```

In this case we've combined the two. Like the order of operations, anything
inside the innermost parentheses is evaluated first, and so on.

In this case we've specified that the results of `ls` should be used for the
`list` argument in `rm`. When assigning values to arguments by name, you *must*
use the `=` operator!!

If instead we use `<-`, there will be unintended side effects, or you may get an error message:


``` r
rm(list <- ls())
```

``` error
Error in rm(list <- ls()): ... must contain names or character strings
```

:::::::::::::::::::::::::::::::::::::::::  callout

## Tip: Warnings vs. Errors

Pay attention when R does something unexpected! Errors, like above,
are thrown when R cannot proceed with a calculation. Warnings on the
other hand usually mean that the function has run, but it probably
hasn't worked as expected.

In both cases, the message that R prints out usually give you clues
how to fix a problem.

::::::::::::::::::::::::::::::::::::::::::::::::::

## Further reading
We recommend the following resources for some additional reading on the topic of this episode:
- [Quick R](https://www.statmethods.net/)
- [RStudio cheat sheets](https://www.rstudio.com/resources/cheatsheets/)
- [Cookbook for R](https://www.cookbook-r.com/)

:::::::::::::::::::::::::::::::::::::::: keypoints

- Use install.packages() to install packages (libraries) from CRAN
- Use `help()` to get online help in R
- Use ls() to list the variables in a program
- Use rm() to delete objects in a program

::::::::::::::::::::::::::::::::::::::::::::::::::




