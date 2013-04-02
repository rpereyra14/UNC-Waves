#include <LEWOS_sim.h>
#include <stdio.h>
#include <string.h>
#include <math.h>

#define ASCII_ZERO 48
#define ASCII_FOUR 52
int MAX_VOLTAGE = 65536;

int main( int argc, char* argv[] ){

	int verbosity = 0;

	if( argc == 2 ){
		if( *argv[1] < ASCII_ZERO || *argv[1] > ASCII_FOUR ){
			printf("USAGE: ./LEWOS_Macro [verbosity], where verbosity (if present) is between 0 and 4.\n");
			return 1;
		}else{
			verbosity = *argv[1] - ASCII_ZERO;
		}
	}else if( argc == 1 ){
		//do nothing, verbosity already set to zero above
	}else{
		printf("USAGE: ./LEWOS_Macro [verbosity], where verbosity (if present) is between 0 and 4.\n");
		return 1;
	}

	//Create a set of domain simulators
	/* REFERENCE:
	LEWOS_sim_domain::LEWOS_sim_domain(LEWOS_u16 domainID, const timeval init_time,
										LEWOS_u16 num_local_domains,
										unsigned num_binary_in, unsigned num_analog_in,
										unsigned num_binary_out, unsigned num_analog_out,
										unsigned num_events,
										bool report_scheduled_time)
	*/

	struct timeval now, start;
	vrpn_gettimeofday(&now, NULL);
	LEWOS_sim_domain global(0, now, 4, 2, 2, 2, 2, 256);			//what constitutes an event? i.e. how many events should I have?
	LEWOS_sim_domain local1(1, now, 0, 2, 2, 2, 2, 2);				//how to determine number of analog/binary in/out?
	LEWOS_sim_domain local2(2, now, 0, 2, 2, 2, 2, 2);
	LEWOS_sim_domain local3(3, now, 0, 2, 2, 2, 2, 2);
	LEWOS_sim_domain local4(4, now, 0, 2, 2, 2, 2, 2);
	std::vector<LEWOS_sim_domain *> domains;
	domains.push_back(&global);
	domains.push_back(&local1);
	domains.push_back(&local2);
	domains.push_back(&local3);
	domains.push_back(&local4);
	LEWOS_sim sim(domains);
	sim.set_verbosity(verbosity);				//verbosity value ranges from 0 - 4 with 4 being most verbose

	//------------------------------------------------------------------
	// Set up an API to talk to the global domain over the sim
	// communicator.  Set the instruction deadline to be 20 milliseconds
	// so it is not likely to miss one.
	LEWOS_api_domain  *d = new LEWOS_api_domain(sim, 0);
	d->instruct_set_deadline(LEWOS_api_time(0,20000));

	//------------------------------------------------------------------
	// Set up callback handlers for the analog reads on
	// one of the domains and then issue instructions to cause those
	// events and see that we get the response we expect.	This basically
	// copies the values in the userdata into the channel.
	LEWOS_u16 	analog_in = 0;
	bool 		event_in = false;
	global.register_read_analog(Lst_read_analog, &analog_in);
	global.register_read_event(Lst_read_event, &event_in);

	//------------------------------------------------------------------
	// Set up a handler that causes and external event on the domain,
	// issue an event, and see if that causes a reflex to call the macro
	// associated with that event.	This basically causes one event
	// whenever the userdata is set to true, flipping it back to false
	// after this is done.

	// Define a macro that will cause a analog read and map a reflex
	// for an event to that macro.	Give this all time to happen.

	//REFERENCE: instruct_define_macro( TimeBase, MacroID, instruction_count, TimeOffset )
	d->instruct_define_macro(LEWOS_xlate_timebase_NOW, 100, 1, 10);			//I think macros are defined at the global domain? How about local?

	//REFERENCE instruct_analog_read( TimeBase, analogID, TimeOffset )
	d->instruct_analog_read(LEWOS_xlate_timebase_NOW, 0, 10);				//these communicate with the global domain (I think).
																			//how to communicate/set analogs with the local domain?
																			//Where did analogID get set? Or is it zero because only one analog
																			//(i.e. the first one/zero offset) was set in line 68?

	//REFERENCE: instruct_map_reflex( TimeBase, MacroID, EventID, TimeOffset )
	d->instruct_map_reflex(LEWOS_xlate_timebase_NOW, 100, 100, 10);			//Why are all the TimeOffsets 10? LEWOS_sim has them all be 10...?
																			//Why is eventID 100? MacroID is 100 because it set in line 82 that way so I get that
	vrpn_gettimeofday(&start, NULL);
	do {
		d->poll();
		vrpn_gettimeofday(&now, NULL);
	} while (now.tv_sec - start.tv_sec <= 1);

	//This is a really basic macro... essentially a "proof of concept" macro
	//I am simply having the global domain step through the max range of voltages with step sizes equal to MAX_VOLTAGE/100
	for( int i = 100; i >= 1; i-- ){

		int voltage = (int)ceil( (double)MAX_VOLTAGE/(double)i );			//get an analog voltage

		// Generate the event and see if this triggers the read.
		analog_in = voltage;
		event_in = true;	// This should trigger the event.
		vrpn_gettimeofday(&start, NULL);
		do {
			d->poll();
			vrpn_gettimeofday(&now, NULL);
		} while ((analog != voltage) && (now.tv_sec - start.tv_sec <= 3));
		if (analog != voltage) {
			fprintf(stderr,"Could not trigger external event.\n");
			return 1;
		}

	}

}