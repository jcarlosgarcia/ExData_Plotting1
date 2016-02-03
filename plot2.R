# data.table includes the fread function
library(data.table)
filename <- "household_power_consumption.txt"

# fread reads more efficiently than read.table(). Missing values are encoded as "?"
data <- fread("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = c("?"), data.table = FALSE)

# Convert data$Date to date
data$Date <- as.Date(data$Date, "%d/%m/%Y")

# Select observations between 2007-02-01 and 2007-02-02
globalActivePowerData <- data[data$Date >= "2007-02-01" & data$Date <= "2007-02-02", ]

# Create a new column to store the date and time as a unique value
globalActivePowerData$Datetime <- strptime(paste(globalActivePowerData$Date, globalActivePowerData$Time), "%Y-%m-%d %H:%M:%S")

# Construct the plot and generate a PNG file
png(filename = "plot2.png", width = 480, height = 480)
with(globalActivePowerData, plot(Datetime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()
