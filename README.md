## Ab-initio SIESTA-4.1b Molecular Dynamics on Parallel or/and Vector Machines ##

As "Open Internet Access by Molecular Dynamics Simulations", a couple of various codes are shown in https://github.com/Mtanaka77/, which are "Relativistic and Electromagnetic Molecular Dynamics Simulation for Nanoscale Phenomena", "Large-scale Electromagnetic Particle-in-Cell Simulation", and "SIESTA on Vector-Parallel Clusters". This page is discussed on the vector-parallel SIESTA code. Please visit other companion pages other than this "SIESTA on Vector-Parallel Clusters".


"Ab initio SIESTA simulation code" is implemented for electronic structure calculations and ab-initio molecular dynamics simulations of molecules and solids by the spanish authors, in https://departments.icmab.es/ (Ref. 1, 2). It is compiled by the gfortran compiler and for MPI parallel environments. It is also compiled by Intel's vector-and-parallel compiler, where the points of arch.make in CC, FC and LIBS are shown here in our PDF file. More things have to be modified and added due to vectorized complexity.

### Generic Parallel SIESTA Code ###

We can compile the siesta-4.1-b4 directory by gfortran for the parallel version with mpich, ScaLapack, and OpenBLAS. The file named "siesta-4.1-b4gcc.tar.gz" is unzipped, do "sh ../Src/obj_setup.sh", and copy "arch.make" of "arch.make-2" (1) or (2) script to your machine. The three packages including mpich above must be installed to your system bofore the "make" steps of SIESTA are executed.

The zipped files of mpi-4.0.2, scalapack-2.2.0, and OpenBLAS-0.3.21 (now in winter, 2022) are downloaded at the internet sites. If they are not yet installed in your system, unzip and "make", and "make install" separately for MPI, ScaLapack and OpenBLAS directories. 
To compile the MPICH, one may use the configure script: "./configure --prefix=/opt/mpich-4.0.2" and go to the "make" step. In the ScaLapack, "SLmake.inc" in that directory may be changed to your PC environments. In the OpenBLAS, "Makefile.rule" may be configured manually before the make step. 

After the installation step, one should test which choice of MPI or OMP is most efficient in the gfortran run. It is very important that generic gfortran compiler must be used throughout the configure and make steps. The PGI fortran does not compile the SIESTA code properly. 


### Special Vector-Parallel SIESTA Code ###

For the Intel vector-parallel compiler supplied by NEC, however, it has the specified MPI and Scalapack packages, but one needs to rewrite more steps due to exact fortran coding. The arch.make script is shown as (3) of "arch.make-2", and the modified changes are summarized in "Annual Report (2021)" (PDF) of this page. The necessary changes and figures as well are shown in Japanese/English, so you may not miss the points. The files are already corrected in "arch.make" and siesta-4.1-b4-LX.tar.gz. It is unzipped, does the shell script, and the "make" step is executed in ~/siesta-4.1-b4-LX/Obj (Ref. 3). The run of CH4 molecules is tested with the vector/parallel computer of 48 cores in the directory ~/siesta-4.1-b4-LX/Examples/C96H384-MD35 (figures in Ref. 3).


### Execution Scripts ###
 
MPI and ScaLapack by gfortran; configure, make, and make install (packages are in winter 2022). 
Not compatible with the PGI fortran.

>mpich-4.0.2: ./configure --prefix=/opt/mpich-4.0.2 2>&1 | tee conf.txt

>OpenBLAS-0.3.21: in Makefile.rule, VERSION= 0.3.21  LIBNAMESUFFIX= omp ...

>ScaLapack-2.2.0: in SLmake.inc, CDEFS= -DAdd_  FC= mpifort  CC= mpicc ...

For an example: 

>#!/bin/bash; mpiexec -n 6 ~/siesta-4.1-b4gcc/Obj/siesta c12h48.fdf > c12h48.out &; exit 0

### References: ###

1. J. M. Soler et al., J. Phys. Cond. Matt. 14, 2745 (2002).
2. A. García et al., Chem. Phys. 152, 204108 (2020).
3. M. Tanaka and Y. Zempo, Annual Report of National Institute for Fusion Science, R03/275 (2021) *).

[Important points and figures are written in English, otherwise in Japanese]


