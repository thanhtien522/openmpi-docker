#v6p2------------------------------makefile------------------------DeltaCAD
#
# Makefile de STBTEL pour Unix.
#
# ATTENTION : doit �tre lanc� dans le r�pertoire ad�quat :
#                   stbtel*/.../sources.
#
# Modes supportes :
#        % maktel 
#        % maktel  [all] [install] [menage]
#        % maktel  libdebug
#        % maktel  libprofile
#----------------------------------------------------Aout-1999-DeltaCAD
#
# definition des noms de fichiers
#
NOM_GENERIQUE = stbtel

VERSION	      = v6p2
V_BIEF        = v6p2
V_DAMOCLES    = v6p2
V_SPECIAL     = v6p2
V_PARAVOID    = v6p2
V_PARALLEL    = v6p2

#
###########################
# Definition des macros
#
# macros predefinies :
#	$@	la cible complete (partie avant les ':').
#	$?	ce qui n'est pas a jour par rapport a la cible (partie apres les ':').
#	$*	(regles implicites) partie fichier d'une dependence sans le suffixe.
#	$<	(regles implicites) la partie a jour : '.c' dans '.c.o:'
#	on peut utiliser les formes $(*D), $(@D) et $(<D) pour ne prendre que la partie
#	repertoire ou $(*F), $(@F) et $(<F) pour la partie fichier.
#
# Options du compilateur :
#
include $(SYSTELCFG)/cfgmak.mak
#
# reserv� a la compilation sur CRAY ou FUJITSU
# include $(PROJECT)/cfgdef-$(DIRLIB)
#
DIRINC            = $(PROJECT)/stbtel/stbtel_$(VERSION)/$(DIRLIB)
DIRINC_BIEF       = $(PROJECT)/bief/bief_$(V_BIEF)/$(DIRLIB)
DIRINC_DAMOCLES   = $(PROJECT)/damocles/damo_$(V_BIEF)/$(DIRLIB)
DIRINC_PARAVOID   = $(PROJECT)/paravoid/paravoid_$(V_BIEF)/$(DIRLIB)
DIRINC_SPECIAL    = $(PROJECT)/special/special_$(V_SPECIAL)/$(DIRLIB)
#
FCO           = $(FC_OPT_COMPIL)
LKO           = $(LK_OPT_OTHERS)
FC            = $(FC_NAM)
FFLAGS        = $(FCO) $(FC_OPT_OTHERS) $(FC_OPT_INCLUDE)$(DIRINC) \
                                        $(FC_OPT_INCLUDE)$(DIRINC_BIEF) \
                                        $(FC_OPT_INCLUDE)$(DIRINC_DAMOCLES) \
                                        $(FC_OPT_INCLUDE)$(DIRINC_SPECIAL) \
                                        $(FC_OPT_INCLUDE)$(DIRINC_PARAVOID)


MODE          =

LIBRARY	      = $(NOM_GENERIQUE)$(MODE)$(VERSION).a

EXEDEF	      = $(NOM_GENERIQUE)$(MODE)$(VERSION).exe
LKLIB         = $(PROJECT)/bief/bief_$(VERSION)/$(DIRLIB)/bief$(MODE)$(VERSION).a \
                $(PROJECT)/damocles/damo_$(VERSION)/$(DIRLIB)/damo$(MODE)$(VERSION).a \
                $(PROJECT)/special/special_$(V_SPECIAL)/$(DIRLIB)/special$(MODE)$(V_SPECIAL).a \
                $(PROJECT)/paravoid/paravoid_$(VERSION)/$(DIRLIB)/paravoid$(MODE)$(VERSION).a \
                $(LK_LIB_SPECIAL)

JOURNAL       = journal
DATE          = `date '+%d/%m/%y %H:%M'`
MESSAGE       = @echo "$(PWD) $(LIBRARY) $(LOGNAME) $(DATE) $@ ($?)" >>$(JOURNAL);echo


DEST	      =  $(PROJECT)/stbtel/stbtel_$(VERSION)/$(DIRLIB)

INSTALL	      = cp

MAKEFILE      = makefile

#------------------------ Liste des fichiers
#
#------- Sources Fortran

SRCS= \
declarations_stbtel.f   \
homere_stbtel.f             \
circul.f             \
cordep.f             \
decoup.f             \
deparr.f             \
divise.f             \
dynami.f             \
echele.f             \
ecrres.f             \
ecrsel.f             \
elmpb.f             \
elmsec.f             \
extrac.f             \
fm3sel.f             \
imprim.f             \
iniadc.f             \
inifas.f             \
inisel.f             \
inisim.f             \
inistb.f             \
initri.f             \
interp.f             \
lecadc.f             \
lecdon_stbtel.f             \
lecfas.f             \
lecfon.f             \
lecsel.f             \
lecsim.f             \
lecstb.f             \
lectri.f             \
point_stbtel.f             \
presel.f             \
projec.f             \
ranbo.f             \
remail.f             \
renum.f             \
shufle.f             \
stbtel.f             \
surcon.f             \
verifi.f             \
verifs.f             \
voisin_stbtel.f

