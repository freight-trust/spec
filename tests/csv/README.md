# Concensus Testing 

> Clique Concensus testing toolkit

### Simulation 1

Run 1 chain simulation with `diff_inturn=2`, `diff_noturn=1`, `peer_count=8`, and `net_fragmentation=0.001`

```bash
ruby ./diff.rb 2 1 8 0.001 true
```
the last argument `true` enables debug logging to display the actual chain simulation:

```bash
2019-07-08 18:48:24 [SEAL] Peer 6ab547e6 (head 28f66f626df1) sealed INTURN block 1721, diff 13384, hash d9ba62f783ac, parent 28f66f626df1
2019-07-08 18:48:24 [SEAL] Peer 0d7383f5 (head 28f66f626df1) sealed NOTURN block 1721, diff 13378, hash fb633efb3c11, parent 28f66f626df1
2019-07-08 18:48:24 [SEAL] Peer 2060dac8 (head 28f66f626df1) sealed NOTURN block 1721, diff 13378, hash 8519447fa5f6, parent 28f66f626df1
2019-07-08 18:48:24 [SEAL] Peer b2f2d1f1 (head 28f66f626df1) sealed NOTURN block 1721, diff 13378, hash 393e054b3321, parent 28f66f626df1
2019-07-08 18:48:24 [SEAL] Peer a4f55b9f (head 28f66f626df1) sealed NOTURN block 1721, diff 13378, hash f6ca5ecc2d39, parent 28f66f626df1
2019-07-08 18:48:24 [SEAL] Peer d2038612 (head 28f66f626df1) sealed NOTURN block 1721, diff 13378, hash 88e4964c429b, parent 28f66f626df1
2019-07-08 18:48:24 [SEAL] Peer d1898681 (head 28f66f626df1) sealed NOTURN block 1721, diff 13378, hash 0abc69127835, parent 28f66f626df1
2019-07-08 18:48:24 [SEAL] Peer 6da7ede8 (head 28f66f626df1) sealed NOTURN block 1721, diff 13378, hash 0e999a613c34, parent 28f66f626df1
2019-07-08 18:48:24 [NETW] Peer 2060dac8 (head 8519447fa5f6) reorg to d9ba62f783ac (13384) from peer 6ab547e6
2019-07-08 18:48:24 [NETW] Peer b2f2d1f1 (head 393e054b3321) reorg to d9ba62f783ac (13384) from peer 6ab547e6
2019-07-08 18:48:24 [NETW] Peer a4f55b9f (head f6ca5ecc2d39) reorg to d9ba62f783ac (13384) from peer 6ab547e6
2019-07-08 18:48:24 [NETW] Peer d2038612 (head 88e4964c429b) reorg to d9ba62f783ac (13384) from peer 6ab547e6
2019-07-08 18:48:24 [NETW] Peer d1898681 (head 0abc69127835) reorg to d9ba62f783ac (13384) from peer 6ab547e6
2019-07-08 18:48:24 [NETW] Peer 6da7ede8 (head 0e999a613c34) reorg to d9ba62f783ac (13384) from peer 6ab547e6
2019-07-08 18:48:24 [SEAL] Peer 6ab547e6 (head d9ba62f783ac) sealed NOTURN block 1722, diff 13385, hash a447873ad104, parent d9ba62f783ac
2019-07-08 18:48:24 [SEAL] Peer 0d7383f5 (head fb633efb3c11) sealed INTURN block 1722, diff 13385, hash fca17484e138, parent fb633efb3c11
2019-07-08 18:48:24 [SEAL] Peer 2060dac8 (head d9ba62f783ac) sealed NOTURN block 1722, diff 13385, hash 760bd06dd838, parent d9ba62f783ac
2019-07-08 18:48:24 [SEAL] Peer b2f2d1f1 (head d9ba62f783ac) sealed NOTURN block 1722, diff 13385, hash 629d32cbcabb, parent d9ba62f783ac
2019-07-08 18:48:24 [SEAL] Peer a4f55b9f (head d9ba62f783ac) sealed NOTURN block 1722, diff 13385, hash a18b467ab30c, parent d9ba62f783ac
2019-07-08 18:48:24 [SEAL] Peer d2038612 (head d9ba62f783ac) sealed NOTURN block 1722, diff 13385, hash c501f7718dfc, parent d9ba62f783ac
2019-07-08 18:48:24 [SEAL] Peer d1898681 (head d9ba62f783ac) sealed NOTURN block 1722, diff 13385, hash 107056ab3394, parent d9ba62f783ac
2019-07-08 18:48:24 [SEAL] Peer 6da7ede8 (head d9ba62f783ac) sealed NOTURN block 1722, diff 13385, hash 1202b41b493b, parent d9ba62f783ac
2019-07-08 18:48:24 [SIML] Network is stuck:
2019-07-08 18:48:24 [SIML] Peer 6ab547e6, block 1722, diff 13385, hash a447873ad104, parent d9ba62f783ac
2019-07-08 18:48:24 [SIML] Peer 0d7383f5, block 1722, diff 13385, hash fca17484e138, parent fb633efb3c11
2019-07-08 18:48:24 [SIML] Peer 2060dac8, block 1722, diff 13385, hash 760bd06dd838, parent d9ba62f783ac
2019-07-08 18:48:24 [SIML] Peer b2f2d1f1, block 1722, diff 13385, hash 629d32cbcabb, parent d9ba62f783ac
2019-07-08 18:48:24 [SIML] Peer a4f55b9f, block 1722, diff 13385, hash a18b467ab30c, parent d9ba62f783ac
2019-07-08 18:48:24 [SIML] Peer d2038612, block 1722, diff 13385, hash c501f7718dfc, parent d9ba62f783ac
2019-07-08 18:48:24 [SIML] Peer d1898681, block 1722, diff 13385, hash 107056ab3394, parent d9ba62f783ac
2019-07-08 18:48:24 [SIML] Peer 6da7ede8, block 1722, diff 13385, hash 1202b41b493b, parent d9ba62f783ac
2019-07-08 18:48:24 [SIML] Network is stuck... Exiting.
```

### run monte-carlo simulation

to run a monte-carlo simulation, adapt and use the bash script

```bash
./diff.sh
```

result can be parsed as CSV:

```csv
peer_count,diff_inturn,diff_noturn,blocks_chain,blocks_target,net_fragmentation,num_reorgs
8,2,1,2058,1000000,0.001,14398
8,2,1,1457,1000000,0.001,10191
8,2,1,482,1000000,0.001,3366
8,2,1,2609,1000000,0.001,18255
8,2,1,57,1000000,0.001,391
8,2,1,417,1000000,0.001,2911
8,2,1,11322,1000000,0.001,79246
8,2,1,1674,1000000,0.001,11710
8,2,1,697,1000000,0.001,4871
```

## License

ISC/MIT