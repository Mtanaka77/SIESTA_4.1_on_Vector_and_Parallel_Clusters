# 
# Copyright (C) 1996-2016	The SIESTA group
#  This file is distributed under the terms of the
#  GNU General Public License: see COPYING in the top directory
#  or http://www.gnu.org/copyleft/gpl.txt.
# See Docs/Contributors.txt for a list of contributors.
#
#-------------------------------------------------------------------
# arch.make file for gfortran compiler.
# To use this arch.make file you should rename it to
#   arch.make
# or make a sym-link.
# For an explanation of the flags see DOCUMENTED-TEMPLATE.make

.SUFFIXES:
.SUFFIXES: .f .F .o .c .a .f90 .F90

SIESTA_ARCH = gfortran-OMP-MPI

CC = mpicc   #gcc
FPP = $(FC) -E -P -x c
FC = mpifort #gfortran 

MPI_INTERFACE = libmpi_f90.a
MPI_INCLUDE = . 

FFLAGS = -O2 -fexpensive-optimizations -ftree-vectorize -fprefetch-loop-arrays -march=native -fPIC -fopenmp
FC_SERIAL = gfortran

AR = ar
RANLIB = ranlib
SYS = nag

SP_KIND = 4
DP_KIND = 8
KINDS = $(SP_KIND) $(DP_KIND)

LDFLAGS = 
INCFLAGS =
INSDIR = /opt
FPPFLAGS += -DMPI

COMP_LIBS =     #libsiestaLAPACK.a libsiestaBLAS.a

LDFLAGS += -L$(INSDIR)/openblas/lib -Wl,-rpath=$(INSDIR)/openblas/lib
LIBS = -lgomp -lopenblas_omp_steamrollerp-r0.3.13

LIBS += -L/opt/scalapack/lib -lscalapack

FPPFLAGS = $(DEFS_PREFIX)-DFC_HAVE_ABORT

# Dependency rules ---------
FFLAGS_DEBUG = -g -O1

# The atom.F code is very vulnerable. Particularly the Intel compiler
# will make an erroneous compilation of atom.f with high optimization
# levels. atom.F and electrostatic.f must be compiled by -O1
atom.o: atom.F
	$(FC) -c $(FFLAGS_DEBUG) $(INCFLAGS) $(FPPFLAGS) $(FPPFLAGS_fixed_F) $< 

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

