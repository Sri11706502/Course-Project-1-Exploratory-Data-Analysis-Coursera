# This file contains the code for the construction of plot4
# The plot has been constructed in png file and saved as png4.png

# importing necessary libraries
library(lubridate)

#Assigning the value of file_name
file_name <- "household_power_consumption.txt"

# Extracting the column names from the file and converting them to vector
column_names <- read.table(file_name,nrows = 1,sep = ";")
column_names <- as.vector(unlist(column_names))

# Extracting the data from file
# Data required is for date 1/2/2007 to 2/2/2007
# Data for this date is present in lines 66638-69517
data <- read.table(file_name,
                   sep=";",
                   skip=66637,
                   nrows = (69517-66637),
                   col.names = column_names)

# Creating a column of date class from Date
Date <- dmy(data$Date)

# Creating a column of datetime class
Date_Time <- strptime(paste(Date,data$Time,sep=" "),
                      format = "%Y-%m-%d %H:%M:%S")

# Adding this column to get final data
data <- cbind(Date,data[-1],Date_Time)

# creating a png file
png(filename = "png4.png",width = 480,height = 480,units = "px")

#plotting the graph
with(data,{
  
  # creating a margin and matrix for plotting multiple plots
  par(mfcol=c(2,2),mar=c(4,5,1,1))
  
  # creating plot 1
  plot(Date_Time,
       Global_active_power,
       type = "l",
       xlab="",
       ylab = "Global Active Power")
  
  #creating plot 2
  plot(Date_Time,Sub_metering_1,type = "l",xlab = "",ylab = "Energy sub metering")
  lines(Date_Time,Sub_metering_2,col="red")
  lines(Date_Time,Sub_metering_3,col="blue")
  legend("topright",lty = c(1,1,1) ,legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col = c("black","red","blue"))
  
  # creating plot 3
  plot(Date_Time,Voltage,type = "l",xlab="datetime",ylab="Voltage")
  
  # creating plot 4
  plot(data$Date_Time,data$Global_reactive_power,type="l",xlab = "datetime",ylab = "Global_reactive_power")
  })

#closing the current device
dev.off()
