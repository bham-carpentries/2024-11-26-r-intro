---
title: Data Structures and Subsetting Data
teaching: 60
exercises: 15
source: Rmd
---

::::::::::::::::::::::::::::::::::::::: objectives

- Identify and understand the five main data types in R
- Explore data frames and understand their relationship with vectors and lists
- To be able to subset vectors, lists, and data frames
- To be able to extract individual and multiple elements: by index, by name, using comparison operations
- To be able to skip and remove elements from various data structures

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: questions

- How can I read data into R?
- What are the basic data types in R?
- How can I work with subsets of data in R?
- How do I represent and work with categorical data in R?

::::::::::::::::::::::::::::::::::::::::::::::::::





One of R's most powerful features is its ability to deal with tabular data -
such as you may already have in a spreadsheet or a CSV file. Let's start by
making a toy dataset in your `data/` directory, called `weather-data.csv`:


``` r
weather <- data.frame(
  island = c("torgersen", "biscoe", "dream"),
  temperature = c(1.6, 1.5, -2.6),
  snowfall = c(0, 0, 1)
)
```

We can now save `weather` as a CSV file. It is good practice to call the argument
names explicitly so the function knows what default values you are changing. Here we
are setting `row.names = FALSE`. Recall you can use `?write.csv` to pull
up the help file to check out the argument names and their default values.


``` r
write.csv(x = weather, file = "data/weather-data.csv", row.names = FALSE)
```

The contents of the new file, `weather-data.csv`:


``` r
island,temperature,snowfall
torgersen,1.6,0
biscoe,1.5,0
dream,-2.6,1
```

:::::::::::::::::::::::::::::::::::::::::  callout

### Tip: Editing Text files in R

Alternatively, you can create `data/weather-data.csv` using a text editor (Nano),
or within RStudio with the **File -> New File -> Text File** menu item.


::::::::::::::::::::::::::::::::::::::::::::::::::

We can load this into R via the following:


``` r
weather <- read.csv(file = "data/weather-data.csv")
weather
```

``` output
     island temperature snowfall
1 torgersen         1.6        0
2    biscoe         1.5        0
3     dream        -2.6        1
```

The `read.table` function is used for reading in tabular data stored in a text
file where the columns of data are separated by punctuation characters such as
CSV files (csv = comma-separated values). Tabs and commas are the most common
punctuation characters used to separate or delimit data points in csv files.
For convenience R provides 2 other versions of `read.table`. These are: `read.csv`
for files where the data are separated with commas and `read.delim` for files
where the data are separated with tabs. Of these three functions `read.csv` is
the most commonly used.  If needed it is possible to override the default
delimiting punctuation marks for both `read.csv` and `read.delim`.

:::::::::::::::::::::::::::::::::::::::::  callout

### Check your data for factors

In recent times, the default way how R handles textual data has changed. Text
data was interpreted by R automatically into a format called "factors". But
there is an easier format that is called "character". We will hear about
factors later, and what to use them for. For now, remember that in most cases,
they are not needed and only complicate your life, which is why newer R
versions read in text as "character". Check now if your version of R has
automatically created factors and convert them to "character" format:

1. Check the data types of your input by typing `str(weather)`
2. In the output, look at the three-letter codes after the colons: If you see
  only "num" and "chr", you can continue with the lesson and skip this box.
  If you find "fct", continue to step 3.
3. Prevent R from automatically creating "factor" data. That can be done by
  the following code: `options(stringsAsFactors = FALSE)`. Then, re-read
  the weather table for the change to take effect.
4. You must set this option every time you restart R. To not forget this,
  include it in your analysis script before you read in any data, for example
  in one of the first lines.
5. For R versions greater than 4.0.0, text data is no longer converted to
  factors anymore. So you can install this or a newer version to avoid this
  problem. If you are working on an institute or company computer, ask your
  administrator to do it.
  

::::::::::::::::::::::::::::::::::::::::::::::::::

We can begin exploring our dataset right away, pulling out columns by specifying
them using the `$` operator:


``` r
weather$temperature
```

``` output
[1]  1.6  1.5 -2.6
```

``` r
weather$island
```

``` output
[1] "torgersen" "biscoe"    "dream"    
```

We can also use the subsetting operator []  on our data frame. While a vector is one dimensionl, a data
frame is two dimensional, so we pass two arguments to the [] operator.

