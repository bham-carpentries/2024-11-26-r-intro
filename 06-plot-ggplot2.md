---
title: Creating Publication-Quality Graphics with ggplot2
teaching: 60
exercises: 20
source: Rmd
---

::::::::::::::::::::::::::::::::::::::: objectives

- To be able to use ggplot2 to generate publication-quality graphics.
- To apply geometry, aesthetic, and statistics layers to a ggplot plot.
- To manipulate the aesthetics of a plot using different colors, shapes, and lines.
- To improve data visualization through transforming scales and paneling by group.
- To save a plot created with ggplot to disk.

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: questions

- How can I create publication-quality graphics in R?

::::::::::::::::::::::::::::::::::::::::::::::::::

Let's make a new script for this episode, by choosing the menu options _File_, _New File_, _R Script_.

Although we loaded the tidyverse in the previous episode, we should make our scripts self-contained, so we should include `library(tidyverse)` in the new script.   


``` r
library(tidyverse)
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

``` r
penguins <- read_csv("data/penguins_teaching.csv", col_types = cols(year = col_character()))
```

Plotting our data is one of the best ways to
quickly explore it and the various relationships
between variables.


There are three main plotting systems in R,
the [base plotting system][base], the [lattice]
package, and the [ggplot2] package.

Today we'll be learning about the ggplot2 package, because
it is the most effective for creating publication-quality
graphics.

ggplot2 is built on the grammar of graphics, the idea that any plot can be
built from the same set of components: a **data set**,
**mapping aesthetics**, and graphical **layers**:

- **Data sets** are the data that you, the user, provide.

- **Mapping aesthetics** are what connect the data to the graphics.
  They tell ggplot2 how to use your data to affect how the graph looks,
  such as changing what is plotted on the X or Y axis, or the size or
  color of different data points.

- **Layers** are the actual graphical output from ggplot2. Layers
  determine what kinds of plot are shown (scatterplot, histogram, etc.),
  the coordinate system used (rectangular, polar, others), and other
  important aspects of the plot. The idea of layers of graphics may
  be familiar to you if you have used image editing programs
  like Photoshop, Illustrator, or Inkscape.

Let's start off building an example using the penguins data from earlier.
First let's create a derived data set to plot! Let's find out if the
mean body mass of the penguins has changed over time.


``` r
penguins_bm <- penguins |>
  filter(species == c("Adelie")) |>
  group_by(year, island, species) |>
  summarize(mean_body_mass = mean(body_mass_g, na.rm = TRUE)) |>
  ungroup()
```

``` output
`summarise()` has grouped output by 'year', 'island'. You can override using
the `.groups` argument.
```

The most basic function is `ggplot`, which lets R know that we're
creating a new plot. Any of the arguments we give the `ggplot`
function are the *global* options for the plot: they apply to all
layers on the plot.



``` r
library(ggplot2)
ggplot(data = penguins_bm)
```

<img src="fig/06-plot-ggplot2-rendered-blank-ggplot-1.png" alt="Blank plot, before adding any mapping aesthetics to ggplot()." style="display: block; margin: auto;" />

Here we called `ggplot` and told it what data we want to show on
our figure. This is not enough information for `ggplot` to actually
draw anything. It only creates a blank slate for other elements
to be added to.

Now we're going to add in the **mapping aesthetics** using the
`aes` function. `aes` tells `ggplot` how variables in the **data**
  map to *aesthetic* properties of the figure, such as which columns
of the data should be used for the **x** and **y** locations.


``` r
ggplot(data = penguins_bm, mapping = aes(x = year, y = mean_body_mass))
```

<img src="fig/06-plot-ggplot2-rendered-ggplot-with-aes-1.png" alt="Plotting area with axes for a scatter plot of mean body mass vs year, with no data points visible." style="display: block; margin: auto;" />

Here we told `ggplot` we want to plot the "mean_body_mass" column of the
our data frame on the x-axis, and the "year" column on the
y-axis. Notice that we didn't need to explicitly pass `aes` these
columns (e.g. `x = penguins[, "year"]`), this is because
`ggplot` is smart enough to know to look in the **data** for that column!

The final part of making our plot is to tell `ggplot` how we want to
visually represent the data. We do this by adding a new **layer**
to the plot using one of the **geom** functions.


``` r
ggplot(data = penguins_bm, mapping = aes(x = year, y = mean_body_mass)) +
  geom_point()
