PLOT 3

## Read csv file and change Date column to date format
power <- read.csv("household_power_consumption.txt", sep=";")
power$Date <- as.Date(power$Date, "%d/%m/%Y")

## Subset the dataframe to only use relevant data
sub <- subset(power, power$Date == "2007-02-01" | power$Date == "2007-02-02")

## Change time to full date/time format for x-axis
sub$Time <- strptime(paste(sub$Date, as.character(sub$Time)), format = "%Y-%m-%d %H : %M : %S")

## Change the Sub_metering columns to numeric in order to graph
sub$Sub_metering_1 <- as.numeric(as.character(sub$Sub_metering_1))
sub$Sub_metering_2 <- as.numeric(as.character(sub$Sub_metering_2))
sub$Sub_metering_3 <- as.numeric(as.character(sub$Sub_metering_3))

## Graph into a .png file of 480 x 480px size
## Make background transparent to match the figures in the original README file
png(filename = "plot3.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "transparent")

## Make empty plot, we'll draw the lines later. Make the limit of y-axis 40
## to fit all data, but invisible as the axis label should only go up to 30
plot(sub$Time, sub$Sub_metering_1, type = 'n', main="", ylab = "Energy sub metering", xlab = "", ylim = c(0,40), yaxt = 'n')

## Insert y-axis with the proper labels that only go up to 30 in intervals of 10
axis(side = 2, at = seq(0, 30, 10), labels = seq(0,30,10))

## Draw the lines
lines(sub$Time, sub$Sub_metering_1)
lines(sub$Time, sub$Sub_metering_2, col = "red")
lines(sub$Time, sub$Sub_metering_3, col = "blue")

## Make legend with the lines of corresponding colors
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()




