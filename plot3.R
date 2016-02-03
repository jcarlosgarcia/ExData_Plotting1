# data.table includes the fread function
library(data.table)
filename <- "household_power_consumption.txt"

# fread reads more efficiently than read.table(). Missing values are encoded as "?"
data <- fread("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = c("?"), data.table = FALSE)

# Convert data$Date to date
data$Date <- as.Date(data$Date, "%d/%m/%Y")

# Select observations between 2007-02-01 and 2007-02-02
energyData <- data[data$Date >= "2007-02-01" & data$Date <= "2007-02-02", ]

# Create a new column to store the date and time as a unique value
energyData$Datetime <- strptime(paste(energyData$Date, energyData$Time), "%Y-%m-%d %H:%M:%S")

# Construct the plot and generate a PNG file
png(filename = "plot3.png", width = 480, height = 480)
with(energyData, {
  plot(Datetime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
  lines(Datetime, Sub_metering_2, col = "red")
  lines(Datetime, Sub_metering_3, col = "blue")
})
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
