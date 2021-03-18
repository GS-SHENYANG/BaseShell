#!/usr/bin/env bash
# shellcheck disable=SC1091,SC2155
#===============================================================
import="$(basename "${BASH_SOURCE[0]}" .sh)_$$"
if [[ $(eval echo '$'"${import}") == 0 ]]; then return; fi
eval "${import}=0"
#===============================================================
source ./../../BaseShell/config.sh
source ./../../BaseShell/Starter/BaseStarter.sh
#===============================================================================
# 这种没有实现的函数类似接口,在对应的xxEnd.sh中必有实现
function assertEquals(){ :
  local sourceValue=$1 #测试结果
  local targetValue=$2 #预期结果
  local description=$3 #描述
}
function assertNotNull(){ :
  local sourceValue=$1 #测试结果
  local targetValue=$2 #预期结果
  local description=$3 #描述
}
function assertNull(){ :
  local sourceValue=$1 #测试结果
  local targetValue=$2 #预期结果
  local description=$3 #描述
}
function assertTrue(){ :
  local sourceValue=$1 #测试结果
  local description=$2 #描述
}
function assertFalse(){ :
  local sourceValue=$1 #测试结果
  local description=$2 #描述
}
mock(){ :

}
