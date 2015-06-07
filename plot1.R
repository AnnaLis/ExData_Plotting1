#setwd("C:/Users/Ania/Documents/GitHub/ExData_Plotting1")

# Installing required packages
list.of.packages <- c("sqldf")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)
library(sqldf)
library(lubridate)

df <- read.csv.sql("household_power_consumption.txt", 
                    sql = "select * from file where Date in ('1/2/2007','2/2/2007')", sep=";")

#Plot1
png(filename = "plot1.png",  width=480, height=480)
hist(df$Global_active_power,  col = "red", xlab="Global active power (kilowatts)",
     main="Global Active Power")
dev.off()
