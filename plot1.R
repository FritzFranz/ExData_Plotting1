# plot1.R

filename = "./data/household_power_consumption.txt"
             
# read data, use some optimizations 
d0 = read.table(filename,quote="",
                comment.char="",
                colClasses=c("character","character",rep("numeric",7)),  
                na.strings="?",        # recognize as NA 
                nrows=2100000,sep=";", header=T)
dim(d0)

# get and convert date fields for extractin 
date0 = as.Date(d0$Date,"%d/%m/%Y")    ## convert to yyyy-mm-dd
date0c = as.character(date0)            ## convert to character

# extract relevant data - 2880 records (1 per minute)
ds = d0[date0c >= "2007-02-01" & date0c <= "2007-02-02",]

# create png plots 480x480 
png(filename="plot1.png",
    width=480,height=480)
hist(ds$Global_active_power,
     col="red",
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency count",
     main="Global Active Power")
dev.off()
