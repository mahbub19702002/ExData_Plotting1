library(dplyr)

power_df <- read.table("./exdata_data_household_power_consumption/household_power_consumption.txt", sep = ";", header = TRUE)

# Subset the date for dates between 2007-02-01 and 2007-02-02
power_df$DateTime <- paste(power_df$Date, power_df$Time)
power_df$DateTime <- as.Date(power_df$DateTime, format = "%d/%m/%Y %H:%M:%S")
df <- filter(power_df, DateTime >= as.Date("2007-02-01 00:00:00"), DateTime <= as.Date("2007-02-02 00:00:00"))

# Convert factor columns to numeric columns
df$Date <- as.Date(as.character(df$Date), format = "%d/%m/%y")
df$Time <- strptime(as.character(df$Time), format = "%H:%M:%S" , tz = "")
df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
df$Global_reactive_power <- as.numeric(as.character(df$Global_reactive_power))
df$Voltage <- as.numeric(as.character(df$Voltage))
df$Global_intensity <- as.numeric(as.character(df$Global_intensity))
df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
df$Sub_metering_3 <- as.numeric(as.character(df$Sub_metering_3))

png("plot4.png")
par(mfrow = c(2, 2))
par(mar = c(4,4,1,1))
plot(df$Global_active_power, xlab = "", ylab = "Global Active Power(kilowatts)", type = "l")

plot(df$Voltage, xlab = "datetime", ylab = "Voltage", type = "l")

plot(df$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l", col="black", ylim = c(0, 40))
lines(df$Sub_metering_2, col = "red")
lines(df$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty = c(1,1,1))

plot(df$Global_reactive_power,  xlab = "datetime", ylab = "Global_reactive_power", type = "l")
dev.off()
