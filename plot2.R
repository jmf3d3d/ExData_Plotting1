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
png(file = "plot2.png",  bg = "transparent")

#second plot
plot(dataset$datetime,dataset$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")


#close png device
dev.off()

