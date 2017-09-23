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

## open the png device and generating Plot 4

png(filename = "plot4.png", width = 480,height=480,units = "px")


par(mfrow=c(2,2))

plot(finalData$newTime, finalData$Global_active_power, type="l", col="green", xlab="", ylab="Global Active Power")

plot(finalData$newTime, finalData$Voltage, type="l", col="orange", xlab="datetime", ylab="Voltage")

plot(finalData$newTime, finalData$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")

lines(finalData$newTime, finalData$Sub_metering_2, type="l", col="red")

lines(finalData$newTime, finalData$Sub_metering_3, type="l", col="blue")

colors <- c("black","red","blue")
legends <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
legend("topright", bty="n", legend=legends, lty=1, col=colors)

plot(finalData$newTime, finalData$Global_reactive_power, type="l", col="blue", xlab="datetime", ylab="Global_reactive_power")

## close device

dev.off()

