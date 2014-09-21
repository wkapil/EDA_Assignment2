## Load data in variables NEI, SCC

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset coal combustion related NEI data
combustionData <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coalData <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
coalCombustionJoin <- (combustionData & coalData)
combustionSCCData <- SCC[coalCombustionJoin,]$SCC
combustionNEIData <- NEI[NEI$SCC %in% combustionSCCData,]

png("plot4.png")

library(ggplot2)

ggp <- ggplot(combustionNEIData,aes(factor(year),Emissions)) +
  geom_bar(stat="identity",fill="grey",width=0.75) +
  theme_bw() +  
  labs(x="year", y=expression("Total PM(2.5) Emission")) + 
  labs(title=expression("PM(2.5) Coal Combustion"))

print(ggp)

dev.off()
