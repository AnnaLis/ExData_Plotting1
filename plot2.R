#setwd("C:/Users/Ania/Documents/GitHub/ExData_Plotting1")

# Installing required packages
list.of.packages <- c("sqldf", "lubridate")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)
library(sqldf)
library(lubridate)

df <- read.csv.sql("household_power_consumption.txt", 
                    sql = "select * from file where Date in ('1/2/2007','2/2/2007')", sep=";")
df <- cbind(paste(df$Date,df$Time),df)
colnames(df)<-c("DateTime","Date","Time","Global_active_power",
                 "Global_reactive_power","Voltage","Global_intensity", 
                 "Sub_metering_1","Sub_metering_2","Sub_metering_3")
df$DateTime<-as.character(df$DateTime)
df$dt<-strptime(df$DateTime, format='%d/%m/%Y %H:%M:%S')
df$day <- wday(df$dt, label = TRUE, abbr = TRUE)

#Plot2
png(filename = "plot2.png",  width=480, height=480)
plot(df$dt, df$Global_active_power, type="l", xlab=" ", ylab="Global active power (kilowatts)")
dev.off()