```

<img src="fig/06-plot-ggplot2-rendered-bodymass-vs-year-scatter-1.png" alt="Scatter plot of mean body mass vs year, now showing the data points." style="display: block; margin: auto;" />

Here we used `geom_point`, which tells `ggplot` we want to visually
represent the relationship between **x** and **y** as a scatterplot of points.

Notice that we use a "+" sign to add another layer to the plot, not a pipe "|>"
which we've previously used to pass the output data from one data processing step to another 
step.


:::::::::::::::::::::::::::::::::::::::  challenge

## Challenge 1

Modify the example so that the figure shows how bill length (mm) varies with
flipper length (mm) instead of body mass :


``` r
ggplot(data = penguin, mapping = aes(x = flipper_length_mm, y = body_mass_g)) + geom_point()
```


:::::::::::::::  solution

## Solution to challenge 1

Here is one possible solution:


``` r
ggplot(data = penguin, mapping = aes(x = flipper_length_mm, y = bill_length_mm)) + geom_point()
```

``` error
Error: object 'penguin' not found
```

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::  challenge

## Challenge 2

In the previous examples and challenge we've used the `aes` function to tell
the scatterplot **geom** about the **x** and **y** locations of each point.
Another *aesthetic* property we can modify is the point *color*. Modify the
code from the previous challenge to **color** the points by the "species"
column. What trends do you see in the data? Are they what you expected?

Hint: Use ?aes or ?ggplot2 to get help on these functions if needed.
:::::::::::::::  solution

## Solution to challenge 2

The solution presented below adds `color=species` to the call of the `aes`
function. The general trend seems to indicate an increased bill length with flipper length. Visual inspection suggests that the strength of this relationship is similar across all three species.


``` r
ggplot(data = penguins, mapping = aes(x = flipper_length_mm, y = bill_length_mm, color=species)) +
  geom_point()
```

<div class="figure" style="text-align: center">
<img src="fig/06-plot-ggplot2-rendered-ch2-sol-1.png" alt="Scatter plot of body mass (g) vs flipper length (mm), with points color-coded by penguin species to show how body mass varies by species and flipper length, thus showing the value of 'aes' function"  />
<p class="caption">Scatter plot of body mass (g) vs flipper length (mm), with points color-coded by penguin species to show how body mass varies by species and flipper length, thus showing the value of 'aes' function</p>
</div>

:::::::::::::::::::::::::
  
::::::::::::::::::::::::::::::::::::::::::::::::::
  
## Layers
  
Using a scatterplot probably isn't the best for visualizing change over time.
Instead, let's tell `ggplot` to visualize the data as a line plot:
  

``` r
ggplot(data = penguins_bm, mapping = aes(x=year, y=mean_body_mass)) +
  geom_line()
```

<img src="fig/06-plot-ggplot2-rendered-mbm-line-1.png" style="display: block; margin: auto;" />

Instead of adding a `geom_point` layer, we've added a `geom_line` layer.

However, the result doesn't look quite as we might have expected: it seems to be jumping around a lot within each year Let's try to separate the data by island, plotting one line for each island:


``` r
ggplot(data = penguins_bm, mapping = aes(x=year, y=mean_body_mass, group=island)) +
  geom_line()
```

<img src="fig/06-plot-ggplot2-rendered-mbm-line-by-1.png" style="display: block; margin: auto;" />

Let's color the lines by island to make things clearer:
  

``` r
ggplot(data = penguins_bm, mapping = aes(x=year, y=mean_body_mass, group=island, color = island)) +
  geom_line()
```

<img src="fig/06-plot-ggplot2-rendered-mbm-line-by-island-1.png" style="display: block; margin: auto;" />

We've added the **group** *aesthetic*, which tells `ggplot` to draw a line for each
island.

But what if we want to visualize both lines and points on the plot? We can
add another layer to the plot:


``` r
ggplot(data = penguins_bm, mapping = aes(x=year, y=mean_body_mass, group=island, color=island)) +
  geom_line() + 
  geom_point()
