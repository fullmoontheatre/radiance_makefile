# General Radiance rendering Makefile
# by Francesco Anselmo
# latest revision: 2023-08-25

# -----------------------------------------------------------------------
# rendering parameters

WORKPATH=/path/to/radiance/project/folder 

VIEWNAME=Camera
RADNAME=projectname
SKYNAME=moon
GRIDNAME=Grid.name
MATNAME=materials
MATLIST=matlist.txt

OPTNAME=ab1

NPROC=4

RVUOPTIONS=-ab 0 -ad 1024 -as 512 -ar 256 -aa .1  -u -ps 1 -ds .1 -dj .8 -n $(NPROC)

GLOBALPMAP = 100k 
CAUSTICSPMAP = 1000k
PFILTOPTIONS=-r .7 -e +2
DOWNSAMPLE=2
LUMFALSECOLOROPTIONS=-s 0.1 -n 10 -l cd/m2
ILLFALSECOLOROPTIONS=-s 1 -n 10 -l lux
RATIFFOPTIONS=-z
PCONDOPTIONS=-s 
FALSECOLORPROGRAM=falsecolor

RPIECEDIVISIONS=10 10

SIZEX=2000
SIZEY=2000

# -----------------------------------------------------------------------
# targets, rules and additional variables

# directories
RADDIR=rad
OCTDIR=oct
VIEWDIR=vf
SKYDIR=sky
MATDIR=mat
PICDIR=pic
RTMDIR=rtm
OBJDIR=obj
AMBDIR=amb
TMPDIR=tmp
SYNCDIR=sync
GRIDDIR=grid
OPTDIR=opt
HDREXT=hdr

