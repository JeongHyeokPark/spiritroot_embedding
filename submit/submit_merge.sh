#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem-per-cpu=3000
#SBATCH --time=24:00:00
#SBATCH --job-name="MERGE"

source /data/RB230064/common_2024/efficiency/spiritroot_mc_submit/build/config.sh
export LD_LIBRARY_PATH=/data/RB230064/common_2024/efficiency/spiritroot_mc_submit/macros/lib:$LD_LIBRARY_PATH

OUTPUT=$1

#hadd -f -j 10 /tmp_work/jhpark/data/${OUTPUT}.digi.root /tmp_work/jhpark/data/${OUTPUT}_SARR_0.digi.root /tmp_work/jhpark/data/${OUTPUT}_SARR_1.digi.root /tmp_work/jhpark/data/${OUTPUT}_SARR_2.digi.root /tmp_work/jhpark/data/${OUTPUT}_SARR_3.digi.root /tmp_work/jhpark/data/${OUTPUT}_SARR_4.digi.root /tmp_work/jhpark/data/${OUTPUT}_SARR_5.digi.root /tmp_work/jhpark/data/${OUTPUT}_SARR_6.digi.root /tmp_work/jhpark/data/${OUTPUT}_SARR_7.digi.root /tmp_work/jhpark/data/${OUTPUT}_SARR_8.digi.root /tmp_work/jhpark/data/${OUTPUT}_SARR_9.digi.root

hadd -j 100 /tmp_work/jhpark/data/${OUTPUT}.digi.root /tmp_work/jhpark/data/${OUTPUT}_SARR_*.digi.root
