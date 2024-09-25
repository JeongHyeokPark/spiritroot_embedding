#!/bin/bash

par=$1
par_digi=$(echo "$par"_"digi.txt")
par_reco=$(echo "$par"_"reco.txt")

dir=/tmp_work/jhpark/data
digi_files=$dir/$par*digi*root
reco_files=$dir/$par*/*2.root

ls -ahlSS $digi_files > $par_digi
ls -ahlSS $reco_files > $par_reco
