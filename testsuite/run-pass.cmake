include(${CMAKE_CURRENT_LIST_DIR}/common.cmake)

PrepareTest(VERONAC_FLAGS EXPECTED_DUMP ACTUAL_DUMP)

set(BYTECODE_OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${TEST_NAME}.vbc)
set(INTERPRETER_LOG ${CMAKE_CURRENT_BINARY_DIR}/${TEST_NAME}.output)

CheckStatus(
  COMMAND ${VERONAC} ${VERONAC_FLAGS} ${TEST_FILE} --output=${BYTECODE_OUTPUT}
  EXPECTED_STATUS 0)

if(EXPECTED_DUMP)
  CheckDump(${EXPECTED_DUMP} ${ACTUAL_DUMP})
endif()

CheckStatus(
  COMMAND ${INTERPRETER} ${BYTECODE_OUTPUT} 
  EXPECTED_STATUS 0
  OUTPUT_FILE ${INTERPRETER_LOG})

FileCheck(${TEST_FILE} ${INTERPRETER_LOG})
