## Read the file into a data frame 
URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(URL, temp)
data <- read.table(unz(temp, "household_power_consumption.txt"), header = TRUE, sep = ";")
unlink(temp)

## Isolate entries ranging from 2007-02-01 to 2007-02-02
## By default, class(data$Date) gives a factor variable, need to reformat into date format
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
graphdata <- subset(data, data$Date == as.Date("2007-02-01") | data$Date == as.Date("2007-02-02"))
## Similarly, the sub-metering quantities need to be cast as numeric types. These fields have to be 
## cast as characters first, and then as numeric, in order to retain the value from factor variable. 
graphdata$Sub_metering_1 <- as.numeric(as.character(graphdata$Sub_metering_1))
graphdata$Sub_metering_2 <- as.numeric(as.character(graphdata$Sub_metering_2))
graphdata$Sub_metering_3 <- as.numeric(as.character(graphdata$Sub_metering_3))

## Set up png file
png(filename = "plot3.png")

## Plot the 3 graphs into PNG file
plot(graphdata$Sub_metering_1,type="l", col = "black",
     xlab="", 
     ylab="Energy sub metering",
     xaxt = "n")
lines(graphdata$Sub_metering_2, col = "red")
lines(graphdata$Sub_metering_3, col = "blue")
axis(1, at = c(1, 1440, 2880), labels = c("Thu", "Fri", "Sat"))
legend("topright", 
       lty = 1,
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Close the graphics device to be able to view contents
dev.off()