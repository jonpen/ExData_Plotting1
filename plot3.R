#
# Script: plot3.R
#
# This script plots the third graph in the first project
# of the Exploratory Data Analysis course.
#
# This consists of the following three tasks:
#
# 1. Load data from the current working directory
# 2. Generate plot
# 3. Write the plot to the plot3.png file in the current working directory
#

################# Dataload start ####################
#
# Loads data file to a variable data. After loading, a number of
# basic formatting tasks are performed on the data set. Finally the 
# relevant data rows for the specified timeframe are loaded into
# the variable dataTimeframe
#
filepath <- "household_power_consumption.txt"

# Load file
data <- read.table(filepath, sep=";", header=TRUE)

# Set column headings
names(data) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_interesting", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

# Convert date and time into POSIXlt datatype and store in the Date column
data$Date <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")

# Change missing values to NA
data$Global_active_power[data$Global_active_power == "?"] <- NA
data$Global_reactive_power[data$Global_reactive_power == "?"] <- NA
data$Voltage[data$Voltage == "?"] <- NA
data$Global_interesting[data$Global_interesting == "?"] <- NA
data$Sub_metering_1[data$Sub_metering_1 == "?"] <- NA
data$Sub_metering_2[data$Sub_metering_2 == "?"] <- NA
data$Sub_metering_3[data$Sub_metering_3 == "?"] <- NA

# Changing column data type
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
data$Global_reactive_power <- as.numeric(as.character(data$Global_reactive_power))
data$Voltage <- as.numeric(as.character(data$Voltage))
data$Global_interesting <- as.numeric(as.character(data$Global_interesting))
data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))
data$Sub_metering_3 <- as.numeric(as.character(data$Sub_metering_3))

# Retrieving the data for the specified timeframe
dataTimeframe <- subset(data, (Date >= strptime("2007-02-01 00:00:00","%Y-%m-%d %H:%M:%S")) & (Date < strptime("2007-02-03 00:00:00","%Y-%m-%d %H:%M:%S")))

################# Dataload finish ####################

################# Generate plot ####################

png(filename = "plot3.png", width = 480 ,height = 480)
with(dataTimeframe, { 
  plot(Date, Sub_metering_1, ylab="Energy sub metering", xlab="", type="n")
  lines(Date, Sub_metering_1)
  lines(Date, Sub_metering_2, col="red")
  lines(Date, Sub_metering_3, col="blue")
  legend("topright", lty=c(1,1,1), lwd=c(2,2,2), col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
})
dev.off()

