$write("\n");
$write("TMU Test \n");
$write("---------- \n");

errorcount <= 0;

$write("Test iTMU version: ");
testtotal = testtotal + 1;
run_test_program_bulk(0,"./memfiles/tmu/i_tmu_check_version.mem",450,result);
if(result != 0) errorcount = errorcount + 1;

$write("Test dTMU version: ");
testtotal = testtotal + 1;
run_test_program_bulk(0,"./memfiles/tmu/d_tmu_check_version.mem",450,result);
if(result != 0) errorcount = errorcount + 1;

$write("Test iTMU defaults: ");
testtotal = testtotal + 1;
run_test_program_bulk(0,"./memfiles/tmu/i_tmu_check_defaults.mem",450,result);
if(result != 0) errorcount = errorcount + 1;

$write("Test dTMU defaults: ");
testtotal = testtotal + 1;
run_test_program_bulk(0,"./memfiles/tmu/d_tmu_check_defaults.mem",450,result);
if(result != 0) errorcount = errorcount + 1;

$write("Test iTMU mode tests: ");
testtotal = testtotal + 1;
run_test_program_bulk(0,"./memfiles/tmu/i_tmu_test_mode_readout.mem",450,result);
if(result != 0) errorcount = errorcount + 1;

$write("Test dTMU mode tests: ");
testtotal = testtotal + 1;
run_test_program_bulk(0,"./memfiles/tmu/d_tmu_test_mode_readout.mem",450,result);
if(result != 0) errorcount = errorcount + 1;

$write("Test iTMU throws interrupt: ");
testtotal = testtotal + 1;
run_test_program_bulk(0,"./memfiles/tmu/i_tmu_check_interrupt.mem",450,result);
if(result != 0) errorcount = errorcount + 1;

$write("Test dTMU throws interrupt: ");
testtotal = testtotal + 1;
run_test_program_bulk(0,"./memfiles/tmu/d_tmu_check_interrupt.mem",450,result);
if(result != 0) errorcount = errorcount + 1;

$write("Test iTMU interrupt and read: ");
testtotal = testtotal + 1;
run_test_program_bulk(0,"./memfiles/tmu/i_tmu_interrupt_and_read.mem",450,result);
if(result != 0) errorcount = errorcount + 1;

$write("Test dTMU interrupt and read: ");
testtotal = testtotal + 1;
run_test_program_bulk(0,"./memfiles/tmu/d_tmu_interrupt_and_read.mem",450,result);
if(result != 0) errorcount = errorcount + 1;

$write("Test iTMU interrupt and flush: ");
testtotal = testtotal + 1;
run_test_program_bulk(0,"./memfiles/tmu/i_tmu_interrupt_and_flush.mem",450,result);
if(result != 0) errorcount = errorcount + 1;

$write("Test dTMU interrupt and flush: ");
testtotal = testtotal + 1;
run_test_program_bulk(0,"./memfiles/tmu/d_tmu_interrupt_and_flush.mem",450,result);
if(result != 0) errorcount = errorcount + 1;

$write("Test dTMU single interrupt and read and check data with compression disabled: ");
testtotal = testtotal + 1;
run_test_program_bulk(0,"./memfiles/tmu/tmu_interrupt_read_check.mem",450,result);
if(result != 0) errorcount = errorcount + 1;

$write("Test dTMU multiple interrupts and read and check data with compression enabled: ");
testtotal = testtotal + 1;
run_test_program_bulk(0,"./memfiles/tmu/tmu_interrupt_read_check_multi.mem",450,result);
if(result != 0) errorcount = errorcount + 1;

$write("Test iTMU no interrupt and readout: ");
testtotal = testtotal + 1;
run_test_program_bulk(0,"./memfiles/tmu/i_tmu_no_int_readout.mem",450,result);
if(result != 0) errorcount = errorcount + 1;

$write("Test dTMU no interrupt and readout: ");
testtotal = testtotal + 1;
run_test_program_bulk(0,"./memfiles/tmu/d_tmu_no_int_readout.mem",450,result);
if(result != 0) errorcount = errorcount + 1;

$write("Test iTMU no interrupt and flush: ");
testtotal = testtotal + 1;
run_test_program_bulk(0,"./memfiles/tmu/i_tmu_no_int_flush.mem",450,result);
if(result != 0) errorcount = errorcount + 1;

$write("Test dTMU no interrupt and flush: ");
testtotal = testtotal + 1;
run_test_program_bulk(0,"./memfiles/tmu/d_tmu_no_int_flush.mem",450,result);
if(result != 0) errorcount = errorcount + 1;

$write("\n\n TMU Tests completed with errorcount = ",errorcount);
$write("\n\n");
errortotal = errortotal + errorcount;
