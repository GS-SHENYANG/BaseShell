#!/usr/bin/env bash
# shellcheck disable=SC1091,SC2155
#===============================================================
import="$(basename "${BASH_SOURCE[0]}" .sh)_$$"
if [[ $(eval echo '$'"${import}") == 0 ]]; then return; fi
eval "${import}=0"
#===============================================================
source ./../../BaseShell/Starter/BaseHeader.sh
source ./../../BaseShell/Utils/BaseUuid.sh
#===============================================================================
# 该锁利用fifo的阻塞原理实现 非重入锁
# 新建一个锁 []<-(lock_fd:String)
new_lock(){ _NotBlank "$1" "lock fd can not be null"
  local fd=$1
  new_fifo "${fd}"
  echo 0 >& "${fd}"
}

# 尝试加锁,也就是获取fifo的执行令牌,并发情况下只有一个线程可以获取到
# 非冲入锁,切勿连续两次上锁,否则有可能死锁
# 尝试加锁 []<-(lock_fd:String)
lock_tryLock(){ _NotBlank "$1" "lock fd can not be null"
  local fd=$1
  ! isExist "${fd}" && {
    new_lock "${fd}"
  }
  read -r -u "${fd}"
}

# 解锁,也就是归还fifo的执行令牌,并发情况下只有一个线程可以获取到
# 非冲入锁,切勿连续两次解锁,否则有可能死锁
# 解锁 []<-(lock_fd:String)
lock_unLock(){ _NotBlank "$1" "lock fd can not be null"
  local fd=$1
  echo 0 >& "${fd}"
}

function lock_run(){ _NotBlank "$1" "lock fd can not be null" && _NotBlank "$2" "function can not be null"
  local fd=$1;shift ; local task=$*
  lock_tryLock "${fd}"
  eval "${task}"
  lock_unLock "${fd}"
}