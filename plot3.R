require(RCurl)
bin <- getBinaryURL("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                    ssl.verifypeer=FALSE)
con <- file("household_power_consumption.zip", open = "wb")
writeBin(bin, con)
close(con)

dts<-read.table(unz("household_power_consumption.zip","household_power_consumption.txt"),sep=";",header=T,na.strings="?",colClasses="character")
dts$datetime<-strptime(paste(dts$Date,dts$Time),"%d/%m/%Y %H:%M:%S")
a<-strptime("01/02/2007 00:00:00","%d/%m/%Y %H:%M:%S")
b<-strptime("03/02/2007 00:00:00","%d/%m/%Y %H:%M:%S")
dts1<-dts[which((dts$datetime>=a) & (dts$datetime<b)),]

##############################
png("plot3.png")
plot(dts1$datetime,as.numeric(dts1$Sub_metering_1),type="l",ylab="Energy sub metering",xlab="",main="")
lines(dts1$datetime,as.numeric(dts1$Sub_metering_2),col="red")
lines(dts1$datetime,as.numeric(dts1$Sub_metering_3),col="blue")
legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()
