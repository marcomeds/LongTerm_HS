### CUTOFF PER SCHOOL
Opciones2005=read.dbf("RawData/COMIPEMS/BD_2005/opciones_educativas_2005.DBF", as.is=T)
Opciones2006=read.dbf("RawData/COMIPEMS/BD_2006/opciones_educativas_2006.DBF", as.is=T)
Opciones2007=read.dbf("RawData/COMIPEMS/BD_2007/opciones_educativas_2007.DBF", as.is=T)
Opciones2008=read.dbf("RawData/COMIPEMS/BD_2008/opciones_educativas_2008.DBF", as.is=T)
Opciones2009=read.dbf("RawData/COMIPEMS/BD_2009/opciones_educativas_2009.DBF", as.is=T)
Opciones2010=read.dbf("RawData/COMIPEMS/BD_2010/opciones_educativas_2010.DBF", as.is=T)


names(Opciones2005)=c("CVE_OPC","NOM_OPC","ESPECIAL","NOM_INST")

Opciones2006=Opciones2006[,c("CLAVE","INSTITU","PLANTEL","ESPECIAL")]
names(Opciones2006)=c("CVE_OPC","NOM_INST","NOM_OPC","ESPECIAL")

Opciones2007=Opciones2007[,c("CLAVE","INSTITU","PLANTEL","ESPECIAL")]
names(Opciones2007)=c("CVE_OPC","NOM_INST","NOM_OPC","ESPECIAL")

Opciones2008=Opciones2008[,c("CLAVE","INSTITU","PLANTEL","ESPECIAL")]
names(Opciones2008)=c("CVE_OPC","NOM_INST","NOM_OPC","ESPECIAL")

Opciones2009=Opciones2009[,c("CLAVE","INSTITU","PLANTEL","ESPECIAL")]
names(Opciones2009)=c("CVE_OPC","NOM_INST","NOM_OPC","ESPECIAL")

Opciones2010=Opciones2010[,c("CLAVE","INSTITU","PLANTEL","ESPECIAL")]
names(Opciones2010)=c("CVE_OPC","NOM_INST","NOM_OPC","ESPECIAL")

setDT(Opciones2005)
setDT(Opciones2006)
setDT(Opciones2007)
setDT(Opciones2008)
setDT(Opciones2009)
setDT(Opciones2010)

Opciones2005$NOM_INST=tolower(iconv(Opciones2005$NOM_INST,to="ASCII//TRANSLIT"))
Opciones2005$NOM_OPC=tolower(iconv(Opciones2005$NOM_OPC,to="ASCII//TRANSLIT"))
Opciones2005$ESPECIAL=tolower(iconv(Opciones2005$ESPECIAL,to="ASCII//TRANSLIT"))

Opciones2006$NOM_INST=tolower(iconv(Opciones2006$NOM_INST,to="ASCII//TRANSLIT"))
Opciones2006$NOM_OPC=tolower(iconv(Opciones2006$NOM_OPC,to="ASCII//TRANSLIT"))
Opciones2006$ESPECIAL=tolower(iconv(Opciones2006$ESPECIAL,to="ASCII//TRANSLIT"))

Opciones2007$NOM_INST=tolower(iconv(Opciones2007$NOM_INST,to="ASCII//TRANSLIT"))
Opciones2007$NOM_OPC=tolower(iconv(Opciones2007$NOM_OPC,to="ASCII//TRANSLIT"))
Opciones2007$ESPECIAL=tolower(iconv(Opciones2007$ESPECIAL,to="ASCII//TRANSLIT"))

Opciones2008$NOM_INST=tolower(iconv(Opciones2008$NOM_INST,to="ASCII//TRANSLIT"))
Opciones2008$NOM_OPC=tolower(iconv(Opciones2008$NOM_OPC,to="ASCII//TRANSLIT"))
Opciones2008$ESPECIAL=tolower(iconv(Opciones2008$ESPECIAL,to="ASCII//TRANSLIT"))


Opciones2009$NOM_INST=tolower(iconv(Opciones2009$NOM_INST,to="ASCII//TRANSLIT"))
Opciones2009$NOM_OPC=tolower(iconv(Opciones2009$NOM_OPC,to="ASCII//TRANSLIT"))
Opciones2009$ESPECIAL=tolower(iconv(Opciones2009$ESPECIAL,to="ASCII//TRANSLIT"))

Opciones2010$NOM_INST=tolower(iconv(Opciones2010$NOM_INST,to="ASCII//TRANSLIT"))
Opciones2010$NOM_OPC=tolower(iconv(Opciones2010$NOM_OPC,to="ASCII//TRANSLIT"))
Opciones2010$ESPECIAL=tolower(iconv(Opciones2010$ESPECIAL,to="ASCII//TRANSLIT"))






Opciones2005$NOM_INST[Opciones2005$NOM_INST=="conalep df"]="conalep_df"
Opciones2005$NOM_INST[Opciones2005$NOM_INST=="conalep_df"]="conalep_df"
Opciones2005$NOM_INST[Opciones2005$NOM_INST=="conalepdf"]="conalep_df"
Opciones2005$NOM_INST[Opciones2005$NOM_INST=="colegio de bachilleres"]="colbach"
Opciones2005$NOM_INST[Opciones2005$NOM_INST=="direccion general del bachillerato"]="dgb"
Opciones2005$NOM_INST[Opciones2005$NOM_INST=="i.p.n."]="ipn"
Opciones2005$NOM_INST[Opciones2005$NOM_INST=="se conalep estado de mexico"]="conalep_em"
Opciones2005$NOM_INST[Opciones2005$NOM_INST=="conalep mx"]="conalep_em"


