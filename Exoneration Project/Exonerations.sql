/*
Author: Tyson Jones 
Title: Exonorations Project
File: Exonerations.sql
Data Source:https://www.law.umich.edu/special/exoneration/Pages/about.aspx
Email: Tel.Jones@hotmail.com 
Date: April 11, 2023
Purpose: To clean my data and prepare it for analysis
Description: This SQL file cleans and orgainzies the Exonerations database.
Version: 1.0
Notes: This query was tested using Microsoft SQL Server Managment Studio. It may not work in other SQL environments.
*/

SELECT *
FROM PortfolioProject..Exonerationsv2

-- Have to remove the neccasary columns (Posting dates, Tags, OM tags)
ALTER TABLE Exonerationsv2
DROP COLUMN "Posting Date", "Tags", "OM Tags"

-- Then Went through the state columns and removed the word fed and put it into a new coloumn called fed
ALTER TABLE Exonerationsv2
ADD federal VARCHAR(3)

UPDATE Exonerationsv2
SET federal = CASE WHEN "State" LIKE 'Fed-%' THEN 'yes' ELSE 'no' END

UPDATE Exonerationsv2
SET "State" = REPLACE("State", 'Fed-', '')

UPDATE Exonerationsv2
SET State = 
  CASE State
    WHEN 'AL' THEN 'Alabama'
    WHEN 'AK' THEN 'Alaska'
    WHEN 'AZ' THEN 'Arizona'
    WHEN 'AR' THEN 'Arkansas'
    WHEN 'CA' THEN 'California'
    WHEN 'CO' THEN 'Colorado'
    WHEN 'CT' THEN 'Connecticut'
    WHEN 'DE' THEN 'Delaware'
    WHEN 'DC' THEN 'District of Columbia'
    WHEN 'FL' THEN 'Florida'
    WHEN 'GA' THEN 'Georgia'
    WHEN 'HI' THEN 'Hawaii'
    WHEN 'ID' THEN 'Idaho'
    WHEN 'IL' THEN 'Illinois'
    WHEN 'IN' THEN 'Indiana'
    WHEN 'IA' THEN 'Iowa'
    WHEN 'KS' THEN 'Kansas'
    WHEN 'KY' THEN 'Kentucky'
    WHEN 'LA' THEN 'Louisiana'
    WHEN 'ME' THEN 'Maine'
    WHEN 'MD' THEN 'Maryland'
    WHEN 'MA' THEN 'Massachusetts'
    WHEN 'MI' THEN 'Michigan'
    WHEN 'MN' THEN 'Minnesota'
    WHEN 'MS' THEN 'Mississippi'
    WHEN 'MO' THEN 'Missouri'
    WHEN 'MT' THEN 'Montana'
    WHEN 'NE' THEN 'Nebraska'
    WHEN 'NV' THEN 'Nevada'
    WHEN 'NH' THEN 'New Hampshire'
    WHEN 'NJ' THEN 'New Jersey'
    WHEN 'NM' THEN 'New Mexico'
    WHEN 'NY' THEN 'New York'
    WHEN 'NC' THEN 'North Carolina'
    WHEN 'ND' THEN 'North Dakota'
    WHEN 'OH' THEN 'Ohio'
    WHEN 'OK' THEN 'Oklahoma'
    WHEN 'OR' THEN 'Oregon'
    WHEN 'PA' THEN 'Pennsylvania'
    WHEN 'RI' THEN 'Rhode Island'
    WHEN 'SC' THEN 'South Carolina'
    WHEN 'SD' THEN 'South Dakota'
    WHEN 'TN' THEN 'Tennessee'
    WHEN 'TX' THEN 'Texas'
    WHEN 'UT' THEN 'Utah'
    WHEN 'VT' THEN 'Vermont'
    WHEN 'VA' THEN 'Virginia'
    WHEN 'WA' THEN 'Washington'
    WHEN 'WV' THEN 'West Virginia'
    WHEN 'WI' THEN 'Wisconsin'
    WHEN 'WY' THEN 'Wyoming'
    ELSE State
  END;

-- Created column called time served 
ALTER TABLE Exonerationsv2
ADD TimeServed int;

UPDATE Exonerationsv2
SET "TimeServed" = CAST(Exonerated AS INT) - CAST(Convicted AS INT)

-- Then filled any null values or blanks 
Update Exonerationsv2
Set "List Add'l Crimes Recode" = 'N/A'
where "List Add'l Crimes Recode" is Null

Update Exonerationsv2
Set "DNA" = 'N/A'
where "DNA" = ''

Update Exonerationsv2
Set "*" = 'N/A'
where "*" = ''

Update Exonerationsv2
Set "FC" = 'N/A'
where "FC" = ''

Update Exonerationsv2
Set "MWID" = 'N/A'
where "MWID" = ''

Update Exonerationsv2
Set "F/MFE" = 'N/A'
where "F/MFE" = ''

Update Exonerationsv2
Set "P/FA" = 'N/A'
where "P/FA" = ''

Update Exonerationsv2
Set "OM" = 'N/A'
where "OM" = ''

Update Exonerationsv2
Set "ILD" = 'N/A'
where "ILD" = ''

Update Exonerationsv2
Set "Age" = 'Do Not Know'
where "Age" = ''