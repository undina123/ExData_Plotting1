tab5rows <- read.table("household_power_consumption.txt", header = TRUE, sep=";", nrows = 5,stringsAsFactors=F)
classes <- sapply(tab5rows, class)
# We subset data on reading
library(sqldf)
data <- read.csv.sql(file="household_power_consumption.txt", sep=";",colClasses = classes,    sql = "select * from file where Date in ('1/2/2007','2/2/2007' ) ")
#changing Date type to Date
data$Date<-as.Date(data$Date,"%d/%m/%Y")
# pasting date and time, making correct format
data$datetime <- paste(data$Date, data$Time)
data$datetime <- strptime(data$datetime, "%Y-%m-%d %H:%M:%S")
# Making plot
png(filename="plot3.png", width=480, height=480,bg="transparent")
par(bg="transparent") 
with(data,plot(datetime,Sub_metering_1, type="n",xlab="",ylab="Energy sub metering"))
with(data,points(datetime,Sub_metering_1, type="l"))
with(data,points(datetime,Sub_metering_2, type="l",col="red"))
with(data,points(datetime,Sub_metering_3, type="l",col="blue"))
legend("topright", lty=c(1,1,1), col = c("black", "red","blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3" ))
dev.off()