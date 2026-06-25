CREATE VIEW [dbo].[clean_race_results] AS 
SELECT 
    -- data type handling
	CAST(res.resultId AS INT) AS result_id,
    CAST(res.raceId AS INT) AS race_id,
    CAST(res.driverId AS INT) AS driver_id,
    CAST(res.constructorId AS INT) AS constructor_id,
    CAST(res.statusId AS INT) AS status_id,

    -- From races table
    r.year AS race_year,
    r.name AS grand_prix_name,
    r.date AS race_date,

    -- from drivers table
    CONCAT(d.forename, ' ', d.surname) AS driver_name,
    c.name AS constructor_name,

    -- imp from results table
    CAST(res.grid AS INT) AS starting_grid_position,
    CAST(res.laps AS INT) AS laps_completed,
    CAST(res.points AS DECIMAL(5,2)) AS points_earned,

    -- null values and data type handling
    CASE WHEN res.position = '\N' THEN NULL ELSE CAST(res.position AS INT) END AS finishing_position,
    CASE WHEN res.rank = '\N' THEN NULL ELSE CAST(res.rank AS INT) END AS fastest_lap_rank,
    CASE WHEN res.fastestLapSpeed = '\N' THEN NULL ELSE CAST(res.fastestLapSpeed AS DECIMAL(6,3)) END AS fastest_lap_speed_kph

FROM f1_data.dbo.results res
JOIN f1_data.dbo.races r ON res.raceId = r.raceID
JOIN f1_data.dbo.drivers d ON res.driverId = d.driverId
JOIN f1_data.dbo.constructors c ON res.constructorId = c.constructorId;



