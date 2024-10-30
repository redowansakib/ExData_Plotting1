library(sqldf)

# original file containing data for this project could not be updated because of its large size

file_path = r"(D:\Coursera Data Science Course\Exploratory Data Analysis\Course Project 1\data\household_power_consumption.txt)"

df = read.csv.sql(file_path,
                  "SELECT * FROM file 
                  WHERE Date = '1/2/2007' or Date = '2/2/2007'",
                  sep=";")

# Opening png device
png("plot1.png")

hist(df$Global_active_power,
     xlab="Global Active Power (kilowatts)",
     col="red",
     main="Global Active Power")

# colosing png device
dev.off()
