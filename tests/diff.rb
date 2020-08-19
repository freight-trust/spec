#!/usr/bin/env ruby

require "digest/sha1"
require "securerandom"
require "colorize"

@DIFF_INTURN   = 7    # DIFF_INTURN as per EIP-225/1955
@DIFF_NOTURN   = 1    # DIFF_NOTURN as per EIP-225/1955
@BLOCK_TIME    = 0    # block time in seconds (can be less than 1)
@PEER_COUNT    = 8    # adjust the number of validators (Görli = 8)
@PEER_INTURN   = 0    # peer allowed to seal first
@SIM_END  = 100000    # number of blocks to simulate

## Network fragmentation
# 0.50 means there is a 50% chance the network is fragmented
# and blocks are not received in meaningful time
# challenge: try to figure out a meaningful value here
# note: setting this to 0 will allow this chain to never get stuck
@NET_FRAG    = 0.001

## Turn on debug logging
@DEBUG_MODE = false

## Stats, do not change
@NUM_REORG   = 0

# block hash is 6 random bytes
def block_hash
  SecureRandom.hex[0..11]
end

# peer identity is 4 random bytes
def peer_hash
  SecureRandom.hex[0..7]
end

# prepent logs with timestamp
def log(string)
  if @DEBUG_MODE
    printf "#{Time.now.utc.strftime('%Y-%m-%d %H:%M:%S')} #{string}\n"
  end
end

# seal an out-of-turn block
def seal_block_out_of_turn(num, diff, par)
  _num = num + 1
  _diff = diff + @DIFF_NOTURN
  _hash = block_hash
  block = {
    "number" => _num,
    "difficulty" => _diff,
    "hash" => _hash,
    "parent" => par
  }
end

# seal an in-turn block
def seal_block_in_turn(num, diff, par)
  _num = num + 1
  _diff = diff + @DIFF_INTURN
  _hash = block_hash
  block = {
    "number" => _num,
    "difficulty" => _diff,
    "hash" => _hash,
    "parent" => par
  }
end

# use this genesis to run the chains
def seal_genesis
  genesis = {
      "number" => 0,
      "difficulty" => 1337,
      "hash" => "d1f7f7cb18b4",
      "parent" => "000000000000"
    }
end

# spawn random validator nodes with same genesis
def spawn_peers(gen)
  peers = []
  (1..@PEER_COUNT).each do
    peers.append ["id" => peer_hash, "best" => gen]
  end
  peers
end

