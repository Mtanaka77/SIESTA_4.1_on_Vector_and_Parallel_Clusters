SIESTA_on_PC

  The SIESTA code is implemented for electronic structure calculations and ab initio molecular dynamics 
simulations of molecules and solids by spanish group https://departments.icmab.es/. It is usually compiled  
for parallel MPI environment, but also is done for Intel's vectorized compiler. We would like to show
how the siesta-4.1 code is compiled.

  We can successfully compile the siesta-4.1-b4 with mpi-3.2, scalapack 2.0, and OpenBLAS-0.3.13 for 
the parallel version. For NEC's Intel vector compiler, however, one has the specified Scalapack routine and 
need to go through more steps.
