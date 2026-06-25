CREATE VIEW constructor_pitstop_analysis AS
SELECT 
    c.constructorId AS constructorId,
    r.year AS race_year,
    r.name AS grand_prix_name,
    c.name AS constructor_name,
    CONCAT(d.forename, ' ', d.surname) AS driver_name,
    ps.stop AS pit_stop_number,
    ps.lap AS pit_stop_lap,
    -- Try_cast returns null when cast fails
    CASE WHEN ps.duration = '\N' THEN NULL ELSE TRY_CAST(ps.duration AS DECIMAL(6,3)) END AS pit_duration_seconds

FROM f1_data.dbo.pit_stops ps
JOIN f1_data.dbo.races r ON ps.raceId = r.raceId
JOIN f1_data.dbo.results res ON ps.raceId = res.raceId AND ps.driverId = res.driverId
JOIN f1_data.dbo.constructors c ON res.constructorId = c.constructorId
JOIN f1_data.dbo.drivers d ON ps.driverId = d.driverId