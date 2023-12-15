
-- 1. Retrieve total cases and deaths for Maharashtra
SELECT States, Total_Cases, Deaths FROM covid WHERE States = 'Maharashtra';

-- 2. Find states with more than 1% death ratio
SELECT States, Death_Ratio FROM covid WHERE Death_Ratio > 1;

-- 3. Calculate the average population of states
SELECT AVG(Population) AS Avg_Population FROM covid;


-- 4. Find the state with the highest total cases
SELECT States, Total_Cases FROM covid ORDER BY Total_Cases DESC LIMIT 1;

-- 5. Calculate the overall discharge ratio for all states
SELECT SUM(Discharged) / SUM(Total_Cases) * 100 AS Overall_Discharge_Ratio FROM covid;

-- 6. Identify states with active cases greater than 10 and death ratio less than 1%
SELECT States, Active FROM covid WHERE Active > 10 AND Death_Ratio < 1;

-- 7. Calculate the percentage of total cases in each state compared to the overall total cases
SELECT States, Total_Cases, (Total_Cases / (SELECT SUM(Total_Cases) FROM covid)) * 100 AS Percentage_Total_Cases FROM covid;

-- 8. Rank states based on their death ratio in descending order
SELECT States, Death_Ratio, RANK() OVER (ORDER BY Death_Ratio DESC) AS Death_Ratio_Rank FROM covid;

-- 9. Find the states with a population greater than the average population
SELECT States, Population FROM covid WHERE Population > (SELECT AVG(Population) FROM covid);

-- 10.Find the State with the Lowest Death Ratio:
SELECT States, Death_Ratio FROM covid ORDER BY Death_Ratio ASC LIMIT 1;

-- 11: Rank states based on total cases in descending order
WITH RankedStates AS (
    SELECT States, Total_Cases, RANK() OVER (ORDER BY Total_Cases DESC) AS CaseRank
    FROM covid
)
SELECT States, Total_Cases, CaseRank FROM RankedStates;

-- 12: Calculate the percentage contribution of each state's total cases to the overall total cases
WITH ContributionCTE AS (
    SELECT States, Total_Cases, Total_Cases / SUM(Total_Cases) OVER () * 100 AS ContributionPercentage
    FROM covid
)
SELECT States, Total_Cases, ContributionPercentage FROM ContributionCTE;

-- 13: Calculate the difference in total cases from the previous state using LAG()
WITH CasesDifferenceCTE AS (
    SELECT States, Total_Cases, LAG(Total_Cases) OVER (ORDER BY Total_Cases) AS PreviousTotalCases
    FROM covid
)
SELECT States, Total_Cases, PreviousTotalCases, Total_Cases - PreviousTotalCases AS CasesDifference
FROM CasesDifferenceCTE;

-- 14: Calculate the running total of deaths using a window function
WITH RunningTotalCTE AS (
    SELECT States, Deaths, SUM(Deaths) OVER (ORDER BY Deaths) AS RunningTotalDeaths
    FROM covid
)
SELECT States, Deaths, RunningTotalDeaths FROM RunningTotalCTE;