The first argument indicates the row(s) we require and the second indicates the columns. 
So to return rows 1 and 2, and columns 2 and 3 we can use:


``` r
weather[1:2,2:3]
```

``` output
  temperature snowfall
1         1.6        0
2         1.5        0
```

We can do other operations on the columns:


``` r
## Let's convert the temperature from Celcius to Kelvin:
weather$temperature + 273.15
```

``` output
[1] 274.75 274.65 270.55
```

``` r
paste("The location is", weather$island)
```

``` output
[1] "The location is torgersen" "The location is biscoe"   
[3] "The location is dream"    
```

But what about


``` r
weather$temperature + weather$island
```

``` error
Error in weather$temperature + weather$island: non-numeric argument to binary operator
```

Understanding what happened here is key to successfully analyzing data in R.

### Data Types

If you guessed that the last command will return an error because `1.6` plus
`"torgersen"` is nonsense, you're right - and you already have some intuition for an
important concept in programming called *data types*. We can ask what type of
data something is:


``` r
typeof(weather$temperature)
```

``` output
[1] "double"
```

There are 5 main types: `double`, `integer`, `complex`, `logical` and `character`.
For historic reasons, `double` is also called `numeric`.


``` r
typeof(3.14)
```

``` output
[1] "double"
```

``` r
typeof(1L) # The L suffix forces the number to be an integer, since by default R uses float numbers
```

``` output
[1] "integer"
```

``` r
typeof(1+1i)
```

``` output
[1] "complex"
```

``` r
typeof(TRUE)
```

``` output
[1] "logical"
```

``` r
typeof('banana')
```

``` output
[1] "character"
```

No matter how
complicated our analyses become, all data in R is interpreted as one of these
basic data types. This strictness has some really important consequences.

A colleagues has added weather observations for another island. This information is in the file
`data/weather-data_v2.csv`.


``` r
file.show("data/weather-data_v2.csv")
```


``` r
island,temperature,snowfall
torgersen,"1.6",0
biscoe,"1.5",0
dream,"-2.6",1
deception,"-3.4 or 3.5",1
```

Load the new weather data like before, and check what type of data we find in the
`temperature` column:


``` r
weather <- read.csv(file="data/weather-data_v2.csv")
typeof(weather$temperature)
```

``` output
[1] "character"
```

Oh no, our temperatures aren't the double type anymore! If we try to do the same math
we did on them before, we run into trouble:


``` r
weather$temperature + 273.15
```

``` error
Error in weather$temperature + 273.15: non-numeric argument to binary operator
```

What happened?
The `weather` data we are working with is something called a *data frame*. Data frames
are one of the most common and versatile types of *data structures* we will work with in R.
A given column in a data frame cannot be composed of different data types.
In this case, R does not read everything in the data frame column `temperature` as a *double*, therefore the entire
column data type changes to something that is suitable for everything in the column.

When R reads a csv file, it reads it in as a *data frame*. Thus, when we loaded the `weather`
csv file, it is stored as a data frame. We can recognize data frames by the first row that
is written by the `str()` function:


``` r
str(weather)
```

``` output
'data.frame':	4 obs. of  4 variables:
 $ X          : int  1 2 3 4
 $ island     : chr  "torgersen" "biscoe" "dream" "deception"
 $ temperature: chr  "1.6" "1.5" "-2.6" "-3.4 or 3.5"
 $ snowfall   : int  1 0 1 1
```

*Data frames* are composed of rows and columns, where each column has the
same number of rows. Different columns in a data frame can be made up of different
data types (this is what makes them so versatile), but everything in a given
column needs to be the same type (e.g., vector, factor, or list).

Let's explore more about different data structures and how they behave.
For now, let's remove that extra line from our weather data and reload it,
while we investigate this behavior further:

weather-data.csv:

```
island,temperature,snowfall
torgersen,"1.6",0
biscoe,"1.5",0
dream,"-2.6",1
```

And back in RStudio:


``` r
weather <- read.csv(file="data/weather-data.csv")
```



### Vectors and Type Coercion

To better understand this behavior, let's meet another of the data structures:
the *vector*.


``` r
my_vector <- vector(length=3)
my_vector
```

``` output
[1] FALSE FALSE FALSE
```

