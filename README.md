# NBA-Players

# 🏀 NBA Players SQL Analysis Project

A comprehensive SQL practice project using real NBA player data from Kaggle. This repository contains 10 progressively challenging SQL tasks.

## 📊 Dataset Overview

This project uses the NBA Players dataset from Kaggle, containing detailed information about NBA players including their physical attributes, draft information, college background, and team affiliations.

Dataset Source: [NBA Players Dataset on Kaggle](https://www.kaggle.com/datasets/justinas/nba-players-data)


## 🎯 Learning Objectives

By completing this project, I will master:

- ✅ Basic SQL queries (SELECT, WHERE, ORDER BY)
- ✅ Aggregate functions (COUNT, AVG, SUM, MIN, MAX)
- ✅ Grouping and filtering (GROUP BY, HAVING)
- ✅ Conditional logic (CASE statements)
- ✅ Data type conversions and calculations
- ✅ String functions and NULL handling
- ✅ Advanced analytics and business intelligence queries

## 🚀 Getting Started

   
## 📝 SQL Tasks & Solutions

### Task 1: Basic Data Exploration 🔍

Question: Find all players who are taller than 200cm and younger than 25 years old.
SELECT player_name, age, player_height, team_abbreviation
FROM nba_players
WHERE player_height > 200 
  AND age < 25
ORDER BY player_height DESC;

Skills Practiced: SELECT, WHERE, AND conditions, ORDER BY

-----

### Task 2: International Players Analysis 🌍

Question: Count how many players are from each country (excluding USA). Show only countries with more than 5 players.
SELECT country, COUNT(*) as player_count
FROM nba_players
WHERE country != 'USA'
GROUP BY country
HAVING COUNT(*) > 5
ORDER BY player_count DESC;

Skills Practiced: GROUP BY, HAVING, COUNT, filtering

-----

### Task 3: Team Composition Analysis 🏀

Question: Calculate the average age, height, and weight for each team.
SELECT 
    team_abbreviation,
    COUNT(*) as total_players,
    ROUND(AVG(age), 1) as avg_age,
    ROUND(AVG(player_height), 1) as avg_height_cm,
    ROUND(AVG(player_weight), 1) as avg_weight_kg
FROM nba_players
GROUP BY team_abbreviation
ORDER BY avg_height_cm DESC;

Skills Practiced: Multiple aggregate functions, ROUND function, aliasing

-----

### Task 4: Draft Analysis 📈

Question: Find players who were drafted in the first round after 2015, grouped by draft year.
SELECT 
    draft_year,
    COUNT(*) as first_round_picks,
    ROUND(AVG(age), 1) as avg_current_age,
    ROUND(AVG(player_height), 1) as avg_height
FROM nba_players
WHERE draft_round = 1 
  AND draft_year > 2015
GROUP BY draft_year
ORDER BY draft_year DESC;

Skills Practiced: Date filtering, multiple conditions, grouping by year

### Question5: Find teams with the highest percentage of international players.
SELECT 
    team_abbreviation,
    COUNT(*) as total_players,
    COUNT(CASE WHEN country != 'USA' THEN 1 END) as international_players,
    ROUND(
        COUNT(CASE WHEN country != 'USA' THEN 1 END) * 100.0 / COUNT(*), 
        1
    ) as international_percentage,
    STRING_AGG(DISTINCT country, ', ') as countries_represented
FROM nba_players
GROUP BY team_abbreviation
HAVING COUNT(*) >= 10
ORDER BY international_percentage DESC
LIMIT 10;

Skills Practiced: Advanced aggregation, STRING_AGG, percentage calculations


## 🛠️ Tools & Technologies

- SQL Database: MySQL
- Dataset: Kaggle NBA Players Dataset
- Skills Level: Beginner to Intermediate SQL


## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 🙏 Acknowledgments

- Dataset provided by [Justinas on Kaggle](https://www.kaggle.com/datasets/justinas/nba-players-data)
- NBA for providing the underlying sports data
- SQL community for best practices and techniques



Happy Querying! 🚀


