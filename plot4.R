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

desiredPowerData$Voltage <- gsub("\\?", NA, desiredPowerData$Voltage)

desiredPowerData$Sub_metering_1 <- gsub("\\?", NA, desiredPowerData$Sub_metering_1)
desiredPowerData$Sub_metering_2 <- gsub("\\?", NA, desiredPowerData$Sub_metering_2)
desiredPowerData$Sub_metering_3 <- gsub("\\?", NA, desiredPowerData$Sub_metering_3)

desiredPowerData$Global_reactive_power <- gsub("\\?", NA, desiredPowerData$Global_reactive_power)


png("plot4.png", width=480, height=480, units="px")
par(mfrow=c(2,2))
plot(desiredPowerData$DateTime, desiredPowerData$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power") 

plot(desiredPowerData$DateTime, desiredPowerData$Voltage, type = "l", xlab = "datetime", ylab = "Voltage" ) 

plot(desiredPowerData$DateTime, desiredPowerData$Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering")
lines(desiredPowerData$DateTime, desiredPowerData$Sub_metering_2, type = "l", col = "red")
lines(desiredPowerData$DateTime, desiredPowerData$Sub_metering_3, type = "l", col = "blue")
legend("topright",legend= c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lwd =1, bty ="n")

plot(desiredPowerData$DateTime, desiredPowerData$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power" ) 

dev.off()




