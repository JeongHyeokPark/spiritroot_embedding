RECOFILE=$1
OUTPUT=$2
NEXTJOB=$3
CONFIGLIST=$4
MCFILE=$5
CONFIGFILE=$6
MCSUBMITFILE=$7
CLEANUPFILE=${8}
NTOTAL=${9}

# Creat directory for logging 
MCID=$(sbatch --parsable ${MCSUBMITFILE} ${OUTPUT} ${CONFIGLIST} ${CONFIGFILE} ${NTOTAL})
MERGEID=$(sbatch --parsable --dependency=afterok:${MCID} --kill-on-invalid-dep=yes embedMacros/submit_merge.sh ${OUTPUT})
RECOID=$(sbatch --parsable --dependency=afterok:${MERGEID} --kill-on-invalid-dep=yes ${RECOFILE} ${OUTPUT} ${NEXTJOB} ${CONFIGLIST} ${MCFILE} ${NTOTAL})
sbatch --job-name="Cleanup" --dependency=afterany:${RECOID} --kill-on-invalid-dep=yes ${CLEANUPFILE} ${OUTPUT} ${CONFIGLIST} ${NEXTJOB} 
