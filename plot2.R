PLOT 2

## Read csv file and change Date column to date format
power <- read.csv("household_power_consumption.txt", sep=";")
power$Date <- as.Date(power$Date, "%d/%m/%Y")

## Subset the dataframe to only use relevant data
sub <- subset(power, power$Date == "2007-02-01" | power$Date == "2007-02-02")

## Change time to full date/time format for x-axis
sub$Time <- strptime(paste(sub$Date, as.character(sub$Time)), format = "%Y-%m-%d %H : %M : %S")

## Change Global_active_power to numeric in order to graph
sub$Global_active_power <- as.numeric(as.character(sub$Global_active_power))

## Graph into a .png file of 480 x 480px size
png(filename = "plot2.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "transparent")

## Plot a line graph (type = 'l'), and make the limit of the y-axis 8 
## to fit all data, but invisible as the axis label should only go up to six
plot(sub$Time, sub$Global_active_power, type = 'l', main="", ylab = "Global Active Power (kilowatts)", xlab = "", ylim = c(0,8), yaxt = 'n' )

## Insert y-axis with the proper labels that only go up to 6 in intervals of 2
axis(side = 2, at = seq(0, 6, 2), labels = seq(0,6,2))
dev.off()

