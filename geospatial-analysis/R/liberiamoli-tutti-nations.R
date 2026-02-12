# Carico i pacchetti necessari
library(spdep)
library(sf)
library(tmap)
library(leaflet)


#########################################################################
### 1. Caricamento Dataset e verifica geometrie                       ###
#########################################################################
setwd("...")

nations_raw <- read.csv("liberiamoli-tutti-nazionalita-totali-wide-plus.csv")
nations_raw$geometry <- as.character(nations_raw$geometry)
# devo togliere 'others'
nations_raw <- nations_raw[!is.na(nations_raw$geometry) & nations_raw$geometry != "", ]


# -> Converto in oggetto sf
nations <- st_as_sf(nations_raw, wkt = "geometry", crs = 4326)

# Controllo le prime righe
head(nations)

# devo vedere se ci sono geometrie 'sporche'
library(sf)


st_is_valid(nations)  # TRUE/FALSE per ogni poligono
# -> problemi sull'egitto (?)
nations <- st_make_valid(nations)
any(!st_is_valid(nations))  # deve restituire FALSE


#########################################################################
### 2. Dataset completo (outlier e country isolate)                   ###
#########################################################################
nations_nb <- poly2nb(nations, queen=T)

coords <- st_coordinates(st_centroid(nations))

# plot come base delle nazioni
plot(st_geometry(nations), border="grey")
# aggiunta dei collegamenti tra vicini
plot(nations_nb, coords, add=TRUE)
#mtext("Countries Neighborhood")

# zero.policy a True perchè ci sono 2 nazioni senza 'neighbor' -> Ukraine/Bangladesh
nations_nb.listw <- nb2listw(nations_nb,style="W", zero.policy = T)

# TEST MORAN I - Global
moran_test_random_false_20250915 <- moran.test(nations$X2025.09.15, nations_nb.listw, randomisation=FALSE)

capture.output(
  print(moran_test_random_false_20250915),
  file = "moran_test_random_false_20250915.txt"
)

# p-value > 0.05, non rifiuto h0

moran_test_random_true_20250915 <- moran.test(nations$X2025.09.15, nations_nb.listw, randomisation=TRUE)

capture.output(
  print(moran_test_random_true_20250915),
  file = "moran_test_random_true_20250915.txt"
)

# p-value > 0,05, non rifiuto h0

moran_test_MC_20250915 <- moran.mc(nations$X2025.09.15, nations_nb.listw, nsim=999)

capture.output(
  print(moran_test_MC_20250915),
  file = "moran_test_MC_20250915.txt"
)

# p-value > 0.05, non rifiuto h0

moran.test(nations$X2025.09.15 - nations$X2023.01.15, nations_nb.listw, randomisation=FALSE)
moran.test(nations$X2022.12.31 - nations$X2019.09.30, nations_nb.listw, randomisation=FALSE)
moran.test(nations$X2025.09.15 - nations$X2024.09.30, nations_nb.listw, randomisation=TRUE)
moran.mc(nations$X2025.09.15 - nations$X2024.09.30, nations_nb.listw, nsim=999)
# H0 non rifiutata in tutti i test

##################
# TEST Geary'C   #
##################
# VERIFICA TOTALE - 2025-2019
geary_test_20250915 <- geary.test(nations$X2025.09.15, nations_nb.listw, zero.policy = TRUE)
capture.output(
  print(geary_test_20250915),
  file = "geary_test_20250915.txt"
)
# H0 RIFIUTATA!!! 

# Monte Carlo
geary_test_mc_20250915 <- geary.mc(nations$X2025.09.15, nations_nb.listw, zero.policy = TRUE, nsim = 999)
capture.output(
  print(geary_test_mc_20250915),
  file = "geary_test_mc_20250915.txt"
)

# H0 NON RIFIUTATA


# VERIFICA INIZIO CONFLITTI GUERRA CIVILE SUDAN 2023-
geary_test_20250915_20230115 <- geary.test(nations$X2025.09.15 - nations$X2023.01.15, nations_nb.listw, zero.policy = TRUE)
capture.output(
  print(geary_test_20250915_20230115),
  file = "geary_test_20250915_20230115.txt"
)

