cmake_minimum_required(VERSION 2.6)
project(MACRO)

#-----------------------------------------------------------------------------
# Local CMake Modules
list(APPEND CMAKE_MODULE_PATH ${MACRO_SOURCE_DIR} ${MACRO_SOURCE_DIR}/cmake)

###
# On Windows 7, it does not work to install in the default location,
# which is the Program Files directory, because you have to not only have
# file permission to write there but also "run as administrator."  This
# means that "make install" from a Visual Studio project fails.  To get
# around that, we need to set CMAKE_INSTALL_PREFIX to something other
# than the default.  However, it is a cache variable that has already been
# set.  If we make a local variable, it uses this rather than the cache
# variable and never tells the poor user what happened (the GUI location
# looks standard but the files end up somewhere else).  If we make it a
# non-forced cache variable, it already has a value so does not change.
# If we make it a forced cache variable, it gets overwritten everytime
# and the user cannot change it on the GUI.  So we have a workaround here.
# We make a cache variable that records whether we have ever forced the
# install prefix.  If not, we force it.  If so, we don't force it again.
# This has the effect of setting it the first time cmake is run, showing
# the change in the GUI, and also letting the user change the value in
# the GUI if they don't like what we did.  If I knew how to do this only
# happen on Windows 7, I'd make the if(WIN32) more specific.
if (WIN32)
        if (NOT ONCE_SET_CMAKE_INSTALL_PREFIX)
                set(ONCE_SET_CMAKE_INSTALL_PREFIX true CACHE BOOL
                        "Have we set the install prefix yet?" FORCE)
                set(CMAKE_INSTALL_PREFIX c:/usr/local CACHE PATH
                    "Install path prefix, prepended onto install directories"
                    FORCE)
        endif (NOT ONCE_SET_CMAKE_INSTALL_PREFIX)
endif (WIN32)

#Build the testapps if required
option(LEWOSSIM_BUILD_EXAMPLES "Enable to build LEWOS examples" ON)

if(LEWOSSIM_BUILD_EXAMPLES)

	# Libraries that we need.
	FIND_PACKAGE(LEWOSSIM REQUIRED)
	FIND_PACKAGE(LEWOS REQUIRED)
	FIND_PACKAGE(VRPN REQUIRED)

	# Include directory needed by all of the files
	include_directories(${MACRO_SOURCE_DIR} ${LEWOSSIM_INCLUDE_DIR} ${LEWOS_INCLUDE_DIR} ${VRPN_INCLUDE_DIR})


	set(CPPAPPS
		LEWOS_ProofOfConceptMacro
		)


	foreach(APP ${CPPAPPS})
		add_executable(MACRO_${APP} ${APP}.cpp)
		target_link_libraries(MACRO_${APP} ${LEWOSSIM_LIBRARIES} ${LEWOS_LIBRARIES} ${VRPN_LIBRARIES})

		if(WIN32)	# MS-Windows, both 32 and 64 bits
			target_link_libraries(MACRO_${APP} wsock32)
		elseif(APPLE)	# Apple
			target_link_libraries(MACRO_${APP} m)	# Math library
		elseif(UNIX)	# other UNIXes
			target_link_libraries(MACRO_${APP} m)	# Math library
		endif()

	endforeach()

endif()

