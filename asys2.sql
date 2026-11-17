WITH monthly_stats AS(
	SELECT
		SUBSTR(appt_date,1,7) AS appt_month,
        COUNT(appointment_id) AS appointments,
        ROUND((sum(no_show) / COUNT(appointment_id))*100,2) AS no_show_pct
	FROM appointments
    GROUP BY appt_month
    )
SELECT 
	appt_month,
    appointments,
    no_show_pct,
    ROUND(no_show_pct - LAG(no_show_pct,1) OVER (ORDER BY appt_MONTH),2) AS rate_diff_vs_prior_month
FROM monthly_stats;