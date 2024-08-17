#!/usr/bin/env zsh

#SBATCH -q debug
#SBATCH -A ast146
#SBATCH -J amg
#SBATCH -o 1node_%x-%j.out
#SBATCH -t 00:05:00
#SBATCH -p batch
#SBATCH -q debug
#SBATCH --ntasks-per-node=8
#SBATCH --cpus-per-task=7
#SBATCH --gpus-per-task=1
#SBATCH --gpu-bind=closest
#SBATCH -N 1

# load cray libs and ROCm libs
export LD_LIBRARY_PATH=${CRAY_LD_LIBRARY_PATH}:${LD_LIBRARY_PATH}

#export FI_MR_CACHE_MAX_COUNT=0  # libfabric disable caching
#export FI_MR_CACHE_MONITOR=memhooks  # alternative cache monitor

# OLCFDEV-1597: OFI Poll Failed UNDELIVERABLE Errors
#export MPICH_SMP_SINGLE_COPY_MODE=NONE
#export FI_CXI_RX_MATCH_MODE=software

# enable GPU-aware MPI
export MPICH_GPU_SUPPORT_ENABLED=1

srun ./amg -problem 1 -n 128 128 128 -P 2 2 2