A vector in R is essentially an ordered list of things, with the special
condition that *everything in the vector must be the same basic data type*. If
you don't choose the datatype, it'll default to `logical`; or, you can declare
an empty vector of whatever type you like.


``` r
another_vector <- vector(mode='character', length=3)
another_vector
```

``` output
[1] "" "" ""
```

You can check if something is a vector:


``` r
str(another_vector)
```

``` output
 chr [1:3] "" "" ""
```

The somewhat cryptic output from this command indicates the basic data type
found in this vector - in this case `chr`, character; an indication of the
number of things in the vector - actually, the indexes of the vector, in this
case `[1:3]`; and a few examples of what's actually in the vector - in this case
empty character strings. If we similarly do


``` r
str(weather$temperature)
```

``` output
 num [1:3] 1.6 1.5 -2.6
```

we see that `weather$temperature` is a vector, too - *the columns of data we load into R
data.frames are all vectors*, and that's the root of why R forces everything in
a column to be the same basic data type.


#### Coercion by combining vectors

As we saw in lesson 1, you can also make vectors with explicit contents with the combine function:


``` r
combine_vector <- c(2,6,3)
combine_vector
```

``` output
[1] 2 6 3
```

Given what we've learned so far, what do you think the following will produce?


``` r
quiz_vector <- c(2,6,'3')
quiz_vector
```

``` output
[1] "2" "6" "3"
```

This is something called *type coercion*, and it is the source of many surprises
and the reason why we need to be aware of the basic data types and how R will
interpret them. When R encounters a mix of types (here double and character) to
be combined into a single vector, it will force them all to be the same
type. Consider:


``` r
coercion_vector <- c('a', TRUE)
coercion_vector
```

``` output
[1] "a"    "TRUE"
```

``` r
another_coercion_vector <- c(0, TRUE)
another_coercion_vector
```

``` output
[1] 0 1
```

#### The type hierarchy

The coercion rules go: `logical` -> `integer` -> `double` ("`numeric`") ->
`complex` -> `character`, where -> can be read as *are transformed into*. For
example, combining `logical` and `character` transforms the result to
`character`:


``` r
c('a', TRUE)
```

``` output
[1] "a"    "TRUE"
```

A quick way to recognize `character` vectors is by the quotes that enclose them
when they are printed.

You can try to force
coercion against this flow using the `as.` functions:


``` r
character_vector_example <- c('0','2','4')
character_vector_example
```

``` output
[1] "0" "2" "4"
```

``` r
character_coerced_to_double <- as.double(character_vector_example)
character_coerced_to_double
```

``` output
[1] 0 2 4
```

``` r
double_coerced_to_logical <- as.logical(character_coerced_to_double)
double_coerced_to_logical
```

``` output
[1] FALSE  TRUE  TRUE
```

As you can see, some surprising things can happen when R forces one basic data
type into another! Nitty-gritty of type coercion aside, the point is: if your
data doesn't look like what you thought it was going to look like, type coercion
may well be to blame; make sure everything is the same type in your vectors and
your columns of data.frames, or you will get nasty surprises!

But coercion can also be very useful! For example, in our `weather` data
`snowfall` is numeric, but we know that the 1s and 0s actually represent
`TRUE` and `FALSE` (a common way of representing them). We should use the
`logical` datatype here, which has two states: `TRUE` or `FALSE`, which is
exactly what our data represents. We can 'coerce' this column to be `logical` by
using the `as.logical` function:


``` r
weather$snowfall
```

``` output
[1] 0 0 1
```

``` r
weather$snowfall <- as.logical(weather$snowfall) # Note this is the first time we have modified our data!
weather$snowfall
```

``` output
[1] FALSE FALSE  TRUE
```


Finally, we can ask a few questions about vectors:


``` r
sequence_example <- 20:25
head(sequence_example, n=2)
```

``` output
[1] 20 21
```

``` r
tail(sequence_example, n=4)
```

``` output
[1] 22 23 24 25
```

``` r
length(sequence_example)
```

``` output
[1] 6
```

``` r
typeof(sequence_example)
```

``` output
[1] "integer"
```


### Lists

Another data structure you'll want in your bag of tricks is the `list`. A list
is simpler in some ways than the other types, because you can put anything you
want in it. Remember *everything in the vector must be of the same basic data type*,
but a list can have different data types:


