#!/bin/bash
ulimit -n 1048576
echo 3 >/proc/sys/vm/drop_caches
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
declare -i data=${2}\*1024\*1024\*1024\/${3}
./db_bench --benchmarks="overwrite,stats,levelstats" \
--use_existing_db=1 \
--sync=0 \
--level0_file_num_compaction_trigger=4 \
--level0_slowdown_writes_trigger=20 \
--level0_stop_writes_trigger=30 \
--max_background_jobs=8 \
--max_write_buffer_number=8 \
--db=${1} \
--num=9000000 \
--duration=3600 \
--disable_wal=${5} \
--num_levels=8 \
--key_size=20 \
--value_size=${3} \
--block_size=8192 \
--cache_size=51539607552 \
--cache_numshardbits=6 \
--compression_max_dict_bytes=0 \
--compression_ratio=0.5 \
--compression_type=snappy \
--bytes_per_sync=8388608 \
--cache_index_and_filter_blocks=1 \
--cache_high_pri_pool_ratio=0.5 \
--benchmark_write_rate_limit=0 \
--write_buffer_size=16777216 \
--target_file_size_base=16777216 \
--max_bytes_for_level_base=67108864 \
--verify_checksum=1 \
--delete_obsolete_files_period_micros=62914560 \
--max_bytes_for_level_multiplier=8 \
--statistics=1 \
--report_interval_seconds=5 \
--histogram=1 \
--memtablerep=skip_list \
--bloom_bits=10 \
--open_files=-1 \
--subcompactions=1 \
--compaction_style=0 \
--min_level_to_compress=3 \
--level_compaction_dynamic_level_bytes=false \
--pin_l0_filter_and_index_blocks_in_cache=1 \
--soft_pending_compaction_bytes_limit=24696061952 \
--hard_pending_compaction_bytes_limit=49392123904 \
--threads=16 \
--merge_operator="put" \
--seed=1642907605 \
--report_file=${4}/write_Dataset_${2}G_Value_${3}_DisWal_${5}_F.csv \
| tee ${4}/write_Dataset_${2}G_Value_${3}_DisWal_${5}_F.txt \

