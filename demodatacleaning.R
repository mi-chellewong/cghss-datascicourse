#######################################################################
### Load required libraries ###########################################
#######################################################################

## if you don't already have readxl downloaded, start by running:
#install.packages("dplyr")
## The code above will install the package you need on your computer
## you only need to run it once, if you haven't downloaded the package before

## within any new R session, you need to load the libraries you need
library(dplyr)

#######################################################################
### Read in course datasets ###########################################
#######################################################################

## this code tells R to read in a tab-delimited file as a data frame
cases <- read.delim("https://raw.githubusercontent.com/seaneff/data-science-basics-2024/main/course-datasets/measles_cases.tsv")
policy <- read.delim("https://raw.githubusercontent.com/seaneff/data-science-basics-2024/main/course-datasets/measles_vaccine_policy.tsv")
countries <- read.delim("https://raw.githubusercontent.com/seaneff/data-science-basics-2024/main/course-datasets/countries.tsv")

#######################################################################
### View the datasets #################################################
#######################################################################

## View() will open a new tab in the top left section or RStudio
View(policy)

## head() will print out the first few rows of a table
head(policy)

#######################################################################
### Explore dataset generally #########################################
#######################################################################

## What are the columns/fields?
names(policy)

## How many rows and columns are there?
nrow(policy) ## number of rows
ncol(policy) ## number of columns
dim(policy) ## this prints out both rows and columns

#######################################################################
### Check for missing values ##########################################
#######################################################################

## this checks for any missing values dataset policy, overall
anyNA(policy)


## this checks for any missing values in the country_name field of the policy dataset
anyNA(policy$country_name)

########################################################################################################
### Your turn ##########################################################################################
########################################################################################################

## Load in a new dataset with country-level information, name it "countries"
## TODO ADD BITLY LINK
## complete the same analyses you did above with that new dataset
View(cases)
head(cases)
names(cases)

nrow(cases)
ncol(cases)
dim(cases)
anyNA(cases)
anyNA(cases$iso_code)
anyNA(cases$country_name)
anyNA(cases$month)
anyNA(cases$measles_cases)
anyNA(cases$who_region)
anyNA(cases$world_bank_region)
anyNA(cases$income_group)

#############################################################################################
### Descriptive statistics: #################################################################
### Measures of centrality (average, median) ################################################
#############################################################################################

## average, across countries reporting data, of proportion of total population who live in a rural area
mean(countries$pct_rural) ## what happened here? missing values
table(is.na(countries$pct_rural))
which(is.na(countries$pct_rural))
mean(countries$pct_rural, na.rm = TRUE) 

## median, across countries reporting data, of proportion of total population who live in a rural area
median(countries$pct_rural) ## what happened here? missing values
median(countries$pct_rural, na.rm = TRUE) 

## look into missing data
table(is.na(countries$pct_rural))

#############################################################################################
### Descriptive statistics: #################################################################
### Measures of spread (standard deviation, interquartile range) ############################
#############################################################################################

## standard deviation, across countries reporting data, of MCV1 rates
## MCV1 =  Measles-containing-vaccine first-dose (MCV1) immunization coverage among 1-year-olds (%) (WUENIC) 
sd(countries$mcv1_coverage) 

## interquartile range (IQR), across countries reporting data, of MVC1 rates
quantile(countries$mcv1_coverage) 

#############################################################################################
### Descriptive statistics: #################################################################
### Counts and rates ########################################################################
#############################################################################################

## counts of countries in each WHO region
table(countries$who_region)

## number of countries where over 75% of the population live in a rural area
table(countries$pct_rural > 75) 

## which countries have over 75% of the population live in a rural area?
countries[which(countries$pct_rural > 75),]$country

#############################################################################################
### Descriptive statistics ##################################################################
### by group ################################################################################
#############################################################################################

countries %>%
  group_by(who_region) %>%
  summarize(n = n(),
            avg_vaccination_rate = mean(mcv1_coverage),
            sd_vaccination_rate = sd(mcv1_coverage))

########################################################################################################
### Your turn ##########################################################################################
########################################################################################################

## Using the code above, instead of calculating average vaccination rate per WHO region, 
## calculate the average population size per income group
## (this is tricky, we can do it together)
countries %>%
  group_by(income_group) %>%
  summarize(n = n(),
            avg_population_size = mean(total_population),
            sd_population_size = sd(total_population))

########################################################################################################
### Your turn ##########################################################################################
########################################################################################################

## Read in a new dataset
## Either: caseload data or another dataset of your choice (e.g., an energy dataset)
cases %>%
  group_by(income_group) %>%
  summarize(n = n(),
            avg_total_cases = mean(measles_cases),
            sd_total_cases = sd(measles_cases))

cases %>%
  group_by(who_region) %>%
  summarize(n = n(),
            avg_num_cases = mean(measles_cases),
            sd_num_cases = sd(measles_cases))

########################################################################################################
### Your turn ##########################################################################################
########################################################################################################

## What are some other ways to explore a new dataset?
## Hint: data visualization ideas?

