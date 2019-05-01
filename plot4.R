#Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

library(ggplot2)


if(!file.exists("summarySCC_PM25.rds") & !file.exists("Source_Classification_Code.rds")) {
     temp <- tempfile()
     download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",temp)
     unzip(temp)
     unlink(temp)
}


NEI <- readRDS("summarySCC_PM25.rds") 
SCC <- readRDS("Source_Classification_Code.rds")

SCC_coal <- SCC[grepl("coal",SCC$Short.Name,ignore.case = TRUE),]
NEI_coal <- merge(NEI,SCC_coal,by = "SCC")
total_coal <- aggregate(Emissions ~ year , NEI_coal,sum)

plot4 <- ggplot(data = total_coal, aes(x=factor(year), y= Emissions))+
     geom_line(aes(group=1, col = Emissions))+
     geom_point(aes(size=1, col = Emissions))+
     labs(x="Year", y = "Total Emissions of PM2.5", title = "Total Coal Combustion Emission 1999-2008")

ggsave("plot4.png",plot = plot4)

dev.off()
