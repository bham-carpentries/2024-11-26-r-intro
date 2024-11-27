---
title: Exploring Data Frames
teaching: 20
exercises: 10
source: Rmd
---

::::::::::::::::::::::::::::::::::::::: objectives

- Add and remove rows or columns.
- Append two data frames.
- Display basic properties of data frames including size and class of the columns, names, and first few rows.

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: questions

- How can I manipulate a data frame?

::::::::::::::::::::::::::::::::::::::::::::::::::



At this point, you've seen it all: in the last lesson, we toured all the basic
data types and data structures in R. Everything you do will be a manipulation of
those tools. But most of the time, the star of the show is the data frame—the table that we created by loading information from a csv file. In this lesson, we'll learn a few more things
about working with data frames.

## Understanding our Data frame


Let's ask some questions about this data frame to understand more about its structure:


``` r
str(weather)
```

``` output
'data.frame':	3 obs. of  3 variables:
 $ island     : chr  "torgersen" "biscoe" "dream"
 $ temperature: num  1.6 1.5 -2.6
 $ snowfall   : int  0 0 1
```

``` r
summary(weather)
```

``` output
    island           temperature         snowfall     
 Length:3           Min.   :-2.6000   Min.   :0.0000  
 Class :character   1st Qu.:-0.5500   1st Qu.:0.0000  
 Mode  :character   Median : 1.5000   Median :0.0000  
                    Mean   : 0.1667   Mean   :0.3333  
                    3rd Qu.: 1.5500   3rd Qu.:0.5000  
                    Max.   : 1.6000   Max.   :1.0000  
```

``` r
ncol(weather)
```

``` output
[1] 3
```

``` r
nrow(weather)
```

``` output
[1] 3
```

``` r
dim(weather)
```

``` output
[1] 3 3
```

``` r
colnames(weather)
```

``` output
[1] "island"      "temperature" "snowfall"   
```

``` r
head(weather)
```

``` output
     island temperature snowfall
1 torgersen         1.6        0
2    biscoe         1.5        0
3     dream        -2.6        1
```

``` r
typeof(weather)
```

``` output
[1] "list"
```

## Adding columns and rows in data frames

We already learned that the columns of a data frame are vectors, so that our
data are consistent in type throughout the columns. As such, if we want to add a
new column, we can start by making a new vector:


``` r
# sunshine hours
sun <- c(10, 11, 12)
weather
```

``` output
     island temperature snowfall
1 torgersen         1.6        0
2    biscoe         1.5        0
3     dream        -2.6        1
```

We can then add this as a column via:


``` r
cbind(weather, sun)
```

``` output
     island temperature snowfall sun
1 torgersen         1.6        0  10
2    biscoe         1.5        0  11
3     dream        -2.6        1  12
```

Note that if we tried to add a vector of sunshine hours with a different number of entries than the number of rows in the data frame, it would fail:


``` r
sun <- c(10, 11, 12, 13)
cbind(weather, sun)
```

``` error
Error in data.frame(..., check.names = FALSE): arguments imply differing number of rows: 3, 4
```

``` r
sun <- c(10, 11)
cbind(weather, sun)
```

``` error
Error in data.frame(..., check.names = FALSE): arguments imply differing number of rows: 3, 2
```

Why didn't this work? Of course, R wants to see one element in our new column
for every row in the table:


``` r
nrow(weather)
```

``` output
[1] 3
```

``` r
length(sun)
```

``` output
[1] 2
```

So for it to work we need to have `nrow(weather)` = `length(sun)`. Let's overwrite the content of weather with our new data frame.


``` r
sun <- c(10, 11, 12)
weather <- cbind(weather, sun)
```

Now how about adding rows? We already know that the rows of a
data frame are lists:


``` r
new_row <- list("deception", -3.45, TRUE, 13)
weather <- rbind(weather, new_row)
```

Let's confirm that our new row was added correctly. 


``` r
weather
```

