README:

================================
Blue Medora Log Generator Script
================================

The Blue Medora log generator script allows you to tail a log file for a certain amount of time. This will output the log you choose to a new log and prevent the log from rolling over. This ensures that Blue Medora support receives the logs they need to troubleshoot the particular product.

Installing and running the script is very easy and you don't need to transfer any files. 

1. Simply copy the string of text in the "bluemedora_log_generator_base64_string.txt" file onto your vROps node and press ENTER.
	
	a. base64 allows us to encode the script into a string of text. When you copy and paste the text into your system, it will automatically decode the file and set necessary permissions to execute the script.

2. run "./bluemedora_log_generator_v.1.0.7.sh" from the command line (wihtout teh quotes).

That's it! The script will ask a few simple questions and then complete.

