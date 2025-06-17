-- Powerplay points
SELECT Player, Team, PPG, PPA, PPP
FROM ( 
	SELECT Player, Team, PPG, PPA, (PPG + PPA) AS PPP
	FROM standard_stats_added
) AS ppPoints
ORDER BY PPP DESC, PPG DESC
LIMIT 10;

-- Powerplay Assists
SELECT Player, Team, PPG, PPA, PPP
FROM ( 
	SELECT Player, Team, PPG, PPA, (PPG + PPA) AS PPP
	FROM standard_stats_added
) AS ppPoints
ORDER BY PPA DESC, PPP DESC
LIMIT 10;

-- Powerplay Goals
SELECT Player, Team, PPG, PPA, PPP
FROM ( 
	SELECT Player, Team, PPG, PPA, (PPG + PPA) AS PPP
	FROM standard_stats_added
) AS ppPoints
ORDER BY PPG DESC, PPA DESC
LIMIT 10;

-- Shorthanded Points
SELECT Player, Team, SHG, SHA, SHP
FROM ( 
	SELECT Player, Team, SHG, SHA, (SHG + SHA) AS SHP
	FROM standard_stats_added
) AS shPoints
ORDER BY SHP DESC, SHG DESC
LIMIT 10;