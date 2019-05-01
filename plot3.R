#Of the four types of sources indicated by the \color{red}{\verb|type|}type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?
#Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

library(ggplot2)


if(!file.exists("summarySCC_PM25.rds") & !file.exists("Source_Classification_Code.rds")) {
     temp <- tempfile()
     download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",temp)
     unzip(temp)
     unlink(temp)
}


NEI <- readRDS("summarySCC_PM25.rds") 
SCC <- readRDS("Source_Classification_Code.rds")

subset_baltimore <- NEI[NEI$fips == "24510",]

plot3 <- ggplot(data = subset_baltimore, aes(x=factor(year), y= Emissions, fill = type))+
     geom_bar(stat="identity")+
     facet_grid(cols = vars(type))+
     labs(x = "Year", y ="Total PM2.5 Emissions", title ="PM 2.5 Emissions for Baltimore by Source Type")
     
ggsave("plot3.png",plot = plot3)
dev.off()