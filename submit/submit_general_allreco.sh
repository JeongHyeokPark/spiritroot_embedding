#!/bin/bash
#SPATCH --ntask=1
#SBATCH --exclude=bwmpc030,bwmpc068,bwmpc164,bwmpc170,bwmpc189,bwmpc190,bwmpc257,bwmpc234
#SBATCH --cpus-per-task=2
#SBATCH --mem=6000
#SBATCH -o "LOGDIRTOBESUB/slurm_%A.log"
#SBATCH --time=24:00:00
#SBATCH --job-name="Reco"

source /data/RB230064/common_2024/efficiency/spiritroot_mc_submit/build/config.sh
export LD_LIBRARY_PATH=/data/RB230064/common_2024/efficiency/spiritroot_mc_submit/macros/lib:$LD_LIBRARY_PATH


OUTPUT=$1
NEXTJOB=$2
CONFIGLIST=$3
MCFILE=$4
NTOTAL=$5

# Creat directory for logging 
LOGDIR=/data/RB230064/common_2024/efficiency/submit/log/${OUTPUT}
mkdir -p "${LOGDIR%/*}"

cd /tmp_work/jhpark

RUN=2384
#let NSPLIT=($NTOTAL+3*17-1)/3/17
GCData=/data/RB230064/production/calib/120fC_RUN1984-2017.root
GGData=/data/RB230064/production/ggNoise/ggNoise_2349.root
MCFile=/tmp_work/jhpark/data/${MCFILE}.digi.root
#MCFile=
SupplePath=/data/RB230064/rawdataSupplement/Exp2016/
ParameterFile=ST.parameters.PhysicsRuns_201707.par

root /data/RB230064/common_2024/efficiency/submit/macros/run_reco_experiment_auto.C\($RUN,$NTOTAL,0,$NTOTAL,\"$GCData\",\"$GGData\",\{\},\"$MCFile\",\"$SupplePath\",30,\"$ParameterFile\",\"data\/${OUTPUT}\/\",kTRUE\) -b -q -l > ${LOGDIR}_reco.log  &
#SPLIT=$((3*$SLURM_ARRAY_TASK_ID+0)); root /data/RB230064/common_2024/efficiency/submit/macros/run_reco_experiment_auto.C\($RUN,$NTOTAL,$SPLIT,$NSPLIT,\"$GCData\",\"$GGData\",\{\},\"$MCFile\",\"$SupplePath\",30,\"$ParameterFile\",\"data\/${OUTPUT}\/\",kTRUE\) -b -q -l > ${LOGDIR}_${SPLIT}_reco.log  &
#SPLIT=$((3*$SLURM_ARRAY_TASK_ID+1)); root /data/RB230064/common_2024/efficiency/submit/macros/run_reco_experiment_auto.C\($RUN,$NTOTAL,$SPLIT,$NSPLIT,\"$GCData\",\"$GGData\",\{\},\"$MCFile\",\"$SupplePath\",30,\"$ParameterFile\",\"data\/${OUTPUT}\/\",kTRUE\) -b -q -l > ${LOGDIR}_${SPLIT}_reco.log  &
#SPLIT=$((3*$SLURM_ARRAY_TASK_ID+2)); root /data/RB230064/common_2024/efficiency/submit/macros/run_reco_experiment_auto.C\($RUN,$NTOTAL,$SPLIT,$NSPLIT,\"$GCData\",\"$GGData\",\{\},\"$MCFile\",\"$SupplePath\",30,\"$ParameterFile\",\"data\/${OUTPUT}\/\",kTRUE\) -b -q -l > ${LOGDIR}_${SPLIT}_reco.log  &


wait
