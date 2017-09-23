## download file

setwd("~/Desktop/Coursera/ExData_Plotting1")
downloadURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
downloadFile <- "./Data/household_power_consumption.zip"
sourceFile <- "./Data/household_power_consumption.txt"

if (!file.exists(sourceFile)) {
  download.file(downloadURL, downloadFile, method = "curl")
  unzip(downloadFile, overwrite = T, exdir = "./Data")
}

## load the raw data

rawData <- read.table(sourceFile, header=T, sep=";", na.strings="?")

## change the time variable

finalData <- rawData[rawData$Date %in% c("1/2/2007","2/2/2007"),]
newTime <-strptime(paste(finalData$Date, finalData$Time, sep=" "),"%d/%m/%Y %H:%M:%S")
finalData <- cbind(newTime, finalData)

## open the png device and generating Plot 3

png(filename = "plot3.png", width = 480,height=480,units = "px")

plot(finalData$newTime, finalData$Sub_metering_1, type="l", col= "black", xlab="", ylab="Energy sub metering")
lines(finalData$newTime, finalData$Sub_metering_2, col= "red")
lines(finalData$newTime, finalData$Sub_metering_3, col= "blue")

## add legends

legends <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
legend("topright", legend=legends, col= c("black", "red", "blue"), lty="solid")

## close device

dev.off()
