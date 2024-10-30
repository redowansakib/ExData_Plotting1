library(sqldf)
library(lubridate)
library(dplyr)

# original file containing data for this project could not be updated because of its large size

file_path = r"(D:\Coursera Data Science Course\Exploratory Data Analysis\Course Project 1\data\household_power_consumption.txt)"

df = read.csv.sql(file_path,"SELECT * FROM file 
                  WHERE Date = '1/2/2007' or Date = '2/2/2007'",
                  sep=";")

df = mutate(df,DateTime = dmy_hms(paste(Date,Time)),.keep="unused",.before=Global_active_power)

# Opening png device
png("plot4.png")

par(mfrow=c(2,2))                 

# plot-1
with(df,plot(DateTime,Global_active_power,"l",xaxt="n",
             xlim=c(as_datetime("2007-02-01 00:00:00"),as_datetime("2007-02-03 00:00:00")),
             ylab="Global Active Power (kilowatts)",xlab=NA))

axis(1,c(as_datetime("2007-02-01 00:00:00"),as_datetime("2007-02-02 00:00:00"),as_datetime("2007-02-03 00:00:00")),
     format(c(as_datetime("2007-02-01 00:00:00"),as_datetime("2007-02-02 00:00:00"),as_datetime("2007-02-03 00:00:00")),"%a"))

# plot-2
with(df,plot(DateTime,Voltage,"l",xaxt="n",
             xlim=c(as_datetime("2007-02-01 00:00:00"),as_datetime("2007-02-03 00:00:00")),
             ylab="Voltage",xlab=NA))

axis(1,c(as_datetime("2007-02-01 00:00:00"),as_datetime("2007-02-02 00:00:00"),as_datetime("2007-02-03 00:00:00")),
     format(c(as_datetime("2007-02-01 00:00:00"),as_datetime("2007-02-02 00:00:00"),as_datetime("2007-02-03 00:00:00")),"%a"))

# plot-3
with(df,plot(DateTime,Sub_metering_1,"l",xaxt="n",
             xlim=c(as_datetime("2007-02-01 00:00:00"),as_datetime("2007-02-03 00:00:00")),
             ylab="Energy sub metering",xlab=NA))

with(df,lines(DateTime,Sub_metering_2,col="red"))
with(df,lines(DateTime,Sub_metering_3,col="blue"))

axis(1,c(as_datetime("2007-02-01 00:00:00"),as_datetime("2007-02-02 00:00:00"),as_datetime("2007-02-03 00:00:00")),
     format(c(as_datetime("2007-02-01 00:00:00"),as_datetime("2007-02-02 00:00:00"),as_datetime("2007-02-03 00:00:00")),"%a"))

legend("topright",
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black","red","blue"),
       lty=1,
       bty="n",
       cex=0.8)

# plot-4
with(df,plot(DateTime,Global_reactive_power,"l",xaxt="n",
             xlim=c(as_datetime("2007-02-01 00:00:00"),as_datetime("2007-02-03 00:00:00")),
             ylab="Global Reactive Power (kilowatts)",xlab=NA))

axis(1,c(as_datetime("2007-02-01 00:00:00"),as_datetime("2007-02-02 00:00:00"),as_datetime("2007-02-03 00:00:00")),
     format(c(as_datetime("2007-02-01 00:00:00"),as_datetime("2007-02-02 00:00:00"),as_datetime("2007-02-03 00:00:00")),"%a"))

dev.off()