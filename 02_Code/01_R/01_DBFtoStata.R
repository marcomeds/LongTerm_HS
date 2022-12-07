for (year in c(2005:2010)) {
  
  # Load bd_sustentantes
  db <- read.dbf(paste0("01_Data/01_Raw/01_COMIPEMS/BD_", year, "/bd_sustentantes_", year, ".dbf"), as.is = T)

  # Convert characters to ASCII
  for (j in 1:dim(db)[2]) {
    db[, j] <- iconv(db[, j], to = "ASCII//TRANSLIT")
  }

  # Save bd_sustentantes as .dta
  write.dta(db, paste0("CreatedData/COMIPEMS/bd_sustentantes_", year, ".dta"))

  # Load opciones_educatiivas
  db <- read.dbf(paste0("RawData/COMIPEMS/BD_", year, "/opciones_educativas_", year, ".dbf"), as.is = T)

  # Convert characters to ASCII
  for (j in 1:dim(db)[2]) {
    db[, j] <- iconv(db[, j], to = "ASCII//TRANSLIT")
  }
  
  # Save opciones_educativas as .dta
  write.dta(db, paste0("CreatedData/COMIPEMS/opciones_educativas_", year, ".dta"))
}
