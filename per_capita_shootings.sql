-- PER CAPITA FATAL POLICE SHOOTINGS PER STATE

SELECT 
    cd.state_code,
    cd.state,
    ROUND((avg_incidents_per_year / cd.2020_census) * 100000, 2) AS per_capita
FROM 
	census_data cd
JOIN (
	SELECT 
		state, 
		ROUND(AVG(incidents_per_year), 2) AS avg_incidents_per_year
	FROM (
		SELECT 
			state,
            YEAR(date),
			COUNT(*) AS incidents_per_year
		FROM 
			incidents
		WHERE 
			YEAR(date) != 2024
		GROUP BY 
			state, 
            YEAR(date)
	) AS incidents_per_year_per_state
GROUP BY 
	state
) AS avg_incidents_per_state
ON 
	cd.state_code = avg_incidents_per_state.state
ORDER BY 
    per_capita ASC
;
