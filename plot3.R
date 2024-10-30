library(sqldf)
library(lubridate)
library(dplyr)

# original file containing data for this project could not be updated because of its large size

file_path = r"(D:\Coursera Data Science Course\Exploratory Data Analysis\Course Project 1\data\household_power_consumption.txt)"

df = read.csv.sql(file_path,
                  "SELECT Date,Time, Sub_metering_1, Sub_metering_2, Sub_metering_3 
                  FROM file 
                  WHERE Date = '1/2/2007' or Date = '2/2/2007'",
                  sep=";")

df = mutate(df,DateTime = dmy_hms(paste(Date,Time)),
            .keep="unused",
            .before=Sub_metering_1)

# Opening png device
png("plot3.png")

with(df,plot(DateTime,Sub_metering_1,"l",xaxt="n",
             xlim=c(as_datetime("2007-02-01 00:00:00"),as_datetime("2007-02-03 00:00:00")),
             ylab="Energy sub metering",xlab=NA))

with(df,lines(DateTime,Sub_metering_2,col="red"))
with(df,lines(DateTime,Sub_metering_3,col="blue"))

axis(1,c(as_datetime("2007-02-01 00:00:00"),as_datetime("2007-02-02 00:00:00"),as_datetime("2007-02-03 00:00:00")),
     format(c(as_datetime("2007-02-01 00:00:00"),as_datetime("2007-02-02 00:00:00"),as_datetime("2007-02-03 00:00:00")),"%a"))

legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col = c("black","red","blue"),lty=1)

# colosing png device
dev.off()
