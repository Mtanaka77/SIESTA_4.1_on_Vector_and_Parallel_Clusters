Ab-initio SIESTA-4.1 Molecular Dynamics

  Ab initio SIESTA simulation code is implemented for electronic structure calculations and ab initio 
molecular dynamics simulations of molecules and solids by the spanish group, https://departments.icmab.es/ 
(Ref. 1, 2). It is compiled for MPI parallel environments. 
It is also compiled by Intel's vector-and-parallel compiler, where the points of arch.make in CC, FC and LIBS 
are written in PDF here. But, it needs to go through more steps due to complexity.

  We can successfully compile the gfortran siesta-4.1-b4 with mpi-3.2, scalapack 2.0, and OpenBLAS-0.3.13 for 
the parallel version. The file named siesta-4.1-b4gcc.tar.gz is unzipped, do "sh ../Src/obj_setup.sh", 
and copy "arch.make" to "Obj". These three packages including mpi-3.2 above must be installed 
to the PC system bofore the "make" step is executed. 

The zipped files of mpi-3.2, scalapack 2.0, and OpenBLAS-0.3.13 are downloaded at the internet sites.
If they are not yet installed, unzip and work for MPI, Scalapack and OpenBLAS directories separately.
It is very important that generic gfortran compiler must be used throughout the configure and make steps.  
The are cases available for the "make" time; the file "arch.make-2" in this directory shows a template 
for "arch.make" of MPI or OMP. You should test which one is most efficient in the gfortran run. 

For NEC's Intel vector-parallel compiler, however, one has the specified MPI and Scalapack packages 
and needs to go through more steps. The arch.make script is shown in (3) of "arch.make-2".
The modified changes are summarized in "Annual Report (2021)" of this page; the important lines to note 
are shown in English, so you may not miss the points. 
The files are already corrected in "arch.make" and siesta-4.1-b4-LX.tar.gz.
It is unzipped and do the sh script, and the make step is executed at ~/siesta-4.1-b4-LX/Obj (Ref. 3).

References:

1. J. M. Soler et al., J. Phys. Cond. Matt. 14, 2745 (2002).
2. A. García1 et al., Chem. Phys. 152, 204108 (2020). 
3. M. Tanaka and Y. Zempo, Annual Report of National Institute for Fusion Science, R03/275 (2021) *). 
* [important points and figures in English, mostly in Japanese]
