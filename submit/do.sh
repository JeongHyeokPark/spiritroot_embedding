for i in {0..4} # pid (0~4)
do
for j in {1..1000} # job numbers
do
  if [[ $i -le 0 && $j -le 56 ]]; then
  #echo "run_stopped.sh $i $j"
  ./run_stopped.sh $i $j
  else
  #echo "run_stopped_reco.sh $i $j"
  ./run_stopped_reco.sh $i $j
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
