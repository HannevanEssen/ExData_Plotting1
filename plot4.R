# loading libraries
library(dplyr)
# loading and unzipping data
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
setwd(file.path("D:/data"))
local <- file.path("exdata_data_household_power_consumption.zip")
download.file(url,local)
unzip(local)
# reading data and transforming the date fields
Sys.setlocale("LC_TIME", "us")
hpc <-read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", stringsAsFactors = FALSE)
hpc <- filter(hpc, hpc$Date %in% c("1/2/2007", "2/2/2007"))
hpc$DateTime <- strptime(paste(hpc$Date, hpc$Time), format="%d/%m/%Y %H:%M:%S")
# writing the plot to a .png file
png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow=c(2,2))
# plot 1
plot(hpc$DateTime,hpc$Global_active_power, type="l", ylab="Global Active Power", xlab="")
#plot 2
plot(hpc$DateTime, hpc$Voltage, type="l", ylab="Voltage", xlab="datetime")
#plot 3
with(hpc, plot(DateTime,Sub_metering_1, col="black", type="l", ylab="Energy sub metering", xlab=""))
with(hpc, points(DateTime,Sub_metering_2, col="red", type="l"))
with(hpc, points(DateTime,Sub_metering_3, col="blue", type="l"))
legend("topright",lty=c(1,1,1),bty="n", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#plot 4
plot(hpc$DateTime, hpc$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")
dev.off()