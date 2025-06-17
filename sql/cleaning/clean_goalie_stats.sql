-- Clean goalie_stats MIN column (convert MM:SS to float minutes)
UPDATE goalie_stats
SET 
	MIN = ROUND(SUBSTRING_INDEX(MIN, ':', 1) + (SUBSTRING_INDEX(MIN, ':', -1) / 60), 2);

ALTER TABLE goalie_stats 
MODIFY COLUMN MIN float;

-- Handle traded goalies marked with '2TM'
ALTER TABLE goalie_stats
ADD COLUMN traded_player VARCHAR(1);

UPDATE goalie_stats
SET traded_player = 'Y'
WHERE Team = '2TM';

-- Update traded goalie team assignments based on rank offset
UPDATE goalie_stats g1
SET g1.Team = (
	SELECT Team
	FROM (
	SELECT g2.team
	FROM goalie_stats g2
	WHERE g1.Player = g2.Player
	ORDER BY g2.Rk ASC
	LIMIT 1 OFFSET 2)
	AS updated_team
	)
WHERE g1.Team = '2TM';

-- Deduplicate goalie records after assigning teams
DELETE FROM goalie_stats
WHERE Player IN (
	SELECT Player 
	FROM (
	SELECT Player
	FROM goalie_stats
	GROUP BY Player
	HAVING COUNT(Player) > 1
	) AS repeated_players
)
AND traded_player IS NULL;

ALTER TABLE goalie_stats
DROP COLUMN traded_player;

-- Rename MIN to TOI for consistency with skater data
ALTER TABLE goalie_stats
RENAME COLUMN MIN TO TOI;

-- Re-convert TOI column from MM:SS to float minutes after renaming
UPDATE goalie_stats
SET 
	TOI = ROUND(SUBSTRING_INDEX(TOI, ':', 1) + (SUBSTRING_INDEX(TOI, ':', -1) / 60), 2);

ALTER TABLE goalie_stats
MODIFY COLUMN TOI FLOAT;