# H0 RIFIUTATA!!!

geary_test_mc_20250915_20230115 <- geary.mc(nations$X2025.09.15 - nations$X2023.01.15, nations_nb.listw, zero.policy = TRUE, nsim=999)
capture.output(
  print(geary_test_mc_20250915_20230115),
  file = "geary_test_mc_20250915_20230115.txt"
)


# VERIFICA 2022-2019
geary_test_20221231_20190930 <- geary.test(nations$X2022.12.31 - nations$X2019.09.30, nations_nb.listw, zero.policy = TRUE)

capture.output(
  print(geary_test_20221231_20190930),
  file = "geary_test_20221231_20190930.txt"
)

# H0 RIFIUTATA!!! 

geary_test_mc_20221231_20190930 <- geary.mc(nations$X2022.12.31 - nations$X2019.09.30, nations_nb.listw, zero.policy = TRUE, nsim=999)
capture.output(
  print(geary_test_mc_20221231_20190930),
  file = "geary_test_mc_20221231_20190930.txt"
)


geary.mc(nations$X2025.09.15, nations_nb.listw, zero.policy = TRUE, nsim = 999)
#
# Monte-Carlo simulation of Geary C
#
# data:  nations$X2025.09.15 
# weights: nations_nb.listw  
# number of simulations + 1: 1000 
#
#statistic = 0.56411, observed rank = 73, p-value = 0.073
# alternative hypothesis: greater
# geary'C Monte Carlo da risultato differente (?) -> Da interpretare



# Visulizzazione all'ultima data disponibile
gStar_2025 <- localG(nations$X2025.09.15, nations_nb.listw, zero.policy = TRUE)
as.numeric(gStar_2025)

nations$gStar_2025 <- as.numeric(gStar_2025)
tm_shape(nations) + 
  tm_polygons("gStar_2025", title = "Getis-Ord G* z-scores (2025.09.15)",
              breaks=c(-2.58, -1.96, -1.65, -1, 0, 1, 1.65, 1.96, 2.58)) +
  tm_layout(legend.outside = TRUE)

# Visualizzazione incrementi 2025-2023
gStar_2025_2023 <- localG(nations$X2025.09.15 - nations$X2023.01.15, nations_nb.listw, zero.policy = TRUE)
as.numeric(gStar_2025_2023)

nations$gStar_2025_2023 <- as.numeric(gStar_2025_2023)
tm_shape(nations) + 
  tm_polygons("gStar_2025_2023", title = "Getis-Ord G* z-scores (2025.09.15 - 2023.01.15)",
              breaks=c(-2.58, -1.96, -1.65, -1, 0, 1, 1.65, 1.96, 2.58)) +
  tm_layout(legend.outside = TRUE)

# #################################### #
# Getis-Ord G - Visualizzazione incrementi 2019-2022 #
# #################################### #
gStar_2022_2019 <- localG(nations$X2022.12.31 - nations$X2019.09.30, nations_nb.listw, zero.policy = TRUE)
as.numeric(gStar_2022_2019)

nations$gStar_2022_2019 <- as.numeric(gStar_2022_2019)
tm_shape(nations) + 
  tm_polygons("gStar_2022_2019", title = "Getis-Ord G* z-scores (2022.12.31 - 2019.09.30)",
              breaks=c(-2.58, -1.96, -1.65, -1, 0, 1, 1.65, 1.96, 2.58)) +
  tm_layout(legend.outside = TRUE)

# Verifica test monte carlo
gStar_perm <- localG_perm(nations$X2025.09.15 - nations$X2023.01.15, nations_nb.listw, zero.policy = TRUE, nsim = 999)
as.numeric(gStar_perm)

localmoran(nations$X2025.09.15 - nations$X2023.01.15, nations_nb.listw)

##########################
# 3. VERIFICA OUTLIER e Nazioni senza 'vicini'
##########################
quantiles <- quantile(nations$X2025.09.15)

