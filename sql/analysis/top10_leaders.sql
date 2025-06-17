-- Top 10 leaders by goals
SELECT Player, Age, Team, Pos, GP, G, A, PTS
FROM standard_stats_added
ORDER BY G DESC, PTS DESC
LIMIT 10;

-- Top 10 leaders by assists
SELECT Player, Age, Team, Pos, GP, G, A, PTS
FROM standard_stats_added
ORDER BY A DESC, PTS DESC
LIMIT 10;

-- Top 10 leaders by points
SELECT Player, Age, Team, Pos, GP, G, A, PTS
FROM standard_stats_added 
ORDER BY PTS DESC, Player DESC
LIMIT 10;