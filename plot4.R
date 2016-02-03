# data.table includes the fread function
library(data.table)
filename <- "household_power_consumption.txt"

# fread reads more efficiently than read.table(). Missing values are encoded as "?"
data <- fread("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = c("?"), data.table = FALSE)

# Convert data$Date to date
data$Date <- as.Date(data$Date, "%d/%m/%Y")

# Select observations between 2007-02-01 and 2007-02-02
data <- data[data$Date >= "2007-02-01" & data$Date <= "2007-02-02", ]

# Create a new column to store the date and time as a unique value
data$Datetime <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")

# Construct the plot and generate a PNG file
png(filename = "plot4.png", width = 480, height = 480)

par(mfcol = c(2, 2))

# Top-left graph
with(data, plot(Datetime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power"))

# Bottom-left graph
with(data, {
  plot(Datetime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
  lines(Datetime, Sub_metering_2, col = "red")
  lines(Datetime, Sub_metering_3, col = "blue")
  legend("topright", lty = 1, bty = "n", cex = 0.9, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})

# Top-right graph
with(data, plot(Datetime, Voltage, type = "l", xlab = "datetime", ylab = "Voltage"))

# Bottom-right graph
with(data, plot(Datetime, Global_reactive_power, type = "l", xlab = "datetime"))

dev.off()