```

<img src="fig/06-plot-ggplot2-rendered-mbm-line-point-1.png" style="display: block; margin: auto;" />

It's important to note that each layer is drawn on top of the previous layer. In
this example, the points have been drawn *on top of* the lines. Here's a
demonstration:


``` r
ggplot(data = penguins_bm, mapping = aes(x=year, y=mean_body_mass, group=island)) +
  geom_line(mapping = aes(color=island)) + geom_point()
```

<img src="fig/06-plot-ggplot2-rendered-mbm-layer-example-1-1.png" style="display: block; margin: auto;" />

In this example, the *aesthetic* mapping of **color** has been moved from the
global plot options in `ggplot` to the `geom_line` layer so it no longer applies
to the points. Now we can clearly see that the points are drawn on top of the
lines.

:::::::::::::::::::::::::::::::::::::::::  callout

## Tip: Setting an aesthetic to a value instead of a mapping

So far, we've seen how to use an aesthetic (such as **color**) as a *mapping* to a variable in the data. For example, when we use `geom_line(mapping = aes(color=island))`, ggplot will give a different color to each island But what if we want to change the color of all lines to blue? You may think that `geom_line(mapping = aes(color="blue"))` should work, but it doesn't. Since we don't want to create a mapping to a specific variable, we can move the color specification outside of the `aes()` function, like this: `geom_line(color="blue")`.


::::::::::::::::::::::::::::::::::::::::::::::::::
  
:::::::::::::::::::::::::::::::::::::::  challenge

## Challenge 3

Switch the order of the point and line layers from the previous example. What
happened?
  
:::::::::::::::  solution

## Solution to challenge 3

The lines now get drawn over the points!
  

``` r
ggplot(data = penguins_bm, mapping = aes(x=year, y=mean_body_mass, group=island)) +
  geom_point() +
  geom_line(mapping = aes(color=island)) 
```

<img src="fig/06-plot-ggplot2-rendered-ch3-sol-1.png" alt="Scatter plot of mran body mass (g) over time, with lines connecting values for each year and species, demonstrating species-specific trends in body mass across years" style="display: block; margin: auto;" />

:::::::::::::::::::::::::
  
::::::::::::::::::::::::::::::::::::::::::::::::::

  
## Statistics
  
ggplot2 also makes it easy to overlay statistical models over the data. To
demonstrate we'll go back to our first challenge:


``` r
ggplot(data = penguins, mapping = aes(x = flipper_length_mm, y = bill_length_mm, color=species)) +
  geom_point()
```

<img src="fig/06-plot-ggplot2-rendered-flipper-vs-bill-scatter3-1.png" style="display: block; margin: auto;" />

We can modify the transparency of the
points, using the *alpha* function, which is especially helpful when you have
a large amount of data which is very clustered.

:::::::::::::::::::::::::::::::::::::::::  callout

## Tip Reminder: Setting an aesthetic to a value instead of a mapping

Notice that we used `geom_point(alpha = 0.5)`. As the previous tip mentioned, using a setting outside of the `aes()` function will cause this value to be used for all points, which is what we want in this case. But just like any other aesthetic setting, *alpha* can also be mapped to a variable in the data. For example, we can give a different transparency to each island with `geom_point(mapping = aes(alpha = island))`.


::::::::::::::::::::::::::::::::::::::::::::::::::

We can fit a simple relationship to the data by adding another layer,
`geom_smooth`:


``` r
ggplot(data = penguins, mapping = aes(x = flipper_length_mm, y = bill_length_mm)) +
  geom_point(alpha = 0.5) + geom_smooth(method="lm")
```

``` output
`geom_smooth()` using formula = 'y ~ x'
```

<img src="fig/06-plot-ggplot2-rendered-lm-fit-1.png" alt="Scatter plot of flipperer length vs bill length with a blue trend line summarising the relationship between variables, and gray shaded area indicating 95% confidence intervals for that trend line." style="display: block; margin: auto;" />

We can make the line thicker by *setting* the **linewidth** aesthetic in the
`geom_smooth` layer:


``` r
ggplot(data = penguins, mapping = aes(x = flipper_length_mm, y = bill_length_mm)) +
  geom_point(alpha = 0.5) + 
  geom_smooth(method="lm") + 
  geom_smooth(method="lm", linewidth=1.5)
