## Things you'll need (Software dependencies)

* MATLAB

    > Obtain this from UNC and install it.

* LEWOS

	> Obtain this from UNC-CS department: `$ git clone ssh://crmullin@login.cs.unc.edu/afs/unc/proj/stm/src/git/LEWOS.git` 

* CMake
	> cmake.org

## Hardware specifications
* These don't exist yet.  
	* However the hardware is configured, make sure that the 0 voltage in the LewOS config file is mapped to half of the voltage of the actual hardware.
	* This way, the exciter will be able to move back and forth, in both directions.


## Compiling the Wavetank simulator with superbuild

* First, you'll need to get LEWOS.  Integration to download LEWOS is tricky because we have to authenticate.

* Create your superbuild directory:
	<pre>
	$ mkdir UNC_Waves_Simulator-superbuild && cd UNC_Waves_Simulator-superbuild
	</pre>
* Configure:
	<pre>
	$ cmake -DCMAKE_C_COMPILER:PATH=/usr/bin/gcc \
	  -DCMAKE_CXX_COMPILER:PATH=/usr/bin/g++ \
	  -DLEWOS_ROOT_DIR:PATH=/path/to/LEWOS \
	  /path/to/UNC-Waves/LEWOS/UNC-Waves_Simulator
	</pre>

* Build:
	<pre>
	$ make
	</pre>

*Test (if you like)
	<pre>
	$ make test
	</pre>


## Compiling without superbuild
* First, obtain VRPN:

	> You can download it here:  http://www.cs.unc.edu/Research/vrpn/
* Build VRPN:
	<pre>
	$ mkdir vrpn-build && cd vrpn-build
	$ cmake /path/to/vrpn
	$ make
	</pre>
	
* Build LEWOS_xlate_lib:
	<pre>
	$ mkdir LEWOS_xlate_build && cd LEWOS_xlate_build
	$ cmake -DVRPN_LIBRARY:PATH=/path/tovrpn-build/libvrpn.a \
	  -DVRPN_INCLUDE_DIR:PATH=/path/to/vrpn/ \
      -DQUATLIB_LIBRARY:PATH=/path/to/vrpn-build/quat/libquat.a \
      -DQUATLIB_INCLUDE_DIR:PATH=/path/to/vrpn/quat/ \
      -DCMAKE_C_COMPILER:PATH=/usr/bin/gcc \
      -DCMAKE_CXX_COMPILER:PATH=/usr/bin/g++ \
      /path/to/LEWOS/LEWOS_xlate_lib/
	$ make
      </pre>

* Build LEWOS_sim_lib:
	<pre>
	$ mkdir LEWOS_sim_build && cd LEWOS_sim_build
	$ cmake -DVRPN_LIBRARY:PATH=/path/to/vrpn-build/libvrpn.a \
          -DVRPN_INCLUDE_DIR:PATH=/path/to/vrpn/ \
          -DQUATLIB_LIBRARY:PATH=/path/to/vrpn-build/quat/libquat.a \
          -DQUATLIB_INCLUDE_DIR:PATH=/path/to/vrpn/quat/ 
          -DLEWOS_xlate_LIBRARY:PATH=/path/to/LEWOS_xlate-build/libLEWOS_xlate.a \
          -DLEWOS_xmit_LIBRARY:PATH=/path/to/LEWOS_xlate-build/libLEWOS_xmit.a \
          -DCMAKE_C_COMPILER:PATH=/usr/bin/gcc \
          -DCMAKE_CXX_COMPILER:PATH=/usr/bin/g++ \
          -DLEWOS_INCLUDE_DIR:PATH=/path/to/LEWOS/LEWOS_xlate_lib/ 
          -DLEWOS_api_LIBRARY:PATH=/path/to/LEWOS_xlate-build/libLEWOS_api.a  \
      	  /path/to/LEWOS/LEWOS_sim_lib/
	$ make
	</pre>

* Finally, build the wavetank simulator
	<pre>
	$ mkdir Wavetank_simulator && cd Wavetank_simulator
	$ cmake -DVRPN_LIBRARY:PATH=/path/to/vrpn-build/libvrpn.a \
          -DVRPN_INCLUDE_DIR:PATH=/path/to/vrpn/ \
          -DLEWOS_xmit_LIBRARY:PATH=/path/to/LEWOS_xlate-build/libLEWOS_xmit.a \
          -DLEWOS_xlate_LIBRARY:PATH=/path/to/LEWOS_xlate-build/libLEWOS_xlate.a \
          -DLEWOS_api_LIBRARY:PATH=/path/to/LEWOS_xlate-build/libLEWOS_api.a  \
          -DLEWOS_ROOT_DIR:PATH=/path/to/LEWOS/LEWOS_xlate_lib/ \
          -DLEWOSSIM_LIBRARY:PATH=/path/to/LEWOS_sim-build/libLEWOS_sim.a \
          -DQUATLIB_LIBRARY:PATH=/path/to/vrpn-build/quat/libquat.a \
          -DQUATLIB_INCLUDE_DIR:PATH=/path/to/vrpn/quat/ \
          -DLEWOSSIM_INCLUDE_DIR:PATH=/path/to/LEWOS/LEWOS_sim_lib/ \
          /path/to/UNC-Waves/LEWOS/UNC-Waves_simulator
	$ make
	</pre>
        
