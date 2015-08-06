## download, unzip and read the data
URL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(URL, destfile="data.zip")
unzip("data.zip")
data<-read.table("household_power_consumption.txt", header=TRUE, sep = ";")
## create DateTime column and convert it to the proper format
data$DateTime<-paste(data$Date,data$Time, sep=" ")
data$DateTime<-strptime(data$DateTime, format="%d/%m/%Y %H:%M:%S")
## convert Data column into Date format and subset the data set to contain data only for two days (2007-02-01 and 2007-02-02)
data$Date<-as.Date(data$Date, format="%d/%m/%Y")
data<-data[(data$Date=="2007-02-01" | data$Date=="2007-02-02"),]
##converting the data into correct format
data$Global_active_power<-as.numeric(as.character(data$Global_active_power))
data$Voltage<-as.numeric(as.character(data$Voltage))
data$Sub_metering_1<-as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2<-as.numeric(as.character(data$Sub_metering_2))
data$Sub_metering_3<-as.numeric(as.character(data$Sub_metering_3))
data$Global_reactive_power<-as.numeric(as.character(data$Global_reactive_power))
## open PNG device
png(filename="plot4.png", width = 480, height = 480, bg = "white")
par(mfrow=c(2,2))
## plot the graphs
with(data,{
        plot(DateTime, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)", main="")
        plot(DateTime, Voltage, type="l", xlab="datetime", ylab="Voltage", main="")
        plot(DateTime, Sub_metering_1, type="l", ylab="Energy sub metering", xlab="", main="")
          lines(DateTime, Sub_metering_2, col="red")
          lines(DateTime, Sub_metering_3, col="blue")
          legend("topright", lty=1, bty = "n", col = c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3",box.lwd=0))
        plot(DateTime, Global_reactive_power, type="l", xlab="datetime", main="")
        
     })
## close PNG device
dev.off()