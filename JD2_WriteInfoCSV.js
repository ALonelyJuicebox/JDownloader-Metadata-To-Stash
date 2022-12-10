/*
    Date: 12/9/2022    
    Author: Juicebox (https://github.com/ALonelyJuicebox/JD2_WriteInfoCSV)
    Event Script: JD2_WriteInfoCSV
  

    Description
        Based on the writeInfoFile script, this script generates an informational CSV file in the same location as the downloaded file.
        The information in the CSV file includes the filename, the filesize (in bytes) and the URL used to download the file
        
        In a normal instance where there's just one file in the package, this will generate a single line CSV with the filename, filesize (in bytes) and URL.
        In a circumstance where a JD2 package has multiple files, this will give you a multi line CSV where each line will have a filename, filesize (in bytes) and the respective URL.
        In the event that the URL is undeterminable, the URL field in the CSV will be defined as 'undefinedURL'
                  
    Version: 0.1
 
 Requirements:
    1 - Install the Event Scripter plugin for JDownloader2
    2 - Add this script (making sure to set the trigger to "package finished")


 Tested:
     JD2 on Windows 10/11 (x64) (see path-creation code at the end of this script) 
 */


//---------- Global declarations -----------------
var bWriteFile = false; // Only create a CSV file if the package was indeed downloaded
var sInfoFilePath = ""; // The CSV is packaged based, so if there is a package of files with different filenames inside the package, the CSV file will be appended to, otherwise, a new CSV file will be created.
var sText = ""; // Variable includes all data to be added to the file
var sInfoFileType = ".csv" // If you have a wacky use case, you can change this filetype, but CSV is accurate
var myPackage = package;
var aParts = myPackage.getDownloadLinks();


// Only create the CSV if the items in the package were indeed downloaded
if (myPackage.isFinished() == true) {
    bWriteFile = true;
}


// Constructing the CSV
if (bWriteFile == true) {

    for (var i = 0; i < aParts.length; i++) {
        sText += "\"" + aParts[i].getName() + "\"," + aParts[i].getBytesTotal() + ",";
        if (aParts[i].getUrl() != undefined) {
            sText += aParts[i].getUrl() + ",\r\n";
        }
        else{
            sText += "undefinedURL,\r\n";
        }
    }
}

// CSV file path creation (or updating)
if (bWriteFile == true) {
    sInfoFilePath = myPackage.getDownloadFolder() + "/" + myPackage.getName() + sInfoFileType; //path creation
    
    // Writing to the filesystem
    try {
        writeFile(sInfoFilePath, sText, true);
    } catch (e) {
        //Be aware that no error handling has been implemented. That said, since the CSV file is generated in the same folder as the downloaded file(s), this shouldn't be an issue    
    }
}