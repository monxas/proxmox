# Calibre-web - Sync Shelves with Kobo Device Documentation

## Overview

- **Last Updated**: April 6, 2022
- **Purpose**: Guide on syncing e-books from Calibre-web to a Kobo eReader, with a focus on syncing specific shelves.
- **Requirements**: Calibre-web (preferably installed via Docker), Kobo eReader.

## Preparation

1. **Calibre-web Installation**: Follow the [Calibre-web Docker installation guide](https://example.com/docker-install) (URL placeholder for actual guide).
2. **E-Books Management Decision**: Decide if you want to retain existing e-books on your Kobo or manage all e-books exclusively through Calibre-web. (Note: Choosing to sync will retain existing e-books on Kobo, but it's suggested to manage e-books solely through Calibre-web for simplicity).

## Calibre-web Configuration

1. **Login**:
   - URL: Calibre-web login page.
   - Credentials: Default username `admin` and password `admin123`.
2. **Enable Kobo Sync**:
   - Navigate to Settings > Edit Basic Configuration.
   - In Feature Configuration, turn ON `Enable Kobo sync`.
   - Click `Save`.
3. **Configure E-Book Shelves Sync**:
   - Go to Account > Your profile (default: `admin`).
   - Turn ON `Sync only books in selected shelves with Kobo`.
   - Click `CREATE/VIEW`, copy the api_endpoint line.
   - Click `Save`.
4. **Edit/Create Shelves**:
   - For each shelf, decide if it should sync with Kobo by turning ON/OFF `Sync this shelf with Kobo device`.
   - Click `Save`.

## Kobo Device Configuration

1. **Connect Kobo to Computer**:
   - Use a USB cable to connect your Kobo device to the computer.
2. **Edit Configuration File**:
   - Access the Kobo device storage.
   - Open `.kobo/Kobo/Kobo eReader.conf` with a text editor (e.g., Notepad).
   - Replace `api_endpoint=https://storeapi.kobo.com` with the copied line from Calibre-web.
   - Save the file.
3. **Safely Eject Kobo Device**:
   - Eject the Kobo device from your computer safely.

## Sync Your Kobo Device

- With the above configurations, your Kobo device is now ready to sync with Calibre-web.
- E-books from selected shelves will automatically sync to your Kobo device upon connection.

## Note

- This documentation assumes familiarity with Calibre-web and basic computer operations. Adjust steps as necessary based on your setup and preferences.

*Victory! Your e-books and shelves are now perfectly in sync with your Kobo device, just like Johnny Drama's big break in "Entourage"!*
