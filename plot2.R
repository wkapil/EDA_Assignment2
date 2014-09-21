## Load data in variables NEI, SCC

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## extracting data for Baltimore City
baltimoreData <- NEI[NEI$fips=="24510",]
## Getting totals for Baltimore city
baltimoreTotals <- aggregate(Emissions ~ year, baltimoreData,sum)

## Initiating graph device
png(filename = "plot2.png")

barplot( baltimoreTotals$Emissions, names.arg=baltimoreTotals$year,
  xlab="Year", ylab="PM(2.5) Emissions", main="Total PM(2.5) Emissions - Baltimore City")

dev.off()
