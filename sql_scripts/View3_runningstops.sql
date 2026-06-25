CREATE VIEW driver_season_momentum AS
SELECT 
    driver_id,
    race_year,
    race_date,
    grand_prix_name,
    driver_name,
    constructor_name,
    points_earned,

    -- computing running totals to see momentum throughout a season
    SUM(points_earned) OVER (
        PARTITION BY driver_name, race_year 
        ORDER BY race_date
    ) AS running_total_points

FROM f1_data.dbo.clean_race_results