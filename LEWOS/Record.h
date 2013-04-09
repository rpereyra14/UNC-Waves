class Record{

	Record( int domain, int channel, int t, int val );
	int domainID;
	int channelID;
	int timeOffset;
	int actuatorValue;

};

Record::Record( int domain, int channel, int t, int val ){

	Record::domainID = domain;
	Record::channelID = channel;
	Record::timeOffset = t;
	Record::actuatorValue = val;

}

struct comparator{
	bool operator()(Record &a, Record &b ){
		return (*a).domainID < (*b).domainID || (*a).channelID < (*b).channelID || (*a).timeOffset < (*b).timeOffset;
	}
} compareRecords;