```

``` output
`geom_smooth()` using formula = 'y ~ x'
`geom_smooth()` using formula = 'y ~ x'
```

<img src="fig/06-plot-ggplot2-rendered-lm-fit2-1.png" alt="Scatter plot of flipper length vs bill length with a trend line summarising the relationship between variables. The trend line is slightly thicker than in the previous figure." style="display: block; margin: auto;" />

There are two ways an *aesthetic* can be specified. Here we *set* the **linewidth** aesthetic by passing it as an argument to `geom_smooth` and it is applied the same to the whole `geom`. Previously in the lesson we've used the `aes` function to define a *mapping* between data variables and their visual representation.


:::::::::::::::::::::::::::::::::::::::  challenge

## Challenge 4a

Modify the color and size of the points on the point layer in the plot from Challenge 1
example.

Hint: do not use the `aes` function.

Hint: the equivalent of `linewidth` for points is `size`.

:::::::::::::::  solution

## Solution to challenge 4a

Here a possible solution:
  Notice that the `color` argument is supplied outside of the `aes()` function.
This means that it applies to all data points on the graph and is not related to
a specific variable.


``` r
ggplot(data = penguins, mapping = aes(x = flipper_length_mm, y = bill_length_mm)) +
  geom_point(size = 2, color = "orange")
```

<img src="fig/06-plot-ggplot2-rendered-ch4a-sol-1.png" alt="Scatter plot of average body mass (g) over time, showing enlarged orange data points for each year, connected by lines colored by species." style="display: block; margin: auto;" />

:::::::::::::::::::::::::
  
::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::  challenge

## Challenge 4b

Modify your solution to Challenge 4a so that the
points are now a different shape and are colored by species.  

Hint: 
(1) The color argument can be used inside the aesthetic.
(2) See this quick reference to find out more about [available point shapes in R](https://www.sthda.com/english/wiki/ggplot2-point-shapes?title=ggplot2-point-shapes)

:::::::::::::::  solution

## Solution to challenge 4b

Here is a possible solution:
  Notice that supplying the `color` argument inside the `aes()` functions enables you to
connect it to a certain variable. The `shape` argument, as you can see, modifies all
data points the same way (it is outside the `aes()` call) while the `color` argument which
is placed inside the `aes()` call modifies a point's color based on its species value.


``` r
ggplot(data = penguins, mapping = aes(x = flipper_length_mm, y = bill_length_mm)) +
  geom_point(size = 2, shape = 17, aes(color=species)) 
```

<img src="fig/06-plot-ggplot2-rendered-ch4b-sol-1.png" alt="Scatter plot of flipper length (mm) against bill length (mm)." style="display: block; margin: auto;" />

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

## Multi-panel figures

Earlier we visualized the relationship between bill length and flipper length across all
species in one plot. Alternatively, we can split this out over multiple panels
by adding a layer of **facet** panels.


``` r
ggplot(data = penguins, mapping = aes(x = flipper_length_mm, y = bill_length_mm, color = island)) +
  geom_point() +
  facet_wrap( ~ species) +
  theme(axis.text.x = element_text(angle = 45))
```

<img src="fig/06-plot-ggplot2-rendered-facet-1.png" style="display: block; margin: auto;" />

The `facet_wrap` layer took a "formula" as its argument, denoted by the tilde
(~). This tells R to draw a panel for each unique value in the species column
of the penguins dataset.

Note that we apply a "theme" definition to rotate
the x-axis labels to maintain readability.  Nearly everything in
ggplot2 is customizable.

## Modifying text

To clean this figure up for a publication we need to change some of the text
elements. The x-axis is too cluttered, and the axis labels should read
"Bill Length" and "Flipper Length, rather than the column names in the data frame.

We can do this by adding a couple of different layers. The **theme** layer
controls the axis text, and overall text size. Labels for the axes, plot
title and any legend can be set using the `labs` function. Legend titles
are set using the same names we used in the `aes` specification. Thus below
the color legend title is set using `color = "Island"`, while the title
of a fill legend would be set using `fill = "MyTitle"`.


``` r
ggplot(data = penguins, mapping = aes(x = flipper_length_mm, y = bill_length_mm, color = island)) +
  geom_point() +
  facet_wrap( ~ species) +
  labs(
    x = "Flipper Length (mm)",              # x axis title
    y = "Bill Length (mm)",   # y axis title
    title = "Figure 1",      # main title of figure
    color = "Island"      # title of legend
  ) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
