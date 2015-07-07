tab5rows <- read.table("household_power_consumption.txt", header = TRUE, sep=";", nrows = 5,stringsAsFactors=F)
classes <- sapply(tab5rows, class)
# We subset data on reading
library(sqldf)
data <- read.csv.sql(file="household_power_consumption.txt", sep=";",colClasses = classes,    sql = "select * from file where Date in ('1/2/2007','2/2/2007' ) ")
# Making plot
par(bg="transparent") 
hist(data$Global_active_power,col="red",xlab="Global Active Power (kilowatts)", main="Global Active Power")
## Copy my plot to a PNG file
dev.copy(png, file = "plot1.png")
dev.off()