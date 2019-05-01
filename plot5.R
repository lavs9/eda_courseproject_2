#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
library(ggplot2)


if(!file.exists("summarySCC_PM25.rds") & !file.exists("Source_Classification_Code.rds")) {
     temp <- tempfile()
     download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",temp)
     unzip(temp)
     unlink(temp)
}


NEI <- readRDS("summarySCC_PM25.rds") 
SCC <- readRDS("Source_Classification_Code.rds")
subset_baltimore_onroad <- NEI[NEI$fips == "24510" & NEI$type == "ON-ROAD",]
aggregrate_baltimore_onroad <- aggregate(Emissions ~ year, subset_baltimore_onroad, sum)

plot5 <- ggplot(data = aggregrate_baltimore_onroad, aes(x=factor(year),y=Emissions))+
     geom_line(aes(group =1, col = Emissions))+
     geom_point(aes(size =0.3, col= Emissions))+
     labs( x= "Year", y= "PM 2.5 Total Emissions", title = "Motor Vehicle PM2.5 Emissions in Baltimore")


ggsave("plot5.png", plot = plot5)
dev.off()