```

<img src="fig/06-plot-ggplot2-rendered-theme-1.png" style="display: block; margin: auto;" />

## Exporting the plot

The `ggsave()` function allows you to export a plot created with ggplot. You can specify the dimension and resolution of your plot by adjusting the appropriate arguments (`width`, `height` and `dpi`) to create high quality graphics for publication. In order to save the plot from above, we first assign it to a variable `bill_flipper_plot`, then tell `ggsave` to save that plot in `png` format to a directory called `results`. (Make sure you have a `results/` folder in your working directory.)




``` r
bill_flipper_plot <- ggplot(data = penguins, mapping = aes(x = flipper_length_mm, y = bill_length_mm, color = island)) +
  geom_point() +
  facet_wrap( ~ species) +
  labs(
    x = "Flipper Length (mm)",              # x axis title
    y = "Bill Length (mm)",   # y axis title
    title = "Figure 1",      # main title of figure
    color = "Island"      # title of legend
  ) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

ggsave(filename = "results/bill_flipper_plot.png", plot = bill_flipper_plot, width = 12, height = 10, dpi = 300, units = "cm")
```

There are two nice things about `ggsave`. First, it defaults to the last plot, so if you omit the `plot` argument it will automatically save the last plot you created with `ggplot`. Secondly, it tries to determine the format you want to save your plot in from the file extension you provide for the filename (for example `.png` or `.pdf`). If you need to, you can specify the format explicitly in the `device` argument.

This is a taste of what you can do with ggplot2. RStudio provides a
really useful [cheat sheet][cheat] of the different layers available, and more
extensive documentation is available on the [ggplot2 website][ggplot-doc]. All RStudio cheat sheets are available from the [RStudio website][cheat_all].
Finally, if you have no idea how to change something, a quick Google search will
usually send you to a relevant question and answer on Stack Overflow with reusable
code to modify!


:::::::::::::::::::::::::::::::::::::::  challenge

## Challenge 5

Generate a boxplot to compare flipper length between species.


Advanced:

- Add axis labels
- Hide the legend

:::::::::::::::  solution

## Solution to Challenge 5

Here a possible solution:
`xlab()` and `ylab()` set labels for the x and y axes, respectively
The axis title, text and ticks are attributes of the theme and must be modified within a `theme()` call.


``` r
ggplot(data = penguins, mapping = aes(x = species, y = flipper_length_mm, fill = species)) +
  geom_boxplot() +
  labs(
    x = "Species",              # x axis title
    y = "Flipper Length (mm)",   # y axis title
  ) +  
  theme(legend.position = "none")
```

<img src="fig/06-plot-ggplot2-rendered-ch5-sol-1.png" alt="Boxplot comparing flipper length (mm) across penguin species, with labeled axes showing species on the x-axis and flipper length on the y-axis, and the legend hidden for a cleaner view." style="display: block; margin: auto;" />

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

## Further reading
We recommend the following resources for some additional reading on the topic of this episode:

### ggplot2
- [ggplot2: Elegant Graphics for Data Analysis (3e)](https://ggplot2-book.org/)
- [ggplot2](https://www.statmethods.net/advgraphs/ggplot2.html)
- [cheat](https://www.rstudio.org/links/data_visualization_cheat_sheet)
- [ggplot-doc](https://ggplot2.tidyverse.org/reference/)

### Other Plotting Systems
- [base]https://www.statmethods.net/graphs/index.html
- [lattice]https://www.statmethods.net/advgraphs/trellis.html

:::::::::::::::::::::::::::::::::::::::: keypoints

- Use `ggplot2` to create plots.
- Think about graphics in layers: aesthetics, geometry, statistics, scale transformation, and grouping.

::::::::::::::::::::::::::::::::::::::::::::::::::


