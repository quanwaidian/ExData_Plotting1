#For data processing
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

##use the variable of Global_active_power
Global_active_power<-as.numeric(usedata$Global_active_power)

##set the format
png("plot1.png" , width = 480, height = 480)

##plot
hist(Global_active_power,col="red",xlab="Global Active Power (Kilowatts)",ylab="Frequency",main="Global Active Power",yaxt="n",xaxt="n")

##set the axis
axis(1,at=c(0,1000,2000,3000),labels=c(0,2,4,6))
axis(2,seq(0,1200, by = 200))

##save
dev.off()
