# This file contains the code for the construction of plot1
# The plot has been constructed in png file and saved as png1.png

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

# opening a png file
png(filename = "png1.png",width = 480,height = 480,units = "px")

# plotting the graph
hist(data$Global_active_power,
     freq=TRUE,
     col="red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

dev.off()