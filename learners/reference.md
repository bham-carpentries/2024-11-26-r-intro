---
title: 'Reference'
---

## Reference

## [Introduction to R and RStudio](episodes/01-rstudio-intro.Rmd)

- Use the escape key to cancel incomplete commands or running code
  (Ctrl+C) if you're using R from the shell.
- Basic arithmetic operations follow standard order of precedence:
  - Brackets: `(`, `)`
  - Exponents: `^` or `**`
  - Divide: `/`
  - Multiply: `*`
  - Add: `+`
  - Subtract: `-`
- Scientific notation is available, e.g: `2e-3`
- Anything to the right of a `#` is a comment, R will ignore this!
- Functions are denoted by `function_name()`. Expressions inside the
  brackets are evaluated before being passed to the function, and
  functions can be nested.
- Mathematical functions: `exp`, `sin`, `log`, `log10`, `log2` etc.
- Comparison operators: `<`, `<=`, `>`, `>=`, `==`, `!=`
- Use `all.equal` to compare numbers!
- `<-` is the assignment operator. Anything to the right is evaluate, then
  stored in a variable named to the left.
- `ls` lists all variables and functions you've created
- `rm` can be used to remove them
- When assigning values to function arguments, you *must* use `=`.


## [Data structures](episodes/02-data-structures-and-subsetting.Rmd)

Individual values in R must be one of 5 **data types**, multiple values can be grouped in **data structures**.

**Data types**

- `typeof(object)` gives information about an items data type.

- There are 5 main data types:
  
  - `?numeric` real (decimal) numbers
  - `?integer` whole numbers only
  - `?character` text
  - `?complex` complex numbers
  - `?logical` TRUE or FALSE values
  
  **Special types:**
  
  - `?NA` missing values
  - `?NaN` "not a number" for undefined values (e.g. `0/0`).
  - `?Inf`, `-Inf` infinity.
  - `?NULL` a data structure that doesn't exist
  
  `NA` can occur in any atomic vector. `NaN`, and `Inf` can only
  occur in complex, integer or numeric type vectors. Atomic vectors
  are the building blocks for all other data structures. A `NULL` value
  will occur in place of an entire data structure (but can occur as list
  elements).

**Basic data structures in R:**

- atomic `?vector` (can only contain one type)
- `?list` (containers for other objects)
- `?data.frame` two dimensional objects whose columns can contain different types of data
- `?matrix` two dimensional objects that can contain only one type of data.
- `?factor` vectors that contain predefined categorical data.
- `?array` multi-dimensional objects that can only contain one type of data

Remember that matrices are really atomic vectors underneath the hood, and that
data.frames are really lists underneath the hood (this explains some of the weirder
behaviour of R).

**Useful functions for querying data structures:**

- `?str` structure, prints out a summary of the whole data structure
- `?typeof` tells you the type inside an atomic vector
- `?class` what is the data structure?
- `?head` print the first `n` elements (rows for two-dimensional objects)
- `?tail` print the last `n` elements (rows for two-dimensional objects)
- `?rownames`, `?colnames`, `?dimnames` retrieve or modify the row names
  and column names of an object.
- `?names` retrieve or modify the names of an atomic vector or list (or
  columns of a data.frame).
