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


png(filename = "plot4.png",  width=480, height=480)
par(mfrow=c(2,2))

#1
plot(df$dt,df$Global_active_power, type="l", xlab=" ", ylab="Global Active Power")

#2
plot(df$dt,df$Voltage, type="l", xlab="datetime", ylab="Voltage")


#3
plot(df$dt, df$Sub_metering_1, type="l", xlab=" ", ylab="Energy sub metering")
lines(df$dt,df$Sub_metering_2, col="red")
lines(df$dt,df$Sub_metering_3, col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       pch="____",
       col=c("black","red","blue"), bty="n")

#4
plot(df$dt, df$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()

