library("data.table")
library("lubridate")

# Unzip the file if necessary
fileName = "household_power_consumption.txt"
if( !file.exists(fileName) ) unzip("exdata_data_household_power_consumption.zip")

# Variables Names
colNames <- c("Date","Time","GlobalActivePower","GlobalReactivePower","Voltage",
              "GlobalIntensity","SubMetering1","SubMetering2","SubMetering3")

# Read only data from the dates 1/2/2007 and 2/2/2007 (dd/mm/yy)
data <- fread(fileName, sep = ";", col.names = colNames, na.strings = "?", skip = "1/2/2007", nrows = 2*24*60-1)

# Date/Time classes
datetime <- dmy_hms(paste(data$Date,data$Time))

# Plot 2
png("plot2.png", width = 480, height = 480)
plot(datetime, data$GlobalActivePower, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()