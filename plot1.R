# loading libraries
library(dplyr)
# loading and unzipping data
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
setwd(file.path("D:/data"))
local <- file.path("exdata_data_household_power_consumption.zip")
download.file(url,local)
unzip(local)
# reading data and transforming the date fields
hpc <-read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", stringsAsFactors = FALSE)
hpc <- filter(hpc, hpc$Date %in% c("1/2/2007", "2/2/2007"))
hpc$DateTime <- strptime(paste(hpc$Date, hpc$Time), format="%d/%m/%Y %H:%M:%S")
# writing the plot to a .png file
png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(hpc$Global_active_power, main="Global Active Power", col="red", xlab="Global Active Power (kilowatts)")
dev.off()