#
#------- Objets
#
OBJS = $(SRCS:.f=.o)

PRINT	      = pr

SHELL	      = /bin/sh

#
# Definition des cibles
#

all:		modules  $(LIBRARY) $(EXEDEF) delete_workdir
exedef:         $(EXEDEF)

$(LIBRARY):	$(OBJS)
		$(MESSAGE) "Archive $(LIBRARY) ..."
		@if [ "$(DIRLIB)" = "unicos" -o "$(DIRLIB)" = "fuji" ]; then \
		  DIR="`whoami`@`uname -n`:`pwd`" ; \
		  remsh $(NAME_CIBLE) -l $(USR_CIBLE) \
		  "cd workdir/compilation ;\
		  $(AR_CIBLE) $(ARFLAG_CIBLE) $(LIBRARY) *.o ;\
		  rcp $(LIBRARY) $$DIR/. ";\
		else \
		  $(LIB_NAM) $(LIB_OPT_OUTNAME) $(LIBRARY) $(OBJS) ;\
		  if [ $(LIB_RANLIB) ]; then $(LIB_RANLIB) $(LIBRARY) > /dev/null ; fi ;\
		fi ;
		@echo "Termine."

$(EXEDEF):	$(OBJS)
		@if [ "$(DIRLIB)" = "unicos" -o "$(DIRLIB)" = "fuji" ]; then \
		  if [ "$(DIRLIB)" = "unicos" ]; then \
		    $(MAKE) -f $(MAKEFILE) execray DIRLIB=unicos ; fi; \
		  if [ "$(DIRLIB)" = "fuji" ]; then \
		    $(MAKE) -f $(MAKEFILE) execray DIRLIB=fuji ; fi; \
		else \
		  $(MESSAGE) "Link executable par defaut ..." ; \
		  $(LK_NAM) $(LKO) $(LK_OPT_OUTNAME) $(NOM_GENERIQUE)$(MODE)$(VERSION).exe $(OBJS) $(LKLIB); fi;
		@echo "Termine."

menage:;	$(MESSAGE) "Efface les objets, librairies, executables et core-file."
		@rm -f $(OBJS) *.a *.exe *.mod *.MOD *.g90 core

Menage:;	$(MESSAGE) "Efface les objets, bibliotheques et core-file."
		@rm -f $(OBJS) *$(VERSION).a core tags *.exe

depend:;	$(MESSAGE) "Met a jour le Makefile."
		@mkmf -f $(MAKEFILE) ROOT=$(ROOT)

install:	$(LIBRARY) $(EXEDEF)
		@if [ ! -d ../$(DIRLIB) ]; then \
		echo "creation du repertoire $(DIRLIB)";mkdir ../$(DIRLIB); fi
		@rm  -f $(DEST)/$(NOM_GENERIQUE)$(MODE)$(VERSION).a
		$(MESSAGE) "Installe $(LIBRARY) dans $(DEST)."
		@if [ $(DEST) != . ]; then \
		(rm -f $(DEST)/$(LIBRARY); $(INSTALL) $(LIBRARY) $(DEST)); fi
		$(MESSAGE) "Installe $(EXEDEF) dans $(DEST)."
		@if [ $(DEST) != . ]; then \
		(rm -f $(DEST)/$(EXEDEF); $(INSTALL) $(EXEDEF) $(DEST)); fi

#--- Librairie en DEBUG
libdebug:
		$(MESSAGE) "Mise a jour forcee de la bibli. en DEBUG"
		@$(MAKE) -f $(MAKEFILE) menage install FCO="$(FC_OPT_DEBUG)" LKO="$(LK_OPT_DEBUG)" MODE=d

#--- Librairie en PROFILE
libprofile:
		$(MESSAGE) "Mise a jour forcee de la bibli. en PROFILE"
		@$(MAKE) -f $(MAKEFILE) menage install FCO="$(FC_OPT_PROFILE)" LKO="$(LK_OPT_PROFILE)" MODE=p
 
#--- Librairie pour le CRAY
libcray:
		$(MESSAGE) "Generation de la bibliotheque pour le CRAY"
		@$(MAKE) -f $(MAKEFILE) transfert_modules DIRLIB=unicos
		@$(MAKE) -f $(MAKEFILE) FCO="$(FC_OPT_CRAY)" DIRLIB=unicos
		@$(MAKE) -f $(MAKEFILE) install DIRLIB=unicos

