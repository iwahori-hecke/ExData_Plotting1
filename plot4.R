filename <- "data/household_power_consumption.txt"
#filename <- "data/test.txt"
# Make some helper classes to with "As" ability for use in data read-in
setClass("mydate")
#setClass('mytime')
setAs("character", "mydate", function(from) as.Date(from, format="%d/%m/%Y") )
#setAs("character", "mytime", function(from) strptime(from, format="%H:%M:%S") )

# Read in data
x <- read.csv2(filename,dec=".",
               colClasses=c("mydate","character","numeric", "numeric",
                            "numeric","numeric","numeric", "numeric",
                            "numeric"), na.strings="?") 
# Restrict ourselves to the relevant dates.
mindate = as.Date("2007-02-01", format="%Y-%m-%d")
maxdate = as.Date("2007-02-02", format="%Y-%m-%d")
x <- x[(x$Date >= mindate) & (x$Date <= maxdate),]

# Turn date and time columns into one datetime column
x$datetime <- strptime(paste(x$Date,x$Time),format="%Y-%m-%d %H:%M:%S")

# Make histogram
hist(x$Global_active_power, col='red', xlab="Global Active Power (kilowatts)",
     main="Global Active Power")
