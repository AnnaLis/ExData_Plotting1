setwd("C:/Users/Ania/Documents/GitHub/ExData_Plotting1")

install.packages("sqldf")
library(sqldf)
install.packages("lubridate")
library("lubridate")

df <- read.csv.sql("household_power_consumption.txt", 
                   sql = "select * from file where Date in ('1/2/2007','2/2/2007')", sep=";")
df <- cbind(paste(df$Date,df$Time),df)
colnames(df)<-c("DateTime","Date","Time","Global_active_power",
                "Global_reactive_power","Voltage","Global_intensity", 
                "Sub_metering_1","Sub_metering_2","Sub_metering_3")
df$DateTime<-as.character(df$DateTime)
df$dt<-strptime(df$DateTime, format='%d/%m/%Y %H:%M:%S')
df$day <- wday(df$dt, label = TRUE, abbr = TRUE)


png(filename = "plot3.png",  width=480, height=480)
plot(df$dt, df$Sub_metering_1, type="l", xlab=" ", ylab="Energy sub metering")
lines(df$dt,df$Sub_metering_2, col="red")
lines(df$dt,df$Sub_metering_3, col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       pch="____",
       col=c("black","red","blue"))
dev.off()