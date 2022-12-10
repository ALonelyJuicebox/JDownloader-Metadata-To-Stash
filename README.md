# JD2_WriteInfoCSV
Based on the JDownloader2 writeInfoFile script, this script outputs file information about a download into a CSV file stored in the same path as the downloaded file. 

This is a great tool if you need to get URLs for your downloads into another platform and are saavy enough to scrape the CSV files in order to pull that data.
 
The information in the CSV file includes the **Filename**, the **Filesize (in bytes)** and the **URL** used to download the file
 
## Setup Instructions:
- Install JDownloader2
- Install the **Event Scripter** plugin for JDownloader2 by going to JDownloader's Settings menu
- Open JD2_WriteInfoCSV.js (the script included in this repository) in the text editor of your choice and copy everything to your clipboard
- Going back to JDownloader's Settings menu, click on **Event Scripter**, then click on the **"+ Add"** button at the bottom of the screen
- Name the script **"Write download information to a CSV"**
- Set the Trigger to **"Package finished"**
- Click on the **Edit** button to the right of the newly named empty script
- In the window that appears, paste the contents of the script and save the file
- Done!
 
## Additional Details 
- In a normal instance where there's just one file in the package, this will generate a single line CSV with the filename, filesize (in bytes) and URL.
- In a circumstance where a JD2 package has multiple files, this will give you a multi line CSV where each line will have a filename, filesize (in bytes) and the respective URL.
- In the event that the URL is undeterminable, the URL field in the CSV will be defined as 'undefinedURL'

