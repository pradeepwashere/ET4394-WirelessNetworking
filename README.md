# ET4394-WirelessNetworking
## RTL SDR FM Discrminator

A FM Reciever has been implemented using RTL-SDR Toolbox from MATLAB.
The Simulink model has also been created for the same. 

## Wireshark Project
── DataFiles <br/>
│   ├── 13:54 <br/>
│   │   ├── bigdatamrt_05_2018.txt <br/>
│   │   ├── commonsub.txt <br/>
│   │   ├── countmrt_05_2018.txt <br/>
│   │   ├── finaldatamrt_05_2018.txt <br/>
│   │   ├── mediumdatamrt_05_2018.txt <br/>
│   │   ├── parse.py <br/>
│   │   ├── sortedCount.txt <br/>
│   │   ├── statistics.sh <br/>
│   │   └── statistics.txt <br/>

── bashscript.sh


- bashscript.sh : Bash script for sniffind packets using tshark running on the command line, monitoring on mon1 interface. Also checks for hidden packets
- parse.py      : Python Script to find the Largest Common Substrings given the list of SSIDs
- bigdatamrt_05_2018.txt : First dump file created on using tshark
- mediumdatamrt_05_2018.txt : Second dump file created after processing bigdatamrt_05_2018.txt
- finaldatamrt_05_2018 : Unique SSIDs list
- sortedCount.txt : Frequency of occurence of each SSID in ascending order
- statistics.sh : Computes the number of unique SSIDs and the average length of SSIDs
- statistics.txt: Contains the number of unique SSIDs in the dump file and the average length of the SSID
- commonsub.txt : Contains list of common substrings for each list obtained.
