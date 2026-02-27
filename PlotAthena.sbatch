#!/bin/tcsh
#----------------------------------------------------
# Example SLURM job script to run multiple mpi
# applications within one batch job on TACC's
# Stampede system.
#----------------------------------------------------
#SBATCH -J plot_job     # Job name
#SBATCH -o plot_job.o%j # Name of stdout output file(%j expands to jobId)
#SBATCH -e plot_job.o%j # Name of stdout output file(%j expands to jobId)
#SBATCH -p wholenode          # Submit to the 'normal' or 'development' queue
#SBATCH -t 24:00:00             # Run time (hh:m) - 1.5 hours
#SBATCH -N 1                    # Total number of nodes requested (16 cores/node)
#SBATCH -n 1                   # Total number of mpi tasks requested
#SBATCH -A phy240036

set plotscript = $HOME/repos/slaunch/plot_athena
srun -n 1  $plotscript


