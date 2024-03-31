<h1 align="center">JDownloader Metadata To Stash</h1>
<p align="center"><img src="/readme_assets/header.png" ></p>

**JDownloader Metadata To Stash** facilitates easy import of URL metadata from JDownloader right into to your Stash.

* Works on all major operating systems!
* Great way to get URLs from your downloads into your Stash for further metadata scraping!
* Simple to setup and use!

## 💻 Requirements
- Microsoft Windows, macOS, or your favourite distro of Linux
- Stash ([Latest Version](https://github.com/stashapp/stash/releases/))
- JDownloader ([Latest Version](https://jdownloader.org/))
- Microsoft Powershell (available on all major operating systems) ([Latest Version](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell))


## 🍦 How it Works
-  The **JDownloader2 script** auto-triggers when files are downloaded and it saves a sidecar `.csv` file by the downloaded file containing `filename`, `filesize` and `URL` metadata.
-  The **JD2_CSV_To_Stash.ps1** Powershell script iterates through a defined folder and parses sidecar `.csv` files against your Stash.<br /> It'll add missing URLs to scenes that need it.

## 📖 Adding the JDownloader2 event script
<img src="/readme_assets/JDownloader.png" width="50%" height="50%" >

This part teaches JDownloader how to generate sidecar files for your downloads. <br /> There are a few steps here, but don't worry-- you only need to do this once!

- Open [JD2_WriteInfoCSV.js](https://github.com/ALonelyJuicebox/JD2_WriteInfoCSV/blob/main/JD2_WriteInfoCSV.js) and copy everything to your clipboard
- With JDownloader2 installed, go to JDownloader2's Settings menu and install the **Event Scripter** plugin (if it is not already installed.)
- Click on the newly installed **Event Scripter** plugin in the Settings menu, and then click on the **"+ Add"** button at the bottom of the screen
- Name the script **"Write download information to a CSV"**
- Set the Trigger to **"Package finished"**
- Click on the **Edit** button to the right of the newly named empty script
- In the window that appears, **paste** the contents of the script and save the file
- Done!

## 📖 Importing URL metadata into Stash

<img src="/readme_assets/Import_JD2_CSV_To_Stash.png" >
This part imports the URL metadata found in your sidecar metadata files into Stash.
You'll want to run this whenever you have new sidecar files to add to Stash.

1. Download `Import_JD2_CSV_To_Stash.ps1` to your filesystem
2. Run `Import_JD2_CSV_To_Stash.ps1` 
3. Select the folder you'd like to parse sidecar files from
4. Press `Enter` when prompted to start the import
5. Done!
