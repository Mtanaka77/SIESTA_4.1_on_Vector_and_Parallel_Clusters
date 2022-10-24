## Ab-initio SIESTA-4.1b Molecular Dynamics ##

Ab initio SIESTA simulation code is implemented for electronic structure calculations and ab initio molecular dynamics simulations of molecules and solids by the spanish group, https://departments.icmab.es/ (Ref. 1, 2). It is compiled by gfortran and for MPI parallel environments. It is also compiled by Intel's vector-and-parallel compiler, where the points of arch.make in CC, FC and LIBS are written in PDF here. But, it needs to go through more steps due to complexity.

We can successfully compile the gfortran siesta-4.1-b4 with mpi-3.2, scalapack 2.0, and OpenBLAS-0.3.13 for the parallel version. The file named siesta-4.1-b4gcc.tar.gz is unzipped, do "sh ../Src/obj_setup.sh", and copy "arch.make" of "arch.make-2" (1) or (2) to "Obj". The three packages including mpi-3.2 above must be installed to the PC system bofore the "make" steps are executed.

The zipped files of mpi-3.2, scalapack 2.0, and OpenBLAS-0.3.13 are downloaded at the internet sites. If they are not yet installed, unzip, then "make" and "make install" for MPI, Scalapack and OpenBLAS directories separately. In MPI, one does the configure step: "env CC=gcc FC=/opt/mpich-3.2/bin/mpifort F77=gfortran CXX=gcpp CFLAGS=-O2 FCFLAGS=-O2 FFLAGS=-O2 CXXFLAGS=-O2 ./configure --prefix=/opt/mpich-3.2 --disable-cxx & conf.log" and the "make" steps. In Scalapack, "SLmake.inc" is changed as one wishes. In OpenBLAS, "Makefile.rule" may be configured manually before the make steps. It is very important that generic gfortran compiler must be used throughout the configure and make steps. The PGI fortran is not successfully committed for the SIESTA code. After the installation, the file "arch.make-2" in this directory has a template for "arch.make" of MPI or OMP. You should test which one is most efficient in the gfortran run.

For NEC's Intel vector-parallel compiler, however, one has the specified MPI and Scalapack packages and needs to rewrite more steps. The arch.make script is shown as (3) of "arch.make-2", and the modified changes are summarized in "Annual Report (2021)" of this page. The important and necessary changes and figures are shown there in English, so you may not miss the points. The files are already corrected in "arch.make" and siesta-4.1-b4-LX.tar.gz. It is unzipped and does the shell script, and the "make" step is executed for ~/siesta-4.1-b4-LX/Obj (Ref. 3).
The run of CH4 molecules is tested in the directory ~/siesta-4.1-b4-LX/Examples/C96H384-MD35.

References:

1. J. Phys. Cond. Matt. 14, 2745 (2002).
2. Chem. Phys. 152, 204108 (2020).
3. Annual Report of National Institute for Fusion Science, R03/275 (2021) *).

   [important points and figures in English, mostly in Japanese]


