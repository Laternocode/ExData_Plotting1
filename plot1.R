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

## Make plot1 
hist(UCI_data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.copy(png, "plot1.png", width=800, height=800)
dev.off()