powerData <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)
powerData$DateTime <- with(powerData, paste0(Date,",", Time))
lct <- Sys.getlocale("LC_TIME"); Sys.setlocale("LC_TIME", "C")
powerData$DateTime <- strptime(powerData$DateTime, format = "%d/%m/%Y,%H:%M:%S")
powerData$Date <- as.Date(powerData$Date,  "%d/%m/%Y" )

date1 <- as.Date("2007-02-01", "%Y-%m-%d")
date2 <- as.Date("2007-02-02", "%Y-%m-%d")

desiredPowerData <- subset(powerData, powerData$Date == date1 | powerData$Date == date2)


desiredPowerData$Global_active_power <- gsub("\\?", NA, desiredPowerData$Global_active_power)
desiredPowerData$Global_active_power <- as.numeric(desiredPowerData$Global_active_power)

png("plot1.png", width=480, height=480, units="px")
hist(desiredPowerData$Global_active_power, col = "red", main ="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()
