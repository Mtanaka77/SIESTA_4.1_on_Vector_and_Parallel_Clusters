# 
# Copyright (C) 1996-2016	The SIESTA group
#  This file is distributed under the terms of the
#  GNU General Public License: see COPYING in the top directory
#  or http://www.gnu.org/copyleft/gpl.txt.
# See Docs/Contributors.txt for a list of contributors.
#
#-------------------------------------------------------------------
# arch.make file for NEC's fortran compiler, CC, FC and LIBS.
# To use this arch.make file you should rename it to
#   arch.make
# or make a sym-link.
# For an explanation of the flags see DOCUMENTED-TEMPLATE.make
# Important for a make step, "module load intel-lx" is necessary.

.SUFFIXES:
.SUFFIXES: .f .F .o .c .a .f90 .F90

SIESTA_ARCH= x86_64-MPI-para7

CC= mpiicc -O2 -qopenmp
FPP= $(FC) -E -P -x c

# 32-bit integer, Scalapack, openmp
# https://www.hpc.nec/documents/sdk/SDK_NLC/UsersGuide/main/ja/f_linking.html
FC= mpiifort

MPI_INTERFACE = libmpi_f90.a
MPI_INCLUDE = .
FC_SERIAL= ifort

FFLAGS = -O2 -fPIC -qopenmp

AR = ar
RANLIB = ranlib
SYS = nag

SP_KIND = 4
DP_KIND = 8
KINDS = $(SP_KIND) $(DP_KIND)

LDFLAGS = 
INCFLAGS =
COMP_LIBS =

FPPFLAGS = $(DEFS_PREFIX)-DFC_HAVE_ABORT
FPPFLAGS += -DMPI

# Link: MPI
LIBS =  -L${MKLROOT}/lib/intel64 -lmkl_scalapack_lp64 -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lmkl_blacs_intelmpi_lp64 -mkl -qopenmp -lpthread -lm -ldl
# -lmkl_sequential ?

# Dependency rules ---------
FFLAGS_DEBUG = -g -O1  # your appropriate flags here...

# The atom.f code is very vulnerable. Particularly the Intel compiler
# will make an erroneous compilation of atom.f with high optimization
# levels.
atom.o: atom.F
	$(FC_SERIAL) -c $(FFLAGS_DEBUG) $(INCFLAGS) $(FPPFLAGS) $(FPPFLAGS_fixed_F) $< 

.c.o:
	$(CC) -c $(CFLAGS) $(INCFLAGS) $(CPPFLAGS) $< 
.F.o:
	$(FC) -c $(FFLAGS) $(INCFLAGS) $(FPPFLAGS) $(FPPFLAGS_fixed_F)  $< 
.F90.o:
	$(FC) -c $(FFLAGS) $(INCFLAGS) $(FPPFLAGS) $(FPPFLAGS_free_F90) $< 
.f.o:
	$(FC) -c $(FFLAGS) $(INCFLAGS) $(FCFLAGS_fixed_f)  $<
.f90.o:
	$(FC) -c $(FFLAGS) $(INCFLAGS) $(FCFLAGS_free_f90)  $<

