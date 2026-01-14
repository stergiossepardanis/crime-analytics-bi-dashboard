-- Load cleaned CSV data into staging table (crime_import)
BULK INSERT dbo.crime_import
FROM 'D:\Other Programs\Master\Project\crime_in_la_cleaned.csv'
WITH(
ROWTERMINATOR = '\n',
FIELDTERMINATOR = ';',
FIRSTROW = 2,
CODEPAGE = 65001,
TABLOCK);    

-- Populate dimArea with unique geographic area records
INSERT INTO dbo.dimArea (area, area_name, rpt_dist_no, location, cross_street, lat, lon)
SELECT DISTINCT area, area_name, rpt_dist_no, location, cross_street, lat, lon
FROM dbo.crime_import;

-- Populate dimCrime with unique crime classification records
INSERT INTO dbo.dimCrime (part_1_2, crm_cd, crm_cd_desc, mocodes, crm_cd_1, crm_cd_2, crm_cd_3, crm_cd_4, status, status_desc)
SELECT DISTINCT part_1_2, crm_cd, crm_cd_desc, mocodes, crm_cd_1, crm_cd_2, crm_cd_3, crm_cd_4, status, status_desc
FROM dbo.crime_import;

-- Populate dimPremise with unique premise/location records
INSERT INTO dbo.dimPremise (premis_cd, premis_desc)
SELECT DISTINCT premis_cd, premis_desc
FROM dbo.crime_import;

-- Populate dimVictim with unique victim demographic records
INSERT INTO dbo.dimVictim (vict_age, vict_sex, vict_descent)
SELECT DISTINCT vict_age, vict_sex, vict_descent
FROM dbo.crime_import;

-- Populate dimWeapon with unique weapon records
INSERT INTO dbo.dimWeapon (weapon_used_cd, weapon_desc)
SELECT DISTINCT weapon_used_cd, weapon_desc
FROM dbo.crime_import;

-- Load factCrime by joining staging table with all dimensions (star schema)
BEGIN TRANSACTION;

INSERT INTO dbo.factCrime (dr_no, date_rptd, date_occ, time_occ, area_id, crm_id, premis_id, vict_id, weapon_id)
SELECT ci.dr_no, ci.date_rptd, ci.date_occ, ci.time_occ, da.area_id, dc.crm_id, dp.premis_id, dv.vict_id, dw.weapon_id
FROM dbo.crime_import ci
JOIN dbo.dimArea da ON 
ci.area = da.area AND 
ci.area_name = da.area_name AND 
ci.rpt_dist_no = da.rpt_dist_no AND
ci.location = da.location AND
ISNULL(ci.cross_street, '') = ISNULL(da.cross_street, '') AND
ci.lat = da.lat AND
ci.lon = da.lon
JOIN dbo.dimCrime dc ON 
ci.part_1_2 = dc.part_1_2 AND
ci.crm_cd = dc.crm_cd AND
ci.crm_cd_desc = dc.crm_cd_desc AND
ISNULL(ci.mocodes, '') = ISNULL(dc.mocodes, '') AND
ISNULL(ci.crm_cd_1, 0) = ISNULL(dc.crm_cd_1, 0) AND
ISNULL(ci.crm_cd_2, 0) = ISNULL(dc.crm_cd_2, 0) AND
ISNULL(ci.crm_cd_3, 0) = ISNULL(dc.crm_cd_3, 0) AND
ISNULL(ci.crm_cd_4, 0) = ISNULL(dc.crm_cd_4, 0) AND
ci.status = dc.status AND
ci.status_desc = dc.status_desc
JOIN dbo.dimPremise dp ON 
ISNULL(ci.premis_cd, 0) = ISNULL(dp.premis_cd, 0) AND
ci.premis_desc = dp.premis_desc
JOIN dimVictim dv ON 
ci.vict_age = dv.vict_age AND 
ci.vict_sex = dv.vict_sex AND 
ci.vict_descent = dv.vict_descent
JOIN dimWeapon dw ON 
ISNULL(ci.weapon_used_cd, 0) = ISNULL(dw.weapon_used_cd, 0) AND 
ISNULL(ci.weapon_desc, '') = ISNULL(dw.weapon_desc, '')
WHERE NOT EXISTS (
SELECT 1 FROM dbo.factCrime fc WHERE fc.dr_no = ci.dr_no);

COMMIT;