# filenames
RADFILE=$(RADNAME).rad
OCTREE=$(WORKPATH)/$(OCTDIR)/$(RADNAME)_$(MATNAME)_$(SKYNAME).oct
VIEWFILE=$(WORKPATH)/$(VIEWDIR)/$(VIEWNAME).vf
SKYFILE=$(WORKPATH)/$(SKYDIR)/$(SKYNAME).sky
MATFILE=$(WORKPATH)/$(MATDIR)/$(MATNAME).rad
OPTFILE=$(WORKPATH)/$(OPTDIR)/$(OPTNAME).opt
LUMPICFILE=$(WORKPATH)/$(PICDIR)/$(RADNAME)_$(MATNAME)_$(SKYNAME)_$(VIEWNAME)_$(OPTNAME)_lum.$(HDREXT)
LUMUNFFILE=$(WORKPATH)/$(PICDIR)/$(RADNAME)_$(MATNAME)_$(SKYNAME)_$(VIEWNAME)_$(OPTNAME)_lum.unf
LUMPFILTFILE=$(WORKPATH)/$(PICDIR)/$(RADNAME)_$(MATNAME)_$(SKYNAME)_$(VIEWNAME)_$(OPTNAME)_lum_pf.$(HDREXT)
LUMFALSECOLORFILE=$(WORKPATH)/$(PICDIR)/$(RADNAME)_$(MATNAME)_$(SKYNAME)_$(VIEWNAME)_$(OPTNAME)_lum_fc.$(HDREXT)
LUMFALSECOLORTIFFFILE=$(WORKPATH)/$(PICDIR)/$(RADNAME)_$(MATNAME)_$(SKYNAME)_$(VIEWNAME)_$(OPTNAME)_lum_fc.tif
LUMPCONDFILE=$(WORKPATH)/$(PICDIR)/$(RADNAME)_$(MATNAME)_$(SKYNAME)_$(VIEWNAME)_$(OPTNAME)_lum_pc.$(HDREXT)
LUMTIFFFILE=$(WORKPATH)/$(PICDIR)/$(RADNAME)_$(MATNAME)_$(SKYNAME)_$(VIEWNAME)_$(OPTNAME)_lum_pc.tif
ILLPICFILE=$(WORKPATH)/$(PICDIR)/$(RADNAME)_$(MATNAME)_$(SKYNAME)_$(VIEWNAME)_$(OPTNAME)_ill.$(HDREXT)
ILLUNFFILE=$(WORKPATH)/$(PICDIR)/$(RADNAME)_$(MATNAME)_$(SKYNAME)_$(VIEWNAME)_$(OPTNAME)_ill.unf
ILLPFILTFILE=$(WORKPATH)/$(PICDIR)/$(RADNAME)_$(MATNAME)_$(SKYNAME)_$(VIEWNAME)_$(OPTNAME)_ill_pf.$(HDREXT)
ILLFALSECOLORFILE=$(WORKPATH)/$(PICDIR)/$(RADNAME)_$(MATNAME)_$(SKYNAME)_$(VIEWNAME)_$(OPTNAME)_ill_fc.$(HDREXT)
ILLFALSECOLORTIFFFILE=$(WORKPATH)/$(PICDIR)/$(RADNAME)_$(MATNAME)_$(SKYNAME)_$(VIEWNAME)_$(OPTNAME)_ill_fc.tif
ILLPCONDFILE=$(WORKPATH)/$(PICDIR)/$(RADNAME)_$(MATNAME)_$(SKYNAME)_$(VIEWNAME)_$(OPTNAME)_ill_pc.$(HDREXT)
ILLTIFFFILE=$(WORKPATH)/$(PICDIR)/$(RADNAME)_$(MATNAME)_$(SKYNAME)_$(VIEWNAME)_$(OPTNAME)_ill_pc.tif
SECTUNFFILE=$(WORKPATH)/$(PICDIR)/$(RADNAME)_$(MATNAME)_$(SKYNAME)_section.unf
SECTPICFILE=$(WORKPATH)/$(PICDIR)/$(RADNAME)_$(MATNAME)_$(SKYNAME)_section.$(HDREXT)
AMBFILE=$(WORKPATH)/$(AMBDIR)/$(RADNAME)_$(MATNAME)_$(SKYNAME)_$(OPTNAME).amb
SYNCFILE=$(WORKPATH)/$(SYNCDIR)/$(RADNAME)_$(MATNAME)_$(SKYNAME)_$(OPTNAME)_$(VIEWNAME).sync
GRIDDFFMTFILE=$(WORKPATH)/$(GRIDDIR)/Grid_df.fmt
GRIDILLFMTFILE=$(WORKPATH)/$(GRIDDIR)/Grid_ill.fmt
GRIDFILE=$(WORKPATH)/$(GRIDDIR)/$(GRIDNAME).pnt
ILLOUTGRIDFILE=$(WORKPATH)/$(GRIDDIR)/$(GRIDNAME).$(RADNAME).$(SKYNAME).$(OPTNAME).ill
RTCONTRIBILLPREFIX=$(WORKPATH)/$(GRIDDIR)/$(GRIDNAME).$(RADNAME).$(SKYNAME).$(OPTNAME)
DFOUTGRIDFILE=$(WORKPATH)/$(GRIDDIR)/$(GRIDNAME).$(RADNAME).$(SKYNAME).$(OPTNAME).df
VTKGRIDFILE=$(WORKPATH)/$(GRIDDIR)/$(GRIDNAME).vtk
ILLVTKOUTGRIDFILE=$(WORKPATH)/$(GRIDDIR)/$(GRIDNAME).$(RADNAME).$(SKYNAME).$(OPTNAME).ill.vtk
DFVTKOUTGRIDFILE=$(WORKPATH)/$(GRIDDIR)/$(GRIDNAME).$(RADNAME).$(SKYNAME).$(OPTNAME).df.vtk
RPICTOPTIONFILE=$(OPTFILE)
PMAPGPMFILE=$(AMBDIR)/$(RADNAME)_$(MATNAME)_$(SKYNAME)_$(OPTNAME).gpm
PMAPCPMFILE=$(AMBDIR)/$(RADNAME)_$(MATNAME)_$(SKYNAME)_$(OPTNAME).cpm
LUMPMAPPICFILE=$(PICDIR)/$(RADNAME)_$(MATNAME)_$(SKYNAME)_$(VIEWNAME)_$(OPTNAME)_pmap_lum.$(HDREXT)
LUMPMAPUNFFILE=$(PICDIR)/$(RADNAME)_$(MATNAME)_$(SKYNAME)_$(VIEWNAME)_$(OPTNAME)_pmap_lum.unf
ILLPMAPPICFILE=$(PICDIR)/$(RADNAME)_$(MATNAME)_$(SKYNAME)_$(VIEWNAME)_$(OPTNAME)_pmap_ill.$(HDREXT)
ILLPMAPUNFFILE=$(PICDIR)/$(RADNAME)_$(MATNAME)_$(SKYNAME)_$(VIEWNAME)_$(OPTNAME)_pmap_ill.unf



