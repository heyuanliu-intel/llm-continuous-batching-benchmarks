#!/bin/bash
# set -x

input_arr=(128 512 128)
output_arr=(1024 256 768)
range_arr=(1024 256 512)
bs_arr=(16 32 64 128)
dist_arr=("capped_exponential" "capped_exponential" "uniform")
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
        idx=$idx+1
    done
done

