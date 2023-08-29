### Birth register data #############################################

### Loading packages ################################################

  # For pipes etc
  library(tidyverse)
  # For handling of large data sets
  library(data.table)
  # For downloading data
  library(httr)


### Loading data ####################################################

  ## Data available from:
  ## https://www.nber.org/data/vital-statistics-natality-data.html

  # Data for 2021
  url <- "https://data.nber.org/nvss/natality/csv/nat2021us.csv"
  # Documentation: 
  # https://data.nber.org/nvss/natality/code/nat2021us.html
  # https://data.nber.org/nvss/natality/orig/UserGuide2021.pdf
  
  # Download file (might take some time!)
  file <- "U:/Data/nat2021us.csv"
  if(!file.exists(file)) {
    GET(url, write_disk(file, overwrite = TRUE), progress() )
  }
  
  # Load file 
  dat <- fread(file,select=c("dob_mm","restatus",
                             "mager","fagecomb",
                             "cig_1","cig_2","cig_3"))
  
  # Number of births and variables
  dim(dat)
  
  
### Editing data ####################################################
  
  # Looking at variables
  summary(dat)
  
  # Restricting data: Population that matters
  dat$restatus %>% table
  dat <- dat %>% filter(restatus!=4)
  
  # Editing variable Age of father
  dat$fagecomb %>% summary
  dat$fagecomb %>% table %>% barplot 
  # Set some values to missing
  dat <- dat %>% mutate(fager=ifelse(fagecomb%in%12:98,fagecomb,NA))
  dat$fager %>% summary
  # Simple imputation to get rid of missing values
  dat$mager %>% summary
  dat <- dat %>% mutate(fager=ifelse(is.na(fager),mager+3,fager))
  dat$fager %>% summary

  
### Get population data for fertility rates #########################
  
  # Load library
  library(HMDHFDplus)
  # Gets data from the HMD: https://www.mortality.org/
  # Note that you need to register with the old version of HMD:
  # https://former.mortality.org/
  
  # Set username and password as used for old HMD
  # us <- "username"
  # pw <- "password"
  
  # Load US data
  pop <- readHMDweb(CNTRY="USA",
                       item="Exposures_1x1",
                       username=us,
                       password=pw)
  
  # Edit pop data (not available for 2021, but 2020 will do)
  pop <- pop %>% 
           filter(Year==2020) %>% 
           select(Age,Female1,Male1)
  
  
### Generate rates for men ##########################################

  # Setting age range
  age_range_m <- 15:59
  agemax <- max(age_range_m)
  agemin <- min(age_range_m)
  
  # Edit age variable for fathers
  dat <- dat %>% mutate(fager=ifelse(fager>agemax,agemax,fager),
                        fager=ifelse(fager<agemin,agemin,fager))
  
  # Aggregate data
  dat$count <- 1
  counts_m <- aggregate(count~fager,data=dat,FUN=sum)
  dim(counts_m)
  head(counts_m)
  counts_m <- counts_m %>% rename('Age'="fager")
  
  # Combine data
  rates_m <- tibble(Age=age_range_m) %>% 
               left_join(counts_m,by="Age")
  rates_m <- pop %>% select(Age,Male1) %>% right_join(rates_m,by="Age")
  
  # Calculate rates
  rates_m <- rates_m %>% mutate(rate=count/Male1)

  # TFR
  rates_m %>% summarize(TFR=sum(rate))
  
  # MAC
  rates_m %>% summarize(MAC=sum(Age*rate/sum(rate)))

  # Simple plot of age schedule  
  ggplot(data=rates_m,aes(x=Age,y=rate)) + 
    geom_line()
  
  
### Another simple analysis: Smoking comparison with birthwt ########
  
  # Create dummy for smoking status 
  dat <- dat %>% mutate( dcig1 = ifelse(cig_1%in%1:98,1,0),
                         dcig2 = ifelse(cig_2%in%1:98,1,0),
                         dcig3 = ifelse(cig_3%in%1:98,1,0),
                         dcig  = dcig1+dcig2+dcig3,
                         dcig  = ifelse(dcig>0,1,0),
                         dcig  = ifelse(cig_1==99,NA,dcig),
                         dcig  = ifelse(cig_2==99,NA,dcig),
                         dcig  = ifelse(cig_3==99,NA,dcig))
  
  # Smoking prevalence in 2021
  dat$dcig %>% table(useNA="always") %>% prop.table
  dat$dcig %>% table %>% prop.table
  
  # Smoking prevalence in birthwt data from MASS
  data(birthwt,package="MASS")
  birthwt$smoke %>% table %>% prop.table
  
  
### Another simple analysis: Seasonality of births ##################
  
  ggplot(data=dat,
         mapping=aes(x=dob_mm))+
    geom_bar(stat="count",
             color="black",
             fill="steelblue") +
    labs(x="Birth month",y="Number of births",
         title="Seasonality of births")+
    scale_x_discrete(limits=paste(1:12))+
    scale_y_continuous(labels = label_number(suffix = " T", scale = 1e-3))
  