``` r
list_example <- list(1, "a", TRUE, 1+4i)
list_example
```

``` output
[[1]]
[1] 1

[[2]]
[1] "a"

[[3]]
[1] TRUE

[[4]]
[1] 1+4i
```

When printing the object structure with `str()`, we see the data types of all
elements:


``` r
str(list_example)
```

``` output
List of 4
 $ : num 1
 $ : chr "a"
 $ : logi TRUE
 $ : cplx 1+4i
```

What is the use of lists? They can **organize data of different types**. For
example, you can organize different tables that belong together, similar to
spreadsheets in Excel. But there are many other uses, too.

We will see another example that will maybe surprise you in the next chapter.

To retrieve one of the elements of a list, use the **double bracket**:


``` r
list_example[[2]]
```

``` output
[1] "a"
```

The elements of lists also can have **names**, they can be given by prepending
them to the values, separated by an equals sign:


``` r
another_list <- list(title = "Numbers", numbers = 1:10, data = TRUE )
another_list
```

``` output
$title
[1] "Numbers"

$numbers
 [1]  1  2  3  4  5  6  7  8  9 10

$data
[1] TRUE
```

This results in a **named list**. Now we have a new function of our object!
We can access single elements by an additional way!


``` r
another_list$title
```

``` output
[1] "Numbers"
```


:::::::::::::::::::::::::::::::::::::::::  callout

## Names

With names, we can give meaning to elements. It is the first time that we do not
only have the **data**, but also explaining information. It is *metadata*
that can be stuck to the object like a label. In R, this is called an
**attribute**. Some attributes enable us to do more with our
object, for example, like here, accessing an element by a self-defined name.

### Accessing vectors and lists by name

We have already seen how to generate a named list. The way to generate a named
vector is very similar. You have seen this function before:


``` r
pizza_price <- c( pizzasubito = 5.64, pizzafresh = 6.60, callapizza = 4.50 )
```

The way to retrieve elements is different, though:


``` r
pizza_price["pizzasubito"]
```

``` output
pizzasubito 
       5.64 
```

The approach used for the list does not work:


``` r
pizza_price$pizzafresh
```

``` error
Error in pizza_price$pizzafresh: $ operator is invalid for atomic vectors
```

It will pay off if you remember this error message, you will meet it in your own
analyses. It means that you have just tried accessing an element like it was in
a list, but it is actually in a vector.

### Accessing and changing names

If you are only interested in the names, use the `names()` function:


``` r
names(pizza_price)
```

``` output
[1] "pizzasubito" "pizzafresh"  "callapizza" 
```

We have seen how to access and change single elements of a vector. The same is
possible for names:


``` r
names(pizza_price)[3]
```

``` output
[1] "callapizza"
```

``` r
names(pizza_price)[3] <- "call-a-pizza"
pizza_price
```

``` output
 pizzasubito   pizzafresh call-a-pizza 
        5.64         6.60         4.50 
```


:::::::::::::::::::::::::::::::::::::

## Data frames

We have data frames at the very beginning of this lesson, they represent
a table of data. We didn't go much further into detail with our example cat
data frame:


``` r
weather
```

``` output
     island temperature snowfall
1 torgersen         1.6    FALSE
2    biscoe         1.5    FALSE
3     dream        -2.6     TRUE
```

We can now understand something a bit surprising in our data.frame; what happens
if we run:


``` r
typeof(weather)
```

``` output
[1] "list"
```

We see that data.frames look like lists 'under the hood'. Think again what we
heard about what lists can be used for:

> Lists organize data of different types

Columns of a data frame are vectors of different types, that are organized
by belonging to the same table.

A data.frame is really a list of vectors. It is a special list in which all the
vectors must have the same length.

How is this "special"-ness written into the object, so that R does not treat it
like any other list, but as a table?


``` r
class(weather)
```

``` output
[1] "data.frame"
```

A **class**, just like names, is an attribute attached to the object. It tells
us what this object means for humans.

You might wonder: Why do we need another what-type-of-object-is-this-function?
We already have `typeof()`? That function tells us how the object is
**constructed in the computer**. The `class` is the **meaning of the object for
humans**. Consequently, what `typeof()` returns is *fixed* in R (mainly the
five data types), whereas the output of `class()` is *diverse* and *extendable*
by R packages.

