# Test Plan



## Descriptions

* Descriptions of tools used

    >There are few regression testing tools for MATLAB, so we will have to test this part of the code body
	manually, by passing in inputs and checking for known outputs. This should be sufficient, since our
	use of MATLAB is limited to small tasks which take advantage of built-in MATLAB functions, which are
	presumably well-tested.

    >LewOS is configured with CMake, so we may use CTest and CDash for regression testing of the C++ part
	of the code body. We will also test manually using the LewOS simulator, passing in inputs checking for
	known outputs.

    >CTest: Testing tool distributed as part of CMake. Can automate testing and other functions,
	and submit results to a dashboard system, here, CDash. [http://cmake.org/Wiki/CMake/
	Testing_With_CTest]
	CDash: [http://www.cdash.org/]

* Descriptions of Types of End Users

    >Applied Mathematician: Applied Mathematicians will submit a mathematical wave description
	and receive a visual representation of the exciter signals sent to hardware to produce the wave.
	(When hardware is working, Mathematician will have the option to send this wave to the wave
	tank.)
	
    >Hardware Tester: Hardware Tester may submit a wave and view the textual output report
	given by LewOS. This report will be a description of signals sent to certain hardware at specific
	times, which may be compared to the actual physical motion of the equipment. Note that the
	Hardware Tester does not care about the relationship between the input wave and the signal
	output, only the relationship between the signal output and the performance of their hardware.


## If time were not an issue...

* Unit testing
    * Any and every function would have a set of inputs and expected outputs that cover any suspected corner cases as well as average cases.  At any time we would be able to run these tests to ensure that every individual piece of the process is working as expected.  This would include sample input to collect metadata from, sample input to be parsed, sample input to interpolate, sample data to create a LewOS macro, samples with errors in them to be caught by the log, etc.

* Integration and systems testing (with ui)
    * Our product is only going to be used in conjunction with LewOS which only runs on linux systems, so we do not need to test using Mac or Windows.  We would want to test the UI on several different popular versions of linux (that LewOS works on) in order to verify that the UI appears properly.

* Usability Testing
    * Usability testing would be performed by distributing our software to the entire Applied Mathematics group (including those who may or may not be directly involved with UNC Fluids Lab). Researchers from the Fluids Lab will be included to ensure they are comfortable with our product; users not involved with the Fluids Lab will be included to guarantee that as new users join the lab our software can be easily learned. Furthermore, we would test the installation steps for our software. We envision our product being distributed in a stand-alone tar/zip file where installation instructions can be followed from a README. Unfortunately we cannot spend time optimizing language and/or design to ease a user's installation process, therefore, we will simply provide a best-effort README file.

* Acceptance Testing
    * For the purposes of acceptance testing, our software as a whole will be considered a black box designed to take the discrete representation of a waveform and output a LEWOS Macro which will generate a waveform of the same general shape as the input representation. Since it is unfeasible to constantly be testing our software in the wavetank, we will add graphing capabilities to existing software which simulates the exitation pattern of a LEWOS Macro and use the graphing capabilities to determine if our macro generates the desired output.
	Testing the graphing capabilities added to the LEWOS simulator will be relatively simple.  
The output of the simulator resembles the following:

    > Excitation of channel number N at time T
      
* *  (in our case, a channel constitutes a piston which will be moving water). Thus, our graphing software will simply need to pictorally represent a time series of binary data (excited or not) for each channel.
	Currently, the end-goal of our system is to generate a physical wave that can be matched to an intended wave after tweaking the physical model used to creat an input representation. With additional time, we would perform testing rounds to statistically determine what tweaking of physical models our system needs and implement correcting factors such that correcting factors previously needed can be bypassed.

## Since time is an issue...

* Unit testing
	* Our actual testing will have a breadth similar to our ideal testing, but since sample inputs and outputs are hard to come by, we won't be able to have as many different test cases as would be ideal.

* Integration and systems testing (with ui)
	* We will test our UI on only a few Linux systems; the ones that we run ourselves.

* Usability Testing
	* Usability testing will be performed by distributing our software to up to 3-4 applied mathematicians who may or may not be directly involved with UNC Fluids Lab. Researchers from the Fluids Lab will be included to ensure they are comfortable with our product; users not involved with the Fluids Lab will be included to guarantee that as new users join the lab our software can be easily learned. 

* Acceptance Testing
	* For the purposes of acceptance testing, our software as a whole will be considered a black box designed to take the discrete representation of a waveform and output a LEWOS Macro which will generate a waveform of the same general shape as the input representation. Since it is unfeasible to constantly be testing our software in the wavetank, we will add graphing capabilities to existing software which simulates the exitation pattern of a LEWOS Macro and use the graphing capabilities to determine if our macro generates the desired output.
	Testing the graphing capabilities added to the LEWOS simulator will be relatively simple. The output of the simulator resembles the following:
    > Excitation of channel N at time T
	* where N stands for the channel number (in our case, a channel constitutes a piston which will be moving water). Thus, our graphing software will simply need to pictorally represent a time series of binary data (excited or not) for each channel.
