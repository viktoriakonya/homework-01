######################
# Házi feladat 1     #
# Programozás I.     #
# 2016/17. II. félév #
# Kónya Viktória     #
# 2017.02.25.        #
######################



# ---- 2. Feladat ---------------------------------------------

# 2.1. package installálása és behívása
install.packages("fivethirtyeight")
require(fivethirtyeight)


# 2.2. dataset beolvasása
data()
data("tarantino")
View(tarantino)


# 2.3. új változó létrehozása

year <- ifelse(tarantino$movie == "Reservoir Dogs" , 1992, 
               +  ifelse(tarantino$movie == "Pulp Fiction", 1994,
                         +    ifelse(tarantino$movie == "Kill Bill: Vol. 1" , 2003, 
                                     +  ifelse(tarantino$movie == "Kill Bill: Vol. 2" , 2004, 
                                               +  ifelse(tarantino$movie == "Jackie Brown" , 1997, 
                                                         +  ifelse(tarantino$movie == "Inglorious Basterds" , 2009, 
                                                                   2012))))))

tarantino$year <- year
View(tarantino)


# 2.4. Melyik filmben hangzott el a legkorábban szitokszó? Melyik szó volt ez és hányadik percben hangzott el?
tarantino$movie[which.min(tarantino$minutes_in)] # A "Reservoir Dogs" c. filmben
tarantino$word[which.min(tarantino$minutes_in)] # a "dick" szó
tarantino$minutes_in[which.min(tarantino$minutes_in)] # a 0.4 percben


# 2.5. Melyik a Tarantino filmek leggyakoribb szitokszava? Tedd csökkenő sorrendbe a szavakat gyakoriság szerint!
sort(table(tarantino$word), decreasing = T) # a "fucking" szó a leggyakoribb


# 2.6. Melyik filmben hangzott el a shitless szó?
tarantino$movie[which(tarantino$word == "shitless")] # a "Kill Bill: Vol. 2" c. filmben hangzott el


# 2.7. Listázd ki azokat a sorokat, ahol a szó hiányos adat! Hány ilyen sor van?
ures <- subset(tarantino, is.na(word))
ures
nrow(ures) # 190 db hiányos szavas adat van


# 2.8. Nézd meg, milyen adattípusúak a movie és word oszlopok! Alakítsd át őket factor típusúvá, ha eddig nem tetted valamelyik lépésben (ami nem volt kötelező)!
class(tarantino$movie) # a movie "character" típusú
class(tarantino$word) # a word is "character" típusú

tarantino$movie <- as.factor(tarantino$movie)
tarantino$word <- as.factor(tarantino$word)
class(tarantino$movie)
class(tarantino$word)


# 2.9. Szűrd le a data frame-et úgy, hogy csak a 3 leggyakoribb szóhoz tartozó sorok maradjanak benne!
sort(table(tarantino$word), decreasing = T) # a 3 leggyakoribb szó a "fucking" , "shit" és "fuck" 
subset(tarantino, word=="fucking" | word=="shit"  | word=="fuck")
harom_leggyak <- subset(tarantino, word=="fucking" | word=="shit"  | word=="fuck")



class(harom_leggyak)
View(harom_leggyak)

# 2.10. Nézd meg az R dokumentációban a table függvényt! Csináld meg vele a filmek és a 3 leggyakoribb szó kereszttábláját! Szükség lesz még a droplevel függvényre is, amivel a felesleges faktorszinteket tudod törölni. Ennek is nézz utána a dokumentációban!

harom_leggyak$movie <- as.factor(harom_leggyak$movie)
harom_leggyak$word <- as.factor(harom_leggyak$word)

levels(harom_leggyak$movie)
levels(harom_leggyak$word)

kereszttabla <- table(harom_leggyak$movie,droplevels(harom_leggyak)$word)
kereszttabla


# 2.11. Nézd meg, melyik filmben hány halál történt és hány szitokszó hangzott el! Volt olyan film, ahol több halál volt, mint szitkozódás?
tarantino$profane <- as.factor(tarantino$profane)
levels(tarantino$profane)

tarantino$profane <- factor(tarantino$profane,
                            levels = c(TRUE, FALSE),
                            labels = c("szitokszó", "halál"))

szo_halal <- table(tarantino$movie,tarantino$profane)
szo_halal


# 2.12. Írd ki tsv formátumba a datasetet egy data nevű mappába datasetneve.tsv néven (értelemszerűen a dataset neve szerepeljen a tsv nevében)!

tarantino <- subset(tarantino)
write.table(
  versicolor,
  file = "data/tarantino.tsv",
  sep = "\t",
  row.names = F,
  fileEncoding = "utf-8"
)

# 2.13. A most kiírt tsv-t olvasd be egy új változóba datasetneve2 néven, majd töröld ki!
tarantino2 <-
  read.table(
    file = "data//tarantino.tsv",
    header = T,
    sep = "\t",
    dec = ".",
    fileEncoding = "utf-8"
  )

rm(tarantino2)



# ---- 3. Feladat ---------------------------------------------