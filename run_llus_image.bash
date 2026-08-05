#!/bin/bash
#SBATCH --account=b234-llus-ag
#SBATCH --time=24:00:00
#SBATCH --job-name=llus_4945
#SBATCH --output=llus_-%J.out
#SBATCH --ntasks=1    # number of MPI processes
#SBATCH --mem=32G      # memory; default unit is megabytes
#SBATCH --cpus-per-task=8
#SBATCH --mail-user=email@email.com
#SBATCH --mail-type=ALL

# Edit these lines to point to correct directory and galaxy name
export code_dir='/users/eros/code/meerkat_processing/'
export target='ngc4945'

# Stage string 
# S = staging
# I = imaging
# A = assemble
# P = postprocess
# D = derived
export stagestring='S'

#### you shouldn't need to edit below this line
module load python/3.12.13
source /idia/projects/llus/test/venv/pipeline/bin/activate

if [ -z ${SLURM_ARRAY_TASK_ID+x} ]; then export SLURM_ARRAY_TASK_ID=-1; else echo "Job array ID is set to '$SLURM_ARRAY_TASK_ID'"; sleep $SLURM_ARRAY_TASK_ID; fi
python ${code_dir}/meerkat_imaging_processing/run_llus_image.py $target $stagestring $SLURM_ARRAY_TASK_ID
