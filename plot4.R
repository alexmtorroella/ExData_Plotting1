PLOT 4

## Read csv file and change Date column to date format
power <- read.csv("household_power_consumption.txt", sep=";")
power$Date <- as.Date(power$Date, "%d/%m/%Y")

## Subset the dataframe to only use relevant data
sub <- subset(power, power$Date == "2007-02-01" | power$Date == "2007-02-02")

## Change time to full date/time format for x-axis
sub$Time <- strptime(paste(sub$Date, as.character(sub$Time)), format = "%Y-%m-%d %H : %M : %S")

## Change all relevant variables to numeric in order to graph
sub$Global_active_power <- as.numeric(as.character(sub$Global_active_power))
sub$Global_reactive_power <- as.numeric(as.character(sub$Global_reactive_power))
sub$Voltage <- as.numeric(as.character(sub$Voltage))
sub$Sub_metering_1 <- as.numeric(as.character(sub$Sub_metering_1))
sub$Sub_metering_2 <- as.numeric(as.character(sub$Sub_metering_2))
sub$Sub_metering_3 <- as.numeric(as.character(sub$Sub_metering_3))

## Graph into a .png file of 480 x 480px size
png(filename = "plot4.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "transparent")

## Create a 2 x 2 space to fit the plots and set margins
par(mfcol = c(2,2), mar = c(4, 5, 4, 1), oma = c(0, 0, 0, 0))

## Same as plot 2, minus '(kilowatts)' in y-axis label
plot(sub$Time, sub$Global_active_power, type = 'l', main="", ylab = "Global Active Power", xlab = "", ylim = c(0,8), yaxt = 'n' )
axis(side = 2, at = seq(0, 6, 2), labels = seq(0,6,2))

## Same as plot 3, minus the border on the legend (bty = 'n')
plot(sub$Time, sub$Sub_metering_1, type = 'n', main="", ylab = "Energy sub metering", xlab = "", ylim = c(0,40), yaxt = 'n')
axis(side = 2, at = seq(0, 30, 10), labels = seq(0,30,10))
lines(sub$Time, sub$Sub_metering_1)
lines(sub$Time, sub$Sub_metering_2, col = "red")
lines(sub$Time, sub$Sub_metering_3, col = "blue")
legend("topright", lty = 1, bty = "n", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Plot line, set y-axis limits, but invisible as label will be different
plot(sub$Time, sub$Voltage, type = 'l', main="", ylab = "Voltage", xlab = "datetime", ylim = c(233,247), yaxt = 'n')
## Set label to range 234-246 in intervals of 4
axis(side = 2, at = seq(234, 246, 4), labels = seq(234, 246, 4))


## Plot line, set y-axis limits, but invisible to set proper intervals
plot(sub$Time, sub$Global_reactive_power, type = 'l', main="", ylab = "Global_reactive_power", xlab = "datetime", ylim = c(0.0, 0.5), yaxt = 'n')
## Set label to range from 0.0-0.5 in 0.1 intervals
axis(side = 2, at = seq(0.0, 0.5, .1), labels = seq(0.0, 0.5, .1))
dev.off()