# rendering options
RTRACEOPTIONS=-x 2000 -y 2000 -ab 2 -ad 1024 -as 512 -aa .1 -ar 256 -af $(SKYNAME).amb -u # for nosun
RPICTOPTIONS=@$(OPTFILE) -w -ps 1 -af $(AMBFILE) -x $(SIZEX) -y $(SIZEY)
ILLRTRACEOPTIONS=@$(OPTFILE) -h -w -I+ -af $(AMBFILE)
PMAPOPTIONS= -w -ps 1 -x $(SIZEX) -y $(SIZEY)

# targets

lumpic: $(LUMPICFILE) $(LUMPCONDFILE) $(LUMTIFFFILE) 
illpic: $(ILLPICFILE) 

lumpmap: $(LUMPMAPPICFILE)
illpmap: $(ILLPMAPPICFILE)

illgrid: $(ILLVTKOUTGRIDFILE)

dfgrid: $(DFVTKOUTGRIDFILE)

dirs: $(RADDIR) $(OCTDIR) $(VIEWDIR) $(SKYDIR) $(MATDIR) $(PICDIR) $(RTMDIR) $(OBJDIR) $(AMBDIR) $(TMPDIR) $(GRIDDIR) $(SYNCDIR) $(OPTDIR)

rvu: $(OCTREE) $(VIEWFILE)
	cd $(WORKPATH)
	rvu -w -vf $(VIEWFILE) $(RVUOPTIONS) $(OCTREE)

section: $(SECTPICFILE)

hdrfinalise: lumhdrfinalise illhdrfinalise

lumhdrfinalise: $(LUMPICFILE) $(LUMFALSECOLORFILE) $(LUMPCONDFILE) $(LUMTIFFFILE) $(LUMFALSECOLORTIFFFILE)

illhdrfinalise: $(ILLPICFILE) $(ILLFALSECOLORFILE) $(ILLPCONDFILE) $(ILLTIFFFILE) $(ILLFALSECOLORTIFFFILE)

# grid calculations

rtcontrib: $(OCTREE) $(GRIDFILE) $(OPTFILE)
	 rtcontrib $(ILLRTRACEOPTIONS) -V -o $(RTCONTRIBILLPREFIX)_%s.dat -M $(MATLIST) $(OCTREE) < $(GRIDFILE)

$(ILLOUTGRIDFILE): $(OCTREE) $(GRIDFILE) $(OPTFILE)
	rtrace $(ILLRTRACEOPTIONS) $(OCTREE) < $(GRIDFILE) | rcalc -e '$$1=179*($$1*.265+$$2*.670+$$3*.065)' > $(ILLOUTGRIDFILE)

$(DFOUTGRIDFILE): $(OCTREE) $(GRIDFILE) $(OPTFILE)
	rtrace $(ILLRTRACEOPTIONS) $(OCTREE) < $(GRIDFILE) | rcalc -e '$$1=179*($$1*.265+$$2*.670+$$3*.065)/10000*100' > $(DFOUTGRIDFILE)

$(ILLVTKOUTGRIDFILE): $(ILLOUTGRIDFILE) $(GRIDILLFMTFILE) $(VTKGRIDFILE) $(GRIDFILE)
	cp $(VTKGRIDFILE) $(ILLVTKOUTGRIDFILE)
	wc -l $(GRIDFILE) | rcalc -o $(GRIDILLFMTFILE) -e 'n=$$1' >> $(ILLVTKOUTGRIDFILE)
	cat $(ILLOUTGRIDFILE) >> $(ILLVTKOUTGRIDFILE)

$(DFVTKOUTGRIDFILE): $(DFOUTGRIDFILE) $(GRIDDFFMTFILE) $(VTKGRIDFILE) $(GRIDFILE)
	cp $(VTKGRIDFILE) $(DFVTKOUTGRIDFILE)
	wc -l $(GRIDFILE) | rcalc -o $(GRIDDFFMTFILE) -e 'n=$$1' >> $(DFVTKOUTGRIDFILE)
	cat $(DFOUTGRIDFILE) >> $(DFVTKOUTGRIDFILE)

$(GRIDDFFMTFILE):
	echo -e "\nPOINT_DATA \$${   n  }\nSCALARS DF float\nLOOKUP_TABLE default\n" > $(GRIDDFFMTFILE)

$(GRIDILLFMTFILE):
	echo -e "\nPOINT_DATA \$${   n  }\nSCALARS Illuminance float\nLOOKUP_TABLE default\n" > $(GRIDILLFMTFILE)


# picture calculations

