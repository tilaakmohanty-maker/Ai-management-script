SELECT 
    CASE 
        WHEN lead_days BETWEEN 1 AND 7 THEN '1-7'
        WHEN lead_days BETWEEN 8 AND 14 THEN '8-14'
        WHEN lead_days BETWEEN 15 AND 30 THEN '15-30'
        ELSE '31+'
    END AS lead_band,
    COUNT(appointment_id) AS appointments,
    SUM(no_show) AS no_shows,
    ROUND((SUM(no_show) / COUNT(appointment_id)) * 100, 2) AS no_show_pct
FROM appointments
GROUP BY lead_band
ORDER BY 
    CASE lead_band
        WHEN '1-7' THEN 1
        WHEN '8-14' THEN 2
        WHEN '15-30' THEN 3
        ELSE 4
    END;



    