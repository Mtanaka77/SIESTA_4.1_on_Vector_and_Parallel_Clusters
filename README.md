## Ab-initio SIESTA-4.1b Molecular Dynamics on Parallel or/and Vector Machines ##

As "Open Internet Access by Molecular Dynamics Simulations", a couple of various codes 
are shown. This page is concerned with the parallel and vector-parallel SIESTA codes,
especially on the vector-parallel code which is listed as siesta-4.1b-LX.tar.gz in the reference. 

### Generic Parallel SIESTA Code ###

"Ab initio SIESTA simulation code" is implemented for electronic structure calculations and ab-initio molecular dynamics simulations of molecules and solids by the spanish authors, in https://departments.icmab.es/ (Ref. 1, 2). It is compiled by the gfortran compiler and for MPI parallel environments. It is also compiled by Intel's vector-and-parallel compiler, where the points of arch.make in CC, FC and LIBS are shown here in our PDF file. More things have to be modified and added due to vectorized complexity.

We can compile the siesta-4.1-b4 directory by gfortran for the parallel version with mpich, ScaLapack, and OpenBLAS. The file named "siesta-4.1-b4gcc.tar.gz" is unzipped, do "sh ../Src/obj_setup.sh", and copy "arch.make" of "arch.make-2" (1) or (2) script to your machine. The three packages including mpich above must be installed to your system bofore the "make" steps of SIESTA are executed.

The zipped files of mpi-4.0.2, scalapack-2.2.0, and OpenBLAS-0.3.21 (now in winter, 2022) are downloaded at the internet sites. If they are not yet installed in your system, unzip and "make", and "make install" separately for MPI, ScaLapack and OpenBLAS directories. 
To compile the MPICH, one may use the configure script: "./configure --prefix=/opt/mpich-4.0.2" and go to the "make" step. In the ScaLapack, "SLmake.inc" in that directory may be changed to your PC environments. In the OpenBLAS, "Makefile.rule" may be configured manually before the make step. 

After the installation step, one should test which choice of MPI or OMP is most efficient in the gfortran run. It is very important that generic gfortran compiler must be used throughout the configure and make steps. The PGI fortran does not compile the SIESTA code properly. Remember that the usual cell size in simulations might be 300 Ry = 33 Ang in three dimensions.


### Special Vector-Parallel SIESTA Code ###

For the Intel's vector and parallel compiler supplied by NEC machines, it uses the MPI and Scalapack packages. But, it needs to rewrite the code on more steps due to NEC's exact fortran coding. The arch.make script is shown as (3) of "arch.make-2", and the modified changes are summarized in "Annual Report of Tanaka and Zempo (2022)" (PDF) of this page. All the changes and figures are shown in English, so you may not miss the points. 

The files are already and strictly corrected to using siesta-4.1-b4-LX.tar.gz and "arch.make". 
It is unzipped, does the shell script, and the "make" step is executed in ~/siesta-4.1-b4-LX/Obj (Ref. 3). 

The run of CH4 molecules is executed with the vector-parallel computer of 48 cores (so named 1 job)
in the directory ~/siesta-4.1-b4-LX/Examples/C96H384-MD35 (figures in Ref. 3). 
The number of 96 carbons is just devided by 2 carbons per core.
Also, the 96 cores using 2 job in parallel or the 192 cores using 4 job in parallel is possible 
by two or four nodes. 

### Points to Make the Vector-Parallel Siesta Code ###

First, we download the SIESTA-4.1b code by internet. On our Linux, we do 'tar -xfzv siesta-4.1-b4.tar.gz'. 
Under the NEC's compiler, we invoke the 'module load intel-lx' directory, and do 'sh ../Src/obj_setup.sh' 
for the Obj directory of SIESTA. The siesta-4.1b's MPICH+OMP script should be, 

  >CC= mpiicc -O2 -qopenmp  
  
  >FPP= $(FC) -E -P -x c
  
  >FC= mpiifort
  
  >MPI_INTERFACE = libmpi_f90.a 
  
  >MPI_INCLUDE = .
  
  >FC_SERIAL= ifort
  
  >FFLAGS = -O2 -fPIC -qopenmp
  
  >LIBS =  -L${MKLROOT}/lib/intel64 -lmkl_scalapack_lp64 -lmkl_intel_lp64 -lmkl_core -lmkl_blacs_intelmpi_lp64 -mkl -qopenmp -lpthread -lm -ldl

 Then, we proceed to the 'make' step, where for NEC's compiler we must add additional terms. 
For the six files including "iokp.f", "m_mixing.F90", "m_ts_contour_neq.f90", "m_ts_electype.F90",  "m_ts_weight.F90" and " ofc.f90", we change the "correct" statement of 'e13.6' from 'e12.6'. It must be written exactly ! 
The parallel code of Siesta may be loose anyway.

