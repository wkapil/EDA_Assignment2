## Load data in variables NEI, SCC

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Sorting NEI data for FIPS 24510
baltimoreNEI <- NEI[NEI$fips=="24510",]

# Totals for NEI data
totalsBaltimore <- aggregate(Emissions ~ year, baltimoreNEI,sum)

## Initiating graph device
png(filename = "plot3.png")

library(ggplot2)

ggp <- ggplot(baltimoreNEI,aes(factor(year),Emissions,fill=type)) +
  geom_bar(stat="identity") +
  theme_bw() + guides(fill=FALSE)+
  facet_grid(.~type,scales = "free",space="free") + 
  labs(x="year", y=expression("Total PM(2.5) Emission")) + 
  labs(title=expression("PM(2.5) Emissions - Baltimore City"))

print(ggp)

dev.off()
