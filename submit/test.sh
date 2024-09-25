declare -a parray=(proton deuteron triton he3 alpha)
declare -a conf_arr=(random_generator.config.par_p random_generator.config.par_d random_generator.config.par_t random_generator.config.par_h random_generator.config.par_a)

for i in {0..4} # pid (0~4)
do
for j in {1..1000} # job numbers
do
RECOFILE=submit_general_allreco.sh
#OUTPUT=output
OUTPUT=${parray[$i]}_$j
NEXTJOB=0
CONFIGLIST=qq
MCFILE=${parray[$i]}_$j
MCFILE=${parray[$i]}_${j}_SARR
CONFIGFILE=random_generator.config.par
CONFIGFILE=${conf_arr[$i]}
MCSUBMITFILE=submit_general_allmc.sh
CLEANUPFILE=cleanup.sh
NTOTAL=5000

ishere=0
test -f /tmp_work/jhpark/data/$MCFILE.digi* && ishere=1

# Creat directory for logging 
if [ $ishere -eq 0 ]; then
MCID=$(sbatch --partition=mpc --account=RB230064 --parsable ${MCSUBMITFILE} ${OUTPUT} ${CONFIGLIST} ${CONFIGFILE} ${NTOTAL})
RECOID=$(sbatch --partition=mpc --account=RB230064 --parsable --dependency=afterok:${MCID} --kill-on-invalid-dep=yes ${RECOFILE} ${OUTPUT} ${NEXTJOB} ${CONFIGLIST} ${MCFILE}  ${NTOTAL})
else
RECOID=$(sbatch --partition=mpc --account=RB230064 --parsable ${RECOFILE} ${OUTPUT} ${NEXTJOB} ${CONFIGLIST} ${MCFILE}  ${NTOTAL})
fi

done

while :
do
  num=$(squeue -u jhpark | wc -l)
  if [ $num -le 100 ]; then
    break;
  fi
done

done
