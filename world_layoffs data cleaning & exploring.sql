--Data Cleaning


SELECT *
FROM layoffs;

-- Creating staging table to make changes on it, and keep the raw data

SELECT * INTO layoffs_staging
FROM layoffs
WHERE 1 = 0;


SELECT *
FROM layoffs_staging;

-- Copy the data from the original table

INSERT layoffs_staging
SELECT * 
FROM layoffs;

-- Checking  duplicates using row number

SELECT *,
ROW_NUMBER() OVER( 
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, CAST(funds_raised_millions AS NVARCHAR(MAX))  ORDER BY (SELECT NULL)) AS row_num
FROM layoffs_staging 

-- Filtering by row number to find out if there are any duplicates

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER( 
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, CAST(funds_raised_millions AS NVARCHAR(MAX))  ORDER BY (SELECT NULL)) AS row_num
FROM layoffs_staging 
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1

-- Filtering data by distinct values

SELECT DISTINCT company, location, industry, total_laid_off, percentage_laid_off, date, stage, country,
CAST(funds_raised_millions AS VARCHAR(MAX)) AS funds_raised_millions
FROM layoffs_staging;

-- Copy this filterd data into new table

SELECT DISTINCT company, location, industry, total_laid_off, percentage_laid_off, date, stage, country,
CAST(funds_raised_millions AS VARCHAR(MAX)) AS funds_raised_millions
INTO layoffs_staging2
FROM layoffs_staging;

SELECT * FROM layoffs_staging2 -- This table contains the data without duplicates

-- Deleting data from the oiginal table

TRUNCATE TABLE layoffs_staging;

-- Copy the data without duplicates into our table

INSERT INTO layoffs_staging
SELECT * FROM layoffs_staging2

DROP TABLE layoffs_staging2;

SELECT DISTINCT company FROM layoffs_staging

-- Standardizing data

UPDATE layoffs_staging
SET company = TRIM(company)

SELECT DISTINCT industry
FROM layoffs_staging
ORDER BY 1

SELECT *
FROM layoffs_staging
WHERE industry LIKE 'Crypto%'

UPDATE layoffs_staging
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%'

SELECT DISTINCT country
FROM layoffs_staging
ORDER BY 1

UPDATE layoffs_staging
SET country = 'United States'
WHERE country LIKE 'United States%'

SELECT date
FROM layoffs_staging

-- Fixing null values

SELECT * FROM layoffs_staging 
WHERE industry IS NULL

SELECT *
FROM layoffs_staging
WHERE company = 'Airbnb'

SELECT *
FROM layoffs_staging
WHERE company = 'Carvana'

SELECT *
FROM layoffs_staging
WHERE company = 'Juul'

UPDATE layoffs_staging
SET industry = 'Travel'
WHERE company = 'Airbnb'

UPDATE layoffs_staging
SET industry = 'Transportation'
WHERE company = 'Carvana'

UPDATE layoffs_staging
SET industry = 'Consumer'
WHERE company = 'Juul'

SELECT * 
FROM layoffs_staging
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL

DELETE 
FROM
layoffs_staging
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL


-- Data exploring


SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging

SELECT * 
FROM layoffs_staging
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC

SELECT * 
FROM layoffs_staging
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC



SELECT company, SUM(total_laid_off) total
FROM layoffs_staging
GROUP BY company
ORDER BY total DESC

SELECT MIN(date), MAX(date)
FROM layoffs_staging


SELECT industry, SUM(total_laid_off) total
FROM layoffs_staging
GROUP BY industry
ORDER BY total DESC

SELECT country, SUM(total_laid_off) total
FROM layoffs_staging
GROUP BY country
ORDER BY total DESC


SELECT company, FORMAT([date], 'yyyy-MM') AS Month_Year, 
       SUM(total_laid_off) AS Total_Laid_Off
FROM layoffs_staging
WHERE FORMAT([date], 'yyyy-MM') IS NOT NULL
GROUP BY company, FORMAT([date], 'yyyy-MM')
ORDER BY Month_Year, Total_Laid_Off DESC;


SELECT company, YEAR(date) AS Years, SUM(total_laid_off) total_laid_off
FROM layoffs_staging
WHERE YEAR(date) IS NOT NULL 
GROUP BY company, YEAR(date)
ORDER BY YEAR(date) ASC , SUM(total_laid_off) DESC

-- Returning Top 5 companies who laid people off each year

WITH CompanyYear (company, years, total_laid_off) AS
(
SELECT company, YEAR(date) AS Years, SUM(total_laid_off) total_laid_off
FROM layoffs_staging
WHERE YEAR(date) IS NOT NULL 
GROUP BY company, YEAR(date)
), COMPANY AS
(
SELECT *, DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM CompanyYear
)
SELECT * 
FROM COMPANY 
WHERE Ranking <= 5 



