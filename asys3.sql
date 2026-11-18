USE noshowguard;
WITH clinic_stats AS (
    SELECT 
        c.clinic_name,
        c.city,
        COUNT(a.appointment_id) AS appointments,
        SUM(a.no_show) AS no_shows,
        ROUND((SUM(a.no_show) / COUNT(a.appointment_id)) * 100, 2) AS no_show_pct
    FROM clinics c
    JOIN appointments a ON c.clinic_id = a.clinic_id
    GROUP BY c.clinic_id, c.clinic_name, c.city
)
SELECT 
    clinic_name,
    city,
    appointments,
    no_shows,
    no_show_pct,
    RANK() OVER (PARTITION BY city ORDER BY no_show_pct DESC) AS clinic_rank
FROM clinic_stats
ORDER BY city, clinic_rank;
