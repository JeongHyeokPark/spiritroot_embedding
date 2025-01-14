set(STPATH /data/RB230064/common_2024/efficiency/spiritroot_mc_hokusai)

set(CREATE_GIT_LOG on)

find_package(Git)
if(NOT GIT_FOUND)
  message(FATAL_ERROR "Git is needed to create git-log.")
  set(CREATE_GIT_LOG off)
endif()

if(CREATE_GIT_LOG)
  execute_process(COMMAND ${GIT_EXECUTABLE} rev-parse --abbrev-ref HEAD OUTPUT_VARIABLE ST_GIT_BRANCH OUTPUT_STRIP_TRAILING_WHITESPACE
                  WORKING_DIRECTORY ${STPATH})
  execute_process(COMMAND ${GIT_EXECUTABLE} rev-list --count ${ST_GIT_BRANCH} OUTPUT_VARIABLE ST_GIT_COMMIT_COUNT OUTPUT_STRIP_TRAILING_WHITESPACE
                  WORKING_DIRECTORY ${STPATH})
  execute_process(COMMAND ${GIT_EXECUTABLE} rev-parse --short ${ST_GIT_BRANCH} OUTPUT_VARIABLE ST_GIT_HASH_SHORT OUTPUT_STRIP_TRAILING_WHITESPACE
                  WORKING_DIRECTORY ${STPATH})
  set(STVERSION "${ST_GIT_BRANCH}.${ST_GIT_COMMIT_COUNT}.${ST_GIT_HASH_SHORT}")

  cmake_host_system_information(RESULT STHOSTNAME QUERY HOSTNAME)
  set(STUSERNAME $ENV{USER})

  configure_file(${STPATH}/cmake/STCompiled.h.in  ${STPATH}/VERSION.compiled @ONLY)
endif()
