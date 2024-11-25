---
title: Instructor Notes
---

## Timing

Leave about 30 minutes at the start of each workshop and another 15 mins
at the start of each session for technical difficulties like WiFi and
installing things (even if you asked students to install in advance, longer if
not).


## RStudio Color Preview

RStudio has a feature to preview the color for certain named colors and hexadecimal colors. This may confuse or distract learners (and instructors) who are not expecting it.

This option can be turned off and on in the following menu setting:
Tools -> Global Options -> Code -> Display -> Enable preview of named and hexadecimal colors (under "Syntax") 

## Pulling in Data

The easiest way to get the data used in this lesson during a workshop is to have
attendees download the raw data from [penguins-wide].

Attendees can use the `File - Save As` dialog in their browser to save the file.

## Overall

Make sure to emphasize good practices: put code in scripts, and make
sure they're version controlled. Encourage students to create script
files for challenges.

If you're working in a cloud environment, get them to upload the
gapminder data after the second lesson.

Make sure to emphasize data frames are lists underneath the hood: this will explain a lot of the esoteric behaviour encountered in basic operations.

Vector recycling and function stacks are probably best explained
with diagrams on a whiteboard.

Be sure to actually go through examples of an R help page: help files
can be intimidating at first, but knowing how to read them is tremendously
useful.

Be sure to show the CRAN task views, look at one of the topics.

There's a lot of content: move quickly through the earlier lessons. Their
extensiveness is mostly for purposes of learning by osmosis: so that their
memory will trigger later when they encounter a problem or some esoteric behaviour.

Key lessons to take time on:

- Data subsetting - conceptually difficult for novices
- Data structures - worth being thorough, but you can go through it quickly.

Don't worry about being correct or knowing the material back-to-front. Use
mistakes as teaching moments: the most vital skill you can impart is how to
debug and recover from unexpected errors.

[penguins-teaching]: data/penguins_teaching.csv




