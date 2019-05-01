#Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (\color{red}{\verb|fips == "06037"|}fips=="06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?

library(ggplot2)
library(dplyr)


if(!file.exists("summarySCC_PM25.rds") & !file.exists("Source_Classification_Code.rds")) {
     temp <- tempfile()
     download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",temp)
     unzip(temp)
     unlink(temp)
}


NEI <- readRDS("summarySCC_PM25.rds") 
SCC <- readRDS("Source_Classification_Code.rds")

sub_bal_los <- NEI[NEI$type == 'ON-ROAD' & (NEI$fips == '24510' | NEI$fips == '06037'),]
sub_bal_los_aggregrate <- aggregate(Emissions ~ year+fips,sub_bal_los,sum)

df <- sub_bal_los_aggregrate %>%
     group_by(fips) %>%
     mutate(Diff = Emissions - lag(Emissions))

df[c(1,5),4] <- 0
df$fips <- factor(df$fips, levels = c("24510",'06037'), labels = c("Baltimore", "Los Angeles"))

plot6 <- ggplot(data = df, aes(x=factor(year), y = Diff , group = fips, color = fips))+
     geom_line()+
     geom_point(aes(size=1))+
     labs(x= "Year", y= " Change in Emissions", title = "Motor Vehicles PM2.5 Change Baltimore vs Los Angeles")

ggsave("plot6.png", plot = plot6)

dev.off()
