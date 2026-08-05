#!/bin/bash
#SBATCH --account=b234-llus-ag
#SBATCH --time=24:00:00
#SBATCH --job-name=llus_test
#SBATCH --output=llus_test-%J.out
#SBATCH --ntasks=1    # number of MPI processes
#SBATCH --mem=32G      # memory; default unit is megabytes
#SBATCH --cpus-per-task=8
#SBATCH --mail-user=rosolowsky@ualberta.ca
#SBATCH --mail-type=ALL

# Edit these lines to point to correct directory and galaxy name

export code_dir='/idia/projects/llus/test/code/'
export target='ic5332'

# Edit to do correct stage string
# S = staging
# I = imaging
# A = assemble
# P = postprocess
# D = derived
export stagestring='S'

#### you shouldn't need to edit below this line
srun bash
module load casa/6.6.4
module load python/3.12.9
pip install spectral-cube
cd ${code_dir}/phangs_imaging_scripts/
pip install -e '.[casa]'
cd $SLURM_SUBMIT_DIR

if [ -z ${SLURM_ARRAY_TASK_ID+x} ]; then export SLURM_ARRAY_TASK_ID=-1; else echo "Job array ID is set to '$SLURM_ARRAY_TASK_ID'"; fi
python ${code_dir}/meerkat_imaging_processing/run_llus_image.py $target $stagestring $SLURM_ARRAY_TASK_ID
