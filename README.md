<h1 align="center">JDownloader Metadata To Stash</h1>
<p align="center"><img src="/readme_assets/header.png" ></p>

**JDownloader Metadata To Stash** facilitates easy import of (URL) metadata from JDownloader right into to your Stash.

* Simple to setup and use!
* Works on all major operating systems!
* Great way to get URLs from your downloads into your Stash for further metadata scraping!

## 🍦 How it Works
As files are downloaded, the JDownloader script saves a sidecar `.csv` file by the downloaded file containing `filename`, `filesize` and `URL` metadata.

The Powershell script iterates through whatever folder you provide it, and uploads metadata from the sidecar `.csv` files into your Stash for matching files.

## 📖 Setup - Adding the JDownloader2 event script
<img src="/readme_assets/JDownloader.png" width="50%" height="50%" >

This part teaches JDownloader how to generate sidecar files for your downloads. <br /> There are a few steps here, but don't worry-- you only need to do this once!

1. Open `JD2_WriteMetadataToCSV.js` and copy everything to your clipboard
2. With JDownloader2 installed, go to JDownloader2's Settings menu and install the **Event Scripter** plugin (if it is not already installed.)
3. Click on the newly installed **Event Scripter** plugin in the Settings menu, and then click on the **"+ Add"** button at the bottom of the screen
4. Name the script **"Write download information to a CSV"**
5. Set the Trigger to **"Package finished"**
6. Click on the **Edit** button to the right of the newly named empty script
7. In the window that appears, **paste** the contents of the script and save the file
8. Done!

## 📖 Setup - Importing URL metadata into Stash
<img src="/readme_assets/import_jd2_csv_to_stash.png" >

This part imports the URL metadata found in your sidecar metadata files into Stash. <br />
You'll want to run this whenever you have new sidecar files to add to Stash.

1. Download `Import_JD2_CSV_To_Stash.ps1` to your filesystem
2. Run `Import_JD2_CSV_To_Stash.ps1` 
3. Select the folder you'd like to parse sidecar files from
4. Press `Enter` when prompted to start the import
5. Done!

## 💻 Requirements
- Microsoft Windows, macOS, or your favourite distro of Linux
- Stash ([Latest Version](https://github.com/stashapp/stash/releases/))
- JDownloader ([Latest Version](https://jdownloader.org/))
- Microsoft Powershell (available on all major operating systems) ([Latest Version](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell))