$(LUMPICFILE): $(OCTREE) $(VIEWFILE) $(SKYFILE) $(MATFILE) $(RADFILE) $(RPICTOPTIONFILE)
	cd $(WORKPATH)
	rpict -t 10 -vf $(VIEWFILE) $(RPICTOPTIONS) -ro $(LUMUNFFILE) $(OCTREE)
	pfilt -1 -x /$(DOWNSAMPLE) -y /$(DOWNSAMPLE) $(PFILTOPTIONS) $(LUMUNFFILE) > $(LUMPICFILE)

$(LUMFALSECOLORFILE): $(LUMPICFILE)
	$(FALSECOLORPROGRAM) -ip $(LUMPICFILE) $(LUMFALSECOLOROPTIONS) > $(LUMFALSECOLORFILE)

$(LUMPCONDFILE): $(LUMPICFILE)
	pcond $(PCONDOPTIONS) $(LUMPICFILE) > $(LUMPCONDFILE)

$(LUMTIFFFILE): $(LUMPCONDFILE)
	ra_tiff $(RATIFFOPTIONS) $(LUMPCONDFILE) $(LUMTIFFFILE)

$(LUMFALSECOLORTIFFFILE): $(LUMFALSECOLORFILE)
	ra_tiff $(RATIFFOPTIONS) $(LUMFALSECOLORFILE) $(LUMFALSECOLORTIFFFILE)

$(ILLPICFILE): $(OCTREE) $(VIEWFILE) $(SKYFILE) $(MATFILE) $(RADFILE) $(RPICTOPTIONFILE)
	cd $(WORKPATH)
	rpict -w -t 10 -vf $(VIEWFILE) $(RPICTOPTIONS) -ro $(ILLUNFFILE) -i+ $(OCTREE)
	pfilt -1 -x /$(DOWNSAMPLE) -y /$(DOWNSAMPLE) $(PFILTOPTIONS) $(ILLUNFFILE) > $(ILLPICFILE)

$(ILLFALSECOLORFILE): $(ILLPICFILE)
	$(FALSECOLORPROGRAM) -ip $(ILLPICFILE) $(ILLFALSECOLOROPTIONS) > $(ILLFALSECOLORFILE)

$(ILLPCONDFILE): $(ILLPICFILE)
	pcond $(PCONDOPTIONS) $(ILLPICFILE) > $(ILLPCONDFILE)

$(ILLTIFFFILE): $(ILLPCONDFILE)
	ra_tiff $(RATIFFOPTIONS) $(ILLPCONDFILE) $(ILLTIFFFILE)

$(ILLFALSECOLORTIFFFILE): $(ILLFALSECOLORFILE)
	ra_tiff $(RATIFFOPTIONS) $(ILLFALSECOLORFILE) $(ILLFALSECOLORTIFFFILE)
	
$(LUMPMAPPICFILE): $(PMAPGPMFILE) $(PMAPCPMFILE) $(OCTREE)
	cd $(WORKPATH)
	rpict -w -t 5 -vf $(VIEWFILE) $(PMAPOPTIONS) -ap $(PMAPGPMFILE) 1000 -ap $(PMAPCPMFILE) 10000 -ro $(LUMPMAPUNFFILE) $(OCTREE) 
	pfilt -1 -x /$(DOWNSAMPLE) -y /$(DOWNSAMPLE) $(PFILTOPTIONS) $(LUMPMAPUNFFILE) > $(LUMPMAPPICFILE)

$(ILLPMAPPICFILE): $(PMAPGPMFILE) $(PMAPCPMFILE) $(OCTREE)
	cd $(WORKPATH)
	rpict -i -t 5 -vf $(VIEWFILE) $(PMAPOPTIONS) -ap $(PMAPGPMFILE) 1000 -ap $(PMAPCPMFILE) 10000 -ro $(ILLPMAPUNFFILE) $(OCTREE)
	pfilt -1 -x /$(DOWNSAMPLE) -y /$(DOWNSAMPLE) $(PFILTOPTIONS) $(ILLPMAPUNFFILE) > $(ILLPMAPPICFILE)

$(PMAPGPMFILE) $(PMAPCPMFILE) : $(OCTREE)
	cd $(WORKPATH)
	mkpmap -apg $(PMAPGPMFILE) $(GLOBALPMAP) -apc $(PMAPCPMFILE) $(CAUSTICSPMAP) -t 5 -n $(NPROC) $(OCTREE)

