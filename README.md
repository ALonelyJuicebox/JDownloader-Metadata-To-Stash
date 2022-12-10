# JD2_WriteInfoCSV
Based on the JDownloader2 writeInfoFile script, this script outputs information about a download into a CSV file stored in the same path as the downloaded file. 

This is a great tool if you need to get URLs for your downloads into another platform and are saavy enough to scrape the CSV files in order to pull that data.
 
The information in the CSV file includes the **Filename**, the **Filesize (in bytes)** and the **URL** used to download the file
 
## Setup Instructions:
- Install JDownloader2
- Install the Event Scripter plugin for JDownloader2 by going to JDownloader Settings
- Add this script (Making sure to set the Trigger to "Package Finished")
 
## Additional Details 
- In a normal instance where there's just one file in the package, this will generate a single line CSV with the filename, filesize (in bytes) and URL.
- In a circumstance where a JD2 package has multiple files, this will give you a multi line CSV where each line will have a filename, filesize (in bytes) and the respective URL.
- In the event that the URL is undeterminable, the URL field in the CSV will be defined as 'undefinedURL'

