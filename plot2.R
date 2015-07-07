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
par(bg="transparent") 
with(data,plot(datetime,Global_active_power, type="l",xlab="",ylab="Global Active Power (kilowatts)"))
## Copy my plot to a PNG file
dev.copy(png, file = "plot2.png")
dev.off()