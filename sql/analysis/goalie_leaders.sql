-- Best Average saves per game
SELECT Player, Team, GP, SV, (SV / GP) AS AVGSavesPerGame, `SV%`
FROM goalie_stats_new
WHERE GP > 15
ORDER BY AVGSavesPerGame DESC, GP DESC
LIMIT 10;

-- Workhorse TOI (MIN)
SELECT Player, Team, GP, GS, W, L, `T/O`, TOI
FROM goalie_stats_new
ORDER BY TOI DESC, W DESC
LIMIT 10;

-- Wins
SELECT Player, Team, GP, W, L, `T/O`, GA
FROM goalie_stats_new
ORDER BY W DESC, L ASC 
LIMIT 10;