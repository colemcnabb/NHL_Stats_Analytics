-- Top Scorers per team
SELECT Team, COUNT(*) as TopScorers
FROM (
	SELECT Player, Team, PTS
	FROM standard_stats_added
	ORDER BY PTS DESC
	LIMIT 50
) AS Top50
GROUP BY Team
ORDER BY TopScorers DESC;