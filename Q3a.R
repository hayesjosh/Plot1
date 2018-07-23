###RScript for Q3 of Data Incubator Challenge

###DI PLOT ONE


#set working directory
setwd("C:/Users/Jouki/Dropbox/Work/DS/DI_Chall/data/Q3/")
#setwd("Dropbox/Data Science/DI_Chall/data/Q3/")

#load some pacakges
library("readr")
library("tidyverse")
library("ggplot2")
library("data.table")
library("dplyr")
library("lubridate")
library("rvest")
library("stringi")
library("ggmap")
library("fiftystater")

#######################inputting mortgage data
#setting the wd to input the mortgage files
setwd("C:/Users/Jouki/Dropbox/Work/DS/DI_Chall/data/Q3/mortgagedata/all/")
file.list <- list.files(pattern = '*.txt')

#making a function to input the mortgage files
mortgage.input <- function(doc) {
  harp_origfile <- read.table(doc, sep="|", header=FALSE, colClasses=origclass )
  names(harp_origfile)=c('fico','dt_first_pi','flag_fthb','dt_matr','cd_msa',"mi_pct",'cnt_units','occpy_sts','cltv','dt i','orig_upb','ltv','int_rt','channel','ppmt_pnlty','prod_type','st', 'prop_type','zipcode','id_loan','loan_purpose', 'orig_loan_term','cnt_borr','seller_name') 
  doc <- harp_origfile
  doc <- subset(doc, select =(c("fico", "dt_first_pi", "flag_fthb", "st", "zipcode", "id_loan")))
  doc1 <- doc
}
#defining origclass
origclass <- c('integer','integer','character', 'integer', 'character', 'real', 'integer',  'character','real','integer','integer','integer','real','character','character','character','character', 'character','character','character','character', 'integer', 'integer','character','character','character') 
#inputting all the data into a list of dataframes
lst <- lapply(file.list, mortgage.input)
#binding all those dataframes together into a single dataframe
dmort = as.data.frame(data.table::rbindlist(lst))

#transforming the date information
dmort$date <- as.character(dmort$dt_first_pi)
stri_sub(dmort$date, 5, 4) <- "-"
dmort$date <- paste(dmort$date, "-01", sep="")
dmort$date <- strptime(dmort$date, "%Y-%m-%d")
dmort$date <- as.POSIXct(dmort$date, "%Y-%m-%d")
dmort$year <- year(dmort$date)
dmort$month <- month(dmort$date)

#making state a factor
dmort$st <- as.factor(dmort$st)

#cleaning First-Time-Buyers FTB
dmort$flag_fthb[dmort$flag_fthb == "9"] <- 0
dmort$flag_fthb[dmort$flag_fthb == "Y"] <- 1
dmort$flag_fthb[dmort$flag_fthb == "N"] <- 0
sapply(dmort, function(x) sum(is.na(x)))

#making some state-wide values for graphing
fico.year  <- dmort %>%
  group_by(st, year) %>%
  summarise (ficoN =n(), ficoAvg = mean(fico))

fthb.year <- dmort %>% 
  group_by(st, year) %>% 
  summarize(fthbN=n(),fthbPerc= sum(flag_fthb=="1")/n()*100)

#for merginging later
fico.merge  <- dmort %>%
  group_by(st, date) %>%
  summarise (ficoN =n(), ficoAvg = mean(fico))

fthb.merge <- dmort2 %>% 
  group_by(st, date) %>% 
  summarize(fthbN=n(),fthbPerc= sum(flag_fthb=="1")/n()*100)

#setting the wd for graphs
setwd("C:/Users/Jouki/Dropbox/Work/DS/DI_Chall/visualizations/Q3/")

#creating plot for Average FICO Score
multiplot1 = filter(fico.year, st=="CA" | st=="MA" | st=="TX"|st=="WA"|st=="CO"|st=="NC") %>%
  ggplot(aes(x = year, y = ficoAvg, color = st)) +
  ggtitle("Average FICO Score for Home Buyers") +
  theme(plot.title = element_text(hjust = 0.5))+
  geom_line(size=1)+
  labs(color = "State", y = "Mean FICO", x = "Year")  
multiplot1
ggsave("avgFico.jpg", width = 5, height = 5)

#creating plot for Percentage of First Time Home Buyers
multiplot2 = filter(state.house.values2, st=="CA" | st=="MA" | st=="TX"|st=="WA"|st=="CO"|st=="NC") %>%
  ggplot(aes(x = year, y = fthbPerc, color = st)) +
  ggtitle("Percentage of Home Buyers that are 'First Time' Buyers")+
  theme(plot.title = element_text(hjust = 0.5))+
  geom_line(size=1) +
  labs(color = "State", y = "Percentage", x = "Year")  
multiplot2                              
ggsave("fthbPerc.jpg", width = 5, height = 5)





