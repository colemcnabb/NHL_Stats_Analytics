-- Clean standard_stats TOI and ATOI columns (convert MM:SS to float minutes)
UPDATE standard_stats
SET 
	TOI = ROUND(SUBSTRING_INDEX(TOI, ':', 1) + (SUBSTRING_INDEX(TOI, ':', -1) / 60), 2),
	ATOI = ROUND(SUBSTRING_INDEX(ATOI, ':', 1) + (SUBSTRING_INDEX(ATOI, ':', -1) / 60), 2);

ALTER TABLE standard_stats 
MODIFY COLUMN TOI float;

ALTER TABLE standard_stats 
MODIFY COLUMN ATOI float;

-- Handle traded players for standard_stats
ALTER TABLE standard_stats
ADD COLUMN traded_player VARCHAR(1);

UPDATE standard_stats
SET traded_player = 'Y'
WHERE Team = '2TM';

UPDATE standard_stats ssa
SET ssa.Team = (
	SELECT Team
	FROM (
	SELECT s2.Team
	FROM standard_stats s2
	WHERE ssa.Player = s2.Player
	ORDER BY s2.Rk ASC
	LIMIT 1 OFFSET 2)
	AS updated_team
	)
WHERE ssa.Team = '2TM';

DELETE FROM standard_stats
WHERE Player IN (
	SELECT Player
	FROM (
		SELECT Player
		FROM standard_stats
		GROUP BY Player
		HAVING COUNT(Player) > 1
	) AS repeated_players
)
AND traded_player IS NULL;

ALTER TABLE standard_stats
DROP COLUMN traded_player;