enable_testing()

add_test( bad_time1 ./UNC-Waves_tester bad_time1.txt )

add_test( bad_value1 ./UNC-Waves_tester bad_value1.txt )
add_test( bad_value2 ./UNC-Waves_tester bad_value2.txt )

add_test( bad_y_offset1 ./UNC-Waves_tester bad_y_offset1.txt )
add_test( bad_y_offset2 ./UNC-Waves_tester bad_y_offset2.txt )

add_test( bad_z_offset1 ./UNC-Waves_tester bad_z_offset1.txt )
add_test( bad_z_offset2 ./UNC-Waves_tester bad_z_offset2.txt )

add_test( improper_format1 ./UNC-Waves_tester improper_format1.txt )
add_test( improper_format2 ./UNC-Waves_tester improper_format2.txt )
add_test( improper_format3 ./UNC-Waves_tester improper_format3.txt )
add_test( improper_format4 ./UNC-Waves_tester improper_format4.txt )
add_test( improper_format5 ./UNC-Waves_tester improper_format5.txt )

add_test( pass1 ./UNC-Waves_tester pass1.txt )
add_test( pass2 ./UNC-Waves_tester pass2.txt )
add_test( pass3 ./UNC-Waves_tester pass3.txt )
add_test( pass4 ./UNC-Waves_tester pass4.txt )
add_test( pass5 ./UNC-Waves_tester pass5.txt )