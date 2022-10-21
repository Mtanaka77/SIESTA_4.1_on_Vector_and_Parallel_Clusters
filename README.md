Ab-initio SIESTA-4.1 Molecular Dynamics

  Ab initio SIESTA simulation code is implemented for electronic structure calculations and ab initio 
molecular dynamics simulations of molecules and solids by the spanish group, https://departments.icmab.es/ 
(Ref. 1, 2). It is compiled for MPI parallel environment. 
It is compiled for Intel's vector-parallel compiler, where the points of arch.make in CC, FC and LIBS 
are shown in PDF here. But, it is needed to go through more steps due to complexity.

  We can successfully compile the gfortran siesta-4.1-b4 with mpi-3.2, scalapack 2.0, and OpenBLAS-0.3.13 for 
the parallel version. The file named siesta-4.1-b4gcc.tar.gz is unzipped, do "sh ../Src/obj_setup.sh", 
and copy "arch.make" to "Obj". These three packages above must be installed to your system bofore "make"
is executed. The are three cases available in Obj1-MPI, Obj3-OMP, and Obj5-OMP-MPI, so you should test 
which one is most efficient in your run. 

For NEC's Intel vector-parallel version, however, one has the specified MPI and Scalapack packages 
and needs to go through more steps. The modified changes are summarized in "Annual Report (2021)" of
this page; the important lines to note are shown in English, so you may not miss the points. 
The files are already modified in "arch.make" and the file siesta-4.1-b4-LX.tar.gz is unzipped
and the make step is executed (Ref. 3).

References:

1. J. Phys. Cond. Matt. 14, 2745 (2002).
2. Chem. Phys. 152, 204108 (2020). 
3. Annual Report of National Institute for Fusion Science, R03/275 (2021) *). 
* [important points and figures in English, mostly in Japanese]
