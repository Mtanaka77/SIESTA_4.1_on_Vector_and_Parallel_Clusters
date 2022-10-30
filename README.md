## Ab-initio SIESTA-4.1b Molecular Dynamics on Parallel or/and Vector Machines ##

Ab initio SIESTA simulation code is implemented for electronic structure calculations and ab initio molecular dynamics simulations of molecules and solids by the spanish group, https://departments.icmab.es/ (Ref. 1, 2). It is compiled by the gfortran compiler and for MPI parallel environments. It is also compiled by Intel's vector-and-parallel compiler, where the points of arch.make in CC, FC and LIBS are written here in PDF file. But, more things have to be changed due to vectorized complexity.

### Generic Parallel Compiler ###

We can compile the siesta-4.1-b4 Obj directory by gfortran with mpich, ScaLapack, and OpenBLAS for the parallel version. The file named "siesta-4.1-b4gcc.tar.gz" is unzipped, do "sh ../Src/obj_setup.sh", and copy "arch.make" of "arch.make-2" (1) or (2) scripts. The three packages including mpich above must be installed to the PC system bofore the "make" steps of SIESTA are executed.

The zipped files of mpi-4.0.2, scalapack-2.2.0, and OpenBLAS-0.3.21 (now in 2022) are downloaded at the internet sites. If they are not yet installed in one's PC, unzip and "make", and "make install" for MPI, ScaLapack and OpenBLAS directories separately. 
In MPICH, one may use the configure script: "./configure --prefix=/opt/mpich-4.0.2" and go to the "make" steps. In ScaLapack, "SLmake.inc" in that directory is changed to one's PC environments. In OpenBLAS, "Makefile.rule" may be configured manually before the make steps. 

After the installation, one should test which choice of MPI or OMP is most efficient in the gfortran run.
It is very important that generic gfortran compiler must be used throughout the configure and make steps. The PGI fortran does not compile the SIESTA code; moreover, "fortran" points to different compilers in general cases !

### Execution Scripts ###
 
MPI and ScaLapack by gfortran; configure, make, and make install. Not compatible with PGI fortran.

>mpich-4.0.2: ./configure --prefix=/opt/mpich-4.0.2 2>&1 | tee conf.txt

>OpenBLAS-0.3.21: in Makefile.rule, VERSION= 0.3.21  LIBNAMESUFFIX= omp ...

>ScaLapack: in SLmake.inc, CDEFS= -DAdd_  FC= mpifort  CC= mpicc ...

(Old) mpich-3.2: env CC=gcc FC=/opt/mpich-3.2/bin/mpifort F77=gfortran CXX=gcpp CFLAGS=-O2 FCFLAGS=-O2 FFLAGS=-O2 CXXFLAGS=-O2 ./configure --prefix=/opt/mpich-3.2 --disable-cxx & conf.log

>#!/bin/bash

>$ mpiexec -n 6 ~/siesta-4.1-b4gcc/Obj/siesta c12h48.fdf > c12h48.out &

>exit 0


### Special Vector-Parallel Compiler ###

For NEC's Intel vector-parallel compiler, however, one has the specified MPI and Scalapack packages, and needs to rewrite more steps. The arch.make script is shown as (3) of "arch.make-2", and the modified changes are summarized in "Annual Report (2021)" (PDF) of this page. The necessary changes and figures as well are shown in Japanese/English, so you may not miss the points. The files are already corrected in "arch.make" and siesta-4.1-b4-LX.tar.gz. It is unzipped, does the shell script, and the "make" step is executed in ~/siesta-4.1-b4-LX/Obj (Ref. 3). The run of CH4 molecules is tested with 48 cores in the directory ~/siesta-4.1-b4-LX/Examples/C96H384-MD35 (figures in Ref. 3).

### References: ###

1. J. M. Soler et al., J. Phys. Cond. Matt. 14, 2745 (2002).
2. A. García et al., Chem. Phys. 152, 204108 (2020).
3. M. Tanaka and Y. Zempo, Annual Report of National Institute for Fusion Science, R03/275 (2021) *).

   [important points and figures in English, otherwise in Japanese]