#0%      25%      50%      75%     100% 
#2.00  2714.00  8593.50 22582.25 75528.00 


boxplot(nations$X2025.09.15,
        main = "Boxplot migration flows (2025.09.15)",
        ylab = "Number of migrants")

# RIMUOVO GLI OUTLIER
bp <- boxplot(nations$X2025.09.15, plot = FALSE)
outliers <- bp$out
nations_filtered <- nations[!nations$X2025.09.15 %in% outliers, ]

nations_nb_filtered <- poly2nb(nations_filtered, queen=T)  # nb filtrato


#tolgo le nazioni senza alcun vicino
# card(nations_nb) restituisce il numero di vicini per ciascun poligono
no_neighbors <- which(card(nations_nb_filtered) == 0)

# seleziona solo le nazioni con almeno 1 vicino
has_neighbors <- card(nations_nb_filtered) > 0



### 1.1.3 Contiguity-based neighbourhood
# Contiguity-based neighbourhood criterion implies that two spatial units are 
# considered as neighbours if they share a common boundary.

# funzione poly2nb crea i neighborhood se queen a true verifica lati e vertici condivis

nations_filtered <- nations_filtered[has_neighbors, ]   # nuovo sf senza isolati
nations_nb_filtered <- poly2nb(nations_filtered, queen=T)  # nb filtrato

coords_filtered <- st_coordinates(st_centroid(nations_filtered))

# plot come base delle nazioni
plot(st_geometry(nations_filtered), border="grey")
# aggiunta dei collegamenti tra vicini
plot(nations_nb_filtered, coords_filtered, add=TRUE)

# zero.policy a False
nations_nb_filtered.listw <- nb2listw(nations_nb_filtered,style="W", zero.policy = F)



# TEST MORAN I - Global
moran.test(nations_filtered$X2025.09.15, nations_nb_filtered.listw, randomisation=FALSE)
moran.test(nations_filtered$X2025.09.15 - nations_filtered$X2023.01.15, nations_nb_filtered.listw, randomisation=FALSE)
moran.test(nations_filtered$X2022.12.31 - nations_filtered$X2019.09.30, nations_nb_filtered.listw, randomisation=FALSE)
moran.mc(nations_filtered$X2025.09.15 - nations_filtered$X2024.09.30, nations_nb_filtered.listw, nsim=999)


# H0 non rifiutata in tutti i test

# TEST Geary'C
geary.test(nations_filtered$X2025.09.15, nations_nb_filtered.listw, zero.policy = TRUE)

geary.test(nations_filtered$X2025.09.15 - nations_filtered$X2023.01.15, nations_nb_filtered.listw, zero.policy = TRUE)
geary.test(nations_filtered$X2025.09.15 - nations_filtered$X2020.09.30, nations_nb_filtered.listw, zero.policy = TRUE)
geary.test(nations_filtered$X2025.09.15, nations_nb_filtered.listw, zero.policy = TRUE)
geary.mc(nations_filtered$X2025.09.15, nations_nb_filtered.listw, zero.policy = TRUE, nsim = 999)
#
# Monte-Carlo simulation of Geary C
#
# data:  nations_filtered$X2025.09.15 
# weights: nations_nb.listw  
# number of simulations + 1: 1000 
#
#statistic = 0.56411, observed rank = 73, p-value = 0.073
# alternative hypothesis: greater


# Visulizzazione all'ultima data disponibile
gStar_2025_filtered <- localG(nations_filtered$X2025.09.15, nations_nb_filtered.listw, zero.policy = TRUE)
as.numeric(gStar_2025_filtered)

nations_filtered$gStar_2025_filtered <- as.numeric(gStar_2025_filtered)
tm_shape(nations_filtered) + 
  tm_polygons("gStar_2025_filtered", title = "Getis-Ord G* z-scores (2025.09.15) - Nations filtered",
              breaks=c(-2.58, -1.96, -1.65, -1, 0, 1, 1.65, 1.96, 2.58)) +
  tm_layout(legend.outside = TRUE)

