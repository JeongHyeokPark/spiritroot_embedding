#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --exclude=bwmpc207,bwmpc030,bwmpc060,bwmpc058,bwmpc068,bwmpc164,bwmpc170,bwmpc189,bwmpc190,bwmpc257,bwmpc234
#SBATCH --cpus-per-task=1
#array=0-9
#SBATCH --mem=2000
#SBATCH -o "LOGDIRTOBESUB/slurm_%A_SARR_MCDigi.log"
#SBATCH --time=24:00:00
#SBATCH --job-name="MC"

source /data/RB230064/common_2024/efficiency/spiritroot_mc_submit/build/config.sh
export LD_LIBRARY_PATH=/data/RB230064/common_2024/efficiency/spiritroot_mc_submit/macros/lib:$LD_LIBRARY_PATH

OUTPUT=$1
CONFIGLIST=$2
CONFIGFILE=$3
NTOTAL=$4
TTOTAL=$4

OUTPUT=${OUTPUT}_SARR

# Creat directory for logging 
LOGDIR=/lustre/data/RB230064/common_2024/efficiency/submit/log/${OUTPUT}
mkdir -p "${LOGDIR%/*}"

cd /tmp_work/jhpark

root /data/RB230064/common_2024/efficiency/submit/macros/run_mc.C\(\"$OUTPUT\",${NTOTAL},\"\",\"data/\",kTRUE,\"$CONFIGFILE\"\) -b -q -l > ${LOGDIR}_mc.log
sleep 1
root /data/RB230064/common_2024/efficiency/submit/macros/run_digi.C\(\"data/$OUTPUT\"\) -b -q -l > ${LOGDIR}_digi.log
