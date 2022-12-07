rm(list=ls())

# Load libraries
pacman::p_load(dplyr, foreign, data.table, haven, stringr, hacksaw)
#pacman::p_load(foreign, gplots, Hmisc, rgdal, raster, rgeos, sp, scales,
#               maptools, GISTools, RColorBrewer, classInt, xlsx, data.table,
#               dismo, rJava, xtable, readstata13, ggplot2, reshape2, grid, 
#               gridExtra, gtable, emoa, plyr, string, pBrackets)


# Set working directory
if(Sys.info()["user"]=="MROMEROLO") setwd("D:/Dropbox/Research/LongTerm_HS")
if(Sys.info()["user"]=="Mauricio") setwd("C:/Users/Mauricio/Dropbox/Research/LongTerm_HS")
if(Sys.info()["user"]=="marcomedina") setwd("/Users/marcomedina/ITAM Seira Research Dropbox/Marco Alejandro Medina/LongTerm_HS")

source("02_Code/01_R/02_Propensity_2005.R")
source("02_Code/01_R/02_Propensity_2006.R")
source("02_Code/01_R/02_Propensity_2007.R")
source("02_Code/01_R/02_Propensity_2008.R")
source("02_Code/01_R/02_Propensity_2009.R")
source("02_Code/01_R/02_Propensity_2010.R")


