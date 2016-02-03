# data.table includes the fread function
library(data.table)
filename <- "household_power_consumption.txt"

# fread reads more efficiently than read.table(). Missing values are encoded as "?"
data <- fread("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = c("?"))

# Convert data$Date to date
data$Date <- as.Date(strptime(data$Date, "%d/%m/%Y"))

# Select observations between 2007-02-01 and 2007-02-02
powerConsumptionData <- data[data$Date >= "2007-02-01" & data$Date <= "2007-02-02"]

# Construct the plot and generate a PNG file
png(filename = "plot1.png", width = 480, height = 480)
hist(powerConsumptionData$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()
