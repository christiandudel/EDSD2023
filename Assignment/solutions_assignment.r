### 1a ########################################################################

  # Tidyverse
  library(tidyverse)

  # To load Stata data
  library(foreign)
  
  # Read file (on N-drive, old EDSD course)
  file <- "N:/IMPRSD/EDSD 19-20/EDSD 140 Computer Programming/Data/soep_lebensz_en.dta"
  soep <- read.dta(file,convert.factors=F)

  
### 1b ########################################################################
  
  # Number of unique IDs
  soep$id %>% unique %>% length
  # Alternative
  soep %>% pull(id) %>% unique %>% length

  
### 1c ########################################################################
  
  # Tabulate number of obs per year
  soep$year %>% table
  # For example, there are 3198 obs for 2000
  
  
### 1d ########################################################################
  
  # Restrict data
  soep_2004 <- soep %>% filter(year==2004)
  
  # Simple check whether it worked
  soep_2004$year %>% table
  
  # Proportion of women
  soep_2004$sex %>% table %>% prop.table
  # About 54% are women  
  
  # Average satisfaction by gender (tidy)
  soep_2004 %>% 
    group_by(sex) %>% 
    summarize(mean(health_org))
  # Women are slightly less satisfied 
  
  # Average satisfaction by gender (base R)
  by(soep_2004$health_org,soep_2004$sex,mean)
  
  
  
### 2a ########################################################################
  
  # Swedish data (on N-drive, old EDSD course)
  filename <- "N:/IMPRSD/EDSD 19-20/EDSD 140 Computer Programming/Data/SWE_E0per.txt"
  e0swe <- read.table(file=filename,
                      header=T,skip=2)  

  
### 2b ########################################################################

  # ggplot2
  e0swe %>% 
    ggplot()+
    geom_line(aes(x=Year, y=Female, color="Female"))+
    # Adding men
    geom_line(aes(x=Year, y=Male, color="Male"))+
    # Changing colors  
    scale_color_manual(values = c("Female" = "#d95f02", "Male" = "#1b9e77"))+
    # Change theme
    theme_bw()+
    # Change title and axis labels
    ggtitle("Life expectancy in Sweden")+
    labs(x="Year",y="e0") +
    # Change legend
    theme(legend.title = element_blank())
  
    
  # Base R
  plot(e0swe$Year,e0swe$Female,type="l",
       xlab="Year",ylab="e0",
       panel.first=grid(),col="#d95f02",
       main="Life expectancy in Sweden")
  # Adding men
  lines(e0swe$Year,e0swe$Male,col="#1b9e77")
  # Adding legend
  legend(x=1750,y=80,lty=1,
         col=c("#d95f02","#1b9e77"),
         legend=c("Females","Males"))

    
### 2c ########################################################################
  
  # Calculate gender gap (base R)
  e0swe$gendergap <- e0swe$Female-e0swe$Male
  # Equivalent:
  e0swe <- e0swe %>% mutate(gendergap=Female-Male)
  
  # ggplot
  e0swe %>% 
    ggplot(aes(x=Year, y=gendergap))+
    geom_line()+
    # Change theme
    theme_bw()+
    # Change title and axis labels
    ggtitle("Gender gap in life expectancy in Sweden")+
    labs(x="Year",y="Women e0 - men e0") +
    lims(y=c(-1,7)) +
    # Add reference line
    geom_hline(yintercept=0)
  # I include the range from -1 to 7 for the y-axis in the plot
  # as this allows to include a reference line at zero.
  # For values below that line males are doing better and
  # values above the reference line mean that women are doing better.
  # This makes reading the figure a bit easier: You can immediately see
  # that women in Sweden have always been doing better  
  
  # Base R
  plot(e0swe$Year,e0swe$gendergap,type="l",
       xlab="Year",ylab="Women e0 - men e0",
       panel.first=grid(),
       main="Gender gap in life expectancy in Sweden",
       ylim=c(-1,7))
  abline(h=0)
  
  
