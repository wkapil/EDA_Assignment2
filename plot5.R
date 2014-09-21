## Load data in variables NEI, SCC

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# subset of vehicle data
vehiclesData <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCCData <- SCC[vehiclesData,]$SCC
vehiclesNEIData <- NEI[NEI$SCC %in% vehiclesSCCData,]

# vehicles NEI data for Baltimore
baltimoreVehiclesNEI <- vehiclesNEIData[vehiclesNEIData$fips=="24510",]

png("plot5.png")

library(ggplot2)

vehicleGraph <- ggplot(baltimoreVehiclesNEI,aes(factor(year),Emissions)) +
  geom_bar(stat="identity",fill="grey",width=0.75) +
  theme_bw() +  guides(fill=FALSE) +
  labs(x="year", y="Total PM(2.5) Emission") + 
  labs(title="PM(2.5) Motor Vehicle Source")

print(vehicleGraph)

dev.off()