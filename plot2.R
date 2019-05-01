#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (\color{red}{\verb|fips == "24510"|}fips=="24510") from 1999 to 2008?
#Use the base plotting system to make a plot answering this question.


if(!file.exists("summarySCC_PM25.rds") & !file.exists("Source_Classification_Code.rds")) {
     temp <- tempfile()
     download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",temp)
     unzip(temp)
     unlink(temp)
}


NEI <- readRDS("summarySCC_PM25.rds") 
SCC <- readRDS("Source_Classification_Code.rds")

subset_baltimore <- NEI[NEI$fips == "24510",]
aggregate_baltimore <- aggregate(Emissions ~ year, subset_baltimore,sum)

png("plot2.png", width =480, height = 480)
plot(aggregate_baltimore$year,(aggregate_baltimore$Emissions)/10^3, type ='b', xlab = "Year", ylab = "Total PM2.5 Emissions (10^3 Tons)", main="Total PM2.5 Emissions From Baltimore", col ="pink", lwd =2,xaxt = "n")
axis(side=1, at=c("1999", "2002", "2005", "2008"))
dev.off()
