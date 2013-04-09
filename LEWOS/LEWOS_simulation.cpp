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
#include <math.h>					//for floor
#include <iostream>					//for I/O
#include <fstream>					//for reading input file
#include <string>					//for handling of input file
#include <algorithm>				//for sorting records by domainID/timeOffset

#define VERBOSITY 		4			//verbosity value for LEWOS simulation (ranges from 0 to 4, 4 being most verbose)
#define MAX_VOLTAGE		65536		//max LEWOS analog value
#define MISUSAGE 		1			//return code for misusage (i.e. unspecified input file)
#define BAD_FILE 		4			//return code for bad input file (i.e. input file unable to be opened)
#define BAD_DOMAIN_ID 	5 			//return code for bad domainID calculated from input file
#define BAD_CHANNEL_ID 	6			//return code for bad channelID calculated from input file
#define INIT_MACRO_ID	100			//arbitrary macroID, the ID is inconsequential as long as below 256
#define EVENT_ID 		100			//eventID must match the channelID in Lst_read_event
#define TIME_OFFSET		10 			//the time offset is set to 10 to ensure enough time for reading of instructions

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
void prepMacro();

int main( int argc, char* argv[] ){

	//verify an input file was specified
	if( argc != 2 ){
		cerr << "USAGE: ./LEWOS_simulation <input_file>. See README for <input_file> format." << endl;
		exit( MISUSAGE );
	}

	parsefile( argv[1] );
	prepMacro();

	return 0;

}

static void Lst_handle_analog(void *userdata, LEWOS_u16 channel, LEWOS_api_time time, LEWOS_u16 new_value){
	LEWOS_u16 *report_value = static_cast<LEWOS_u16 *>(userdata);
	*report_value = new_value;
}

static void Lst_read_event(void *userdata, LEWOS_u16 channel, LEWOS_api_time time, bool &triggered_out){
	if (channel == 100) { // We only trigger events on channel 100
		bool *do_event = static_cast<bool *>(userdata);
		if (*do_event) {
			triggered_out = true;
			*do_event = false;
		} else {
			triggered_out = false;
		}
	} else {
		triggered_out = false;
	}
}

int get_num_instructions( int domain, int channel ){

	//the instruction count
	int count = 0;

	//since list is sorted, keep a bool to determine if the block of records for a domain-channel combination has ended
	bool fndBlock = false;

	//count the instructions
	for( int i = 0; i < actuatorRecords.size(); i++ ){
		if( (*actuatorRecords[i]).domainID == domain && (*actuatorRecords[i]).channelID == channel ){
			count++;
			fndBlock = true;

		}
		else if( fndBlock ){
			break;
		}
	}

	return count;

}

