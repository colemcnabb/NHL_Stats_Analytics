-- Total Faceoff leaders
SELECT Player, Team, TotalFO, FOW, FOL, `FO%`
FROM (
	SELECT Player, Team, (FOW + FOL) AS TotalFO, FOW, FOL, `FO%`
	FROM standard_stats_added
) AS faceoffSQ
WHERE NOT TotalFO = 0
ORDER BY TotalFO DESC, `FO%` DESC
LIMIT 25;

-- Most successful Faceoff leaders by win %
SELECT Player, Team, TotalFO, FOW, FOL, `FO%`
FROM (
	SELECT Player, Team, (FOW + FOL) AS TotalFO, FOW, FOL, `FO%`
	FROM standard_stats_added
) AS faceoffSQ
WHERE NOT TotalFO = 0 AND TotalFO > 400
ORDER BY `FO%` DESC, TotalFO DESC
LIMIT 25;

-- Average Faceoffs per game
SELECT Player, Team, GP, TotalFO, FOW, FOL, `FO%`, ROUND((TotalFO / GP), 2) AS FOPerGame
FROM (
	SELECT Player, Team, GP, (FOW + FOL) AS TotalFO, FOW, FOL, `FO%`
	FROM standard_stats_added
) AS faceoffSQ
WHERE NOT TotalFO = 0 AND TotalFO > 400
ORDER BY FOPerGame DESC, `FO%` DESC
LIMIT 25;