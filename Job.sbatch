#!/bin/tcsh
#----------------------------------------------------
# Example SLURM job script to run multiple mpi
# applications within one batch job on SLURM
#
# Look up a SLURM user guide for the options here.
#----------------------------------------------------
#SBATCH -J AEa02T     # Job name
#SBATCH -o AEa02T.o%j # Name of stdout output file(%j expands to jobId)
#SBATCH -e AEa02T.o%j # Name of stderr output file(%j expands to jobId)
#SBATCH -p shared          # look up the queue structuer
#SBATCH -t 00:05:00             # Run time (hh:m) - 1.5 hours
#SBATCH -N 1                    # Total number of nodes requested (16 cores/node)
#SBATCH -n 64                   # Total number of mpi tasks requested
#SBATCH -A phy240036
#SBATCH --mail-user=YOUR_EMAIL
#SBATCH --mail-type=end    # email me when the job finishes

#It's useful to see everything, just in case something goes wrong.
set echo
env

set MAIN = a02.enzo

#
# NOGO only gets written after Enzo finishes, either successfully or unsuccessfully.
# In either event, don't restart.
#
if ( -e NOGO ) then
    echo "TOLD TO NOT GO"
    echo "Enzo either crashed or ran successfully. Check it out, remove NOGO"
    exit -1
endif

#
# If there's an output log, restart
#
if ( -e OutputLog ) then
    module load openmpi
    set restart = `awk '{print $3}' OutputLog |tail -1`
    mpirun ./enzo.exe -d -r $restart
else
    mpirun ./enzo.exe -d $MAIN
endif

#The code should continue running until it times out, so it shouldn't get here
#unless it finished or failed.
touch NOGO