void prepMacro(){

	//get the current time
	struct timeval now;
	vrpn_gettimeofday(&now, NULL);

	/* REFERENCE:
	LEWOS_sim_domain::LEWOS_sim_domain(LEWOS_u16 domainID, const timeval init_time,
										LEWOS_u16 num_local_domains,
										unsigned num_binary_in, unsigned num_analog_in,
										unsigned num_binary_out, unsigned num_analog_out,
										unsigned num_events,
										bool report_scheduled_time)
	*/

	//intialize domains vector with the global domain (note that the domainID is 0)
	std::vector<LEWOS_sim_domain *> domains;
	domains.push_back( new LEWOS_sim_domain(0, now, num_local_domains, 0, 1, 0, 0, 1) );

	//add local domains with i as domainID and local_domain_width * local_domain_height as number of channels.
	//These domains will have 1 trigger event.
	for( int i = 1; i <= num_local_domains; i++ )
		domains.push_back( new LEWOS_sim_domain(i, now, 0, 0, local_domain_width * local_domain_height, 0, 0, 1) );

	//initalize LEWOS_sim
	LEWOS_sim sim( domains );

	//set verbosity value: ranges from 0 - 4 with 4 being most verbose
	sim.set_verbosity( VERBOSITY );

	//the macro initialization requires that instructions for a given domain/channel combination be contiguous, therefore will sort using
	//compareRecords struct found in Record.h
	sort( actuatorRecords.begin(), actuatorRecords.end(), compareRecords );

	/****************************************************************

							SERVER CODE

	****************************************************************/

	//bookkeeping
	int analogs[ domains.size() ];

	//used to trigger event; false for untriggered
	bool event_in = false;

	//instruct the server to call Lst_handle_analog when an analog value is inputted.
	//The proper index of analogs and events is set to equal the latest input value.
	for( int j = 0; j < domains.size(); j++ ){
		(*domains[j]).register_report_analog(Lst_handle_analog, &analogs[j]);
		(*domains[j]).register_read_event(Lst_read_event, &event_in);
	}

	/****************************************************************

							END SERVER CODE

	****************************************************************/

	/****************************************************************

							CLIENT CODE

	****************************************************************/

	LEWOS_api_domain *d;			//handle for local domains
	int macroID = INIT_MACRO_ID;

	for( int i = 1; i <= num_local_domains; i++ ){

		//get a handle for the ith local domain
		d = new LEWOS_api_domain(sim, i);

		//give the instruction a very long time to act (20 seconds), simply to ensure all instructions take place in simulation
		//will need to be tweaked in live hardware
		d -> instruct_set_deadline( LEWOS_api_time(0, 20000) );

		//build a separate macro for each channel in each local domain
		for( int j = 0; j < local_domain_width * local_domain_height; j++ ){

			//define macro
			d -> instruct_define_macro( LEWOS_xlate_timebase_NOW, macroID, get_num_instructions(i, j), TIME_OFFSET );

			//add macro instructions
			bool fndBlock = false;			//used to deterimine when the block of domain-channel pairings ends
			for( int k = 0; k < actuatorRecords.size(); k++ ){
				if( (*actuatorRecords[k]).domainID == i && (*actuatorRecords[k]).channelID == j ){

					/* REFERENCE
					bool LEWOS_api_domain::instruct_analog_set(	const LEWOS_u8 TimeBase,
																const LEWOS_u8 AnalogID,
																const LEWOS_u16 Value,
																const LEWOS_u32 TimeOffset)*/
					d -> instruct_analog_set( LEWOS_xlate_timebase_NOW, 0, (*actuatorRecords[k]).actuatorValue, (*actuatorRecords[k]).timeOffset );

					fndBlock = true;

				}
				else if( fndBlock ){
					break;
				}
			}

			//define trigger event
			d -> instruct_map_reflex( LEWOS_xlate_timebase_NOW, macroID, EVENT_ID, TIME_OFFSET );

			//increase macroID: this means that the next channel will get a new ID
			macroID++;

		}

		//reset the macroID so next local domain starts at INIT_MACRO_ID
		macroID = INIT_MACRO_ID;

		//get the start time for syncing
		struct timeval start;
		vrpn_gettimeofday(&start, NULL);

		do {
			//update link between client and server
			d->poll();
			vrpn_gettimeofday(&now, NULL);
		} while (now.tv_sec - start.tv_sec <= 1);

	}

	/****************************************************************

							END CLIENT CODE

	****************************************************************/

	//prep event for triggering
	event_in = true;

	//get a handle for the global domain
	d = new LEWOS_api_domain(sim, 0);

	//fire event
	struct timeval start;
	vrpn_gettimeofday(&start, NULL);
	do {
		//update link between client and server
		d->poll();
		vrpn_gettimeofday(&now, NULL);
	} while (now.tv_sec - start.tv_sec <= 1);

}

void parsefile( const string& filename ){
	//open input file
	ifstream infile;
	infile.open( filename.c_str() );

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

	cout << "READING FILE" << endl;

	//parse input file
	while( getline( infile, temp, ' ' ) ){

		line++;

		//read the input z_location
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

		cout << "line: " << line << " -domainID: " << domainID << " -channelID: " << channelID 
									<< " -time: " << t << " -value: " << actuatorValue << endl;

		actuatorRecords.push_back( new Record(domainID, channelID, t, actuatorValue) );

	}

}