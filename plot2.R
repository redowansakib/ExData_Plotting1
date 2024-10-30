library(sqldf)
library(lubridate)
library(dplyr)

# original file containing data for this project could not be updated because of its large size

file_path = r"(D:\Coursera Data Science Course\Exploratory Data Analysis\Course Project 1\data\household_power_consumption.txt)"

df = read.csv.sql(file_path,
                  "SELECT Date, Time, Global_active_power 
                   FROM file 
                   WHERE Date = '1/2/2007' or Date = '2/2/2007'",
                  sep=";")

df2 = mutate(df,DateTime = dmy_hms(paste(Date,Time)),.before="Date",.keep="unused")

# Opening png device
png("plot2.png")

with(df,plot(DateTime,Global_active_power,"l",xaxt="n",
             xlim=c(as_datetime("2007-02-01 00:00:00"),as_datetime("2007-02-03 00:00:00")),
             ylab="Global Active Power (kilowatts)",xlab=NA))

axis(1,c(as_datetime("2007-02-01 00:00:00"),as_datetime("2007-02-02 00:00:00"),as_datetime("2007-02-03 00:00:00")),
     format(c(as_datetime("2007-02-01 00:00:00"),as_datetime("2007-02-02 00:00:00"),as_datetime("2007-02-03 00:00:00")),"%a"))

# colosing png device
dev.off()
