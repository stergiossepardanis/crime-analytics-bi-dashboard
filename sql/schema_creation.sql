-- Cleaned data import table (post–Power Query)
CREATE TABLE dbo.crime_import (
    dr_no INT NOT NULL,
    date_rptd DATE NOT NULL,
    date_occ DATE NOT NULL,
    time_occ TIME NOT NULL,
    area INT NOT NULL,
    area_name VARCHAR(50) NOT NULL,
    rpt_dist_no INT NOT NULL,
    part_1_2 INT NOT NULL,
    crm_cd INT NOT NULL,
    crm_cd_desc VARCHAR(200) NOT NULL,
    mocodes VARCHAR(200) NULL,
    vict_age INT NOT NULL,
    vict_sex CHAR(1) NOT NULL,
    vict_descent CHAR(1) NOT NULL,
    premis_cd INT NULL,
    premis_desc VARCHAR(200) NOT NULL,
    weapon_used_cd INT NULL,
    weapon_desc VARCHAR(200) NULL,
    status CHAR(2) NOT NULL,
    status_desc VARCHAR(50) NOT NULL,
    crm_cd_1 INT NULL,
    crm_cd_2 INT NULL,
    crm_cd_3 INT NULL,
    crm_cd_4 INT NULL,
    location VARCHAR(100) NOT NULL,
    cross_street VARCHAR(100) NOT NULL,
    lat FLOAT NOT NULL,
    lon FLOAT NOT NULL
);


-- Dimension table for geographic areas
CREATE TABLE dbo.dimArea (
    area_id INT IDENTITY (1,1) PRIMARY KEY,
    area INT NOT NULL,
    area_name VARCHAR(50) NOT NULL,
    rpt_dist_no INT NOT NULL,
    location VARCHAR(100) NOT NULL,
    cross_street VARCHAR(100) NULL,
    lat FLOAT NOT NULL,
    lon FLOAT NOT NULL
  );


-- Dimension table for crime classifications
CREATE TABLE dbo.dimCrime (
    crm_id INT IDENTITY (1,1) PRIMARY KEY,
    part_1_2 INT NOT NULL,
    crm_cd INT NOT NULL,
    crm_cd_desc VARCHAR(200) NOT NULL,
    mocodes VARCHAR(200) NULL,
    crm_cd_1 INT NULL,
    crm_cd_2 INT NULL,
    crm_cd_3 INT NULL,
    crm_cd_4 INT NULL,
    status CHAR(2) NOT NULL,
    status_desc VARCHAR(50) NOT NULL
  );


-- Dimension table for premises (crime locations)
CREATE TABLE dbo.dimPremise (
    premis_id INT IDENTITY (1,1) PRIMARY KEY,
    premis_cd INT NULL,
    premis_desc VARCHAR(200) NOT NULL
  );


-- Dimension table for victim demographics
CREATE TABLE dbo.dimVictim (
    vict_id INT IDENTITY (1,1) PRIMARY KEY,
    vict_age INT NOT NULL,
    vict_sex CHAR(1) NOT NULL,
    vict_descent CHAR(1) NOT NULL
  );


-- Dimension table for weapon information
CREATE TABLE dbo.dimWeapon (
    weapon_id INT IDENTITY (1,1) PRIMARY KEY,
    weapon_used_cd INT NULL,
    weapon_desc VARCHAR(200) NULL
  );


-- Fact table linking all dimensions (star schema)
CREATE TABLE dbo.factCrime (
    dr_no INT PRIMARY KEY,
    date_rptd DATE NOT NULL,
    date_occ DATE NOT NULL,
    time_occ TIME NOT NULL,
    area_id INT NOT NULL FOREIGN KEY REFERENCES dbo.dimArea(area_id),
    crm_id INT NOT NULL FOREIGN KEY REFERENCES dbo.dimCrime(crm_id),
    premis_id INT NOT NULL FOREIGN KEY REFERENCES dbo.dimPremise(premis_id),
    vict_id INT NOT NULL FOREIGN KEY REFERENCES dbo.dimVictim(vict_id),
    weapon_id INT NOT NULL FOREIGN KEY REFERENCES dbo.dimWeapon(weapon_id)
  );