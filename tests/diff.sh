#!/usr/bin/env bash

echo "peer_count,diff_inturn,diff_noturn,blocks_chain,blocks_target,net_fragmentation,num_reorgs" | tee -a ./csv/diff-8-2-1-001.csv
for i in {1..1000}; do
	ruby ./diff.rb 2 1 8 0.001 | tee -a ./csv/diff-8-2-1-001.csv
done

echo "peer_count,diff_inturn,diff_noturn,blocks_chain,blocks_target,net_fragmentation,num_reorgs" | tee -a ./csv/diff-8-7-3-001.csv
for i in {1..1000}; do
	ruby ./diff.rb 7 3 8 0.001 | tee -a ./csv/diff-8-7-3-001.csv
done

echo "peer_count,diff_inturn,diff_noturn,blocks_chain,blocks_target,net_fragmentation,num_reorgs" | tee -a ./csv/diff-8-7-2-001.csv
for i in {1..1000}; do
	ruby ./diff.rb 7 2 8 0.001 | tee -a ./csv/diff-8-7-2-001.csv
done

echo "peer_count,diff_inturn,diff_noturn,blocks_chain,blocks_target,net_fragmentation,num_reorgs" | tee -a ./csv/diff-8-7-1-001.csv
for i in {1..1000}; do
	ruby ./diff.rb 7 1 8 0.001 | tee -a ./csv/diff-8-7-1-001.csv
done

echo "peer_count,diff_inturn,diff_noturn,blocks_chain,blocks_target,net_fragmentation,num_reorgs" | tee -a ./csv/diff-8-3-1-001.csv
for i in {1..1000}; do
	ruby ./diff.rb 3 1 8 0.001 | tee -a ./csv/diff-8-3-1-001.csv
done
