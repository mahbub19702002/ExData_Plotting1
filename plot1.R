library(dplyr)

power_df <- read.table("./exdata_data_household_power_consumption/household_power_consumption.txt", sep = ";", header = TRUE)

# Subset the date for dates between 2007-02-01 and 2007-02-02
power_df$DateTime <- paste(power_df$Date, power_df$Time)
power_df$DateTime <- as.Date(power_df$DateTime, format = "%d/%m/%Y %H:%M:%S")
df <- filter(power_df, DateTime >= as.Date("2007-02-01 00:00:00"), DateTime <= as.Date("2007-02-02 00:00:00"))

# Convert factor columns to numeric columns
df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
df$Global_reactive_power <- as.numeric(as.character(df$Global_reactive_power))
df$Voltage <- as.numeric(as.character(df$Voltage))
df$Global_intensity <- as.numeric(as.character(df$Global_intensity))
df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
df$Sub_metering_3 <- as.numeric(as.character(df$Sub_metering_3))

# Draw a histogram of Global Active Power
png("plot1.png")
hist(df$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
rug(df$Global_active_power)
dev.off()
