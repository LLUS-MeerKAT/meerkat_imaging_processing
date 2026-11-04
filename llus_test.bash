#!/bin/bash
#SBATCH --account=b234-llus-ag
#SBATCH --time=24:00:00
#SBATCH --job-name=pgc31359
#SBATCH --output=pgc31359-%J.out
#SBATCH --ntasks=1    # number of MPI processes
#SBATCH --mem=32G      # memory; default unit is megabytes
#SBATCH --cpus-per-task=8
#SBATCH --mail-user=rosolowsky@ualberta.ca
#SBATCH --mail-type=ALL

# Edit these lines to point to correct directory and galaxy name
export code_dir='/idia/projects/llus/test/code/meerkat_imaging_processing/'
export target='pgc31359'

# Edit to do correct stage string
# S = staging
# I = imaging
# A = assemble
# P = postprocess
# D = derived
export stagestring='S'

#### you shouldn't need to edit below this line
srun bash
module load python/3.12.9
module load casa/6.6.4

if [ -z ${SLURM_ARRAY_TASK_ID+x} ]; then export SLURM_ARRAY_TASK_ID=-1; else echo "Job array ID is set to '$SLURM_ARRAY_TASK_ID'"; fi
casapy ${code_dir}/run_llus_image.py $target $stagestring $SLURM_ARRAY_TASK_ID
