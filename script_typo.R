library(readr)
library(bestNormalize)

# import data
conso <- na.omit(read_csv("conso_surf.csv", col_types = cols(id = col_skip(), geom = col_skip())))

# champs calculés
# TU - artif
conso$TU <- c(conso$`evo espaces urbains (ha)`+conso$`evo espaces d'activités (ha)`+conso$`evo espaces urbains en mutation (ha)`)
conso$tx_TU <- c(conso$TU / conso$area_ha) # taux de consommation (part de la surface communale consom
# dominante habitat / activités
conso$tx_U <- c(conso$`evo espaces urbains (ha)` / conso$area_ha)       # taux de conso habitat
conso$tx_A <- c(conso$`evo espaces d'activités (ha)` / conso$area_ha)   # taux de conso activités

# normalisation tx_TU
tx_TU_norm <- bestNormalize(conso$tx_TU)

# normalisation tx_U
tx_U_norm <- bestNormalize(conso$tx_U)

# normalisation tx_A
tx_A_norm <- bestNormalize(conso$tx_A)

# normalisation tx_UA
tx_UA_norm <- bestNormalize(c((tx_U_norm$x.t + abs(min(tx_U_norm$x.t)) + 1)/(tx_A_norm$x.t + abs(min(tx_A_norm$x.t)) + 1)))

# histogrammes
par(mfrow = c(1, 2))
truehist(conso$tx_TU)
lines(density(conso$tx_TU), col ="red")
truehist(tx_TU_norm$x.t)
lines(density(tx_TU_norm$x.t), col ="red")
truehist(conso$tx_U)
lines(density(conso$tx_U), col ="red")
truehist(tx_U_norm$x.t)
lines(density(tx_U_norm$x.t), col ="red")
truehist(conso$tx_A)
lines(density(conso$tx_A), col ="red")
truehist(tx_A_norm$x.t)
lines(density(tx_A_norm$x.t), col ="red")
par(mfrow = c(1,1))
truehist(tx_UA_norm$x.t)
lines(density(tx_UA_norm$x.t), col ="red")
plot(x=tx_UA_norm$x.t, y=tx_TU_norm$x.t)

# output
typo <- data.frame(insee=conso$code_insee, TU=tx_TU_norm$x.t, UA=tx_UA_norm$x.t)
write.csv(output, "typo.csv")