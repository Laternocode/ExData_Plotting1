## Set working directory
setwd("C:/Users/Gert-Jan/Dropbox/Coursera Data Science Specialisation/Course 4 Exploratory data analysis")

## create "data" directory if needed
if(!file.exists("data")){
  dir.create("data")
}

##download file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./data/UCI_household_power_consumption.zip",method="curl")

###Unzip UCI_household_power_consumption to /data directory
unzip(zipfile="./data/UCI_household_power_consumption.zip",exdir="./data")

##read data files
UCI_data <- read.table("./data/household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")

##change Date column class "factor" to "date"
UCI_data$Date <- as.Date(UCI_data$Date, "%d/%m/%Y")

## Filter data set from Feb. 1, 2007 to Feb. 2, 2007
UCI_data <- subset(UCI_data,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

##make a new column and combine Date and Time
library(lubridate)
UCI_data$DateTime <- paste(UCI_data$Date, UCI_data$Time, sep = " ")
UCI_data$DateTime <- ymd_hms(UCI_data$DateTime)

## Make plot4
par(mfrow = c(2,2), mar = c(4,4,2,1))

## Make plot 1 out of 4
with(UCI_data, plot(Global_active_power~DateTime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""))

## Make plot 2 out of 4
with(UCI_data, plot(Voltage~DateTime, type = "l", xlab = "datetime"))


## Make plot 3 out of 4
with(UCI_data, {
  plot(Sub_metering_1~DateTime, type = "l", ylab = "Energy sub metering", xlab="")
  lines(Sub_metering_2~DateTime, col="red")
  lines(Sub_metering_3~DateTime, col="blue")
})
legend("topright", lwd = c(1,1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
    bty= "n", cex = 1)

## Make plot 4 out of 4
with(UCI_data, plot(Global_reactive_power~DateTime, type = "l", xlab = "datetime"))
dev.copy(png, "plot4.png", width=800, height=800)
dev.off()