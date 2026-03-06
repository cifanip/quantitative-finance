# Makefile
EXE = HM_solver

COMPILER = mpifort

########################## 	standard
STD_FLAGS = -std=f2018

########################## 	multi-threading
MT_FLAG = -fopenmp

########################## 	libraries
LIBS_FLAGS  = # add libs if needed
LIBS = $(LIBS_FLAGS)

########################## 	look for source files
SOURCE=src

########################## 	place obj files
OBJDIR=OBJECTS
MKDIR_OBJ := $(shell mkdir -p $(OBJDIR))
OBJDIR_FLAG = -J $(OBJDIR)

##########################  compiler options
#debug
FLAGS = -g -fcheck=all -fbacktrace -C $(MT_FLAG) $(STD_FLAGS) $(OBJDIR_FLAG)

#optimal
#FLAGS = -O3 -fbacktrace $(MT_FLAG) $(STD_FLAGS) $(OBJDIR_FLAG)

#--------------------------compile
include makefile_source

clean : 
	rm -rf $(EXE) $(OBJDIR)
