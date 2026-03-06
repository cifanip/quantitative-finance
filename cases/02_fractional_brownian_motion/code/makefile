# Makefile
EXE = exe

#-------------------------- flags
include makefile_flags

#-------------------------- source
SOURCE=src
include makefile_source

#-------------------------- main.C
$(OBJDIR)/main.o: main.F90 \
$(OBJDIR)/basic_utils.o \
$(OBJDIR)/mpi_utils.o \
$(OBJDIR)/fbm.o
	$(COMPILER) -c $(FLAGS) $< -o $@

#-------------------------- clean
include makefile_clean