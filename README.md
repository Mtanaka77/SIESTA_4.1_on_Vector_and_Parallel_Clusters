SIESTA_on_PC

  Ab initio SIESTA simulation code is implemented for electronic structure calculations and ab initio 
molecular dynamics simulations of molecules and solids by the spanish group, https://departments.icmab.es/ 
(Ref. 1, 2). It is compiled for MPI parallel environment. 
It is compiled for Intel's vector-parallel compiler, but it is needed to go through more steps 
due to complexity.

  We can successfully compile the siesta-4.1-b4 with mpi-3.2, scalapack 2.0, and OpenBLAS-0.3.13 for 
the parallel version. The file is named siesta-4.1-b4gcc.tar.gz and these three packages must be 
installed to your system.
For the NEC's Intel vector-parallel case, however, one has the specified Scalapack package 
and needs to go through more steps. It is already modified in arch.make and the file 
siesta-4.1-b4-LX.tar.gz (Ref. 3).

References:

1. J. Phys. Cond. Matt. 14, 2745 (2002).
2. Chem. Phys. 152, 204108 (2020). 
3. Annual Report of National Institute for Fusion Science, Japan, R03/275 (2021)
