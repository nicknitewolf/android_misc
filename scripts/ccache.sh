# Setup ccache
function ccache-s() {
  if [ "$USE_CCACHE" != "1" ]; then
    echo "USE_CCACHE not set, bailing!"
    return
  fi

  if [ ! -d "$CCACHE_DIR" ]; then
    echo "CCACHE_DIR not set, bailing!"
    return
  fi

  device="$1"
  if [ -z "$device" ]; then
    echo "device parameter invalid, bailing!"
    return
  fi

  device_cache="$CCACHE_DIR/$device"
  if [ ! -d "$device_cache" ]; then
    mkdir -p "$device_cache"
  fi
  
  export CCACHE_DIR="$device_cache"
  $(which ccache) -M 10G
  touch "$device_cache/.last_used"
}

# setup ccache for lunch combo and lunch
function lunch-c() {
  local combo="$1"
  if [ -z "$combo" ]; then
    echo "No argument given, bailing!"
    return
  fi

  local device=`echo "$combo" | cut -d"_" -f2 | cut -d"-" -f1`
  if [ -z "$device" ]; then
    echo "Could not extract device from argument, bailing!"
    return
  fi

  echo "Setting up ccache for: $device"
  ccache-s "$device"
  echo "Performing the real lunching"
  lunch "$combo"
}
