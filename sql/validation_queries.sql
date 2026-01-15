-- Validate staging table
SELECT *
FROM dbo.crime_import;


-- Validate dimensions
SELECT * 
FROM dbo.dimArea;

SELECT * 
FROM dbo.dimCrime;

SELECT * 
FROM dbo.dimPremise;

SELECT * 
FROM dbo.dimVictim;

SELECT * 
FROM dbo.dimWeapon;


-- Validate fact table
SELECT * 
FROM dbo.factCrime;


-- Crime count by crime type
SELECT 
    crm_cd_desc AS crime_type,
    COUNT(*) AS incident_count
FROM dbo.dimCrime AS dc
JOIN dbo.factCrime AS fc ON dc.crm_id = fc.crm_id
GROUP BY crm_cd_desc
ORDER BY incident_count DESC;


-- Crime count by area
SELECT 
    area_name AS area,
    COUNT(*) AS incident_count
FROM dbo.dimArea AS da
JOIN dbo.factCrime AS fc ON da.area_id = fc.area_id
GROUP BY area_name
ORDER BY incident_count DESC;


-- Victim count by descent
SELECT 
    vict_descent,
    COUNT(*) AS vict_count
FROM dbo.dimVictim AS dv
JOIN dbo.factCrime AS fc ON dv.vict_id = fc.vict_id
WHERE vict_descent NOT LIKE 'X'
GROUP BY vict_descent
ORDER BY vict_count DESC;


-- Crime count by Part 1 / Part 2 classification
SELECT 
    part_1_2,
    COUNT(*) AS incident_count
FROM dbo.dimCrime AS dc
JOIN dbo.factCrime AS fc ON dc.crm_id = fc.crm_id
GROUP BY part_1_2
ORDER BY incident_count DESC;


-- Victim sex by crime type
SELECT 
    crm_cd_desc AS crime_type,
    vict_sex,
    COUNT(*) AS vict_count
FROM dbo.dimVictim AS dv
JOIN dbo.factCrime AS fc ON dv.vict_id = fc.vict_id
JOIN dbo.dimCrime AS dc ON dc.crm_id = fc.crm_id
WHERE vict_sex NOT LIKE 'X'
GROUP BY vict_sex, crm_cd_desc
ORDER BY vict_count DESC;


-- Weapon usage by premise
SELECT 
    premis_desc,
    COUNT(*) AS weapon_incident_count
FROM dbo.dimPremise AS dp
JOIN dbo.factCrime AS fc ON dp.premis_id = fc.premis_id
JOIN dbo.dimWeapon AS dw ON dw.weapon_id = fc.weapon_id
WHERE weapon_desc IS NOT NULL
GROUP BY premis_desc
ORDER BY weapon_incident_count DESC;


-- Average victim age by crime type
SELECT 
    crm_cd_desc AS crime_type,
    AVG(vict_age) AS avg_vict_age
FROM dbo.dimVictim AS dv
JOIN dbo.factCrime AS fc ON dv.vict_id = fc.vict_id
JOIN dbo.dimCrime AS dc ON dc.crm_id = fc.crm_id
WHERE vict_age > 0
GROUP BY crm_cd_desc
ORDER BY avg_vict_age;


-- Crime distribution by time of day
SELECT 
    time_occ,
    COUNT(*) AS incident_count
FROM dbo.factCrime
GROUP BY time_occ
ORDER BY incident_count DESC;


-- Crime trends by year and month
SELECT 
    DATEPART(YEAR, date_occ) AS year,
    DATEPART(MONTH, date_occ) AS month,
    COUNT(*) AS incident_count
FROM dbo.factCrime
GROUP BY DATEPART(YEAR, date_occ), DATEPART(MONTH, date_occ)
ORDER BY year, month;


-- Percentage of crimes involving a weapon
SELECT 
    (SELECT COUNT(*) FROM dbo.factCrime WHERE weapon_id <> 10) * 1.0 /
    (SELECT COUNT(*) FROM dbo.factCrime) AS weapon_percent;


-- Heatmap: incidents by coordinates
SELECT 
    lat,
    lon,
    COUNT(*) AS incident_count
FROM dbo.dimArea AS da
JOIN dbo.factCrime AS fc ON da.area_id = fc.area_id
WHERE lat <> 0 AND lon <> 0
GROUP BY lat, lon
ORDER BY incident_count DESC;


-- Average reporting delay by crime type
SELECT 
    crm_cd_desc AS crime_type,
    AVG(DATEDIFF(DAY, date_occ, date_rptd)) AS avg_delay
FROM dbo.factCrime AS fc
JOIN dbo.dimCrime AS dc ON fc.crm_id = dc.crm_id
GROUP BY crm_cd_desc
ORDER BY avg_delay DESC;


-- Average reporting delay by area
SELECT 
    da.area_name AS area,
    AVG(DATEDIFF(DAY, date_occ, date_rptd)) AS avg_delay
FROM dbo.factCrime AS fc
JOIN dbo.dimArea AS da ON fc.area_id = da.area_id
GROUP BY area_name
ORDER BY avg_delay DESC;


-- Crime count by date
SELECT 
    date_occ,
    COUNT(*) AS incident_count
FROM dbo.factCrime
GROUP BY date_occ
ORDER BY incident_count DESC;