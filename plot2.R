#CH4 W1 Project

# Objective: examine how household energy usage varies over a 2-day period in February, 2007
# Using dataset from UC Irvine Machine Learning Repository, "Individual household electric power consumption Data Set

# load packages
library(data.table)

# initial load and directory structure
# remember to set the working directory if needed

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("./data")){dir.create("./data")}           #create a data subdirectory
if(!file.exists('./data/data.zip')){                       # put the zip file in the data subdirectory
    download.file(fileUrl,destfile = './data/data.zip')
}

unzip('./data/data.zip') # Unzip file "household_power_consumption.txt"

# Extract information from dataset

## fast extraction of the rows, option to return as data frame for compatibility with strptime 
dataSet <- fread("grep [12]/2/2007 data/household_power_consumption.txt", na.strings="?", data.table = FALSE)
# unique(dataSet$V1)  # shows that format is in D/M/Y - note 22/2/2007 

# D/M/Y select day 1 or 2
dataSet <- dataSet[(dataSet$V1=="1/2/2007"|dataSet$V1=="2/2/2007"),]

## add column names to dataSet
colNames <- readLines("data/household_power_consumption.txt", n=1)   # fast to read only one row with readLines
names(dataSet) <-  strsplit(colNames, "\\;")[[1]]                    # extract character vector from list

## convert date and time 
dataSet$Time <- strptime(paste(dataSet$Date,dataSet$Time), "%d/%m/%Y %H:%M:%S")  # adds correct date to time
dataSet$Date <- as.Date(dataSet$Date,"%d/%m/%Y")

# plot 2
plot(dataSet$Time, dataSet$Global_active_power, type='l',ylab="Global Active Power (kilowatts)", xlab="")
# save to .png
dev.copy(png, file = "plot2.png")
dev.off()