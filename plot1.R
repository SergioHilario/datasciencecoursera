####### DOWNLOAD 
temp <- tempfile()
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, dest=temp, mode="wb") 
unzip (temp, exdir = "./")
unlink(temp)


####### READ
######## option 1
library(data.table)
vars<-names(fread("household_power_consumption.txt",nrows=0,data.table=F))
consumption<-fread("egrep '^1/2/2007|^2/2/2007' household_power_consumption.txt",
                   col.names = vars,na.strings="?",data.table=FALSE)

######## option 2
library(sqldf)
consumption<-read.csv2.sql("household_power_consumption.txt", 
              sql = "select * from file where Date in ('1/2/2007','2/2/2007')")

####### PLOT AND WRITE TO PNG
png(file = "plot1.png",width=480,heigh=480)
hist(consumption$Global_active_power,col="red",main="Global Active Power",
     xlab="Global Active Power (kilowatts)",ylab="Frequency")
dev.off()
