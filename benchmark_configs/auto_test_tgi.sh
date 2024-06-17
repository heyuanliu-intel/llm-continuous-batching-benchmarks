#!/bin/bash
# set -x

input_arr=(128 128 128 512 2048)
output_arr=(1024 768 1536 768 96)
range_arr=(1024 256 512 256 32)
bs_arr=(16 32 64 128)
# input_arr=(128)
# output_arr=(1024)
# range_arr=(1024)
# bs_arr=(32)
dist_arr=("capped_exponential" "uniform" "uniform" "uniform" "uniform")
for bs in "${bs_arr[@]}"
do
    idx=0
    for _ in "${input_arr[@]}"
    do
        input=${input_arr[$idx]}
        output=${output_arr[$idx]}
        range=${range_arr[$idx]}
        dist=${dist_arr[$idx]}
        echo "bs:$bs input:$input output:$output range:$range dist:$dist"
        bash ./tgi_gaudi_variable_size $input $output $range $bs $dist $dist 2>&1 | tee term_log_i${input}_o${output}_range${range}_bs${bs}
        print_o=$(( output + range ))
        print_r=$((range * 2))
        # mv ../bsoutput_new.txt ./bs_modeltime/i${input}_o${print_o}_range${print_r}_bs${bs}.txt
        idx=$idx+1
    done
done

