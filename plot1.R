#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.


if(!file.exists("summarySCC_PM25.rds") & !file.exists("Source_Classification_Code.rds")) {
     temp <- tempfile()
     download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",temp)
     unzip(temp)
     unlink(temp)
}

NEI <- readRDS("summarySCC_PM25.rds") 
SCC <- readRDS("Source_Classification_Code.rds")


aggregate_emission <- aggregate(Emissions ~ year,NEI, sum)

png("plot1.png", width =480, height = 480)
plot(aggregate_emission$year,(aggregate_emission$Emissions)/10^6, type ='b', xlab = "Year", ylab = "Total PM2.5 Emissions (10^6 Tons)", main="Total PM2.5 Emissions From All US Sources", col ="pink", lwd =2,xaxt = "n")
axis(side=1, at=c("1999", "2002", "2005", "2008"))
dev.off()
