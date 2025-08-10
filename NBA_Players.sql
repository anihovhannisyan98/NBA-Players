# Task 1: Basic Data Exploration
# Question: Find all players who are taller than 200cm and younger than 25 years old.
SELECT player_name, age, player_height, team_abbreviation
FROM all_seasons
WHERE player_height > 200 
  AND age < 25
ORDER BY player_height DESC;

# Task 2: International Players Analysis
# Question: Count how many players are from each country (excluding USA). Show only countries with more than 5 players.
SELECT country, COUNT(*) as player_count
FROM all_seasons
WHERE country != 'USA'
GROUP BY country
HAVING COUNT(*) > 5
ORDER BY player_count DESC;

### Task 3: Team Composition Analysis
# Question: Calculate the average age, height, and weight for each team.
SELECT 
    team_abbreviation,
    COUNT(*) as total_players,
    ROUND(AVG(age), 1) as avg_age,
    ROUND(AVG(player_height), 1) as avg_height_cm,
    ROUND(AVG(player_weight), 1) as avg_weight_kg
FROM all_seasons
GROUP BY team_abbreviation
ORDER BY avg_height_cm DESC;

### Task 4: Draft Analysis
# Question: Find players who were drafted in the first round (draft_round = 1) after 2015, grouped by draft year.
SELECT 
    draft_year,
    COUNT(*) as first_round_picks,
    ROUND(AVG(age), 1) as avg_current_age,
    ROUND(AVG(player_height), 1) as avg_height
FROM all_seasons
WHERE draft_round = 1 
  AND draft_year > 2015
GROUP BY draft_year
ORDER BY draft_year DESC;

### Task 5: College Pipeline Analysis
# Question: Which colleges have produced the most NBA players? Show top 10 colleges.
SELECT 
    college,
    COUNT(*) as nba_players_produced,
    ROUND(AVG(age), 1) as avg_age,
    COUNT(CASE WHEN draft_round = 1 THEN 1 END) as first_round_picks
FROM all_seasons
WHERE college IS NOT NULL 
  AND college != ''
GROUP BY college
HAVING COUNT(*) >= 3
ORDER BY nba_players_produced DESC
LIMIT 10;

### Task 6: Physical Attributes by Position (Advanced)
# Question: Assuming teams with certain abbreviations represent different play styles, compare physical attributes of players from different conferences.
-- Western Conference vs Eastern Conference analysis (sample teams)
SELECT 
    CASE 
        WHEN team_abbreviation IN ('LAL', 'GSW', 'PHX', 'DEN', 'DAL') THEN 'Western Sample'
        WHEN team_abbreviation IN ('BOS', 'MIA', 'NYK', 'PHI', 'ATL') THEN 'Eastern Sample'
        ELSE 'Other'
    END as conference_sample,
    COUNT(*) as player_count,
    ROUND(AVG(player_height), 1) as avg_height,
    ROUND(AVG(player_weight), 1) as avg_weight,
    ROUND(AVG(age), 1) as avg_age
FROM all_seasons
WHERE team_abbreviation IN ('LAL', 'GSW', 'PHX', 'DEN', 'DAL', 'BOS', 'MIA', 'NYK', 'PHI', 'ATL')
GROUP BY conference_sample
ORDER BY avg_height DESC;

### Task 7: Undrafted Players Analysis
# Question: Find all undrafted players (where draft_year or draft_round is NULL) and analyze their characteristics.
SELECT 
    COUNT(*) as undrafted_players,
    ROUND(AVG(age), 1) as avg_age,
    ROUND(AVG(player_height), 1) as avg_height,
    ROUND(AVG(player_weight), 1) as avg_weight,
    COUNT(DISTINCT country) as countries_represented
FROM all_seasons
WHERE draft_year IS NULL OR draft_round IS NULL;

-- Compare with drafted players
SELECT 
    CASE 
        WHEN draft_year IS NULL OR draft_round IS NULL THEN 'Undrafted'
        ELSE 'Drafted'
    END as draft_status,
    COUNT(*) as player_count,
    ROUND(AVG(age), 1) as avg_age,
    ROUND(AVG(player_height), 1) as avg_height,
    ROUND(AVG(player_weight), 1) as avg_weight
FROM all_seasons
GROUP BY draft_status;

### Task 8: BMI Analysis (Advanced Calculation)
# Question: Calculate BMI for all players and categorize them by BMI ranges.
SELECT 
    player_name,
    team_abbreviation,
    player_height,
	player_weight,
    ROUND((player_weight / POWER(player_height/100.0, 2)), 1) as bmi,
    CASE 
        WHEN (player_weight / POWER(player_height/100.0, 2)) < 18.5 THEN 'Underweight'
        WHEN (player_weight / POWER(player_height/100.0, 2)) BETWEEN 18.5 AND 24.9 THEN 'Normal'
        WHEN (player_weight / POWER(player_height/100.0, 2)) BETWEEN 25 AND 29.9 THEN 'Overweight'
        ELSE 'Obese'
    END as bmi_category
FROM all_seasons
WHERE player_height > 0 AND player_weight > 0
ORDER BY bmi DESC
LIMIT 20;

### Task 9: Age Distribution Analysis
# Question: Create age groups and analyze the distribution of players across different age ranges.
SELECT 
    CASE 
        WHEN age <= 22 THEN '18-22 (Rookies/Young)'
        WHEN age BETWEEN 23 AND 26 THEN '23-26 (Prime Early)'
        WHEN age BETWEEN 27 AND 30 THEN '27-30 (Prime)'
        WHEN age BETWEEN 31 AND 34 THEN '31-34 (Veteran)'
        ELSE '35+ (Elder)'
    END as age_group,
    COUNT(*) as player_count,
    ROUND(AVG(player_height), 1) as avg_height,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM all_seasons), 1) as percentage
FROM all_seasons
WHERE age IS NOT NULL
GROUP BY age_group
ORDER BY MIN(age);
