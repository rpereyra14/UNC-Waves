/*------------------------------------------------------------------------------------------+
| @ProjectName		UNC Waves COMP 523 Project 												|
| @Team Members		Alex French																|
|					Steven Love																|
|					Chris Mullins															|
|					Renato Pereyra															|
|																							|
| @Title			UNC Waves COMP 523 LEWOS Simulator										|
| @Author			Renato Pereyra															|
| @Updated			April 8, 2013															|
| 																							|
| @Description		Reads waveform data from <input_file> and simulates the behavior of 	|
|					LEWOS based on that data. The input file must have the format:			|
|																							|
|						<z_location> <y_location> <time> <actuator_value>					|
|																							|
|					where time is given as an integer specifying an offset in miliseconds	|
|					and actuator_value is given as a float between 0.0 and 1.0, inclusive.	|
|																							|
+------------------------------------------------------------------------------------------*/

#include <LEWOS_sim.h>				//for LEWOS
#include "FluidTankSpecs.h"			//hardware specifications of the fluid tank
#include "Record.h"					//holds information about an excitation record (i.e. line in input file)
#include <stdlib.h>					//for atoi and atof
#include <iostream>					//for I/O
#include <ifstream>					//for reading input file
#include <string>					//for handling of input file
#include <algorithm>				//for sorting records by domainID/timeOffset

#define VERBOSITY 4					//verbosity value for LEWOS simulation (ranges from 0 to 4, 4 being most verbose)
#define MAX_VOLTAGE 65536			//max LEWOS analog value
#define MISUSAGE 1					//return code for misusage (i.e. unspecified input file)
#define BAD_FILE 4					//return code for bad input file (i.e. input file unable to be opened)
#define BAD_DOMAIN_ID 5 			//return code for bad domainID calculated from input file
#define BAD_CHANNEL_ID 6			//return code for bad channelID calculated from input file

using std::ifstream;				//file reading handle
using std::string;					//string
using std::getline;					//read input line from file
using std::cout;					//stdout
using std::cerr;					//stderr
using std::endl;					//newline char
using std::vector;					//vector template class
using std::sort;					//sorting routine

vector<Record *> actuatorRecords;	//the z_locations excited

void parsefile( const string& filename );
void simulateMacro();

void main( int argc, char* argv[] ){

	//verify an input file was specified
	if( argc != 2 ){
		cerr << "USAGE: ./LEWOS_simulation <input_file>. See README for <input_file> format." << endl;
		exit( MISUSAGE );
	}

	parsefile( *argv[1] );
	simulateMacro();

}

void simulateMacro(){

	//get the current time
	struct timeval now;
	vrpn_gettimeofday(&now, NULL);

	//intialize domains vector with the global domain (not that the domainID is 0)
	std::vector<LEWOS_sim_domain *> domains;
	domains.push_back( new LEWOS_sim_domain(0, now, num_local_domains, 0, 0, 0, 0, 0) );

	for( int i = 1; i <= num_local_domains; i++ )
		domains.push_back( new LEWOS_sim_domain(i, now, 0, 0, local_domain_width * local_domain_height, 0, 0, 0) );

	//initalize LEWOS_sim
	LEWOS_sim sim( domains );

	//set verbosity value: ranges from 0 - 4 with 4 being most verbose
	sim.set_verbosity( VERBOSITY );

	//the macro initialization requires that instructions for a given domain/channel combination be contiguous, therefore will sort using
	//compareRecords struct found in Record.h
	sort( actuatorRecords.begin(), actuatorRecords.end(), compareRecords );

}

void parsefile( const string& filename ){
	//open input file
	ifstream infile;
	infile.open( filename );

	//opening of input file failed
	if( infile.fail() ){
		cerr << "USAGE: ./LEWOS_simulation <input_file>. See README for <input_file> format." << endl;
		exit( BAD_FILE );
	}

	//placeholder variables for reading the input file
	string temp;
	int z_location, y_location, t;
	int domainID, channelID, actuatorValue;
	int flattened_z, flattened_y;
	double val;

	int line = 0;

	//parse input file
	while( !infile.eof() ){

		line++;

		//read the input z_location
		getline( infile, temp, ' ' );
		z_location = atoi(temp.c_str());

		//read the input y_location
		getline( infile, temp, ' ' );
		y_location = atoi(temp.c_str());

		//read the input excitation time
		getline( infile, temp, ' ' );
		t = atoi(temp.c_str());

		//read the input excitation value
		getline( infile, temp );
		val = atof(temp.c_str());

		//flatten the z and y directions based on size of local domains
		flattened_z = (int)floor( (float)z_location/(float)local_domain_width );
		flattened_y = (int)floor( (float)y_location/(float)local_domain_height );

		//calculate the domainID by determining mapping the (z,y) location to a local domain.
		//The local domains need to be 1-offset (not 0-offset), thus 1 is added below.
		domainID = flattened_z + flattened_y * global_domain_width + 1;

		//check domainID
		if( domainID > num_local_domains ){
			cerr << "Parse error in line " << line << 
			": (z,y) coordinate given leads to domainID outside allowed range. See README for details." << endl;
			exit( BAD_DOMAIN_ID );
		}

		//calculate the channelID within the domainID above
		channelID = z_location - (flattened_z * local_domain_width) 
					+ (y_location - (flattened_y * local_domain_height)) * local_domain_width;

		//check channelID
		if( channelID >= local_domain_width * local_domain_height ){
			cerr << "Parse error in line " << line << 
			": (z,y) coordinate given leads to channelID outside allowed range. See README for details." << endl;
			exit( BAD_CHANNEL_ID );
		}

		//get actuator value
		actuatorValue = (int)floor(val * MAX_VOLTAGE);

		actuatorRecords.push_back( new Record(domainID, channelID, t, actuatorValue) );

	}

}