##For data processing
if(!file.exists("exdata-data-household_power_consumption.zip")) {
    temp <- tempfile()
    download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
    alldata <- unzip(temp)
    unlink(temp)
}

##read the data and extract the data we need from 01/02/2007 to 02/02/2007
alldata<-read.table(alldata,sep=";",header=T)
data1<-alldata[which(alldata[,"Date"]=="1/2/2007"),]
data2<-alldata[which(alldata[,"Date"]=="2/2/2007"),]
usedata<-rbind(data1,data2)

##change date format
usedata$Date<-as.Date(usedata$Date, format="%d/%m/%Y")
usedata$datetime<-paste(usedata$Date, usedata$Time)
usedata$datetime <- as.POSIXct(usedata$datetime)

##use the variables
Global_active_power<-as.numeric(usedata$Global_active_power)
Voltage<-as.numeric(usedata$Voltage)
Global_reactive_power<-as.numeric(usedata$Global_reactive_power)

##set the format
png("plot4.png" , width = 480, height = 480)
par(mfrow=c(2,2))

##for plot1
##plot
plot(usedata$datetime,Global_active_power,ylab="Global Active Power",xlab="",type="l",yaxt="n",xaxt="n")

##set the axis
axis(1, at=c(as.numeric(min(usedata$datetime)), as.numeric(min(usedata$datetime))+86400, as.numeric(min(usedata$datetime))+2*86400), labels=c("Thu", "Fri", "Sat"))
axis(2,at=c(0,1000,2000,3000),labels=c(0,2,4,6))

##for plot2
##plot
plot(usedata$datetime,Voltage,ylab="Voltage",xlab="",type="l",yaxt="n",xaxt="n")

##set the axis
axis(1, at=c(as.numeric(min(usedata$datetime)), as.numeric(min(usedata$datetime))+86400, as.numeric(min(usedata$datetime))+2*86400), labels=c("Thu", "Fri", "Sat"))
axis(2,at=c(234,238,242,246),labels=c(234,238,242,246))

##for plot3
##plot
plot(usedata$datetime,usedata$Sub_metering_1,ylab="Energy sub metering",xlab="",type="n",yaxt="n",xaxt="n")
points(usedata$datetime,usedata$Sub_metering_1,col="black",type="l")
points(usedata$datetime,usedata$Sub_metering_2,col="red",type="l")
points(usedata$datetime,usedata$Sub_metering_3,col="blue",type="l")

##set the legends
legend("topright",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1)

##set the axis
axis(1, at=c(as.numeric(min(usedata$datetime)), as.numeric(min(usedata$datetime))+86400, as.numeric(min(usedata$datetime))+2*86400), labels=c("Thu","Fri","Sat"))
axis(2,at=c(0,1000,2000,3000),labels=c(0,2,4,6))
axis(2,at=c(0,10,20,30),labels=c(0,10,20,30))

##for plot4
##plot
plot(usedata$datetime,Global_reactive_power,ylab="Global_reactive_power",xlab="",type="l",yaxt="n",xaxt="n")

##set the axis
axis(1, at=c(as.numeric(min(usedata$datetime)), as.numeric(min(usedata$datetime))+86400, as.numeric(min(usedata$datetime))+2*86400), labels=c("Thu", "Fri", "Sat"))
axis(2,at=c(0,50,100,150,200,250),labels=c(0.0,0.1,0.2,0.3,0.4,0.5))

##save
dev.off()
