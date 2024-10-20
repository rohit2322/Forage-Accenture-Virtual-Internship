use forage;
-- 1. Descriptive Analysis
-- a) Total Number of Reactions:
SELECT COUNT(*) AS Total_Reactions 
FROM reaction;

-- b) Reactions by Content Type:
SELECT c.content_type, COUNT(r.Content_Id) AS Total_Reactions
FROM reaction r
JOIN content c ON r.Content_Id = c.Content_Id
GROUP BY c.content_type
ORDER BY Total_Reactions DESC;

-- c) Reactions by Content Category top 5:
SELECT c.Category, COUNT(r.Content_Id) AS Total_Reactions
FROM reaction r
JOIN content c ON r.Content_Id = c.Content_Id
GROUP BY c.Category
ORDER BY Total_Reactions DESC
limit 5;

-- 2. Trend Analysis
-- a) score by day:
SELECT 
    DAYNAME(r.Date) AS Day_Name, 
    SUM(rt.Score) AS Sum_of_Score
FROM reaction r
JOIN reactiontypes rt ON r.reaction_type = rt.reaction_type
GROUP BY DAYNAME(r.Date);


-- b) score month:
SELECT 
    MONTHNAME(r.Date) AS Month_Name, 
    SUM(rt.Score) AS Sum_of_Score
FROM reaction r
JOIN reactiontypes rt ON r.reaction_type = rt.reaction_type
GROUP BY MONTHNAME(r.Date);


-- c) Peak Hours of Engagement:
SELECT 
    HOUR(r.Time) AS Hour, 
    SUM(rt.Score) AS Total_Score
FROM reaction r
JOIN content c ON r.Content_Id = c.Content_Id
JOIN reactiontypes rt ON r.reaction_type = rt.reaction_type
GROUP BY HOUR(r.Time)
ORDER BY Hour;

-- Category-wise score:
SELECT 
    c.Category, 
    SUM(rt.Score) AS Total_Score
FROM content c
JOIN reaction r ON c.Content_Id = r.Content_Id
JOIN reactiontypes rt ON r.reaction_type = rt.reaction_type
GROUP BY c.Category
ORDER BY Total_Score DESC;

-- Sentiment-wise score:
SELECT 
    rt.Sentiment, 
    SUM(rt.Score) AS Total_Score
FROM reactiontypes rt
JOIN reaction r ON r.reaction_type = rt.reaction_type
GROUP BY rt.Sentiment
ORDER BY Total_Score DESC;

-- Reaction-wise score:
SELECT 
    r.reaction_type, 
    SUM(rt.Score) AS Total_Score
FROM reaction r
JOIN reactiontypes rt ON r.reaction_type = rt.reaction_type
GROUP BY r.reaction_type
ORDER BY Total_Score DESC;

-- 6. Combining Insights for Comprehensive Analysis
-- a) Top 5 Most Engaged Content with Positive Reactions:
SELECT c.Content_Id, c.content_type, COUNT(*) AS Total_Positive_Reactions
FROM reaction r
JOIN content c ON r.Content_Id = c.Content_Id
JOIN reactiontypes rt ON r.reaction_type = rt.reaction_type
WHERE rt.Sentiment = 'Positive'
GROUP BY c.Content_Id, c.content_type
ORDER BY Total_Positive_Reactions DESC
LIMIT 5;

-- b) Category with Most Negative Reactions:
SELECT c.Category, COUNT(*) AS Total_Negative_Reactions
FROM reaction r
JOIN content c ON r.
Content_Id = c.Content_Id
JOIN reactiontypes rt ON r.reaction_type = rt.reaction_type
WHERE rt.Sentiment = 'Negative'
GROUP BY c.Category
ORDER BY Total_Negative_Reactions DESC;


-- 1. Sum of Score (Total score from the reactions):
SELECT SUM(rt.Score) AS Sum_of_Score
FROM reaction r
JOIN reactiontypes rt ON r.reaction_type = rt.reaction_type;

-- 2. Count of Content ID (Total number of unique content IDs):
SELECT COUNT(DISTINCT c.Content_Id) AS Count_of_Content_ID
FROM content c;

-- 3. Distinct Content Type (Count distinct content types):
SELECT COUNT(DISTINCT c.content_type) AS Distinct_Content_Type
FROM content c;

-- 4. Distinct Content Categories (Count distinct content categories):
SELECT COUNT(DISTINCT c.Category) AS Distinct_Content_Categories
FROM content c;

-- 5. Distinct Reaction Type (Count distinct reaction types):
SELECT COUNT(DISTINCT r.reaction_type) AS Distinct_Reaction_Type
FROM reaction r;

-- 6. Distinct Sentiment (Count distinct sentiments):
SELECT COUNT(DISTINCT rt.Sentiment) AS Distinct_Sentiment
FROM reactiontypes rt;

