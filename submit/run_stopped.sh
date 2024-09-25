declare -a parray=(proton deuteron triton he3 alpha)
declare -a conf_arr=(random_generator.config.par_p random_generator.config.par_d random_generator.config.par_t random_generator.config.par_h random_generator.config.par_a)

i=$1
j=$2
RECOFILE=submit_general_allreco.sh
#OUTPUT=output
OUTPUT=${parray[$i]}_$j
NEXTJOB=0
CONFIGLIST=qq
MCFILE=${parray[$i]}_$j
MCFILE=${parray[$i]}_${j}_SARR
#CONFIGFILE=random_generator.config.par_p
CONFIGFILE=${conf_arr[$i]}
MCSUBMITFILE=submit_general_allmc.sh
CLEANUPFILE=cleanup.sh
NTOTAL=5000

rm -rf /tmp_work/jhpark/data/${MCFILE}*.root

# Creat directory for logging 
MCID=$(sbatch --partition=mpc --account=RB230064 --parsable ${MCSUBMITFILE} ${OUTPUT} ${CONFIGLIST} ${CONFIGFILE} ${NTOTAL})
RECOID=$(sbatch --partition=mpc --account=RB230064 --parsable --dependency=afterok:${MCID} --kill-on-invalid-dep=yes ${RECOFILE} ${OUTPUT} ${NEXTJOB} ${CONFIGLIST} ${MCFILE}  ${NTOTAL})


