## download, unzip and read the data
URL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(URL, destfile="data.zip")
unzip("data.zip")
data<-read.table("household_power_consumption.txt", header=TRUE, sep = ";")
## create DateTime column and convert it to the proper format
data$DateTime<-paste(data$Date,data$Time, sep=" ")
data$DateTime<-strptime(data$DateTime, format="%d/%m/%Y %H:%M:%S")
## convert Date column into Date format and subset the data set to contain data only for two days (2007-02-01 and 2007-02-02)
data$Date<-as.Date(data$Date, format="%d/%m/%Y")
data<-data[(data$Date=="2007-02-01" | data$Date=="2007-02-02"),]
## converting the data into correct format
data$Global_active_power<-as.numeric(as.character(data$Global_active_power))
## open PNG device
png(filename="plot2.png", width = 480, height = 480, bg = "white")
## create a plot
plot(data$DateTime, data$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)", main="")
## close PNG device
dev.off()