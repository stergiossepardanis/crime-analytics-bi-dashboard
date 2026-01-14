-- Core view of dimArea (geographic attributes)
SELECT 
    area_id,
    area_name AS area,
    lat,
    lon
FROM dbo.dimArea;

-- Core view of dimCrime (crime classification attributes)
SELECT 
    crm_id,
    part_1_2,
    crm_cd_desc AS crime_type,
    status_desc AS status
FROM dbo.dimCrime;

-- Core view of dimPremise (premise/location attributes)
SELECT 
    premis_id,
    premis_desc
FROM dbo.dimPremise;

-- Core view of dimVictim (victim demographic attributes)
SELECT 
    vict_id,
    vict_age,
    vict_sex,
    vict_descent
FROM dbo.dimVictim;

-- Core view of dimWeapon (weapon attributes)
SELECT 
    weapon_id
FROM dbo.dimWeapon;

-- Core view of factCrime (incident-level fact table)
SELECT 
    dr_no,
    date_occ,
    time_occ,
    DATEDIFF(DAY, date_occ, date_rptd) AS delay,
    area_id,
    crm_id,
    premis_id,
    vict_id,
    weapon_id
FROM dbo.factCrime;