Next point is that we must comment out the $OMP lines of "inal_H_f_stress.F" as,

  >!!$OMP parallel default(shared)
  
  >!!$OMP workshare
  
  >H_tmp = 0.0_dp
  
  >!!$OMP end workshare nowait
  
  >!!$OMP single
  
  >!  Initialize forces and stress ...................
  
  >nullify(fal) 
  
  >call re_alloc( fal, 1, 3, 1, na_u, 'fal', 'final_H_f_stress' )
  
  >!!$OMP end single
  
  >!!$OMP workshare
  
  >fa(1:3,1:na_u) = 0.0_dp
  
  >fal(1:3,1:na_u) = 0.0_dp   
  
  >stress(1:3,1:3) = 0.0_dp   
  
  >stressl(1:3,1:3) = 0.0_dp
  
  >!!$OMP end workshare nowait
  
  >!!$OMP end parallel

The vector lines must be changed as "novector" in the "old_atmfuncs.f" file:

  >!NEC$ novector
 
  >do 5 izeta=1,nzetasave(l,nsm,is)
  
  >norb=norb+(2*l+1)
  
  >indx=indx+1
  
  >if(norb.ge.io) goto 30
 
  >5 continue

They correspond to the lines at 426, 436, 492, 502, 523, 570, 580, 605, 666, 712, 724 and 756 of "old_atmfuncs.f" file.
The file "normalize_dm.F90" undergoes an error, thus we just skips as '! call die(msg)' at the line 95. 
We compile the rest of the code. 

Finally for execution, we may write:

  >#PBS -T intmpi

  >#PBS -v NQSV_MPI_VER= 2024.2

  >module load intel-lx/$NQSV_MPI_VER

Note: The mpicc and mpifort system for the vector-parallel supercomputer may often be changed.
When you feel something strange, you should consult the administrator of the RedHat Linux/NEC compiler. 
The compiler which was installed in summer 2024 is buggy of memory leak for a large number 
of >2000 atoms and the four jobs (mpiexec -n 48..., #PBS -b 4, #PBS -v OMP_NUM_THREADS=4).
It is fixed up to 3 jobs of 48 MPI's (mpiexec -n 48..., #PBS -b 3, #PBS -v OMP_NUM_THREADS=3), 
and also 2 jobs of 96 MPI's (mpiexec -n 96..., #PBS -b 2, #PBS -v OMP_NUM_THREADS=1).
Contrarily, the parallel code of Siesta-4.1b hasn't a problem.

### Execution Scripts ###
 
MPI and ScaLapack by gfortran; configure, make, and make install (packages are in winter 2022). 
Not compatible with the PGI fortran.

>mpich-4.0.2: ./configure --prefix=/opt/mpich-4.0.2 2>&1 | tee conf.txt

>OpenBLAS-0.3.21: in Makefile.rule, VERSION= 0.3.21  LIBNAMESUFFIX= omp ...

>ScaLapack-2.2.0: in SLmake.inc, CDEFS= -DAdd_  FC= mpifort  CC= mpicc ...

>#!/bin/bash; mpiexec -n 6 ~/siesta-4.1-b4gcc/Obj/siesta <c12h48.fdf >c12h48.out &; exit 0

On NEC's supercomputer, you will do 'make' where the file 'arch.make' is: 

>CC= mpiicx -O2 -qopenmp

>FPP= $(FC) -E -P -x c

>FC= mpiifort

>MPI_INTERFACE = libmpi_f90.a

>FFLAGS = -O2 -fPIC -qopenmp

>LIBS =  -L${MKLROOT}/lib/intel64 -lmkl_scalapack_lp64 -lmkl_intel_lp64 -lmkl_core -lmkl_blacs_intelmpi_lp64 -mkl -qopenmp -lpthread -lm -ldl

with the spring 2025 version (Ref. 4). The execution with 2 jobs (i.e. 96 nodes in parallel, 
1 OpenMP threads, 96 processes) will be:

>mpirun -machinefile ${PBS_NODEFILE} -n 96 -perhost 1 ~/siesta-4.1-b4-LX/Obj/siesta <./c384h1536.fdf >c384h1536.out

It takes 67 steps in 10 hours by the LX server '2 jobs' of NIFS/NEC supercomputer.


### References: ###

1. J. M. Soler et al., J. Phys. Cond. Matt. 14, 2745 (2002).
2. A. García et al., Chem. Phys. 152, 204108 (2020).
3. M. Tanaka and Y. Zempo, Annual Report of National Institute for Fusion Science, R03/275 (2021) *).
4. M. Tanaka, Execution of Siesta-4.1b4 by Spring 2025 NIFS Supercomputer, Japan.
