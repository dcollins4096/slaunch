#!/bin/tcsh
#----------------------------------------------------
# Example SLURM job script to run multiple mpi
# applications within one batch job on TACC's
# Stampede system.
#----------------------------------------------------
#SBATCH -J plot_tar_job     # Job name
#SBATCH -o plot_tar_job.o%j # Name of stdout output file(%j expands to jobId)
#SBATCH -e plot_tar_job.o%j # Name of stdout output file(%j expands to jobId)
#SBATCH -p shared          # Submit to the 'normal' or 'development' queue
#SBATCH -t 24:00:00             # Run time (hh:m) - 1.5 hours
#SBATCH -N 1                    # Total number of nodes requested (16 cores/node)
#SBATCH -n 1                   # Total number of mpi tasks requested
#SBATCH -A phy240036
#SBATCH --array=1-2

set tarscript = $HOME/repos/slaunch/tarme
set plotscript = $HOME/repos/slaunch/plotme
if ( $SLURM_ARRAY_TASK_ID == 1 ) then
    srun -n 1 --exclusive $tarscript 
else if ( $SLURM_ARRAY_TASK_ID == 2 ) then
    srun -n 1 --exclusive $plotscript
endif


