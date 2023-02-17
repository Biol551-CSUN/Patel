library(ggbernie)

ggplot(ChemData) +
  geom_bernie(aes(x = Salinity, y = NN), bernie = "sitting")
