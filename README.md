# Download Info to CSV file (JD2 Event Script)
![Image of JDownloader2](https://github.com/ALonelyJuicebox/JD2_WriteInfoCSV/blob/main/JDownloader.png)
Based on the JDownloader2 `writeInfoFile` script, this script (`JD2_WriteInfoCSV.js`) exports file information about a given download into a CSV file stored in the same path as the downloaded file. 

This triggers on each newly completed download, creating a bespoke CSV file for each file.

This is a *great* tool if you need to get URLs for your downloads into another platform and are saavy enough to scrape the CSV files in order to pull that data.
 
The information in the CSV file includes the **Filename**, the **Filesize (in bytes)** and the **URL** used to download the file
 
## Setup
- Open [JD2_WriteInfoCSV.js](https://github.com/ALonelyJuicebox/JD2_WriteInfoCSV/blob/main/JD2_WriteInfoCSV.js) and copy everything to your clipboard
- With JDownloader2 installed, go to JDownloader2's Settings menu and install the **Event Scripter** plugin
- Click on the newly installed **Event Scripter** plugin in the settings menu, and then click on the **"+ Add"** button at the bottom of the screen
- Name the script **"Write download information to a CSV"**
- Set the Trigger to **"Package finished"**
- Click on the **Edit** button to the right of the newly named empty script
- In the window that appears, **paste** the contents of the script and save the file
- Done!
 
## Additional Details 
- In a normal instance where there's just one file in the package, this will generate a single line CSV with the `filename`, `filesize (in bytes)` and `URL`.
- In a circumstance where a JD2 package has multiple files, this will give you a multi line CSV where each line will have a `filename`, `filesize (in bytes)` and the respective `URL`.
- In the event that the URL is undeterminable, the URL field in the CSV will be defined as 'undefinedURL'

