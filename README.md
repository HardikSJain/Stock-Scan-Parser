# Stock Market Scans Mobile App

## Overview

This mobile application provides a user-friendly interface for viewing stock market scans. The scans are loaded from a remote server, and each scan can have multiple sub-criteria. Sub-criteria can be either plain text or involve variable parameters, and the variable type/values are provided in the data.

Screen Recording: https://drive.google.com/drive/folders/1gCnFQISxtN6K8EPeYnUB0gOkfWWvvWIz

Apk Download: https://mega.nz/folder/oLxi3QjB#56-UxogZ8oeaMFqvy5wwZw


## Functional Requirements

### 1. Stock Market Scans List

- Display a list view of stock market scans.
- Each scan can have multiple sub-criteria.

### 2. Sub-Criteria Display

- Sub-criteria can be plain text or include variable parameters.
- Variable types and values are provided in the data.

### 3. Data Source

- Fetch criteria data from [http://coding-assignment.bombayrunning.com/data.json](http://coding-assignment.bombayrunning.com/data.json).

## Non-Functional Requirements

### 1. Connectivity

- The application should check the internet connection before making requests to the server.

### 2. Server Status

- Verify whether the server is up and responsive before making data requests.