``` output
     island temperature snowfall sun
1 torgersen        1.60        0  10
2    biscoe        1.50        0  11
3     dream       -2.60        1  12
4 deception       -3.45        1  13
```


## Removing rows

We now know how to add rows and columns to our data frame in R. Now let's learn to remove rows. 


``` r
weather
```

``` output
     island temperature snowfall sun
1 torgersen        1.60        0  10
2    biscoe        1.50        0  11
3     dream       -2.60        1  12
4 deception       -3.45        1  13
```

We can ask for a data frame minus the last row:


``` r
weather[-4, ]
```

``` output
     island temperature snowfall sun
1 torgersen         1.6        0  10
2    biscoe         1.5        0  11
3     dream        -2.6        1  12
```

Notice the comma with nothing after it to indicate that we want to drop the entire fourth row.

Note: we could also remove several rows at once by putting the row numbers
inside of a vector, for example: `weather[c(-3,-4), ]`


## Removing columns

We can also remove columns in our data frame. What if we want to remove the column "sun". We can remove it in two ways, by variable number or by index.


``` r
weather[,-4]
```

``` output
     island temperature snowfall
1 torgersen        1.60        0
2    biscoe        1.50        0
3     dream       -2.60        1
4 deception       -3.45        1
```

Notice the comma with nothing before it, indicating we want to keep all of the rows.

Alternatively, we can drop the column by using the index name and the `%in%` operator. The `%in%` operator goes through each element of its left argument, in this case the names of `weather`, and asks, "Does this element occur in the second argument?"


``` r
drop <- names(weather) %in% c("sun")
weather[,!drop]
```

``` output
     island temperature snowfall
1 torgersen        1.60        0
2    biscoe        1.50        0
3     dream       -2.60        1
4 deception       -3.45        1
```


## Appending to a data frame

The key to remember when adding data to a data frame is that *columns are
vectors and rows are lists.* We can also glue two data frames
together with `rbind`:


``` r
weather <- rbind(weather, weather)
weather
```

``` output
     island temperature snowfall sun
1 torgersen        1.60        0  10
2    biscoe        1.50        0  11
3     dream       -2.60        1  12
4 deception       -3.45        1  13
5 torgersen        1.60        0  10
6    biscoe        1.50        0  11
7     dream       -2.60        1  12
8 deception       -3.45        1  13
```

## Saving Our Data Frame

We can use the write.table function to save our new data frame:


``` r
write.table(
  file="results/prepared_weather.csv",
  sep=",", 
  quote=FALSE, 
  row.names=FALSE
)
```

:::::::::::::::::::::::::::::::::::::::  challenge

## Challenge 1

You can create a new data frame right from within R with the following syntax:


``` r
df <- data.frame(id = c("a", "b", "c"),
                 x = 1:3,
                 y = c(TRUE, TRUE, FALSE))
```

Make a data frame that holds the following information for yourself:

- first name
- last name
- lucky number

Then use `rbind` to add an entry for the people sitting beside you.
Finally, use `cbind` to add a column with each person's answer to the question, "Is it time for coffee break?"

:::::::::::::::  solution

## Solution to Challenge 1


``` r
df <- data.frame(first = c("Grace"),
                 last = c("Hopper"),
                 lucky_number = c(0))
df <- rbind(df, list("Marie", "Curie", 238) )
df <- cbind(df, coffeetime = c(TRUE,TRUE))
```

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::



:::::::::::::::::::::::::::::::::::::::: keypoints

- Use `cbind()` to add a new column to a data frame.
- Use `rbind()` to add a new row to a data frame.
- Use `str()`, `summary()`, nrow()`, `ncol()`, `dim()`, `colnames()`, `head()`, and `typeof()` to understand the structure of a data frame.
- Read in a csv file using `read.csv()`.
- Understand what `length()` of a data frame represents.

::::::::::::::::::::::::::::::::::::::::::::::::::