#--- Librairie pour le FUJITSU
libfuji:
		$(MESSAGE) "Generation de la bibliotheque pour le FUJITSU"
		@$(MAKE) -f $(MAKEFILE) transfert_modules DIRLIB=fuji
		@$(MAKE) -f $(MAKEFILE) FCO="$(FC_OPT_FUJI)" DIRLIB=fuji
		@$(MAKE) -f $(MAKEFILE) install DIRLIB=fuji

#--- Executable pour le CRAY
execray:
		$(MESSAGE) "Generation de l'executable"
		@echo "=> Transfert des bibliotheques "
		@for BIB in `ls $(LKLIB)`  ;\
		do \
		  DIR="`whoami`@`uname -n`:$$BIB" ; \
		  remsh $(NAME_CIBLE) -l $(USR_CIBLE) \
		   "rcp $$DIR workdir/compilation/. " ; \
		done ;
		@echo "=> Edition de liens "
		@if [ "$(DIRLIB)" = "unicos" -o "$(DIRLIB)" = "fuji" ]; then \
		  DIR="`whoami`@`uname -n`:`pwd`" ; \
		  remsh $(NAME_CIBLE) -l $(USR_CIBLE) \
	  	  "cd workdir/compilation ;\
		  $(FC_LKCIBLE) $(FC_FLAG_LKCIBLE) -o $(EXEDEF) $(OBJS) *.a $(FC_LIBCIBLE) ;\
		  rcp $(EXEDEF) $$DIR/. " ; fi
		@echo "=> Executable recupere "

#--- Transfert des modules
transfert_modules: create_workdir
		@if [ "$(DIRLIB)" = "unicos" -o "$(DIRLIB)" = "fuji" ]; then \
		for MOD in `ls $(DIRINC)`  ;\
		do \
		DIR="`whoami`@`uname -n`:$(DIRINC)/$$MOD" ; \
		  remsh $(NAME_CIBLE) -l $(USR_CIBLE) \
		  "rcp $$DIR workdir/compilation/. ";\
		done ; fi;

#------- Modules
#
MODS = declarations_stbtel.o

modules:	$(MODS)
		@if [ "$(DIRLIB)" = "unicos" -o "$(DIRLIB)" = "fuji" ]; then \
		  DIR="`whoami`@`uname -n`:`pwd`" ; \
		  remsh $(NAME_CIBLE) -l $(USR_CIBLE) \
		  "cd workdir/compilation ;\
		  rcp *.mod $$DIR/. ";\
		  mv *.mod $(DEST)/.; fi;
		@echo "=> Transfert des modules effectue "

create_workdir :
		@if [ "$(DIRLIB)" = "unicos" -o "$(DIRLIB)" = "fuji" ]; then \
		  remsh $(NAME_CIBLE) -l $(USR_CIBLE) \
		  "cd workdir ;  mkdir compilation " ; fi

delete_workdir :
		@if [ "$(DIRLIB)" = "unicos" -o "$(DIRLIB)" = "fuji" ]; then \
		  remsh $(NAME_CIBLE) -l $(USR_CIBLE) \
		  "cd workdir ;  rm -rf compilation " ; fi


#------- Regles de compilation des sources FORTRAN

.f.o:
	@echo "=> Compilation de $< :"
	@if [ ! -d ../$(DIRLIB) ]; then \
	echo "creation du repertoire $(DIRLIB)";mkdir ../$(DIRLIB); fi
	@if [ "$(DIRLIB)" = "unicos" -o "$(DIRLIB)" = "fuji" ]; then \
          DIR="`whoami`@`uname -n`:`pwd`" ; \
	  remsh $(NAME_CIBLE) -l $(USR_CIBLE) \
	  "cd workdir/compilation ;\
	  rcp $$DIR/$(<F) . ;\
	  $(FC_CIBLE) $(FCFLAG_CIBLE) $(<F) ;\
	  rm $(*F).f ;\
	  rcp $(*F).o $$DIR/. ";\
	else \
	  $(FC) $(FFLAGS) $< ; fi;
	@if [ -r *.mod ]; then \
	 echo "Transfert du module $(@F:.o=.mod) ";\
	 cp  *.mod $(DEST)/.; /bin/rm *.mod; fi;
	@if [ -r *.MOD ]; then \
	 echo "Transfert du module $(@F:.o=.MOD) ";\
	 cp  *.MOD $(DEST)/.; /bin/rm *.MOD; fi;

