---- show data
SELECT * 
FROM dbo.megaGymDataset

--rename column
EXEC sp_rename 'dbo.megaGymDataset.Column 0', 'Index', 'COLUMN';
-----------------------
SELECT Level, BodyPart, COUNT(Title) as Cout_exsercises
FROM	dbo.megaGymDataset
group by  BodyPart,Level

----------------------------------
SELECT Type , COUNT(Title) as Count_exsercises 
FROM dbo.megaGymDataset
GROUP BY Type
---------------------------------------------------
SELECT BodyPart,Title
FROM dbo.megaGymDataset
WHERE Level = 'Beginner'

