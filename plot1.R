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
## Similarly, the global active power needs to be cast as a numeric type. The field has to be 
## cast as a character first, and then as numeric, in order to retain the value from factor variable. 
graphdata$Global_active_power <- as.numeric(as.character(graphdata$Global_active_power))

## Set up png file
png(filename = "plot1.png")

## Plot the graph into png file
hist(graphdata$Global_active_power, 
     col = "red", 
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency")

## Close the graphics device to be able to view contents
dev.off()
