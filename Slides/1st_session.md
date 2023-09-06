---
title: "Computer programming E140"
author: Christian Dudel
date: September 6, 2023
output: beamer_presentation
---

# What will be covered in this course?
  
- Software: R (and RStudio)
- Mostly basic things in these programs
- Course will not cover many things
- Course will not be deep

# Goals

At the end of this course...

- ...you understand basic concepts of R
- ...you can do a basic analysis in R

# Prerequisites

- Basic demographic knowledge (e.g., you know what a 'rate' is)
- Basic statistical knowledge (e.g., you know what a 'mean' is)
- First experince using statistical software (Stata, Excel, SAS, SPSS, R, ...)

# Already an expert?

- Write a function that takes any integer as input and returns TRUE if the integer is a prime number, otherwise it returns FALSE
- Write a function that takes any integer as input and returns its amicable number if it exists, otherwise it returns FALSE
- Check one of the many tasks on rosettacode.org solved with R
- Reproduce or replicate one of the many reproducible/replicable articles available at Demographic Research
- Work on your own analysis

# Materials

Materials will be available from GitHub, also mirrored on OSF:
  
- https://github.com/christiandudel/EDSD2023
- https://osf.io/vdq4k/

# Contact

- Email: dudel@demogr.mpg.de
- Office: 358 (3rd floor, east wing)
- Twitter: @c_dudel
- Website: http://www.christiandudel.com

# Things I work on/I am interested in

- *Topics*: Labor markets, fertility, health
- *Concepts*: Stratification, inequality, life courses, aging
- *Methods*: Longitudinal data analysis, causal inference, identification, survey methodology

# Course schedule

September 6 (Wed), 14:00-16:00 (Basics)

September 7 (Thu), 14:00-16:00 (Descriptive)

September 11 (Mon), 9:30-11:30 (Data viz)

September 12 (Tue), 14:00-16:00 (Data handling)

September 13 (Wed), 14:00-16:00 (Programming 1)

September 25 (Mon), 14:00-16:00 (Programming 2)

September 27 (Wed), 14:00-16:00 (Example)

# Other dates

Staff outing: September 14 (Thu)

Social Demography Research Day: October 13 (Fri), 10:00-15:00

# (Voluntary) exercises

- For some sessions, there will be voluntary exercises 
- Exercises and solutions are available online (GitHub/OSF)
- These voluntary exercises have to be distinguished from the (mandatory!) assignment

# Assignment: Overview

- One mandatory assignment
- Assignment handed out on September 25
- Deadline: October 22
- Assignment will consist of several tasks

# Assignment: Your solutions

- You submit R code as solutions (via email)
- R code should be commented, explaining what is happening
- Code should work without errors

# Assignment: Deadline

- Deadline assignment: October 22, 12am/midnight/24:00 (CEST/Berlin time)
- Send your solutions to me (dudel@demogr.mpg.de)
- You will get a confirmation (might take a bit, sorry)
- I might get back to you if I have problems with your file(s)
- It is your responsibility that your files are working!
  
# Assignment: Groups
  
- You can work in groups
- Actually, I strongly suggest you work in groups!
- Please not more than five people per group
- Please submit your solutions only once per group
- Make clear who is member of the group when submitting

# Assignment: Grading

* You can either “pass” or “fail”
* Your code should...
* ...work without errors
* ...be well-documented: Comments!
* ...should be (somewhat) efficient. If one step can do the work then don’t
use two or more!
  
# Assignment: Summary
  
- One assignment consisting of coding tasks
- You submit code as solutions, via email
- Deadline: October 22
- You can work in groups
- Pass/fail

# What is R?

- R is an open source statistical programming language
- First release in 1995
- Used for data analysis and statistical programming

# Why use R?

- Free, open source
- Can easily be extended
- More than 20,000 packages available
- Many methods are already implemented in R
- Commonly used in both science and industry
- Many R-related materials: Books, journals, conferences, forums, tutorials...


# Why use RStudio?

* R is the programming language
* RStudio is a tool to use R more efficiently (IDE)
* Features:
+ Syntax highlighting, code folding
+ Project management (e.g., GitHub)
+ Markdown support
+ ...

# Disclaimer

- R is not the only statistical software and it is fine if you prefer something else
- RStudio is not the only IDE/editor for R (ESS, RKWward, Tinn-R, ...)
- R can be used in many different ways
- Example: base R vs tidyverse vs data.table vs specialized packages
- I do things in certain ways, and this course will follow that
- This does not mean that the solutions from this course are the only or the best way to do things

# What do you need to get started?

- R: https://cloud.r-project.org/
- R-Studio: https://www.rstudio.com/
  