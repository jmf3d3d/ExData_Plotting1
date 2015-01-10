#setwd("D:/DATA SCIENCE/EXPLORE DATA")


# read the household power consumption file which has semicolons as separators and ? for non data entries

data <- read.csv("./data/household_power_consumption.txt", sep = ";", na.strings = "?")

# subset to get only dates

# create a variable called "datetime" that gives the date and time together in one variable. 
datetime <- strptime(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")

# convert date column to date class and add a column called datetime
# cbind these and assign to table "data1"
data1 <- cbind(as.Date(data$Date, format = "%d/%m/%Y"), datetime, as.numeric(data$Global_active_power), data[,4:9])

# sort out the column names that have been added or changed
colnames(data1)[1] <- "Date"
colnames(data1)[2] <- "datetime"
colnames(data1)[3] <- "Global_active_power"

# select rows only for the two dates 2007-02-01 and 02 and assign to file called "dataset"

filt<-data1$Date == "2007-02-01" | data1$Date == "2007-02-02"  
dataset <- data1[filt,]

##  now begin to make the plots

##  load the library datasets
library(datasets)


##  call png device
png(file = "plot4.png",  bg = "transparent")


#fourth plot - 4 plots in one

##call par and set mfrow to 2 rows of 2 columns each and set margins
par(mfrow = c(2,2), mar = c(6,5,4,3))     #, oma = c(0,0,2,0))

# top right graph
with(dataset, plot(datetime, Global_active_power, type = "l", ylab = "Global Active Power", xlab = ""))

# top left graph
with(dataset, plot(datetime, Voltage, type = "l"))

# bottom righ graph
with(dataset, {
        
        plot(datetime, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "",col = "black")
        lines(datetime, Sub_metering_2,  col="red3", lwd=.1)
        lines(datetime, Sub_metering_3,  col="blue", lwd=.1)
})
legend("topright",  lty=c(1,1,1), col = c("black", "red3", "blue"), cex = 0.75, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# bottom right graph
with(dataset, plot(datetime, Global_reactive_power, lwd=.1, type = "l", ylab = "Global Active Power"))


#close png device
dev.off()