Opciones2006$NOM_INST[Opciones2006$NOM_INST=="conalep df"]="conalep_df"
Opciones2006$NOM_INST[Opciones2006$NOM_INST=="conalep_df"]="conalep_df"
Opciones2006$NOM_INST[Opciones2006$NOM_INST=="conalepdf"]="conalep_df"
Opciones2006$NOM_INST[Opciones2006$NOM_INST=="conalep"]="conalep_df"
Opciones2006$NOM_INST[Opciones2006$NOM_INST=="colegio de bachilleres"]="colbach"
Opciones2006$NOM_INST[Opciones2006$NOM_INST=="direccion general del bachillerato"]="dgb"
Opciones2006$NOM_INST[Opciones2006$NOM_INST=="i.p.n."]="ipn"
Opciones2006$NOM_INST[Opciones2006$NOM_INST=="se conalep estado de mexico"]="conalep_em"
Opciones2006$NOM_INST[Opciones2006$NOM_INST=="conalep mx"]="conalep_em"

Opciones2007$NOM_INST[Opciones2007$NOM_INST=="conalep df"]="conalep_df"
Opciones2007$NOM_INST[Opciones2007$NOM_INST=="conalep_df"]="conalep_df"
Opciones2007$NOM_INST[Opciones2007$NOM_INST=="conalepdf"]="conalep_df"
Opciones2007$NOM_INST[Opciones2007$NOM_INST=="conalep"]="conalep_df"
Opciones2007$NOM_INST[Opciones2007$NOM_INST=="colegio de bachilleres"]="colbach"
Opciones2007$NOM_INST[Opciones2007$NOM_INST=="direccion general del bachillerato"]="dgb"
Opciones2007$NOM_INST[Opciones2007$NOM_INST=="i.p.n."]="ipn"
Opciones2007$NOM_INST[Opciones2007$NOM_INST=="se conalep estado de mexico"]="conalep_em"
Opciones2007$NOM_INST[Opciones2007$NOM_INST=="conalep mx"]="conalep_em"


Opciones2008$NOM_INST[Opciones2008$NOM_INST=="conalep df"]="conalep_df"
Opciones2008$NOM_INST[Opciones2008$NOM_INST=="conalep_df"]="conalep_df"
Opciones2008$NOM_INST[Opciones2008$NOM_INST=="conalepdf"]="conalep_df"
Opciones2008$NOM_INST[Opciones2008$NOM_INST=="conalep"]="conalep_df"
Opciones2008$NOM_INST[Opciones2008$NOM_INST=="colegio de bachilleres"]="colbach"
Opciones2008$NOM_INST[Opciones2008$NOM_INST=="direccion general del bachillerato"]="dgb"
Opciones2008$NOM_INST[Opciones2008$NOM_INST=="i.p.n."]="ipn"
Opciones2008$NOM_INST[Opciones2008$NOM_INST=="se conalep estado de mexico"]="conalep_em"
Opciones2008$NOM_INST[Opciones2008$NOM_INST=="conalep mx"]="conalep_em"


Opciones2009$NOM_INST[Opciones2009$NOM_INST=="conalep df"]="conalep_df"
Opciones2009$NOM_INST[Opciones2009$NOM_INST=="conalep_df"]="conalep_df"
Opciones2009$NOM_INST[Opciones2009$NOM_INST=="conalepdf"]="conalep_df"
Opciones2009$NOM_INST[Opciones2009$NOM_INST=="conalep"]="conalep_df"
Opciones2009$NOM_INST[Opciones2009$NOM_INST=="colegio de bachilleres"]="colbach"
Opciones2009$NOM_INST[Opciones2009$NOM_INST=="direccion general del bachillerato"]="dgb"
Opciones2009$NOM_INST[Opciones2009$NOM_INST=="i.p.n."]="ipn"
Opciones2009$NOM_INST[Opciones2009$NOM_INST=="se conalep estado de mexico"]="conalep_em"
Opciones2009$NOM_INST[Opciones2009$NOM_INST=="conalep mx"]="conalep_em"

Opciones2010$NOM_INST[Opciones2010$NOM_INST=="conalep df"]="conalep_df"
Opciones2010$NOM_INST[Opciones2010$NOM_INST=="conalep_df"]="conalep_df"
Opciones2010$NOM_INST[Opciones2010$NOM_INST=="conalepdf"]="conalep_df"
Opciones2010$NOM_INST[Opciones2010$NOM_INST=="conalep"]="conalep_df"
Opciones2010$NOM_INST[Opciones2010$NOM_INST=="colegio de bachilleres"]="colbach"
Opciones2010$NOM_INST[Opciones2010$NOM_INST=="direccion general del bachillerato"]="dgb"
Opciones2010$NOM_INST[Opciones2010$NOM_INST=="i.p.n."]="ipn"
Opciones2010$NOM_INST[Opciones2010$NOM_INST=="se conalep estado de mexico"]="conalep_em"
Opciones2010$NOM_INST[Opciones2010$NOM_INST=="conalep mx"]="conalep_em"

Total=rbind(Opciones2005,Opciones2006,Opciones2007,Opciones2008,Opciones2009,Opciones2010)

M=merge(Opciones2005, Opciones2006, by=c('CVE_OPC','NOM_INST','ESPECIAL'), all=T)