$(SECTPICFILE): $(OCTREE) $(VIEWDIR)/section.vf $(SKYFILE) $(MATFILE) $(RADFILE) $(OCTDIR)/section.oct
	cd $(WORKPATH)
	vwrays -fd -vf $(VIEWDIR)/section.vf -x 2000 -y 2000 | rtrace -w -h -fd -opd $(OCTDIR)/section.oct \
	| rtrace $(RTRACEOPTIONS) -fdc `vwrays -d -vf $(VIEWDIR)/section.vf -x 2000 -y 2000` \
	$(OCTREE) > $(SECTUNFFILE)
	pfilt -1 -x /$(DOWNSAMPLE) -y /$(DOWNSAMPLE) $(SECTUNFFILE) > $(SECTPICFILE)
	
$(OCTREE): $(MATFILE) $(RADFILE) $(SKYFILE)
	cd $(WORKPATH)
	oconv -w $(SKYFILE) $(MATFILE) $(RADFILE) > $(OCTREE)

$(SYNCFILE).ill:
	cd $(WORKPATH)
	echo $(RPIECEDIVISIONS) > $(SYNCFILE).ill

$(SYNCFILE).lum:
	cd $(WORKPATH)
	echo $(RPIECEDIVISIONS) > $(SYNCFILE).lum

lumrpiece: $(OCTREE) $(VIEWFILE) $(SKYFILE) $(MATFILE) $(RADFILE) $(SYNCFILE).lum $(OPTFILE)
	cd $(WORKPATH)
	rpiece -v -t 10 -F $(SYNCFILE).lum -vf $(VIEWFILE) $(RPICTOPTIONS) -o $(LUMUNFFILE) $(OCTREE)

lumrpiecefix: $(OCTREE) $(VIEWFILE) $(SKYFILE) $(MATFILE) $(RADFILE) $(SYNCFILE).lum $(OPTFILE)
	cd $(WORKPATH)
	rpiece -v -t 10 -R $(SYNCFILE).lum -vf $(VIEWFILE) $(RPICTOPTIONS) -o $(LUMUNFFILE) $(OCTREE)
      
illrpiece: $(OCTREE) $(VIEWFILE) $(SKYFILE) $(MATFILE) $(RADFILE) $(SYNCFILE).ill $(OPTFILE)
	cd $(WORKPATH)
	rpiece -v -t 10 -F $(SYNCFILE).ill -vf $(VIEWFILE) $(RPICTOPTIONS) -i+ -o $(ILLUNFFILE) $(OCTREE)

illrpiecefix: $(OCTREE) $(VIEWFILE) $(SKYFILE) $(MATFILE) $(RADFILE) $(SYNCFILE).ill $(OPTFILE)
	cd $(WORKPATH)
	rpiece -v -t 10 -R $(SYNCFILE).ill -vf $(VIEWFILE) $(RPICTOPTIONS) -i+ -o $(ILLUNFFILE) $(OCTREE)

$(RADDIR):
	cd $(WORKPATH)
	mkdir $(RADDIR)

$(OCTDIR):
	cd $(WORKPATH)
	mkdir $(OCTDIR)

$(VIEWDIR):
	cd $(WORKPATH)
	mkdir $(VIEWDIR)

$(SKYDIR):
	cd $(WORKPATH)
	mkdir $(SKYDIR)

$(MATDIR):
	cd $(WORKPATH)
	mkdir $(MATDIR)

$(MATFILE): $(MATDIR)
	cd $(WORKPATH)/$(MATDIR)
	touch $(MATFILE)

$(PICDIR):
	mkdir $(PICDIR)

$(RTMDIR):
	cd $(WORKPATH)
	mkdir $(RTMDIR)

$(OBJDIR):
	cd $(WORKPATH)
	mkdir $(OBJDIR)

$(AMBDIR):
	cd $(WORKPATH)
	mkdir $(AMBDIR)

$(TMPDIR):
	cd $(WORKPATH)
	mkdir $(TMPDIR)

$(GRIDDIR):
	cd $(WORKPATH)
	mkdir $(GRIDDIR)

$(SYNCDIR):
	cd $(WORKPATH)
	mkdir $(SYNCDIR)

$(OPTDIR):
	cd $(WORKPATH)
	mkdir $(OPTDIR)




#RPICTOPTIONS=-x 2000 -y 2000 -ab 2 -ad 1024 -as 512 -aa .1 -ar 256 -af $(SKYNAME).amb -ps 1 -u # for nosun
#RPICTOPTIONS=-x 2000 -y 2000 -ab 0 -ps 1 -u # for sun