- `?length` get the number of elements in an atomic vector
- `?nrow`, `?ncol`, `?dim` get the dimensions of a n-dimensional object
  (Won't work on atomic vectors or lists).

## [Exploring Data Frames](episodes/03-exploring-dataframes.Rmd)

- `read.csv` to read in data in a regular structure
  - `sep` argument to specify the separator
    - "," for comma separated
    - "\\t" for tab separated
  - Other arguments:
    - `header=TRUE` if there is a header row

## [Seeking help](episodes/04-seeking-help.Rmd)

- To access help for a function type `?function_name` or `help(function_name)`
- Use quotes for special operators e.g. `?"+"`
- Use fuzzy search if you can't remember a name '??search\_term'
- [CRAN task views](https://cran.at.r-project.org/web/views) are a good starting point.
- [Stack Overflow](https://stackoverflow.com/) is a good place to get help with your code.
  - `?dput` will dump data you are working from so others can load it easily.
  - `sessionInfo()` will give details of your setup that others may need for debugging.


## [Dataframe manipulation with dplyr](episodes/05-dplyr.Rmd)

- `library(dplyr)`
- `?select` to extract variables by name.
- `?filter` return rows with matching conditions.
- `?group_by` group data by one of more variables.
- `?summarize` summarize multiple values to a single value.
- `?mutate` add new variables to a data.frame.
- Combine operations using the `?"|>"` pipe operator.

## [Creating publication quality graphics](episodes/06-plot-ggplot2.Rmd)

- figures can be created with the grammar of graphics:
  - `library(ggplot2)`
  - `ggplot` to create the base figure
  - `aes`thetics specify the data axes, shape, color, and data size
  - `geom`etry functions specify the type of plot, e.g. `point`, `line`, `density`, `box`
  - `geom`etry functions also add statistical transforms, e.g. `geom_smooth`
  - `scale` functions change the mapping from data to aesthetics
  - `facet` functions stratify the figure into panels
  - `aes`thetics apply to individual layers, or can be set for the whole plot
    inside `ggplot`.
  - `theme` functions change the overall look of the plot
  - order of layers matters!
  - `ggsave` to save a figure.
  

## Glossary

[argument]{#argument}
:   A value given to a function or program when it runs.
The term is often used interchangeably (and inconsistently) with [parameter](#parameter).

[assign]{#assign}
:   To give a value a name by associating a variable with it.

[body]{#body}
:   (of a function): the statements that are executed when a function runs.

[comment]{#comment}
:   A remark in a program that is intended to help human readers understand what is going on,
but is ignored by the computer.
Comments in Python, R, and the Unix shell start with a `#` character and run to the end of the line;
comments in SQL start with `--`,
and other languages have other conventions.

[comma-separated values]{#comma-separated-values}
:   (CSV) A common textual representation for tables
in which the values in each row are separated by commas.

[delimiter]{#delimiter}
:   A character or characters used to separate individual values,
such as the commas between columns in a [CSV](#comma-separated-values) file.

[documentation]{#documentation}
:   Human-language text written to explain what software does,
how it works, or how to use it.

[floating-point number]{#floating-point-number}
:   A number containing a fractional part and an exponent.
See also: [integer](#integer).

[for loop]{#for-loop}
:   A loop that is executed once for each value in some kind of set, list, or range.
See also: [while loop](#while-loop).

[index]{#index}
:   A subscript that specifies the location of a single value in a collection,
such as a single pixel in an image.

[integer]{#integer}
:   A whole number, such as -12343. See also: [floating-point number](#floating-point-number).

[library]{#library}
:   In R, the directory(ies) where [packages](#package) are stored.

[package]{#package}
:   A collection of R functions, data and compiled code in a well-defined format. Packages are stored in a [library](#library) and loaded using the library() function.

[parameter]{#parameter}
:   A variable named in the function's declaration that is used to hold a value passed into the call.
The term is often used interchangeably (and inconsistently) with [argument](#argument).

[return statement]{#return-statement}
:   A statement that causes a function to stop executing and return a value to its caller immediately.

[sequence]{#sequence}
:   A collection of information that is presented in a specific order.

[shape]{#shape}
:   An array's dimensions, represented as a vector.
For example, a 5×3 array's shape is `(5,3)`.

[string]{#string}
:   Short for "character string",
a [sequence](#sequence) of zero or more characters.

[syntax error]{#syntax-error}
:   A programming error that occurs when statements are in an order or contain characters
not expected by the programming language.

[type]{#type}
:   The classification of something in a program (for example, the contents of a variable)
as a kind of number (e.g. [floating-point number](#floating-point-number), [integer](#integer)), [string](#string),
or something else. In R the command typeof() is used to query a variables type.

[while loop]{#while-loop}
:   A loop that keeps executing as long as some condition is true.
See also: [for loop](#for-loop).