In our `weather` example, we have an integer, a double and a logical variable. As
we have seen already, each column of data.frame is a vector.


``` r
weather$island
```

``` output
[1] "torgersen" "biscoe"    "dream"    
```

``` r
weather[,1]
```

``` output
[1] "torgersen" "biscoe"    "dream"    
```

``` r
typeof(weather[,1])
```

``` output
[1] "character"
```

``` r
str(weather[,1])
```

``` output
 chr [1:3] "torgersen" "biscoe" "dream"
```

Each row is an *observation* of different variables, itself a data.frame, and
thus can be composed of elements of different types.


``` r
weather[1,]
```

``` output
     island temperature snowfall
1 torgersen         1.6    FALSE
```

``` r
typeof(weather[1,])
```

``` output
[1] "list"
```

``` r
str(weather[1,])
```

``` output
'data.frame':	1 obs. of  3 variables:
 $ island     : chr "torgersen"
 $ temperature: num 1.6
 $ snowfall   : logi FALSE
```


:::::::::::::::::::::::::::::::::::::::  challenge

### Challenge 1

An important part of every data analysis is cleaning the input data. If you
know that the input data is all of the same format, (e.g. numbers), your
analysis is much easier! Clean the weather data set from the chapter about
type coercion.

#### Copy the code template

Create a new script in RStudio and copy and paste the following code. Then
move on to the tasks below, which help you to fill in the gaps (\_\_\_\_\_\_).

```
# Read data
weather <- read.csv("data/weather-data_v2.csv")

# 1. Print the data
_____

# 2. Show an overview of the table with all data types
_____(weather)

# 3. The "temperature" column has the incorrect data type __________.
#    The correct data type is: ____________.

# 4. Correct the 4th temperature data point with the mean of the two given values
weather$temp[4] <- -3.45
#    print the data again to see the effect
weather

# 5. Convert the temperature to the right data type
weather$temp <- ______________(weather$temp)

#    Calculate the mean to test yourself
mean(weather$temp)

# If you see the correct mean value (and not NA), you did the exercise
# correctly!
```

### Instructions for the tasks

#### 1\. Print the data

Execute the first statement (`read.csv(...)`). Then print the data to the
console

:::::::::::::::  solution

### Tip 1.1

Show the content of any variable by typing its name.

:::::::::::::::::::::::::

:::::::::::::::  solution
### Solution to Challenge 1.1

Two correct solutions:

```
weather
print(weather)
```

:::::::::::::::::::::::::

#### 2\. Overview of the data types

The data type of your data is as important as the data itself. Use a
function we saw earlier to print out the data types of all columns of the
`weather` table.

:::::::::::::::  solution

### Tip 1.2

In the chapter "Data types" we saw two functions that can show data types.
One printed just a single word, the data type name. The other printed
a short form of the data type, and the first few values. We need the second
here.


:::::::::::::::::::::::::

:::::::::::::::  solution
### Solution to Challenge 1.2

```
 str(weather)
```

:::::::::::::::::::::::::

#### 3\. Which data type do we need?

The shown data type is not the right one for this data (temperature at a location). Which data type do we need?

- Why did the `read.csv()` function not choose the correct data type?
- Fill in the gap in the comment with the correct data type for temperature!

:::::::::::::::  solution

### Tip 1.3

