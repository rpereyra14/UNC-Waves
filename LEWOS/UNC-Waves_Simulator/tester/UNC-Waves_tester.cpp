/*******************************************************

	TESTING FRAMEWORK FOR LEWOS INPUT FILE FORMATS


*******************************************************/

#include <stdlib.h>
#include <string.h>
#include <string>
#include <iostream>

int main( int argc, char* argv[] ){

	if( argc != 2 ){
		std::cout << "Usage: ./UNC-Waves_tester <input_test_file>" << std::endl ;
		exit( 1 );
	}

	std::string temp( argv[1] );

	char cmd[200] = "";
	cmd[0] = '\0';
	strcat( cmd, "../MACRO_UNC-Waves_Simulator " );
	strcat( cmd, temp.c_str() );
	int ret = system( cmd );

	if( temp.find( "pass", 0 ) != std::string::npos && ret == 0 ){
		std::cout << 0 << std::endl;
		return 0;
	}else if( temp.find( "pass", 0 ) == std::string::npos && ret != 0 ){ 
		if( temp.find( "bad_file", 0 ) == std::string::npos && ret == 4 ){
			std::cout << 1 << std::endl;
			return 1;
		}else if( temp.find( "improper_format", 0 ) == std::string::npos && ret == 5 ){
			std::cout << 1 << std::endl;
			return 1;
		}else if( temp.find( "bad_value", 0 ) == std::string::npos && ret == 8 ){
			std::cout << 1 << std::endl;
			return 1;
		}else if( temp.find( "bad_z_offset", 0 ) == std::string::npos && ret == 9 ){
			std::cout << 1 << std::endl;
			return 1;
		}else if( temp.find( "bad_y_offset", 0 ) == std::string::npos && ret == 10 ){
			std::cout << 1 << std::endl;
			return 1;
		}else if( temp.find( "bad_time", 0 ) == std::string::npos && ret == 11 ){
			std::cout << 1 << std::endl;
			return 1;
		}else{
			std::cout << 0 << std::endl;
			return 0;
		}
	}else{
		std::cout << 1 << std::endl;
		return 1;
	}

}
