### Soluations for the exercise of session 2

# Load data
file <- "https://raw.githubusercontent.com/kosukeimai/qss/master/CAUSALITY/resume.csv"
experiment <- read.csv(file)

# Look inside
head(experiment)

# Create table
tab <- table(experiment$race,
             experiment$call,
             dnn=c("Race","Call"))

# Turn into relative proportions (row-wise)
prop.table(tab,1)

# Direct comparison:
prop.table(tab,1)[2,2]/prop.table(tab,1)[1,2]
# => Whites are 50% more likely to receive a callback than Blacks