Scroll up to the section about the [type hierarchy](#the-type-hierarchy)
to review the available data types


:::::::::::::::::::::::::

:::::::::::::::  solution

### Solution to Challenge 1.3

- temperature is expressed on a continuous scale (real numbers). The R
data type for this is "double" (also known as "numeric").
- The fourth row has the value "-3.4 or -3.5". That is not a number
but two numbers, and an english word. Therefore, the "character" data type
is chosen. The whole column is now text, because all values in the same
columns have to be the same data type.


:::::::::::::::::::::::::

#### 4\. Correct the problematic value

The code to assign a new temperature value to the problematic fourth row is given.
Think first and then execute it: What will be the data type after assigning
a number like in this example?
You can check the data type after executing to see if you were right.

:::::::::::::::  solution

### Tip 1.4

Revisit the hierarchy of data types when two different data types are
combined.


:::::::::::::::::::::::::

:::::::::::::::  solution

### Solution to challenge 1.4

The data type of the column "temperature" is "character". The assigned data
type is "double". Combining two data types yields the data type that is
higher in the following hierarchy:

```
 logical < integer < double < complex < character
```

Therefore, the column is still of type character! We need to manually
convert it to "double".
:::::::::::::::  

#### 5\. Convert the column "temperature" to the correct data type

Temperature readings are numbers. But the column does not have this data type yet.
Coerce the column to floating point numbers.

:::::::::::::::  solution

### Tip 1.5

The functions to convert data types start with `as.`. You can look
for the function further up in the manuscript or use the RStudio
auto-complete function: Type "`as.`" and then press the TAB key.

:::::::::::::::::::::::::

:::::::::::::::  solution
### Solution to Challenge 1.5

There are two functions that are synonymous for historic reasons:

```
weather$temp <- as.double(weather$temp)
weather$temp <- as.numeric(weather$temp)
```
::::::::::::::: 
::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::  challenge

### Challenge 2

There are several subtly different ways to call variables, observations and
elements from data.frames:

- `weather[1]`
- `weather[[1]]`
- `weather$island`
- `weather["island"]`
- `weather[1, 1]`
- `weather[, 1]`
- `weather[1, ]`

Try out these examples and explain what is returned by each one.

*Hint:* Use the function `typeof()` to examine what is returned in each case.

:::::::::::::::  solution

### Solution to Challenge 2


``` r
weather[1]
```

``` output
     island
1 torgersen
2    biscoe
3     dream
```

We can think of a data frame as a list of vectors. The single brace `[1]`
returns the first slice of the list, as another list. In this case it is the
first column of the data frame.


``` r
weather[[1]]
```

``` output
[1] "torgersen" "biscoe"    "dream"    
```

The double brace `[[1]]` returns the contents of the list item. In this case
it is the contents of the first column, a *vector* of type *character*.


``` r
weather$island
```

``` output
[1] "torgersen" "biscoe"    "dream"    
```

This example uses the `$` character to address items by name. *island* is the
first column of the data frame, again a *vector* of type *character*.


``` r
weather["island"]
```

``` output
     island
1 torgersen
2    biscoe
3     dream
```

Here we are using a single brace `["island"]` replacing the index number with
the column name. Like example 1, the returned object is a *list*.


``` r
weather[1, 1]
```

``` output
[1] "torgersen"
```

This example uses a single brace, but this time we provide row and column
coordinates. The returned object is the value in row 1, column 1. The object
is a *vector* of type *character*.


``` r
weather[, 1]
```

``` output
[1] "torgersen" "biscoe"    "dream"    
```

Like the previous example we use single braces and provide row and column
coordinates. The row coordinate is not specified, R interprets this missing
value as all the elements in this *column* and returns them as a *vector*.


``` r
weather[1, ]
```

``` output
     island temperature snowfall
1 torgersen         1.6    FALSE
```

Again we use the single brace with row and column coordinates. The column
coordinate is not specified. The return value is a *list* containing all the
values in the first row.

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::


:::::::::::::::::::::::::::::::::::::::::  callout

### Tip: Renaming data frame columns

Data frames have column names, which can be accessed with the `names()` function.


``` r
names(weather)
```

``` output
[1] "island"      "temperature" "snowfall"   
```

If you want to rename the second column of `weather`, you can assign a new name to the second element of `names(weather)`.


``` r
names(weather)[2] <- "temperature_celcius"
weather
```

``` output
     island temperature_celcius snowfall
1 torgersen                 1.6    FALSE
2    biscoe                 1.5    FALSE
3     dream                -2.6     TRUE
```

::::::::::::::::::::::::::::::::::::::::::::::::::


:::::::::::::::::::::::::::::::::::::::: keypoints

- Use `read.csv` to read tabular data in R.
- The basic data types in R are double, integer, complex, logical, and character.
- Data structures such as data frames are built on top of lists and vectors, with some added attributes.
- Indexing in R starts at 1, not 0.
- Access individual values by location using `[]`.
- Access slices of data using `[low:high]`.
- Access arbitrary sets of data using `[c(...)]`.
- Use logical operations and logical vectors to access subsets of data.
::::::::::::::::::::::::::::::::::::::::::::::::::