# Visualizzazione incrementi 2025-2024
gStar_2025_2024_filtered <- localG(nations_filtered$X2025.09.15 - nations_filtered$X2024.01.15, nations_nb_filtered.listw, zero.policy = TRUE)
as.numeric(gStar_2025_2024_filtered)

nations_filtered$gStar_2025_2024_filtered <- as.numeric(gStar_2025_2024_filtered)
tm_shape(nations_filtered) + 
  tm_polygons("gStar_2025_2024_filtered", title = "Getis-Ord G* z-scores (2025.09.15 - 2024.01.15) - Nations filtered",
              breaks=c(-2.58, -1.96, -1.65, -1, 0, 1, 1.65, 1.96, 2.58)) +
  tm_layout(legend.outside = TRUE)

# Visualizzazione incrementi 2025-2023
gStar_2025_2023_filtered <- localG(nations_filtered$X2025.09.15 - nations_filtered$X2023.01.15, nations_nb_filtered.listw, zero.policy = TRUE)
as.numeric(gStar_2025_2023_filtered)

nations_filtered$gStar_2025_2023_filtered <- as.numeric(gStar_2025_2023_filtered)
tm_shape(nations_filtered) + 
  tm_polygons("gStar_2025_2023_filtered", title = "Getis-Ord G* z-scores (2025.09.15 - 2023.01.15) - Nations filtered",
              breaks=c(-2.58, -1.96, -1.65, -1, 0, 1, 1.65, 1.96, 2.58)) +
  tm_layout(legend.outside = TRUE)


# Visualizzazione incrementi 2024-2023
gStar_2024_2023_filtered <- localG(nations_filtered$X2024.01.15 - nations_filtered$X2023.01.15, nations_nb_filtered.listw, zero.policy = TRUE)
as.numeric(gStar_2024_2023_filtered)

nations_filtered$gStar_2024_2023_filtered <- as.numeric(gStar_2024_2023_filtered)
tm_shape(nations_filtered) + 
  tm_polygons("gStar_2024_2023_filtered", title = "Getis-Ord G* z-scores (2024.01.15 - 2023.01.15) - Nations filtered",
              breaks=c(-2.58, -1.96, -1.65, -1, 0, 1, 1.65, 1.96, 2.58)) +
  tm_layout(legend.outside = TRUE)


# Visualizzazione incrementi 2024-2022
gStar_2024_2022_filtered <- localG(nations_filtered$X2024.01.15 - nations_filtered$X2022.01.15, nations_nb_filtered.listw, zero.policy = TRUE)
as.numeric(gStar_2024_2022_filtered)

nations_filtered$gStar_2024_2022_filtered <- as.numeric(gStar_2024_2022_filtered)
tm_shape(nations_filtered) + 
  tm_polygons("gStar_2024_2022_filtered", title = "Getis-Ord G* z-scores (2024.01.15 - 2022.01.15) - Nations filtered",
              breaks=c(-2.58, -1.96, -1.65, -1, 0, 1, 1.65, 1.96, 2.58)) +
  tm_layout(legend.outside = TRUE)


# Visualizzazione incrementi 2019-2023
gStar_2023_2019_filtered <- localG(nations_filtered$X2023.01.15 - nations_filtered$X2019.09.30, nations_nb_filtered.listw, zero.policy = TRUE)
as.numeric(gStar_2023_2019_filtered)

nations_filtered$gStar_2023_2019_filtered <- as.numeric(gStar_2023_2019_filtered)
tm_shape(nations_filtered) + 
  tm_polygons("gStar_2023_2019_filtered", title = "Getis-Ord G* z-scores (2023.01.15 - 2019.09.30)",
              breaks=c(-2.58, -1.96, -1.65, -1, 0, 1, 1.65, 1.96, 2.58)) +
  tm_layout(legend.outside = TRUE)

# Verifica test monte carlo
gStar_perm <- localG_perm(nations$X2025.09.15, nations_nb.listw, zero.policy = TRUE, nsim = 999)
as.numeric(gStar_perm)




