# mine a single chain starting at genesis with a number of peers
def mine_chain(gen, peers)

  # genesis is best block now
  best = gen
  log "[SIML] Genesis block #{gen['number']}, diff #{gen['difficulty']}, hash #{gen['hash']}".colorize(:green)

  # storing best possible diff for sanity checks later
  _diff = 0
  _num = 0

  # run simulation till SIM_END
  while _num < @SIM_END
    _current = 0
    _best = nil

    # assuming each peer is a validator
    peers.each do |peer|

      # if node is in turn, seal in-turn block
      if _current === @PEER_INTURN
        _best = seal_block_in_turn(
            peer[0]['best']["number"],
            peer[0]['best']["difficulty"],
            peer[0]['best']["hash"]
          )
        _diff = _best['difficulty']
        _num = _best['number']
        log "[SEAL] Peer #{peer[0]['id']} (head #{peer[0]['best']['hash']}) sealed INTURN block #{_best['number']}, diff #{_best['difficulty']}, hash #{_best['hash']}, parent #{_best['parent']}".colorize(:light_green)

      # if node is not in turn, seal out-of-turn block
      else
        _best = seal_block_out_of_turn(
            peer[0]['best']["number"],
            peer[0]['best']["difficulty"],
            peer[0]['best']["hash"]
          )
        log "[SEAL] Peer #{peer[0]['id']} (head #{peer[0]['best']['hash']}) sealed NOTURN block #{_best['number']}, diff #{_best['difficulty']}, hash #{_best['hash']}, parent #{_best['parent']}".colorize(:light_blue)
      end

      # each peer assumes its own block as best before seeing others
      peer[0]['best'] = _best
      _current += 1
    end

    # simulate "n-to-m-networking" assuming each peer sees all blocks
    peers.each do |p|
      peers.each do |q|

        # assume network fragmentation (a % chance to miss blocks)
        if rand() > @NET_FRAG

          # if their total diff is higher, re-organize to their chain
          if p[0]['best']['difficulty'] < q[0]['best']['difficulty']
            log "[NETW] Peer #{p[0]['id']} (head #{p[0]['best']['hash']}) reorg to #{q[0]['best']['hash']} (#{q[0]['best']['difficulty']}) from peer #{q[0]['id']}".colorize(:yellow)
            p[0]['best'] = q[0]['best']

            # count reorgs
            @NUM_REORG += 1

          # if their total diff is the same, print a red warning and keep own block, ideally this should not happen much
          elsif p[0]['best']['difficulty'] === q[0]['best']['difficulty']

            # doing nothing but staying on wrong block
            # log "[DEBG] Peer #{p[0]['id']} (head #{p[0]['best']['hash']}) SAME DIFFICULTY as #{q[0]['best']['hash']} (#{q[0]['best']['difficulty']}); keeping own best block".colorize(:gray)
          else

            # already on best head, do nothing
            # log "[DEBG] Peer #{p[0]['id']} (head #{p[0]['best']['hash']}) idles".colorize(:gray)
          end
        end
      end
    end


    # check: is the network stuck?
    _stuck = false
    peers.each do |p|
      peers.each do |q|

      	# condition 1: same difficulty
        if p[0]['best']['difficulty'] === q[0]['best']['difficulty']

        	# condition 2: different hash
          if p[0]['best']['hash'].to_i(16) != q[0]['best']['hash'].to_i(16)

          	# condition 3: same diff as best in-turn block
            if p[0]['best']['difficulty'] === _diff

            	# network is unable to reorg if all conditions are met
              _stuck = true
            end
          end
        end
      end
    end

    # print stats about peers and best blocks if stuck
    if _stuck
      log "[SIML] Network is stuck:".colorize(:light_red)
      peers.each do |peer|
        log "[SIML] Peer #{peer[0]['id']}, block #{peer[0]['best']['number']}, diff #{peer[0]['best']['difficulty']}, hash #{peer[0]['best']['hash']}, parent #{peer[0]['best']['parent']}".colorize(:light_red)
      end
      log "[SIML] Network is stuck... Exciting.".colorize(:light_red)

      # exit simulation at block hight #{_num}
      return _num
    end

    # simulate an actual block time
    sleep @BLOCK_TIME
    @PEER_INTURN = (@PEER_INTURN + 1) % @PEER_COUNT
  end

  # finish simulation at block hight #{_num}
  return _num
end

# Sorry for overriding this here, lol - used for convenience in the bash script
if ARGV.length >= 3
  @DIFF_INTURN = ARGV[0].to_i
  @DIFF_NOTURN = ARGV[1].to_i
  @PEER_COUNT = ARGV[2].to_i
  @NET_FRAG = ARGV[3].to_f
end
if ARGV.length >= 4
  @DEBUG_MODE = ARGV[4].to_s.downcase == "true"
end

# script starts here, seal genesis and spawn peers; "mine" chain
genesis = seal_genesis
network = spawn_peers(genesis)
block = mine_chain(genesis, network)

## stats of the simulation in CSV format
# peer_count,diff_inturn,diff_noturn,blocks_chain,blocks_target,net_fragmentation,num_reorgs
if not @DEBUG_MODE
	printf "#{@PEER_COUNT},#{@DIFF_INTURN},#{@DIFF_NOTURN},#{block},#{@SIM_END},#{@NET_FRAG},#{@NUM_REORG}\n"
end
