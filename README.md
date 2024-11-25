# Introduction to R

This lesson is an Introduction to R and R Studio for researchers at the University of Birmingham (UK) using the [Palmer Penguins][palmerpenguinspkg] data and the [tidyverse][tidyversepkg] suit of packages.

A rendered version of the course notes can be found at:
<PLACEHOLDER>

## Overview 
The goal of this lesson is to teach novice programmers to write modular code
and best practices for using R for data analysis. R is commonly used in many
scientific disciplines for statistical analysis and its array of third-party
packages. 

The emphasis of these materials is to give
attendees a strong foundation in the fundamentals of R, and to teach best
practices for scientific computing: breaking down analyses into modular units,
task automation, and encapsulation.

Note that this workshop focuses on the fundamentals of the programming
language R, and not on statistical analysis.

A variety of third party packages are used throughout this workshop. These
are not necessarily the best, nor are they comprehensive, but they are 
packages we find useful, and have been chosen primarily for their 
usability.


## Changes from R for Reproducible Scientific Analysis

This course is based on the CC-BY-4.0 licensed [Software Carpentry](https://software-carpentry.org/) course [R for Reproducible Scientific Analysis][rgapminder], and has been abridged and tailored to 
meet the needs of researchers at the University of Birmingham. 

The main changes are:

* We reuse content from the following core episodes from the original course: (i) Introduction to R and R Studio (E1), (ii) Project Management with RStudio (E2) (iii) Data Structures (E4) (iv) Exploring Data Frames (E5) (v) Data Frame Manipulation with Dplyr (E12) and (vi) Creating Publication Quality Graphics with GGplot2 (E8) with some additional material from Subsetting Data (E6) and Vectorisation (E9). 
* We cover vectors and lists but have removed material on other data structures such as factors and matrices
* We do not use git or GitHub during the course and signpost researchers to 
University of Birmingham's Advanced Research Computing's git course. 
* We have updated the episode to use the  [Palmer Penguins][palmerpenguinspkg] dataset
rather than [gapminder][].
* Setup instructions have been tailored to University of Birmingham infrastructure
* Episode 4 "Seeking Help" is reused with minor adaptations from ["Data Analysis using R"][daur] which in turn was also adapted from 
[R for Reproducible Scientific Analysis][rgapminder] by David Mawdsley. Small sectiond of "Loading data into R" from ["Data Analysis using R"][daur] are re-used in Episode 5 "Manipulating Tibbles With Dplyr".


A rendered version of the original Software Carpentry lesson can be found at: <https://swcarpentry.github.io/r-novice-gapminder>,


## Data

This lesson uses the [Palmer Penguins][palmerpenguinspkg] dataset. The original 
palmer penguins datasets can be found in folder `episodes/data` as files 
`penguins_raw.csv` and the simplified version `penguins.csv`. 

### License 
Data are re-used untder [CC-0](https://creativecommons.org/share-your-work/public-domain/cc0/) license in accordance with the [Palmer Station LTER Data Policy](http://pal.lternet.edu/data/policies)
and the [LTER Data Access Policy for Type I data](https://lternet.edu/data-access-policy/).

### Teaching Dataset 
This course uses the file `penguins_teaching.csv` for demonstration purposes. This dataset was created from `penguins.csv` for the purposes of teaching this course using the script `episodes/data/prepare.R`. The `year` variable has been converted to text and missing values
have been replaced with their mean and modal values for convenience. 


#### See also
More information about the dataset is available in
[its official documentation](https://allisonhorst.github.io/palmerpenguins/).

## Authors
This course was developed by Kamilla Kopec-harding with some additional material by David Mawdesley.  Helpful reviews were provided by Catherine Smith. Artwork by Allison Horst was re-used under CC-BY-4.0 license.  

The authors of the original Software Carpentries course from which this course was adapted are listed in the citation below. 

## Citations

Naupaka Zimmerman, Greg Wilson, Raniere Silva, Scott Ritchie, François Michonneau, Jeffrey Oliver, … Yuka Takemon. (2019, July). swcarpentry/r-novice-gapminder: Software Carpentry: R for Reproducible Scientific Analysis, June 2019 (Version v2019.06.1). Zenodo. http://doi.org/10.5281/zenodo.3265164

Gorman KB, Williams TD, Fraser WR (2014) Ecological Sexual Dimorphism and Environmental
Variability within a Community of Antarctic Penguins (Genus Pygoscelis). PLoS ONE 9(3):
e90081. https://doi.org/10.1371/journal.pone.0090081
